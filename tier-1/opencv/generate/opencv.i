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

#include <string.h>
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
}


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
