//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_IStream.h
//
//  Contents: Declaration of IStream interface implementation class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_ISTREAM_H_INC__
#define __ECOM_E_ISTREAM_H_INC__

#define E_end_of_stream 114

#include <objbase.h>
#include "eif_cecil.h"
#include "eif_except.h"
#include "ecom_rt_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

class E_IStream
{
public:
  // Commands
  E_IStream (IStream * p_i);
  ~E_IStream();
  void ccom_read (void * p_buffer, ULONG number_bytes);
  EIF_CHARACTER ccom_read_character();
  EIF_INTEGER ccom_read_integer();
  EIF_REAL ccom_read_real();
  EIF_BOOLEAN ccom_read_boolean();
  EIF_REFERENCE ccom_read_string();
  void ccom_write (void * p_buffer, ULONG number_bytes);
  void ccom_write_character (EIF_CHARACTER character);
  void ccom_write_integer (EIF_INTEGER integer);
  void ccom_write_real (EIF_REAL real);
  void ccom_write_boolean (EIF_BOOLEAN boolean);
  void ccom_write_string (EIF_POINTER string);
  void ccom_seek (EIF_POINTER dlibMove, EIF_INTEGER dwOrigin);
  void ccom_set_size (EIF_POINTER libNewSize);
  void ccom_copy_to (IStream * pDestination, EIF_POINTER cb); 
  void ccom_lock_region ( EIF_POINTER libOffset, 
      EIF_POINTER cb, EIF_INTEGER dwLockType);
  void ccom_unlock_region (EIF_POINTER libOffset, 
      EIF_POINTER cb, EIF_INTEGER dwLockType);
  STATSTG * ccom_stat (EIF_INTEGER grfStatFlag);
  IStream * ccom_clone ();
  
  // Queries
  IStream * ccom_item (){return pStream;};
  EIF_INTEGER ccom_end_of_stream_reached();
private:
  IStream * pStream;
};

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_E_ISTREAM_H_INC__
