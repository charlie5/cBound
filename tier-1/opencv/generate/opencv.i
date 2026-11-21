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
#include <opencv2/core/ocl.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/geometry.hpp>     // The shape and transform functions, which OpenCV 5 moved out of 'imgproc'.
#include <opencv2/features.hpp>
#include <opencv2/objdetect.hpp>
#include <opencv2/calib.hpp>
#include <opencv2/dnn.hpp>

#include <string.h>
#include <vector>

//  The outlines which are found in an image.
//
struct cv_Contours
{
  std::vector <std::vector <cv::Point> >   Items;
};

//  The features which are found in an image: places which can be told from those around them, each with a description.
//
struct cv_Features
{
  std::vector <cv::KeyPoint>   Points;
  cv::Mat                      Descriptions;
};

//  The features of one image which are like those of another.
//
struct cv_Matches
{
  std::vector <cv::DMatch>   Items;
};

//  A camera: the views of known points from which it is measured, and its measures.
//
struct cv_Camera
{
  std::vector <std::vector <cv::Point3f> >   Objects;
  std::vector <std::vector <cv::Point2f> >   Images;

  cv::Mat   Matrix     = cv::Mat::eye   (3, 3, CV_64F);
  cv::Mat   Distortion = cv::Mat::zeros (1, 5, CV_64F);
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
struct cv_Features;       // The features which are found in an image.
struct cv_Matches;        // The features of one image which are like those of another.
struct cv_Camera;         // A camera, and its measures.

namespace cv
{
  namespace dnn
  {
    class Net;            // A neural network.
  }
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


  //  Features.
  //
  //  The features of an image must be given to 'cv_delete_features' when done with, and matches to 'cv_delete_matches'.
  //  A feature is counted from 0, as is a match.
  //

  //  The strongest features of an image, with their descriptions (by the ORB method).
  //
  cv_Features*  cv_find_features (const cv::Mat*   From,  int   Most)
  {
    cv_Features*   the_Features = new cv_Features;

    try
    {
      cv::ORB::create (Most)->detectAndCompute (*From, cv::noArray (), the_Features->Points, the_Features->Descriptions);
    }
    catch (...)
    {
      delete the_Features;
      throw;
    }

    return the_Features;
  }

  //  The strongest corners of an image of one channel. They have no descriptions, so cannot be matched.
  //
  cv_Features*  cv_find_corners (const cv::Mat*   From,  int   Most,  double   Quality,  double   least_Distance)
  {
    cv_Features*               the_Features = new cv_Features;
    std::vector <cv::Point2f>  the_Corners;

    try
    {
      cv::goodFeaturesToTrack (*From, the_Corners, Most, Quality, least_Distance);

      for (size_t i = 0;  i < the_Corners.size ();  i++)
        the_Features->Points.push_back (cv::KeyPoint (the_Corners [i], 1.0f));
    }
    catch (...)
    {
      delete the_Features;
      throw;
    }

    return the_Features;
  }

  void  cv_delete_features (cv_Features*         Self)                     { delete Self; }
  int   cv_feature_count   (const cv_Features*   Self)                     { return (int) Self->Points.size (); }

  void  cv_feature (const cv_Features*   Self,  int   Index,  double*   Column,  double*   Row,  double*   Size,  double*   Angle,  double*   Strength)
  {
    const cv::KeyPoint&   the_Point = Self->Points.at (Index);

    *Column   = the_Point.pt.x;
    *Row      = the_Point.pt.y;
    *Size     = the_Point.size;
    *Angle    = the_Point.angle;
    *Strength = the_Point.response;
  }

  void  cv_draw_features (const cv::Mat*   From,  const cv_Features*   Self,  cv::Mat*   To,  double   Blue,  double   Green,  double   Red)
  {
    cv::drawKeypoints (*From, Self->Points, *To, cv::Scalar (Blue, Green, Red));
  }

  //  Pairs each feature of the left with the feature of the right which is most like it, where each is the other's best.
  //
  cv_Matches*  cv_match_features (const cv_Features*   Left,  const cv_Features*   Right)
  {
    cv_Matches*   the_Matches = new cv_Matches;

    try
    {
      if (!Left->Descriptions.empty () && !Right->Descriptions.empty ())
        cv::BFMatcher (cv::NORM_HAMMING, true).match (Left->Descriptions, Right->Descriptions, the_Matches->Items);
    }
    catch (...)
    {
      delete the_Matches;
      throw;
    }

    return the_Matches;
  }

  void  cv_delete_matches (cv_Matches*         Self)                       { delete Self; }
  int   cv_match_count    (const cv_Matches*   Self)                       { return (int) Self->Items.size (); }

  //  The features which are paired, and how far apart their descriptions are (the less, the more alike).
  //
  void  cv_match (const cv_Matches*   Self,  int   Index,  int*   Left,  int*   Right,  double*   Distance)
  {
    const cv::DMatch&   the_Match = Self->Items.at (Index);

    *Left     = the_Match.queryIdx;
    *Right    = the_Match.trainIdx;
    *Distance = the_Match.distance;
  }


  //  Neural networks.
  //
  //  A network is read from the file of a model (ONNX, and others), and must be given to 'cv_delete_network' when done with.
  //

  cv::dnn::Net*  cv_read_network (const char*   Model,  const char*   Configuration)
  {
    return new cv::dnn::Net (cv::dnn::readNet (Model, Configuration));
  }

  void  cv_delete_network   (cv::dnn::Net*         Self)                   { delete Self; }
  int   cv_network_is_empty (const cv::dnn::Net*   Self)                   { return Self->empty () ? 1 : 0; }

  //  Gives the network an image: resized, less a mean for each channel, and then scaled.
  //
  void  cv_set_network_input (cv::dnn::Net*   Self,  const cv::Mat*   Image,
                              double   Scale,  int   Columns,  int   Rows,
                              double   mean_Blue,  double   mean_Green,  double   mean_Red,
                              int      swap_Red_and_Blue)
  {
    Self->setInput (cv::dnn::blobFromImage (*Image, Scale, cv::Size (Columns, Rows),
                                            cv::Scalar (mean_Blue, mean_Green, mean_Red),
                                            swap_Red_and_Blue != 0,
                                            false));
  }

  //  Runs the network, and gives its result, which is an array of real numbers of several dimensions.
  //
  void  cv_run_network (cv::dnn::Net*   Self,  cv::Mat*   Result)          { Self->forward ().copyTo (*Result); }

  //  The dimensions of such an array, and its numbers, counted from 0, with the last dimension changing first.
  //
  int     cv_dimensions (const cv::Mat*   Self)                            { return Self->dims; }
  int     cv_dimension  (const cv::Mat*   Self,  int   Index)              { CV_Assert (Index >= 0 && Index < Self->dims);  return Self->size [Index]; }
  int     cv_number_count (const cv::Mat*   Self)                          { return (int) Self->total (); }

  double  cv_number     (const cv::Mat*   Self,  int   Index)
  {
    CV_Assert (Self->depth () == CV_32F && Self->isContinuous () && Index >= 0 && (size_t) Index < Self->total ());
    return ((const float*) Self->data) [Index];
  }

  //  Of boxes which overlap, keeps the one with the best score. Each box is a column, a row, a width and a height.
  //  Returns how many are kept, whose numbers (from 0) are put into 'Kept', which must have room for 'Count'.
  //
  int  cv_keep_best_boxes (const double*   Boxes,  const double*   Scores,  int   Count,
                           double   least_Score,  double   most_Overlap,
                           int*     Kept)
  {
    std::vector <cv::Rect2d>   the_Boxes;
    std::vector <float>        the_Scores;
    std::vector <int>          the_Kept;

    for (int i = 0;  i < Count;  i++)
    {
      the_Boxes .push_back (cv::Rect2d (Boxes [4 * i], Boxes [4 * i + 1], Boxes [4 * i + 2], Boxes [4 * i + 3]));
      the_Scores.push_back ((float) Scores [i]);
    }

    cv::dnn::NMSBoxes (the_Boxes, the_Scores, (float) least_Score, (float) most_Overlap, the_Kept);

    for (size_t i = 0;  i < the_Kept.size ();  i++)
      Kept [i] = the_Kept [i];

    return (int) the_Kept.size ();
  }


  //  Cameras.
  //
  //  A camera is measured from several views of points whose places are known (the corners of a chessboard, commonly).
  //  It must be given to 'cv_delete_camera' when done with.
  //

  cv_Camera*  cv_new_camera    ()                                          { return new cv_Camera; }
  void        cv_delete_camera (cv_Camera*   Self)                         { delete Self; }

  //  Adds a view: the places of the points (an x, y and z for each), and where the camera saw them (a column and a row for each).
  //
  void  cv_add_view (cv_Camera*   Self,  const double*   Objects,  const double*   Images,  int   Count)
  {
    std::vector <cv::Point3f>   the_Objects;
    std::vector <cv::Point2f>   the_Images;

    for (int i = 0;  i < Count;  i++)
    {
      the_Objects.push_back (cv::Point3f ((float) Objects [3 * i], (float) Objects [3 * i + 1], (float) Objects [3 * i + 2]));
      the_Images .push_back (cv::Point2f ((float) Images  [2 * i], (float) Images  [2 * i + 1]));
    }

    Self->Objects.push_back (the_Objects);
    Self->Images .push_back (the_Images);
  }

  int     cv_view_count (const cv_Camera*   Self)                          { return (int) Self->Objects.size (); }

  //  Measures the camera from its views, for images of the given size. Returns the error which remains, in elements.
  //
  double  cv_calibrate (cv_Camera*   Self,  int   Columns,  int   Rows)
  {
    std::vector <cv::Mat>   the_Rotations, the_Translations;

    return cv::calibrateCamera (Self->Objects, Self->Images, cv::Size (Columns, Rows),
                                Self->Matrix, Self->Distortion,
                                the_Rotations, the_Translations);
  }

  //  The focal lengths along the columns and the rows, and the centre, all in elements.
  //
  double  cv_focal_length_across (const cv_Camera*   Self)                 { return Self->Matrix.at <double> (0, 0); }
  double  cv_focal_length_down   (const cv_Camera*   Self)                 { return Self->Matrix.at <double> (1, 1); }
  double  cv_centre_column       (const cv_Camera*   Self)                 { return Self->Matrix.at <double> (0, 2); }
  double  cv_centre_row          (const cv_Camera*   Self)                 { return Self->Matrix.at <double> (1, 2); }

  //  One of the five measures of the distortion of its lens, counted from 0.
  //
  double  cv_distortion (const cv_Camera*   Self,  int   Index)
  {
    CV_Assert (Index >= 0 && (size_t) Index < Self->Distortion.total ());
    return Self->Distortion.ptr <double> () [Index];
  }

  //  An image as it would be with no distortion of the lens.
  //
  void    cv_undistort (const cv_Camera*   Self,  const cv::Mat*   From,  cv::Mat*   To)
  {
    cv::undistort (*From, *To, Self->Matrix, Self->Distortion);
  }

  //  Where a camera, with no distortion, sees points: for a camera which is turned (by a rotation vector)
  //  and then moved. 'Images' must have room for a column and a row for each point.
  //
  void    cv_project (double   focal_Length_across,  double   focal_Length_down,  double   centre_Column,  double   centre_Row,
                      const double*   Rotation,
                      const double*   Translation,
                      const double*   Objects,  int   Count,
                      double*         Images)
  {
    std::vector <cv::Point3d>   the_Objects;
    std::vector <cv::Point2d>   the_Images;

    for (int i = 0;  i < Count;  i++)
      the_Objects.push_back (cv::Point3d (Objects [3 * i], Objects [3 * i + 1], Objects [3 * i + 2]));

    cv::Mat   the_Matrix = (cv::Mat_ <double> (3, 3) << focal_Length_across, 0, centre_Column,
                                                        0, focal_Length_down, centre_Row,
                                                        0, 0, 1);
    cv::projectPoints (the_Objects,
                       cv::Vec3d (Rotation    [0], Rotation    [1], Rotation    [2]),
                       cv::Vec3d (Translation [0], Translation [1], Translation [2]),
                       the_Matrix, cv::noArray (),
                       the_Images);

    for (int i = 0;  i < Count;  i++)
    {
      Images [2 * i]     = the_Images [i].x;
      Images [2 * i + 1] = the_Images [i].y;
    }
  }

  //  Finds the inner corners of a chessboard, of which there are 'Columns' along each row and 'Rows' down each column.
  //  Returns 1 if all are found, and puts a column and a row for each into 'Corners', which must have room for them.
  //
  int     cv_find_chessboard (const cv::Mat*   From,  int   Columns,  int   Rows,  double*   Corners)
  {
    std::vector <cv::Point2f>   the_Corners;

    if (!cv::findChessboardCorners (*From, cv::Size (Columns, Rows), the_Corners))
      return 0;

    for (size_t i = 0;  i < the_Corners.size ();  i++)
    {
      Corners [2 * i]     = the_Corners [i].x;
      Corners [2 * i + 1] = the_Corners [i].y;
    }

    return 1;
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

  //  Whether the library may use OpenCL, where it has it, to do its work on a graphics card. Some operations start
  //  OpenCL when they are first used, which can hang where its drivers are not usable (within a container, say).
  //
  void         cv_use_opencl (int   Use)                                   { cv::ocl::setUseOpenCL (Use != 0); }
%}
