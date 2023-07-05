with
     gmp_c.Binding,
     --  gmp_c.a_a_mpf_struct,
     gmp_c.a_a_mpz_struct,
     gmp_c.mpz_srcptr,
     --  gmp_c.mpz_ptr,

     ada.unchecked_Deallocation,
     interfaces.C.Strings;


package body GMP.discrete
is
   use gmp_c.Binding,
       gmp_c.mpz_t,

       Interfaces,
       interfaces.C,
       Interfaces.C.Strings;


   function Data (Self : in Integer) return gmp_c.mpz_srcptr.item
   is
      lean_Src : constant gmp_c.a_a_mpz_struct.Pointer := Self.lean (0)'access;
   begin
      return gmp_c.mpz_srcptr.item (lean_Src);
   end Data;



   ---------
   --- Forge
   --

   procedure define (Self : in out Integer)
   is
   begin
      Self.lean := new gmp_c.mpz_t.item;
      init (Self.lean (0)'access);
   end define;



   procedure define (Self : in out Integer;   Value : in long_long_Integer)
   is
   begin
      Self.lean := new gmp_c.mpz_t.item;
      init_set_si (Data (Self),  c.Long (Value));
   end define;



   procedure define (Self : in out Integer;   Value : in discrete.Integer)
   is
   begin
      Self.lean := new gmp_c.mpz_t.item;
      init_set (Data (Self),  Data (Value));
   end define;



   function to_Integer return Integer
   is
      Self : Integer;
   begin
      define (Self);
      return Self;
   end to_Integer;



   function to_Integer (From : long_long_Integer) return Integer
   is
      Self : Integer;
   begin
      define (Self, From);
      return Self;
   end to_Integer;



   function to_Integer (From : discrete.Integer)  return Integer
   is
      Self : Integer;
   begin
      define (Self, From);
      return Self;
   end to_Integer;



   procedure destroy (Self : in out Integer)
   is
      procedure deallocate is new ada.unchecked_Deallocation (gmp_c.mpz_t.item,
                                                              gmp_c.mpz_t.pointer);
   begin
      clear (Self.lean (0)'access);
      deallocate (Self.lean);
   end destroy;



   --------------
   --- Attributes
   --

   function Value (Self : in Integer) return long_long_Integer
   is
   begin
      return long_long_Integer (get_si (Data (Self)));
   end Value;



   function Image (Self : in Integer) return String
   is
      Image_c : c.Strings.chars_ptr := get_Str (c.strings.null_Ptr,  10,  Data (Self));
      Result  : constant String              := Value (Image_c);
   begin
      free (Image_c);
      return Result;
   end Image;



   function hex_Image (Self : in Integer) return String
   is
      Image_c : c.Strings.chars_ptr := get_Str (c.strings.null_Ptr,  16,  Data (Self));
      Result  : constant String              := "16#" & Value (Image_c) & "#";
   begin
      free (Image_c);
      return Result;
   end hex_Image;



   function oct_Image (Self : in Integer) return String
   is
      Image_c : c.Strings.chars_ptr := get_Str (c.strings.null_Ptr,  8,  Data (Self));
      Result  : constant String              := "8#" & Value (Image_c) & "#";
   begin
      free (Image_c);
      return Result;
   end oct_Image;



   --------------
   --- Operations
   --

   overriding function "=" (Left, Right : in Integer) return Boolean
   is
   begin
      return cmp (Data (Left),
                  Data (Right)) = 0;
   end "=";



   function "<" (Left, Right : in Integer) return Boolean
   is
   begin
      return cmp (Data (Left),
                  Data (Right)) = -1;
   end "<";



   function "**" (Left : in Integer;   Right : in long_long_Integer) return Integer
   is
      Result : constant Integer := to_Integer;
   begin
      pow_ui (Data (Result),
              Data (Left),
              c.unsigned_Long (Right));

      return Result;
   end "**";



   function "*" (Left, Right : in Integer) return Integer
   is
      Result : constant Integer := to_Integer;
   begin
      mul (Data (Result),
           Data (Left),
           Data (Right));

      return Result;
   end "*";



   function "/" (Left, Right : in Integer) return Integer
   is
      Result : constant Integer := to_Integer;
   begin
      tdiv_q (Data (Result),
              Data (Left),
              Data (Right));

      return Result;
   end "/";



   function div (Left, Right : in Integer;
                 Round       : in Rounding) return Integer
   is
      Result : constant Integer := to_Integer;
   begin
      case Round
      is
         when Up =>
            cdiv_q (Data (Result),
                    Data (Left),
                    Data (Right));

         when Down =>
            fdiv_q (Data (Result),
                    Data (Left),
                    Data (Right));
      end case;

      return Result;
   end div;



   function "+" (Left, Right : in Integer) return Integer
   is
      Result : constant Integer := to_Integer;
   begin
      add (Data (Result),
           Data (Left),
           Data (Right));

      return Result;
   end "+";



   function "-" (Left, Right : in Integer) return Integer
   is
      Result : constant Integer := to_Integer;
   begin
      sub (Data (Result),
           Data (Left),
           Data (Right));

      return Result;
   end "-";



   function "or" (Left, Right : in Integer) return Integer
   is
      Result : constant Integer := to_Integer;
   begin
      ior (Data (Result),
           Data (Left),
           Data (Right));

      return Result;
   end "or";



   function "xor" (Left, Right : in Integer) return Integer
   is
      Result : constant Integer := to_Integer;
   begin
      z_xor (Data (Result),
             Data (Left),
             Data (Right));

      return Result;
   end "xor";



   function "and" (Left, Right : in Integer) return Integer
   is
      Result : constant Integer := to_Integer;
   begin
      z_and (Data (Result),   Data (Left),  Data (Right));
      return Result;
   end "and";



   -- Unary operators.
   --

   function "-" (Self : in Integer) return Integer
   is
      Result : constant Integer := to_Integer;
   begin
      neg (Data (Result),  Data (Self));
      return Result;
   end "-";




   function "not" (Self : in Integer) return Integer
   is
      Result : constant Integer := to_Integer;
   begin
      com (Data (Result),  Data (Self));
      return Result;
   end "not";


end GMP.Discrete;
