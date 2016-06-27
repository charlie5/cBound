
with gmp_lean.Binding;
with ada.Unchecked_Deallocation;
with gmp_lean.a_a_mpf_struct;
with gmp_lean.a_a_mpz_struct;
with gmp_lean.mpz_srcptr;
with gmp_lean.mpz_ptr;

with interfaces.C.strings;
with Interfaces.C.Strings; use Interfaces.C.Strings;



package body GMP.discrete
--
--
--
is

   use GMP_lean.Binding;
   use GMP_lean.mpz_t;
   use interfaces.C;

   package C renames interfaces.C;



   -- Private subprograms specs
   --

   function Data (Self : in Integer) return gmp_lean.mpz_srcptr.item;
--     function Data (Self : in Integer) return gmp_lean.mpz_ptr.item;






   -- forge
   --

   procedure define (Self : in out Integer)
   is
   begin
      self.Lean := new GMP_lean.mpz_t.item;
      init (Self.lean (0)'access);
   end;



   procedure define (Self : in out Integer;   Value : in long_long_Integer)
   is
   begin
      self.Lean := new GMP_lean.mpz_t.item;
      init_set_si (Data (Self),  c.Long (Value));
   end;



   procedure define (Self : in out Integer;   Value : in discrete.Integer)
   is
   begin
      self.Lean := new GMP_lean.mpz_t.item;
      init_set (Data (Self),  Data (Value));
   end;





   function to_Integer return Integer
   is
      Self : Integer;
   begin
      define (Self);
      return Self;
   end;





   function  to_Integer (From : long_long_Integer) return Integer
   is
      Self : Integer;
   begin
      define (Self, From);
      return Self;
   end;




   function  to_Integer (From : discrete.Integer)  return Integer
   is
      Self : Integer;
   begin
      define (Self, From);
      return Self;
   end;






   procedure destroy (Self : in out Integer)
   is
      procedure deallocate is new ada.Unchecked_Deallocation (GMP_lean.mpz_t.item,
                                                              GMP_lean.mpz_t.pointer);
   begin
      clear (Self.lean (0)'access);
      deallocate (self.Lean);
   end;





   -- Attributes
   --



   function Data (Self : in Integer) return gmp_lean.mpz_srcptr.item
   is
      lean_Src : gmp_lean.a_a_mpz_struct.Pointer := Self.lean (0)'access;
   begin
      return gmp_lean.mpz_srcptr.item (lean_Src);
   end;




--     function Data (Self : in Integer) return gmp_lean.mpz_ptr.item
--     is
--        lean_Src : gmp_lean.a_a_mpz_struct.view := Self.lean (0)'access;
--     begin
--        return gmp_lean.a_a_mpz_struct.mpz_ptr (lean_Src);
--     end;





   function Value (Self : in Integer) return long_long_Integer
   is
   begin
      return long_long_Integer (get_si (Data (Self)));
   end;






   function Image (Self : in Integer) return String
   is
      Image_c : c.Strings.chars_ptr := get_Str (c.strings.null_Ptr,  10,  Data (Self));
      Result  : String              := Value (Image_c);
   begin
      free (Image_c);
      return Result;
   end;



   function hex_Image (Self : in Integer) return String
   is
      Image_c : c.Strings.chars_ptr := get_Str (c.strings.null_Ptr,  16,  Data (Self));
      Result  : String              := "16#" & Value (Image_c) & "#";
   begin
      free (Image_c);
      return Result;
   end;



   function oct_Image (Self : in Integer) return String
   is
      Image_c : c.Strings.chars_ptr := get_Str (c.strings.null_Ptr,  8,  Data (Self));
      Result  : String              := "8#" & Value (Image_c) & "#";
   begin
      free (Image_c);
      return Result;
   end;





   -- Operations
   --



   function "=" (Left, Right : in Integer) return Boolean
   is
   begin
      return cmp (Data (Left),
                  Data (Right)) = 0;
   end;



   function "<" (Left, Right : in Integer) return Boolean
   is
   begin
      return cmp (Data (Left),
                  Data (Right)) = -1;
   end;




   function "**" (Left : in Integer;   Right : in long_long_Integer) return Integer
   is
      Result : Integer := to_Integer;
   begin
      pow_ui (Data (Result),   Data (Left),  c.unsigned_Long (Right));
      return Result;
   end;




   function "*" (Left, Right : in Integer) return Integer
   is
      Result : Integer := to_Integer;
   begin
      mul (Data (Result),   Data (Left),  Data (Right));
      return Result;
   end;



   function "/" (Left, Right : in Integer) return Integer
   is
      Result : Integer := to_Integer;
   begin
      cdiv_q (Data (Result),   Data (Left),  Data (Right));
      return Result;
   end;




   function "+" (Left, Right : in Integer) return Integer
   is
      Result : Integer := to_Integer;
   begin
      add (Data (Result),   Data (Left),  Data (Right));
      return Result;
   end;



   function "-" (Left, Right : in Integer) return Integer
   is
      Result : Integer := to_Integer;
   begin
      sub (Data (Result),   Data (Left),  Data (Right));
      return Result;
   end;



   function "or" (Left, Right : in Integer) return Integer
   is
      Result : Integer := to_Integer;
   begin
      ior (Data (Result),   Data (Left),  Data (Right));
      return Result;
   end;



   function "xor" (Left, Right : in Integer) return Integer
   is
      Result : Integer := to_Integer;
   begin
      z_xor (Data (Result),   Data (Left),  Data (Right));
      return Result;
   end;



   function "and" (Left, Right : in Integer) return Integer
   is
      Result : Integer := to_Integer;
   begin
      z_and (Data (Result),   Data (Left),  Data (Right));
      return Result;
   end;






   -- Unary operators
   --

   function "-" (Self : in Integer) return Integer
   is
      Result : Integer := to_Integer;
   begin
      neg (Data (Result),  Data (Self));
      return Result;
   end;




   function "not" (Self : in Integer) return Integer
   is
      Result : Integer := to_Integer;
   begin
      com (Data (Result),  Data (Self));
      return Result;
   end;



end GMP.Discrete;
