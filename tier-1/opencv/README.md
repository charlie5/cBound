# opencv

A binding to [OpenCV](https://opencv.org) 5, the computer vision library.

It needs OpenCV 5 and its headers, which are expected in `/usr/include/opencv5`.


## How it is made

OpenCV has only a C++ interface, of templates, proxy types and operators, which does not bind well. So the swig
interface file (`generate/opencv.i`) does not include the headers of OpenCV. It declares a set of plain functions, each
of which calls the library, over types which the binding sees only as pointers. To bind more of the library, add a
function there, generate the binding again, and give it a counterpart in the thick binding.

Two things in that file are worth knowing:

- A constant is given as a number, and the wrapper file checks it against the library when it is compiled. (OpenCV 5
  numbers the types of its elements differently from OpenCV 4.)
- An error which OpenCV reports, a `cv::Exception`, is caught and left pending, as a C++ exception would otherwise end
  an Ada program. The thick binding raises it as an Ada exception.


## The thin binding

`openCV_c.Binding` has the functions, each named `cv_...`, and `openCV_c` the constants. An image is a `Mat_Pointer`,
which must be deleted by hand, and a string is a `chars_ptr`.


## The thick binding

| Package            | Holds                                                                                         |
|--------------------|-----------------------------------------------------------------------------------------------|
| `openCV`           | The exception `Error`, and the version of the library.                                        |
| `openCV.Images`    | An image, with its elements, files, operations, geometry, drawing and windows.                |
| `openCV.Contours`  | The outlines of the shapes in an image, and their measures.                                   |
| `openCV.Videos`    | A source of frames, which is a camera or a file, and a sink which frames are written to.      |

An image is a value: assigning one copies it, and it frees its storage when it is done with. Operations return images,
so they may be joined:

    with openCV.Images;   use openCV.Images;

    procedure Example
    is
       Picture : Image := to_Image (Width => 160,  Height => 120);
    begin
       Picture.draw_Circle (Row => 60,  Column => 80,  Radius => 25,  Ink => Red,  Thickness => Filled);

       declare
          Marked : constant Image := Picture.to_Grey.blurred (Size => 9).above (128);
       begin
          Marked.write ("marked.png");
       end;
    end Example;

An element is found by its row and its column, each counted from 0, with row 0 at the top. A colour is a record of
red, green and blue. An error which the library reports raises `openCV.Error`, with the message of the library.

`thin (the_Image)` gives the image of the thin binding, for an operation which the thick binding lacks.


## The demos

Each checks its own results, and exits with a failure status if one is wrong.

| Demo        | Shows                                                                                              |
|-------------|----------------------------------------------------------------------------------------------------|
| `simple`    | The thin binding.                                                                                  |
| `images`    | Drawing, conversion, blurring, thresholds, geometry, files and errors. `./images show` shows the picture in a window. |
| `contours`  | Finding the shapes in a picture, and measuring them.                                               |
| `video`     | Writing a video and reading it back. `./video camera` also takes a frame from a camera.            |

To build and run one:

    cd applet/demo/images
    gprbuild -p -P images.gpr
    ./images
