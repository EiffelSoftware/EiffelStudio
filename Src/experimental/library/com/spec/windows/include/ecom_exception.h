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

#ifndef __ECOM_EXCEPTION_H_INC__
#define __ECOM_EXCEPTION_H_INC__

#include "eif_eiffel.h"
#ifdef __cplusplus

class Formatter
{
public:
  Formatter();
  virtual ~Formatter();
  EIF_REFERENCE ccom_format_message( EIF_INTEGER Code );
  char* c_format_message( long Code );
  EIF_INTEGER ccom_hresult (char * exception_code_name); 
  EIF_REFERENCE ccom_hresult_to_string( EIF_INTEGER Code );
  HRESULT hresult (int code);

};

#endif  // __cplusplus

#endif // !__ECOM_EXCEPTION_H_INC__

