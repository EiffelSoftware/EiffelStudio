//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   ecom_exception.h
//
//  Contents: Externals definition for class ECOM_EXCEPTION
//
//
//--------------------------------------------------------------------------


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

