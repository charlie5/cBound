
private with GMP_c.mpz_t;



package GMP.discrete
--
--
--
is


   type Integer is private;



   -- forge
   --

   function  to_Integer                            return Integer;
   function  to_Integer (From : long_long_Integer) return Integer;
   function  to_Integer (From : discrete.Integer)  return Integer;

   procedure define  (Self : in out Integer);
   procedure define  (Self : in out Integer;   Value : in long_long_Integer);
   procedure define  (Self : in out Integer;   Value : in discrete.Integer);

   procedure destroy (Self : in out Integer);




   -- attributes
   --


   function Value (Self : in Integer) return long_long_Integer;
   function Image (Self : in Integer) return String;

   function hex_Image (Self : in Integer) return String;
   function oct_Image (Self : in Integer) return String;




   -- operations
   --


   function "=" (Left, Right : in Integer) return Boolean;
   function "<" (Left, Right : in Integer) return Boolean;

   function "+" (Left, Right : in Integer) return Integer;
   function "-" (Left, Right : in Integer) return Integer;
   function "*" (Left, Right : in Integer) return Integer;
   function "/" (Left, Right : in Integer) return Integer;

   function "**" (Left : in Integer;   Right : in long_long_Integer) return Integer;


   function "or"  (Left, Right : in Integer) return Integer;
   function "xor" (Left, Right : in Integer) return Integer;
   function "and" (Left, Right : in Integer) return Integer;


   function "-"   (Self : in Integer) return Integer;
   function "not" (Self : in Integer) return Integer;






private



   type Integer is
      record
         Lean : GMP_c.mpz_t.Pointer;
      end record;





end GMP.Discrete;
