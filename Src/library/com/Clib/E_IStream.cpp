//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_IStream.cpp
//
//  Contents: 	IStream interface implementation class.
//				Wrapping of OLE compound file implementation 
//				of the IStream interface.
//
//
//--------------------------------------------------------------------------

#include "E_IStream.h"

E_IStream::~E_IStream ()
{
	pStream->Release();
};
//--------------------------------------------------------------------------

void E_IStream::ccom_initialize_stream (IStream * p_Stream)

// Points pStream to known stream object pointed by p_Stream
//		Parameters
// - p_Stream points to open storage object
{
	pStream = p_Stream;
};
//--------------------------------------------------------------------------

void E_IStream::ccom_read (void * p_buffer, ULONG number_bytes)

// Reads a specified number of bytes from the stream object 
// into memory starting at the current seek pointer. 
//		Parameters
// - p_buffer Points to the buffer into which the stream is read. 
// - number_bytes Specifies the number of bytes of data to 
//	attempt to read from the stream object. 
{
	HRESULT hr;
	hr = pStream->Read(p_buffer, number_bytes, NULL);
	if (FAILED(hr))
	{	
		Formatter * f;
		f = new Formatter;
		com_eraise (f->c_format_message (hr), HRESULT_CODE (hr));
		delete f;
	}
};
//-------------------------------------------------------------------------
void E_IStream::ccom_write (void * p_buffer, ULONG number_bytes)

// Writes a specified number of bytes into the stream object 
// starting at the current seek pointer. 
//		Parameters
// - p_buffer Points to the buffer from which the stream 
//	should be written. 
// - number_bytes The number of bytes of data to attempt to 
//	write into the stream. 
{
	HRESULT hr;
	hr = pStream->Write(p_buffer, number_bytes, NULL);
	if (hr != S_OK)
	{
		Formatter * f;
		f = new Formatter;
		com_eraise (f->c_format_message (hr), HRESULT_CODE (hr));
		delete f;
	}
};
//-------------------------------------------------------------------------
void E_IStream::ccom_seek (EIF_POINTER offset, EIF_INTEGER origin)

// Changes the seek pointer to a new location relative to 
// the beginning of the stream, to the end of the stream, 
// or to the current seek pointer. 
//		Parameters
// - offset points to the displacement to be 
//	added to the location indicated by origin.
// - origin Specifies the origin for the displacement.
//	The origin can be the beginning of the file, the current seek
//	pointer, or the end of the file.
{
	HRESULT hr;
	LARGE_INTEGER * dlibMove =((LARGE_INTEGER *)offset);

	hr = pStream->Seek (*dlibMove, (DWORD)origin, NULL);
	if (hr != S_OK)
	{
		Formatter * f;
		f = new Formatter;
		com_eraise (f->c_format_message (hr), HRESULT_CODE (hr));
		delete f;
	}
};
//-------------------------------------------------------------------------
void E_IStream::ccom_set_size (EIF_POINTER new_size)

// Changes the size of the stream object. 
//		Parameters
// - new_size points to the new size of the stream 
//	as a number of bytes. 
{
	HRESULT hr;
	ULARGE_INTEGER * libNewSize = ((ULARGE_INTEGER *)new_size);

	hr = pStream->SetSize(*libNewSize);
	if (hr != S_OK)
	{
		Formatter * f;
		f = new Formatter;
		com_eraise (f->c_format_message (hr), HRESULT_CODE (hr));
		delete f;
	}
};
//-------------------------------------------------------------------------
void E_IStream::ccom_copy_to (IStream * pDestination, EIF_POINTER cb)

// Copies a specified number of bytes from the current seek 
// pointer in the stream to the current seek pointer in  
// pDestination. 
//		Parameters
// - pDestination points to the destination stream.
// - cb points to the number of bytes to copy from the source stream
{
	HRESULT hr;
	ULARGE_INTEGER * uliNumBytes = ((ULARGE_INTEGER *)cb);

	hr = pStream->CopyTo (pDestination, *uliNumBytes, NULL, NULL);
	if (hr != S_OK)
	{
		Formatter * f;
		f = new Formatter;
		com_eraise (f->c_format_message (hr), HRESULT_CODE (hr));
		delete f;
	}
};
//-------------------------------------------------------------------------
void E_IStream::ccom_lock_region (EIF_POINTER offset, 
			EIF_POINTER cb, EIF_INTEGER dwLockType)

// Restricts access to a specified range of bytes in the stream. 
//		Parametrs
// - offset points to the byte offset for the beginning of 
//	the range 
// - cb points to the length of the range in bytes 
// - dwLockType Specifies the restriction on accessing 
//	the specified range 
{
	HRESULT hr;
	ULARGE_INTEGER * ulibOffset = ((ULARGE_INTEGER *)offset);
	ULARGE_INTEGER * uliNumBytes = ((ULARGE_INTEGER *)cb);

	hr = pStream->LockRegion (*ulibOffset, *uliNumBytes, (DWORD)dwLockType);
	if (hr != S_OK)
	{
		Formatter * f;
		f = new Formatter;
		com_eraise (f->c_format_message (hr), HRESULT_CODE (hr));
		delete f;
	}
};
//-------------------------------------------------------------------------
void E_IStream::ccom_unlock_region (EIF_POINTER offset, 
			EIF_POINTER cb, EIF_INTEGER dwLockType)

// Removes the access restriction on a range of bytes 
// previously restricted with ccom_lock_region.
//		Parametrs
// - offset points to the byte offset for the beginning of 
//	the range 
// - cb points to the length of the range in bytes 
// - dwLockType Specifies the access restriction previously 
//	placed on the range 
{
	HRESULT hr;
	ULARGE_INTEGER * ulibOffset = ((ULARGE_INTEGER *)offset);
	ULARGE_INTEGER * uliNumBytes = ((ULARGE_INTEGER *)cb);

	hr = pStream->UnlockRegion (*ulibOffset, *uliNumBytes, (DWORD)dwLockType);
	if (hr != S_OK)
	{
		Formatter * f;
		f = new Formatter;
		com_eraise (f->c_format_message (hr), HRESULT_CODE (hr));
		delete f;
	}
};
//-------------------------------------------------------------------------
STATSTG * E_IStream::ccom_stat (EIF_INTEGER grfStatFlag)

// Retrieves the STATSTG structure for the stream.
// Points pstatstg to the STATSTG sructure containing 
// information about the stream object.
//		Parameters
// - grfStatFlag Specifies that this method does not 
//	return some of the fields in the STATSTG structure, 
//	thus saving a memory allocation operation. Values are 
//	taken from the STATFLAG enumeration. 
{
	HRESULT hr;
	STATSTG * pstatstg;
	
	pstatstg = (STATSTG *)malloc(sizeof(STATSTG));
	hr = pStream->Stat (pstatstg, (DWORD)grfStatFlag);
	if (hr != S_OK)
	{
		Formatter * f;
		f = new Formatter;
		com_eraise (f->c_format_message (hr), HRESULT_CODE (hr));
		delete f;
		if (pstatstg->pwcsName != NULL)
			CoTaskMemFree (pstatstg->pwcsName);
		free (pstatstg);
		pstatstg = NULL;
	}
	return pstatstg;
};
//-------------------------------------------------------------------------
IStream * E_IStream::ccom_clone ()

// Creates a new stream object with its own seek pointer 
// that references the same bytes as the original stream. 
// Points pClonedStream to the new stream object.
{
	HRESULT hr;
	IStream * pClonedStream;
	hr = pStream->Clone (&pClonedStream);
	if (hr != S_OK)
	{
		Formatter * f;
		f = new Formatter;
		com_eraise (f->c_format_message (hr), HRESULT_CODE (hr));
		delete f;
	}
	return pClonedStream;
};
//-------------------------------------------------------------------------
