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
	if (pStream != NULL)
		pStream->Release();
};
//--------------------------------------------------------------------------

E_IStream::E_IStream (IStream * p_Stream)

// Points pStream to known stream object pointed by p_Stream
//		Parameters
// - p_Stream points to open stream object
{
	HRESULT hr;

	hr = p_Stream->QueryInterface(IID_IStream, (void **)&pStream);
	if (hr != S_OK)
	{
		pStream = NULL;
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
};
//--------------------------------------------------------------------------

EIF_INTEGER E_IStream::ccom_end_of_stream_reached()

// Returns 1 if current seek pointer at the end of the stream 
// and 0 otherwise
{
	EIF_INTEGER result = 0;
	HRESULT hr;
	ULONG bytes_read;
	char byte;
	LARGE_INTEGER li;
	ULARGE_INTEGER uli;

	LISet32(li, (DWORD)(0));
	hr = pStream->Seek (li, 1, &uli);

	hr = pStream->Read(&byte, 1, &bytes_read);
	if (FAILED(hr))
	{	
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
	else if (hr == S_FALSE)
	{
		com_eraise ("Data could not be read from stream", EN_PROG);
	}
	else if (1 > bytes_read)
	{
		result = 1;
	}
	else 
	{
		(li).HighPart = (uli).HighPart;
		(li).LowPart = (uli).LowPart;
		hr = pStream->Seek (li, 0, NULL);
		if (FAILED(hr))
		{
			com_eraise (f.c_format_message (hr), EN_PROG);
		}
	}
	return result;
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
	ULONG bytes_read;
	hr = pStream->Read(p_buffer, number_bytes, &bytes_read);
	
	if (FAILED(hr))
	{	
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
	else if (hr == S_FALSE)
	{
		com_eraise ("Data could not be read from stream", EN_PROG);
	}
	else if (number_bytes > bytes_read)
	{
		com_eraise ("end of stream is reached", E_end_of_stream);
	}
};
//-------------------------------------------------------------------------

EIF_CHARACTER E_IStream::ccom_read_character()

// Read character from stream
{
	HRESULT hr;
	ULONG bytes_read;
	EIF_CHARACTER character;
	hr = pStream->Read((void *)&character, (ULONG)sizeof(EIF_CHARACTER), &bytes_read);
	if (FAILED(hr))
	{	
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
	else if (hr == S_FALSE)
	{
		com_eraise ("Data could not be read from stream", EN_PROG);
	}
	else if (sizeof (EIF_CHARACTER) > bytes_read)
	{
		com_eraise ("end of stream is reached", E_end_of_stream);
	}
	return character;
};
//-------------------------------------------------------------------------

EIF_INTEGER E_IStream::ccom_read_integer()

// Read integer from stream
{
	HRESULT hr;
	ULONG bytes_read;
	EIF_INTEGER integer;
	hr = pStream->Read((void *)&integer, (ULONG)sizeof(EIF_INTEGER), &bytes_read);
	if (FAILED(hr))
	{	
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
	else if (hr == S_FALSE)
	{
		com_eraise ("Data could not be read from stream", EN_PROG);
	}
	else if (sizeof (EIF_INTEGER) > bytes_read)
	{
		com_eraise ("end of stream is reached", E_end_of_stream);
	}
	return integer;
};
//-------------------------------------------------------------------------

EIF_REAL E_IStream::ccom_read_real()

// Read real from stream
{
	HRESULT hr;
	ULONG bytes_read;
	EIF_REAL real;
	hr = pStream->Read((void *)&real, (ULONG)sizeof(EIF_REAL), &bytes_read);
	if (FAILED(hr))
	{	
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
	else if (hr == S_FALSE)
	{
		com_eraise ("Data could not be read from stream", EN_PROG);
	}
	else if (sizeof (EIF_REAL) > bytes_read)
	{
		com_eraise ("end of stream is reached", E_end_of_stream);
	}
	return real;
};
//-------------------------------------------------------------------------

EIF_BOOLEAN E_IStream::ccom_read_boolean()

// Read boolean from stream
{
	HRESULT hr;
	ULONG bytes_read;
	EIF_BOOLEAN boolean;
	hr = pStream->Read((void *)&boolean, (ULONG)sizeof(EIF_BOOLEAN), &bytes_read);
	if (FAILED(hr))
	{	
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
	else if (hr == S_FALSE)
	{
		com_eraise ("Data could not be read from stream", EN_PROG);
	}
	else if (sizeof (EIF_BOOLEAN) > bytes_read)
	{
		com_eraise ("end of stream is reached", E_end_of_stream);
	}
	return boolean;
};
//-------------------------------------------------------------------------

EIF_REFERENCE E_IStream::ccom_read_string()

// Read string from stream
{
	HRESULT hr;
	ULONG bytes_read;
	EIF_REFERENCE local_obj;
	char * string;
	EIF_INTEGER size;

	hr = pStream->Read((void *)&size, (ULONG)sizeof(EIF_INTEGER), &bytes_read);
	if (FAILED(hr))
	{	
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
	else if (hr == S_FALSE)
	{
		com_eraise ("Data could not be read from stream", EN_PROG);
	}
	else if (sizeof (EIF_INTEGER) > bytes_read)
	{
		com_eraise ("end of stream is reached", E_end_of_stream);
	}

	string = (char *)malloc(size + 1);
	hr = pStream->Read((void *)string, size + 1, &bytes_read);
	if (FAILED(hr))
	{	
		free (string);
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
	else if (hr == S_FALSE)
	{
		free (string);
		com_eraise ("Data could not be read from stream", EN_PROG);
	}
	else if (size + 1 > bytes_read)
	{
		free (string);
		com_eraise ("end of stream is reached", E_end_of_stream);
	}
	local_obj = RTMS((char *)string);
	free (string);
	return local_obj;
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
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
};
//-------------------------------------------------------------------------

void E_IStream::ccom_write_character (EIF_CHARACTER character)

// Writes `character' into stream

{
	HRESULT hr;
	hr = pStream->Write((void *)&character, (ULONG)sizeof(EIF_CHARACTER), NULL);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
};
//-------------------------------------------------------------------------

void E_IStream::ccom_write_integer (EIF_INTEGER integer)

// Writes `integer' into stream

{
	HRESULT hr;
	hr = pStream->Write((void *)&integer, (ULONG)sizeof(EIF_INTEGER), NULL);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
};
//-------------------------------------------------------------------------

void E_IStream::ccom_write_real (EIF_REAL real)

// Writes `real' into stream

{
	HRESULT hr;
	hr = pStream->Write((void *)&real, (ULONG)sizeof(EIF_REAL), NULL);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
};
//-------------------------------------------------------------------------

void E_IStream::ccom_write_boolean (EIF_BOOLEAN boolean)

// Writes `boolean' into stream

{
	HRESULT hr;
	hr = pStream->Write((void *)&boolean, (ULONG)sizeof(EIF_BOOLEAN), NULL);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
};
//-------------------------------------------------------------------------

void E_IStream::ccom_write_string (EIF_POINTER string)

// Writes `string' into stream
{
	HRESULT hr;
	EIF_INTEGER size;

	size = strlen ((char *) string);
	hr = pStream->Write((void *)&size, (ULONG)sizeof(EIF_INTEGER), NULL);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), EN_PROG);
	}

	hr = pStream->Write((void *)string, size + 1, NULL);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), EN_PROG);
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
		com_eraise (f.c_format_message (hr), EN_PROG);
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
		com_eraise (f.c_format_message (hr), EN_PROG);
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
		com_eraise (f.c_format_message (hr), EN_PROG);
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
		com_eraise (f.c_format_message (hr), EN_PROG);
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
		com_eraise (f.c_format_message (hr), EN_PROG);
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
		if (pstatstg->pwcsName != NULL)
			CoTaskMemFree (pstatstg->pwcsName);
		free (pstatstg);
		pstatstg = NULL;
		com_eraise (f.c_format_message (hr), EN_PROG);
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
		com_eraise (f.c_format_message (hr), EN_PROG);
	}
	return pClonedStream;
};
//-------------------------------------------------------------------------
