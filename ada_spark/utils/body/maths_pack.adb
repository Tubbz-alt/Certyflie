with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Safety_Pack; use Safety_Pack;

package body Maths_Pack
  with SPARK_Mode
is

   --------------
   -- Inv_Sqrt --
   --------------

   function Inv_Sqrt (X : Float) return Float
   is
      -----------
      -- Sqrtf --
      -----------

      function Sqrtf (X : Float) return Float with
        Global => null,
        Pre    => X >= Float'Succ (0.0),
        Post   => Sqrtf'Result in 3.745E-23 .. 1.85E+19,
        Import, Convention => Intrinsic, External_Name => "__builtin_sqrtf";
   begin
      return 1.0 / Sqrtf (X);
   end Inv_Sqrt;

   ----------
   -- Atan --
   ----------

   function Atan (Y :  Float; X : Float) return T_Radians is
   begin
      --  We constrain the return value accordingly to
      --  the Ada RM specification for Arctan
      --  (A.5.1 Elementary Functions)
      return Saturate (Arctan (Y, X), -Pi, Pi);
   end Atan;

   ----------
   -- Asin --
   ----------

   function Asin (X : Float) return T_Radians is
   begin
      --  We constrain the return value accordingly to
      --  the Ada RM specification for Arcsin
      --  (A.5.1 Elementary Functions)
      return Saturate (Arcsin (X), -Pi / 2.0, Pi / 2.0);
   end Asin;

end Maths_Pack;
