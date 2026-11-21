with
     openCV.Errors,
     openCV_c.Binding,

     interfaces.C.Strings;


package body openCV.Networks
is
   use openCV_c.Binding,
       openCV_c.Pointers,
       interfaces.C,
       interfaces.C.Strings;

   use type openCV_c.Pointers.Net_Pointer,
            openCV_c.Pointers.Mat_Pointer;


   ------------
   --- Networks
   --

   function load (Model         : in String;
                  Configuration : in String := "") return Network
   is
      the_Model         : chars_ptr := new_String (Model);
      the_Configuration : chars_ptr := new_String (Configuration);
   begin
      return Result : Network
      do
         Result.Thin := cv_read_network (the_Model, the_Configuration);
         free (the_Model);
         free (the_Configuration);
         Errors.check;

         if        Result.Thin = null
           or else cv_network_is_empty (Result.Thin) /= 0
         then
            raise Error with "Unable to read a network from '" & Model & "'.";
         end if;
      end return;
   end load;



   overriding
   procedure finalize (Self : in out Network)
   is
   begin
      if Self.Thin /= null
      then
         cv_delete_network (Self.Thin);
         Self.Thin := null;
      end if;
   end finalize;



   -----------
   --- Results
   --

   function Dimensions (Self : in Result) return Sizes
   is
   begin
      if Self.Thin = null
      then
         return [1 .. 0 => <>];
      end if;

      return the_Sizes : Sizes (1 .. Natural (cv_dimensions (Self.Thin)))
      do
         for i in the_Sizes'Range
         loop
            the_Sizes (i) := Positive (cv_dimension (Self.Thin, int (i - 1)));
         end loop;

         Errors.check;
      end return;
   end Dimensions;



   function Count (Self : in Result) return Natural
   is
   begin
      return (if Self.Thin = null then 0
                                  else Natural (cv_number_count (Self.Thin)));
   end Count;



   function Value (Self : in Result;   Index : in Positive) return Long_Float
   is
   begin
      if Index > Self.Count
      then
         raise Constraint_Error with "There is no number" & Index'Image & " in a result of" & Self.Count'Image & ".";
      end if;

      return the_Value : constant Long_Float := Long_Float (cv_number (Self.Thin, int (Index - 1)))
      do
         Errors.check;
      end return;
   end Value;



   overriding
   procedure adjust (Self : in out Result)
   is
   begin
      if Self.Thin /= null
      then
         Self.Thin := cv_copy_of (Self.Thin);
      end if;
   end adjust;



   overriding
   procedure finalize (Self : in out Result)
   is
   begin
      if Self.Thin /= null
      then
         cv_delete (Self.Thin);
         Self.Thin := null;
      end if;
   end finalize;



   -----------
   --- Running
   --

   function run (Self              : in out Network'Class;
                 Input             : in     Image;
                 Width, Height     : in     Positive;
                 Scale             : in     Long_Float := 1.0;
                 Mean              : in     Colour     := Black;
                 swap_Red_and_Blue : in     Boolean    := False) return Result
   is
   begin
      if Input.is_Empty
      then
         raise Error with "The image is empty.";
      end if;

      cv_set_network_input (Self.Thin, Input.thin,
                            double (Scale),
                            int (Width),
                            int (Height),
                            double (Mean.Blue), double (Mean.Green), double (Mean.Red),
                            (if swap_Red_and_Blue then 1 else 0));
      Errors.check;

      return the_Result : Result
      do
         the_Result.Thin := cv_new_image;
         cv_run_network (Self.Thin, the_Result.Thin);
         Errors.check;
      end return;
   end run;



   ---------
   --- Boxes
   --

   function best_of (the_Boxes    : in Boxes;
                     least_Score  : in Long_Float := 0.5;
                     most_Overlap : in Long_Float := 0.4) return Boxes
   is
   begin
      if the_Boxes'Length = 0
      then
         return the_Boxes;
      end if;

      declare
         type Reals    is array (Natural range <>) of aliased double;
         type Integers is array (Natural range <>) of aliased int;

         the_Places : aliased Reals    (0 .. 4 * the_Boxes'Length - 1);
         the_Scores : aliased Reals    (0 ..     the_Boxes'Length - 1);
         the_Kept   : aliased Integers (0 ..     the_Boxes'Length - 1) := [others => 0];
         kept_Count :         Natural;
      begin
         for i in the_Boxes'Range
         loop
            declare
               the_Box : Box     renames the_Boxes (i);
               Offset  : constant Natural := i - the_Boxes'First;
            begin
               the_Places (4 * Offset)     := double (the_Box.Column);
               the_Places (4 * Offset + 1) := double (the_Box.Row);
               the_Places (4 * Offset + 2) := double (the_Box.Width);
               the_Places (4 * Offset + 3) := double (the_Box.Height);
               the_Scores (Offset)         := double (the_Box.Score);
            end;
         end loop;

         kept_Count := Natural (cv_keep_best_boxes (the_Places (0)'unchecked_Access,
                                                    the_Scores (0)'unchecked_Access,
                                                    int (the_Boxes'Length),
                                                    double (least_Score),
                                                    double (most_Overlap),
                                                    the_Kept (0)'unchecked_Access));
         Errors.check;

         return Result : Boxes (1 .. kept_Count)
         do
            for i in Result'Range
            loop
               Result (i) := the_Boxes (the_Boxes'First + Natural (the_Kept (i - 1)));
            end loop;
         end return;
      end;
   end best_of;

end openCV.Networks;
