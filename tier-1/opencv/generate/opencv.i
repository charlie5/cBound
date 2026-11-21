//
//   SWIG interface definition for the OpenCV ('Open Computer Vision') library binding.
//
//   OpenCV has only a C++ interface, of templates, proxy types and operators, which does not bind well.
//   So this file does not include its headers: it declares a set of plain functions, each of which calls
//   the library, over an image ('cv::Mat') which the binding sees only as a pointer.
//
//   An error which OpenCV reports (a 'cv::Exception') is caught, and left as a pending exception of the
//   wrapper: the function then does nothing more, and a function with a result returns zero.
//

%module openCV_c

%{
#include <opencv2/core.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/geometry.hpp>     // The shape and transform functions, which OpenCV 5 moved out of 'imgproc'.

#include <string.h>
#include <vector>

//  The outlines which are found in an image.
//
struct cv_Contours
{
  std::vector <std::vector <cv::Point> >   Items;
};
%}


//  Errors.
//
%exception
{
  try
  {
    $action
  }
  catch (const cv::Exception&   the_Error)
  {
    SWIG_AdaThrowException (SWIG_AdaException, the_Error.what ());
  }
}


//  The image.
//
namespace cv
{
  class Mat;
  class VideoCapture;     // A source of frames: a camera, or a file.
  class VideoWriter;      // A file which frames are written to.
}

struct cv_Contours;       // The outlines which are found in an image.


//  Constants. Each is given its number here, which the wrapper checks against the library when it is compiled.
//
%define CV_CONSTANT(Name, Value, Library_Value)
%constant int Name = Value;
%insert("header") { static_assert (Value == (int) (Library_Value), "A constant of the binding differs from the library: " #Name); }
%enddef

//  The types of the elements of an image. (These numbers are those of OpenCV 5, which differ from those of OpenCV 4.)
//
CV_CONSTANT(CV_8UC1_type,      0,  CV_8UC1)
CV_CONSTANT(CV_8UC3_type,     64,  CV_8UC3)
CV_CONSTANT(CV_8UC4_type,     96,  CV_8UC4)
CV_CONSTANT(CV_16UC1_type,     2,  CV_16UC1)
CV_CONSTANT(CV_32FC1_type,     5,  CV_32FC1)
CV_CONSTANT(CV_32FC3_type,    69,  CV_32FC3)
CV_CONSTANT(CV_64FC1_type,     6,  CV_64FC1)

//  How an image is read.
//
CV_CONSTANT(READ_UNCHANGED,   -1,  cv::IMREAD_UNCHANGED)
CV_CONSTANT(READ_GREYSCALE,    0,  cv::IMREAD_GRAYSCALE)
CV_CONSTANT(READ_COLOUR,       1,  cv::IMREAD_COLOR)

//  Conversions of colour.
//
CV_CONSTANT(BGR_TO_GREY,       6,  cv::COLOR_BGR2GRAY)
CV_CONSTANT(GREY_TO_BGR,       8,  cv::COLOR_GRAY2BGR)
CV_CONSTANT(BGR_TO_RGB,        4,  cv::COLOR_BGR2RGB)
CV_CONSTANT(BGR_TO_HSV,       40,  cv::COLOR_BGR2HSV)
CV_CONSTANT(HSV_TO_BGR,       54,  cv::COLOR_HSV2BGR)

//  Interpolation.
//
CV_CONSTANT(INTERPOLATE_NEAREST,   0,  cv::INTER_NEAREST)
CV_CONSTANT(INTERPOLATE_LINEAR,    1,  cv::INTER_LINEAR)
CV_CONSTANT(INTERPOLATE_CUBIC,     2,  cv::INTER_CUBIC)
CV_CONSTANT(INTERPOLATE_AREA,      3,  cv::INTER_AREA)

//  Thresholds.
//
CV_CONSTANT(THRESHOLD_BINARY,          0,  cv::THRESH_BINARY)
CV_CONSTANT(THRESHOLD_BINARY_INVERSE,  1,  cv::THRESH_BINARY_INV)
CV_CONSTANT(THRESHOLD_TRUNCATE,        2,  cv::THRESH_TRUNC)
CV_CONSTANT(THRESHOLD_TO_ZERO,         3,  cv::THRESH_TOZERO)
CV_CONSTANT(THRESHOLD_OTSU,            8,  cv::THRESH_OTSU)

//  Ways to flip an image.
//
CV_CONSTANT(FLIP_VERTICALLY,     0,   0)
CV_CONSTANT(FLIP_HORIZONTALLY,   1,   1)
CV_CONSTANT(FLIP_BOTH,          -1,  -1)

//  A filled shape.
//
CV_CONSTANT(FILLED,             -1,  cv::FILLED)

//  Quarter turns.
//
CV_CONSTANT(TURN_CLOCKWISE,       0,  cv::ROTATE_90_CLOCKWISE)
CV_CONSTANT(TURN_HALF,            1,  cv::ROTATE_180)
CV_CONSTANT(TURN_ANTICLOCKWISE,   2,  cv::ROTATE_90_COUNTERCLOCKWISE)


%inline
%{
  //  Making and destroying an image.
  //
  //  An image is made by one of the functions below, and must be given to 'cv_delete' when it is done with.
  //  Where a function has a destination, that image is made to suit, whatever it held before.
  //

  cv::Mat*   cv_new_image ()                                               { return new cv::Mat (); }
  cv::Mat*   cv_new_image_of (int   Rows,  int   Columns,  int   Type)     { return new cv::Mat (Rows, Columns, Type, cv::Scalar::all (0)); }
  cv::Mat*   cv_copy_of   (const cv::Mat*   Self)                          { return new cv::Mat (Self->clone ()); }
  void       cv_delete    (cv::Mat*         Self)                          { delete Self; }


  //  The attributes of an image.
  //

  int        cv_rows      (const cv::Mat*   Self)                          { return Self->rows; }
  int        cv_columns   (const cv::Mat*   Self)                          { return Self->cols; }
  int        cv_channels  (const cv::Mat*   Self)                          { return Self->channels (); }
  int        cv_type      (const cv::Mat*   Self)                          { return Self->type (); }
  int        cv_is_empty  (const cv::Mat*   Self)                          { return Self->empty () ? 1 : 0; }

  //  The first element of the image, and the number of bytes from one row to the next.
  //
  unsigned char*   cv_data     (cv::Mat*         Self)                     { return Self->data; }
  int              cv_row_step (const cv::Mat*   Self)                     { return (int) Self->step [0]; }


  //  The elements of an image.
  //
  //  These are for an image of 8 bit elements. A channel is counted from 0 (blue, green and red, in a colour image).
  //

  int   cv_get  (const cv::Mat*   Self,  int   Row,  int   Column,  int   Channel)
  {
    return Self->ptr <unsigned char> (Row) [Column * Self->channels () + Channel];
  }

  void  cv_set  (cv::Mat*   Self,  int   Row,  int   Column,  int   Channel,  int   Value)
  {
    Self->ptr <unsigned char> (Row) [Column * Self->channels () + Channel] = cv::saturate_cast <unsigned char> (Value);
  }

  //  Sets every element. (The last three values are not used by an image of one channel.)
  //
  void  cv_fill (cv::Mat*   Self,  double   Blue,  double   Green,  double   Red)
  {
    Self->setTo (cv::Scalar (Blue, Green, Red));
  }

  //  The mean of a channel.
  //
  double  cv_mean (const cv::Mat*   Self,  int   Channel)                  { return cv::mean (*Self) [Channel]; }

  //  The least and greatest elements of an image of one channel.
  //
  void    cv_least_and_greatest (const cv::Mat*   Self,  double*   Least,  double*   Greatest)
  {
    cv::minMaxLoc (*Self, Least, Greatest);
  }


  //  Files.
  //
  //  Each returns 1 if it succeeds, and 0 if not.
  //

  int   cv_read   (const char*   Filename,  int   How,  cv::Mat*   Into)
  {
    *Into = cv::imread (Filename, How);
    return Into->empty () ? 0 : 1;
  }

  int   cv_write  (const char*   Filename,  const cv::Mat*   Self)         { return cv::imwrite (Filename, *Self) ? 1 : 0; }


  //  Operations on images.
  //

  void    cv_convert_colour (const cv::Mat*   From,  cv::Mat*   To,  int   Conversion)
  {
    cv::cvtColor (*From, *To, Conversion);
  }

  void    cv_resize (const cv::Mat*   From,  cv::Mat*   To,  int   Columns,  int   Rows,  int   Interpolation)
  {
    cv::resize (*From, *To, cv::Size (Columns, Rows), 0, 0, Interpolation);
  }

  void    cv_flip (const cv::Mat*   From,  cv::Mat*   To,  int   How)      { cv::flip (*From, *To, How); }

  //  Blurs with a square of the given size, which must be odd.
  //
  void    cv_gaussian_blur (const cv::Mat*   From,  cv::Mat*   To,  int   Size,  double   Sigma)
  {
    cv::GaussianBlur (*From, *To, cv::Size (Size, Size), Sigma);
  }

  //  Returns the threshold which was used, which differs from the one given where it is found by 'THRESHOLD_OTSU'.
  //
  double  cv_threshold (const cv::Mat*   From,  cv::Mat*   To,  double   Threshold,  double   Greatest,  int   Kind)
  {
    return cv::threshold (*From, *To, Threshold, Greatest, Kind);
  }

  void    cv_find_edges (const cv::Mat*   From,  cv::Mat*   To,  double   Lower,  double   Upper)
  {
    cv::Canny (*From, *To, Lower, Upper);
  }

  void    cv_add               (const cv::Mat*   Left,  const cv::Mat*   Right,  cv::Mat*   To)    { cv::add      (*Left, *Right, *To); }
  void    cv_subtract          (const cv::Mat*   Left,  const cv::Mat*   Right,  cv::Mat*   To)    { cv::subtract (*Left, *Right, *To); }
  void    cv_absolute_difference (const cv::Mat*   Left,  const cv::Mat*   Right,  cv::Mat*   To)  { cv::absdiff  (*Left, *Right, *To); }

  void    cv_blend (const cv::Mat*   Left,   double   left_Weight,
                    const cv::Mat*   Right,  double   right_Weight,
                    cv::Mat*         To)
  {
    cv::addWeighted (*Left, left_Weight, *Right, right_Weight, 0.0, *To);
  }

  //  The number of elements of an image of one channel which are not zero.
  //
  int     cv_count_non_zero (const cv::Mat*   Self)                        { return cv::countNonZero (*Self); }


  //  Drawing.
  //
  //  A thickness of 'FILLED' fills a closed shape.
  //

  void  cv_draw_line (cv::Mat*   Self,  int   from_Column,  int   from_Row,  int   to_Column,  int   to_Row,
                      double   Blue,  double   Green,  double   Red,  int   Thickness)
  {
    cv::line (*Self, cv::Point (from_Column, from_Row), cv::Point (to_Column, to_Row), cv::Scalar (Blue, Green, Red), Thickness);
  }

  void  cv_draw_rectangle (cv::Mat*   Self,  int   Column,  int   Row,  int   Width,  int   Height,
                           double   Blue,  double   Green,  double   Red,  int   Thickness)
  {
    cv::rectangle (*Self, cv::Rect (Column, Row, Width, Height), cv::Scalar (Blue, Green, Red), Thickness);
  }

  void  cv_draw_circle (cv::Mat*   Self,  int   Column,  int   Row,  int   Radius,
                        double   Blue,  double   Green,  double   Red,  int   Thickness)
  {
    cv::circle (*Self, cv::Point (Column, Row), Radius, cv::Scalar (Blue, Green, Red), Thickness);
  }

  void  cv_draw_text (cv::Mat*   Self,  const char*   Text,  int   Column,  int   Row,  double   Scale,
                      double   Blue,  double   Green,  double   Red,  int   Thickness)
  {
    cv::putText (*Self, Text, cv::Point (Column, Row), cv::FONT_HERSHEY_SIMPLEX, Scale, cv::Scalar (Blue, Green, Red), Thickness);
  }


  //  Geometry.
  //

  //  The part of an image which is within a rectangle.
  //
  void  cv_crop (const cv::Mat*   From,  cv::Mat*   To,  int   Column,  int   Row,  int   Width,  int   Height)
  {
    (*From) (cv::Rect (Column, Row, Width, Height)).copyTo (*To);
  }

  //  Copies an image onto another, with its top left corner at the given place. It must lie within the other.
  //
  void  cv_paste (const cv::Mat*   From,  cv::Mat*   Onto,  int   Column,  int   Row)
  {
    From->copyTo ((*Onto) (cv::Rect (Column, Row, From->cols, From->rows)));
  }

  void  cv_turn (const cv::Mat*   From,  cv::Mat*   To,  int   Turn)       { cv::rotate (*From, *To, Turn); }

  //  Rotates about the centre of the image, anticlockwise, by an angle in degrees. The image keeps its size.
  //
  void  cv_rotate (const cv::Mat*   From,  cv::Mat*   To,  double   Degrees,  double   Scale)
  {
    cv::Mat   the_Transform = cv::getRotationMatrix2D (cv::Point2f (From->cols / 2.0f, From->rows / 2.0f), Degrees, Scale);
    cv::warpAffine (*From, *To, the_Transform, From->size ());
  }

  //  Maps four corners of an image to four of the result, each given as a column and a row.
  //
  void  cv_warp (const cv::Mat*   From,  cv::Mat*   To,
                 const double*    from_Corners,
                 const double*    to_Corners,
                 int   Columns,  int   Rows)
  {
    cv::Point2f   the_From [4];
    cv::Point2f   the_To   [4];

    for (int i = 0;  i < 4;  i++)
    {
      the_From [i] = cv::Point2f ((float) from_Corners [2 * i], (float) from_Corners [2 * i + 1]);
      the_To   [i] = cv::Point2f ((float) to_Corners   [2 * i], (float) to_Corners   [2 * i + 1]);
    }

    cv::warpPerspective (*From, *To, cv::getPerspectiveTransform (the_From, the_To), cv::Size (Columns, Rows));
  }


  //  Outlines.
  //
  //  The outlines of the shapes in an image of one channel, in which whatever is not zero is part of a shape.
  //  They must be given to 'cv_delete_contours' when done with. An outline is counted from 0, as are its points.
  //

  cv_Contours*  cv_find_contours (const cv::Mat*   From,  int   outer_Only)
  {
    cv_Contours*   the_Contours = new cv_Contours;

    try
    {
      cv::findContours (*From, the_Contours->Items, outer_Only ? cv::RETR_EXTERNAL : cv::RETR_LIST, cv::CHAIN_APPROX_SIMPLE);
    }
    catch (...)
    {
      delete the_Contours;
      throw;
    }

    return the_Contours;
  }

  void    cv_delete_contours   (cv_Contours*         Self)                 { delete Self; }

  int     cv_contour_count     (const cv_Contours*   Self)                 { return (int) Self->Items.size (); }
  int     cv_contour_size      (const cv_Contours*   Self,  int   Index)   { return (int) Self->Items.at (Index).size (); }
  double  cv_contour_area      (const cv_Contours*   Self,  int   Index)   { return cv::contourArea (Self->Items.at (Index)); }
  double  cv_contour_perimeter (const cv_Contours*   Self,  int   Index)   { return cv::arcLength   (Self->Items.at (Index), true); }

  void    cv_contour_point  (const cv_Contours*   Self,  int   Index,  int   Point,  int*   Column,  int*   Row)
  {
    const cv::Point&   the_Point = Self->Items.at (Index).at (Point);

    *Column = the_Point.x;
    *Row    = the_Point.y;
  }

  void    cv_contour_bounds (const cv_Contours*   Self,  int   Index,  int*   Column,  int*   Row,  int*   Width,  int*   Height)
  {
    const cv::Rect   the_Bounds = cv::boundingRect (Self->Items.at (Index));

    *Column = the_Bounds.x;
    *Row    = the_Bounds.y;
    *Width  = the_Bounds.width;
    *Height = the_Bounds.height;
  }

  //  Draws one outline, or all of them if the index is -1.
  //
  void    cv_draw_contours (cv::Mat*   Onto,  const cv_Contours*   Self,  int   Index,
                            double   Blue,  double   Green,  double   Red,  int   Thickness)
  {
    cv::drawContours (*Onto, Self->Items, Index, cv::Scalar (Blue, Green, Red), Thickness);
  }


  //  Video.
  //
  //  A source is a camera, by its number, or a file. Each must be given to 'cv_close_source' when done with.
  //

  cv::VideoCapture*  cv_open_camera (int           Number)                 { return new cv::VideoCapture (Number);   }
  cv::VideoCapture*  cv_open_video  (const char*   Filename)               { return new cv::VideoCapture (Filename); }
  void               cv_close_source (cv::VideoCapture*   Self)            { delete Self; }

  int     cv_source_is_open (const cv::VideoCapture*   Self)               { return Self->isOpened () ? 1 : 0; }
  int     cv_frame_width    (const cv::VideoCapture*   Self)               { return (int) Self->get (cv::CAP_PROP_FRAME_WIDTH);  }
  int     cv_frame_height   (const cv::VideoCapture*   Self)               { return (int) Self->get (cv::CAP_PROP_FRAME_HEIGHT); }
  int     cv_frame_count    (const cv::VideoCapture*   Self)               { return (int) Self->get (cv::CAP_PROP_FRAME_COUNT);  }
  double  cv_frame_rate     (const cv::VideoCapture*   Self)               { return       Self->get (cv::CAP_PROP_FPS);          }

  //  Takes the next frame. Returns 1, or 0 when there are no more, which leaves the image as it was.
  //
  int     cv_next_frame     (cv::VideoCapture*   Self,  cv::Mat*   Into)
  {
    cv::Mat   the_Frame;

    if (!Self->read (the_Frame))
      return 0;

    the_Frame.copyTo (*Into);     // The source may use the storage of its frame again, so the image is given its own.
    return 1;
  }

  //  A file to which frames are written, as Motion JPEG. Must be given to 'cv_close_sink' when done with, which ends the file.
  //
  cv::VideoWriter*  cv_create_video (const char*   Filename,  double   frame_Rate,  int   Columns,  int   Rows,  int   in_Colour)
  {
    return new cv::VideoWriter (Filename,
                                cv::VideoWriter::fourcc ('M', 'J', 'P', 'G'),
                                frame_Rate,
                                cv::Size (Columns, Rows),
                                in_Colour != 0);
  }

  int     cv_sink_is_open (const cv::VideoWriter*   Self)                  { return Self->isOpened () ? 1 : 0; }
  void    cv_write_frame  (cv::VideoWriter*   Self,  const cv::Mat*   Frame)   { Self->write (*Frame); }
  void    cv_close_sink   (cv::VideoWriter*   Self)                        { delete Self; }


  //  Windows.
  //

  void  cv_show          (const char*   Window,  const cv::Mat*   Self)    { cv::imshow (Window, *Self); }
  void  cv_close         (const char*   Window)                            { cv::destroyWindow (Window); }
  void  cv_close_all     ()                                                { cv::destroyAllWindows (); }

  //  Waits for a key, for the given number of milliseconds (or for ever, if that is zero). Returns the key, or -1.
  //
  int   cv_wait_for_key  (int   Milliseconds)                              { return cv::waitKey (Milliseconds); }


  //  The version of the library.
  //
  const char*  cv_version ()                                               { return CV_VERSION; }
%}
