private
with
     GMP_c.mpz_t;


package GMP.discrete
--
-- A thick binding to the GMP C library.
--
is
   type Integer is private;


   ---------
   --- Forge
   --

   function  to_Integer                            return Integer;
   function  to_Integer (From : long_long_Integer) return Integer;
   function  to_Integer (From : discrete.Integer)  return Integer;

   procedure define  (Self : in out Integer);
   procedure define  (Self : in out Integer;   Value : in long_long_Integer);
   procedure define  (Self : in out Integer;   Value : in discrete.Integer);

   procedure destroy (Self : in out Integer);



   -------------
   -- Attributes
   --

   function Value (Self : in Integer) return long_long_Integer;
   function Image (Self : in Integer) return String;

   function hex_Image (Self : in Integer) return String;
   function oct_Image (Self : in Integer) return String;



   -------------
   -- Operations
   --

   overriding
   function "="   (Left, Right : in Integer) return Boolean;
   function "<"   (Left, Right : in Integer) return Boolean;

   function "+"   (Left, Right : in Integer) return Integer;
   function "-"   (Left, Right : in Integer) return Integer;
   function "*"   (Left, Right : in Integer) return Integer;
   function "/"   (Left, Right : in Integer) return Integer;     -- Rounds towards 0 and result will have the same sign as 'Left'.

   type Rounding is (Up,                                         -- Rounds up   towards '+Infinity' and result will have the opposite sign to 'Right'.
                     Down);                                      -- Rounds down towards '-Infinity' and result will have the same     sign as 'Right'.

   function div   (Left, Right : in Integer;
                   Round       : in Rounding) return Integer;

   function "**"  (Left  : in Integer;
                   Right : in long_long_Integer) return Integer;

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
