with fann_c.Binding;
with fann_c.Fann;
with fann_c.Pointers;

with swig.Pointers;

with Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Command_Line;
with Ada.Directories;


procedure Test
--
--  Trains a small network to give the negative of its input, saves it,
--  loads it again and runs it over a range of inputs.
--
--  The training data ('xor.data', which is not of an exclusive or) is ten
--  pairs of an input from 0.1 to 1.0 and its negative.
--
is
   use Interfaces, interfaces.C,
       fann_c, fann_c.Binding, fann_c.Pointers;

   use type fann_c.fann.Pointer;

   the_net_File  : constant String := "build/linear_float.net";
   the_data_File :          chars_ptr := new_String ("xor.data");
   the_net_Name  :          chars_ptr := new_String (the_net_File);

   Layers        : aliased array (0 .. 2) of aliased unsigned := (1, 8, 1);     -- One input, eight hidden neurons and one output.
   ann           : fann_c.fann.Pointer;

   calc_out      : fann_type_Pointer;
   input         : array (1 .. 1) of aliased fann_Type;
   worst_Error   : fann_Type := 0.0;

   procedure seed_random_Numbers (Seed : in unsigned);
   pragma Import (C, seed_random_Numbers, "srand");

begin
   --  Make the network and train it.
   --
   ann := fann_create_standard_array (3, Layers (0)'unchecked_Access);

   --  The library gives a new network weights at random, from a seed which it takes from the clock, so that now
   --  and then the training does not come close enough. The weights are given again from a fixed seed, so that
   --  each run trains the same network.
   --
   seed_random_Numbers (1);
   fann_randomize_weights (ann, -0.1, 0.1);

   fann_set_activation_function_hidden (ann, FANN_SIGMOID_SYMMETRIC);
   fann_set_activation_function_output (ann, FANN_SIGMOID_SYMMETRIC);

   fann_train_on_file (ann, the_data_File,
                       max_epochs             => 5_000,
                       epochs_between_reports => 0,
                       desired_error          => 0.000_1);

   put_Line ("Trained, to a mean square error of " & c_float'Image (fann_get_MSE (ann)));

   --  Save it, and load it again from its file.
   --
   if fann_save (ann, the_net_Name) /= 0
   then
      put_Line ("Unable to save the network to '" & the_net_File & "'.");
      Ada.Command_Line.set_exit_Status (Ada.Command_Line.Failure);
      return;
   end if;

   fann_destroy (ann);
   ann := fann_create_from_file (the_net_Name);
   Ada.Directories.delete_File (the_net_File);     -- It has served its purpose.

   if ann = null
   then
      put_Line ("Unable to load the network from '" & the_net_File & "'.");
      Ada.Command_Line.set_exit_Status (Ada.Command_Line.Failure);
      return;
   end if;

   --  Run it.
   --
   input (1) := 0.0;

   for Each in 1 .. 20 loop
      input (1) := input (1) + 0.05;
      calc_out  := fann_run (ann, input (1)'unchecked_access);
      put_Line ("linear neural test (" & fann_Type'Image (input (1)) & ") -> "  & fann_Type'Image (calc_out.all));

      worst_Error := fann_Type'Max (worst_Error,
                                    abs (calc_out.all + input (1)));
   end loop;

   fann_destroy (ann);
   free (the_data_File);
   free (the_net_Name);

   new_Line;
   put_Line ("Worst error: " & fann_Type'Image (worst_Error));

   if worst_Error > 0.1
   then
      put_Line ("The network has not learnt to give the negative of its input.");
      Ada.Command_Line.set_exit_Status (Ada.Command_Line.Failure);
   end if;
end Test;
