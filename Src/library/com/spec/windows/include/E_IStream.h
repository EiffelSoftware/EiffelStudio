//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_IStream.h
//
//  Contents:	Declaration of IStream interface implementation class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_ISTREAM_H_INC__
#define __ECOM_E_ISTREAM_H_INC__

#include <objbase.h>
#include "eif_cecil.h"
#include "eif_except.h"
#include "ecom_exception.h"

class E_IStream
{
public:
	// Commands
	E_IStream (){};
	~E_IStream();
	void ccom_initialize_stream (IStream * p_Stream);
	void ccom_read (void * p_buffer, ULONG number_bytes);
	void ccom_write (void * p_buffer, ULONG number_bytes);
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
	IStream * ccom_stream (){return pStream;};
private:
	IStream * pStream;
};
#endif // !__ECOM_E_ISTREAM_H_INC__
