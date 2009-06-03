/*
indexing
	description: "EiffelCOM: library of reusable components for COM."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "E_Decimal.h"

#ifdef __cplusplus
  extern "C" {
#endif

void ccom_decimal_value_zero (DECIMAL * a_value)
{
  long zero = 0;
  VarDecFromI4(zero, a_value);
};
//--------------------------------------------------------------------------

void ccom_decimal_value_one (DECIMAL * a_value)
{
  long one = 1;
  VarDecFromI4(one, a_value);
};
//-------------------------------------------------------------------------

EIF_DOUBLE ccom_decimal_to_double (DECIMAL * a_value)
{
  EIF_DOUBLE a_double = 0;
  HRESULT hr = VarR8FromDec (a_value, (double *)&a_double);
  if (FAILED(hr))
    a_double = 0;

  return a_double;
};

#ifdef __cplusplus
  }
#endif
