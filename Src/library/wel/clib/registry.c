/*
 * REGISTRY.C
 *
 * Functions used by the class WEL_REGISTRY.
 *
 */
#ifndef __WEL_REGISTRY__
#	include "registry.h"
#endif
		

////////////////////////////////////////////////////////////
// Creation of a key if it does not exists. If it does, just
// open it. 
// This function returns the reference to the created/opened\
// key (default_pointer if it failed).


EIF_POINTER cwin_reg_create_key(
	EIF_POINTER parent_key,
	EIF_POINTER keyName,
	EIF_INTEGER access_mode
)
	{
	// Declarations
   	HKEY phkResult;
   	LONG result;
	LPDWORD lpdwDisposition;
	
	// Allocations
	lpdwDisposition = (LPDWORD)malloc(sizeof (DWORD));

	// Routine Body
	result = RegCreateKeyEx(
		(HKEY) parent_key,		// handle of an open key
		(LPCTSTR)keyName,		// address of subkey name
		0,						// reserved
		REG_NONE,				// address of class string
		REG_OPTION_NON_VOLATILE,// special options flag
		(REGSAM)access_mode,	// desired security access
		NULL,					// address of key security structure
		&phkResult,				// address of buffer for opened handle
		lpdwDisposition			// address of disposition value buffer
	);

	// Result
   	if (result == ERROR_SUCCESS)
		return (EIF_POINTER) phkResult;
	return NULL;
	}

//////////////////////////////////////////////////////////////
//  Opening of a key. This function returns the reference to
//  the opened key ( default_pointer if it failed ).

EIF_POINTER cwin_reg_open_key(
        EIF_POINTER parent_key,
        EIF_POINTER keyName,
        EIF_INTEGER access_mode)
	{
    HKEY key;
    LONG result;
	
    result = RegOpenKeyEx(
            (HKEY)parent_key ,
            (LPCTSTR)keyName,
            (DWORD)0,
            (REGSAM)access_mode,
            (PHKEY)&key);
    if( result == ERROR_SUCCESS )
	    return (EIF_POINTER)key;
	return NULL;
	}

//////////////////////////////////////////////////////////////
//  Deletion of a key.
//  Return TRUE whether the deletion worked.

EIF_BOOLEAN cwin_reg_delete_key(
		EIF_POINTER parent_key,
		EIF_POINTER keyName)
	{
	LONG result;

	result = RegDeleteKey (
		(HKEY)parent_key,
		(LPCTSTR)keyName);
	if (result == ERROR_SUCCESS)
		return EIF_TRUE;
	return EIF_FALSE;
	}

//////////////////////////////////////////////////////////////
//
//  Value setting of a key.
//

void cwin_reg_set_key_value(
	EIF_POINTER key,
	EIF_POINTER keyname,
	EIF_POINTER keyvalue
)
	{
    RegSetValueEx(
		(HKEY)key ,
		(char *)keyname,
		0,
		((REG_VALUE *)keyvalue)->type,
		((REG_VALUE *)keyvalue)->data,
		((REG_VALUE *)keyvalue)->length
	);
	}

//////////////////////////////////////////////////////////////
//
//  Enumeration of subkeys.
//

EIF_POINTER cwin_reg_enum_key(
	EIF_POINTER key,
	EIF_INTEGER index
)
	{
	TCHAR key_name[64];
	DWORD key_size = sizeof (key_name);
	DWORD key_size_increment = sizeof (key_name);
	DWORD last_key_size = key_size;
	TCHAR class_name[20];
	DWORD class_size = sizeof (class_name);
	DWORD class_size_increment = sizeof (class_name);
	DWORD last_class_size = class_size;
	LONG result = 0;

	REG_KEY* pRK = (REG_KEY*) calloc (sizeof (REG_KEY), 1);
	if (!pRK)
		goto error;

	pRK->LastWriteTime = (PFILETIME) calloc (sizeof (FILETIME), 1);
	if (! pRK->LastWriteTime)
		goto error_rk;

	result = RegEnumKeyEx(
		(HKEY) key,
		(DWORD) index,
		key_name,
		&key_size,
		NULL,
		class_name,
		&class_size,
		pRK->LastWriteTime
	);

	if (result == ERROR_SUCCESS)
		{
		pRK->name = (EIF_POINTER) malloc (key_size + 1);
		if (! pRK->name)
			goto error_last_write;

		memcpy (pRK->name, key_name, key_size);
		pRK->name[key_size] = '\0';

		pRK->KeyClass = (EIF_POINTER) malloc (class_size + 1);
		if (! pRK->KeyClass)
			goto error_name;

		memcpy (pRK->KeyClass, class_name, class_size + 1);
		pRK->KeyClass[class_size] = '\0';

		return (EIF_POINTER) pRK;
		}

	if (result == ERROR_MORE_DATA)
		{

		if (key_size != last_key_size)
			{
			pRK->name = malloc (key_size + 1);
			if (! pRK->name)
				goto error_class;
			strcpy (pRK->name, key_name);
			}

		if (class_size != last_class_size)
			{
			pRK->KeyClass = malloc (class_size + 1);
			if (! pRK->KeyClass)
				goto error_class;
			strcpy (pRK->KeyClass, class_name);
			}

		do	
			{
			if (key_size == last_key_size)
				{
				key_size += key_size_increment;
				if (pRK->name)
					free (pRK->name);
				pRK->name = malloc (key_size);
				if (! pRK->name)
					goto error_class;
				last_key_size = key_size;
				}

			if (class_size == last_class_size)
				{
				class_size += class_size_increment;
				if (pRK->KeyClass)
					free (pRK->KeyClass);
				pRK->KeyClass = malloc (class_size);
				if (! pRK->KeyClass)
					goto error_class;
				last_class_size = class_size;
				}

			result = RegEnumKeyEx(
				(HKEY) key,
				(DWORD) index,
				pRK->name,
				&key_size,
				NULL,
				pRK->KeyClass,
				&class_size,
				pRK->LastWriteTime
			);
		
			} while (result == ERROR_MORE_DATA);
		
		if (result == ERROR_SUCCESS)
			return (EIF_POINTER) pRK;
		}

	if (pRK->KeyClass)
		free (pRK->KeyClass);
	if (pRK->name)
		free (pRK->name);
	free (pRK->LastWriteTime);
	free (pRK);

	return 0;

// Allocation memory error
error_class:
	if (pRK->KeyClass)
		free (pRK->KeyClass);
error_name:
	if (pRK->name)
		free (pRK->name);
error_last_write:
	if (pRK->LastWriteTime)
		free (pRK->LastWriteTime);
error_rk:
	if (pRK)
		free (pRK);
error:
	enomem();
	return 0;
	}


/////////////////////////////////////////////////////
// Function which allows enumerate values for a given
// key. Return the a pointer of the name the value
// we are enumerating.

EIF_POINTER cwin_reg_enum_value(
	EIF_POINTER key,
	EIF_INTEGER index
)
	{
	DWORD size;
	LONG result;
	CHAR *name;
	
	size = 512;
	name = malloc(size*sizeof(CHAR));

	result = RegEnumValue(
		(HKEY)key,			// handle to key to query
		(DWORD)index,		// index of value to query
		(LPTSTR)name,		// value buffer
		(LPDWORD)&size,		// size of value buffer
		NULL,				// reserved
		NULL,				// type buffer
		NULL,				// data buffer
		NULL				// size of data buffer
	);

	if (result == ERROR_SUCCESS) 
		return (EIF_POINTER) name;
	return NULL;
	}

//////////////////////////////////////////////////////////////
//
// Deleting a key value
//

EIF_BOOLEAN cwin_reg_delete_value(EIF_POINTER key, EIF_POINTER value_name)
	{
	if (RegDeleteValue((HKEY)key, (LPCTSTR)value_name) == ERROR_SUCCESS)
		return EIF_TRUE;

	return EIF_FALSE;
	}

//////////////////////////////////////////////////////////////
//
//  Closing of a key.
//

EIF_BOOLEAN cwin_reg_close_key( EIF_POINTER key )
	{
    LONG result;
	
	result = RegCloseKey( (HKEY)key );
	if (result == ERROR_SUCCESS) 
		return EIF_TRUE;
	return EIF_FALSE;
	}

//////////////////////////////////////////////////////////////
//
//  Value accessing of a key.
//

EIF_POINTER cwin_reg_query_value(EIF_POINTER key, EIF_POINTER value_name)
	{
    LONG result;
    LONG bufferSize = 256;
	DWORD type;
    char* buffer;
	REG_VALUE* RV;

	buffer = (char *)malloc (bufferSize);	
    buffer[0] = 0;
	
    result = RegQueryValueEx(
		(HKEY)key,				// handle to key
        (LPCTSTR)value_name,	// value name
		NULL,					// reserved
		(LPDWORD)(&type),		// type buffer
        (LPBYTE)buffer,			// data buffer
        (LPDWORD)(&bufferSize)	// size of data buffer
	);
		
	if (result == ERROR_SUCCESS)
		{
		RV = (REG_VALUE*)malloc (sizeof (REG_VALUE));
		if (!RV)
			goto error_rv;
		RV->type = (DWORD)type;
		RV->data = (LPBYTE) buffer;
		RV->length = (DWORD)(bufferSize - 1);	//do not forget the \0 character!
		return (EIF_POINTER) RV;	
		}
	else
		{
		if (result == ERROR_MORE_DATA)
			{
			if (buffer)
				free (buffer);
			buffer = (char *)malloc (bufferSize); // bufferSize was set by RegQueryValueEx
			if (!buffer)
				goto error;
			result = RegQueryValueEx(
				(HKEY)key,
				(LPCTSTR)value_name,
				NULL,
				(LPDWORD)(&type),
				(LPBYTE)buffer,
				(LPDWORD)(&bufferSize)
			);
			if (result == ERROR_SUCCESS)
				{
				RV = (REG_VALUE*)malloc (sizeof (REG_VALUE));
				if (!RV)
					goto error_rv;
				RV->type = (DWORD)type;
				RV->data = (LPBYTE)buffer;
				RV->length = (DWORD)(bufferSize - 1); // do not forget the \0 character!
				return (EIF_POINTER) RV;
				}
			else
				{
				return NULL;
				}
			}
		else
			{
			return NULL;
			}
		}

/* Out of memory errors handling. */
error_rv:
	free (buffer);
error:
	enomem();
	return NULL;
}

//////////////////////////////////////////////////////////////
//
//  Default value accessing of a key.
//

EIF_POINTER cwin_reg_def_query_value(EIF_POINTER key, EIF_POINTER value_name)
	{
    LONG result;
    LONG charCount;
    char *buffer;
	REG_VALUE* RV;

	buffer = (char *)malloc (256);
    buffer[0] = 0;
    charCount = 255;
	
    result = RegQueryValue( (HKEY)key ,
        (LPTSTR)value_name,
        (LPTSTR)buffer,
        &charCount );
		
	if (result == ERROR_SUCCESS)
		{
		RV = (REG_VALUE*)malloc (sizeof (REG_VALUE));
		RV->type = (DWORD)0;
		RV->data = (LPBYTE)buffer;
		RV->length = (DWORD)charCount;
		return (EIF_POINTER) RV;	
		}
   	else
		{
		return NULL;
		}
}

EIF_INTEGER cwin_reg_subkey_number(
        EIF_POINTER key)
{
	LONG result;
	DWORD nbkeys;
	DWORD nbkey;
	DWORD lpcchMaxClassLen;
	DWORD lpcValues;

    result = RegQueryInfoKey ( (HKEY)key ,
        NULL,
		NULL,
		NULL,
		(LPDWORD) &nbkeys,
		(LPDWORD) &nbkey,
		(LPDWORD) &lpcchMaxClassLen,
		(LPDWORD) &lpcValues,
		NULL,
		NULL,
		NULL,
		NULL); 

		
	if (result == ERROR_SUCCESS)
		return (EIF_INTEGER) nbkeys;
	return (EIF_INTEGER) 0;
	}

EIF_INTEGER cwin_reg_value_number(EIF_POINTER key)
	{
	LONG result;
	DWORD nbkeys;
	DWORD nbkey;
	DWORD lpcchMaxClassLen;
	DWORD Values;

    result = RegQueryInfoKey ( (HKEY)key ,
        NULL,
		NULL,
		NULL,
		(LPDWORD) &nbkeys,
		(LPDWORD) &nbkey,
		(LPDWORD) &lpcchMaxClassLen,
		(LPDWORD) &Values,
		NULL,
		NULL,
		NULL,
		NULL
	); 

		
	if (result == ERROR_SUCCESS)
		return (EIF_INTEGER) Values;
	return (EIF_INTEGER) 0;
	}


void cwin_reg_value_destroy(EIF_POINTER reg_value)
	{
	REG_VALUE* pRV = (REG_VALUE*) reg_value;
	free (pRV->data);
	free (pRV);
	}

EIF_POINTER cwin_reg_connect_key(EIF_POINTER hostname, EIF_POINTER key)
	{
	LONG result;
	HKEY *phkResult;  // address of buffer for remote registry handle 
  
    result = RegConnectRegistry (
		(LPTSTR)hostname, 
		(HKEY)key ,
		(PHKEY) &phkResult
	);

	if (result == ERROR_SUCCESS)
		return (EIF_POINTER) phkResult;
	return NULL;
	}


/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-2000, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, ISE Building, 2nd floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
