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
// key (0 if it failed).


EIF_INTEGER cwin_reg_create_key(
		EIF_INTEGER parent_key,
        	EIF_POINTER keyName,
        	EIF_INTEGER access_mode )
{
	// Declarations
    	HKEY phkResult;
    	LONG result;
	LPDWORD lpdwDisposition;
	
	// Allocations
	lpdwDisposition = (LPDWORD)malloc(sizeof (DWORD));

	// Routine Body
	result = RegCreateKeyEx(
            	(HKEY) parent_key ,		// handle of an open key
            	(LPCTSTR)keyName,		// address of subkey name
            	0,											// reserved
            	REG_NONE,									// address of class string
		REG_OPTION_NON_VOLATILE,	// special options flag
		(REGSAM)access_mode,		// desired security access
		NULL,				// address of key security structure
            	&phkResult,                     // address of buffer for opened handle
		lpdwDisposition );		// address of disposition value buffer

	// Result
    	if( result = ERROR_SUCCESS )
		return (EIF_INTEGER) phkResult;
        return 0;
}

//////////////////////////////////////////////////////////////
//  Opening of a key. This function returns the reference to
//  the opened key ( 0 if it failed ).

EIF_INTEGER cwin_reg_open_key(
        EIF_INTEGER parent_key,
        EIF_POINTER keyName,
        EIF_INTEGER access_mode )
{
    HKEY key;
    LONG result;
	LPSECURITY_ATTRIBUTES lpSecurityAttributes;
	LPDWORD lpdwDisposition;
	
    result = RegOpenKeyEx(
            (HKEY)parent_key ,
            (LPCTSTR)keyName,
            (DWORD)0,
            (REGSAM)access_mode,
            (PHKEY)&key);
    if( result == ERROR_SUCCESS )
	    return (EIF_INTEGER)key;
	return 0;
}

//////////////////////////////////////////////////////////////
//  Deletion of a key.
//  Return TRUE whether the deletion worked.

EIF_BOOLEAN cwin_reg_delete_key(
		EIF_INTEGER parent_key,
		EIF_POINTER keyName )
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
        EIF_INTEGER key,
        EIF_POINTER keyname,
        EIF_POINTER keyvalue )
{
    HKEY key_result;
    LONG result;


    result = RegSetValueEx(
            (HKEY)key ,
            (char *)keyname,
            0,
            ((REG_VALUE *)keyvalue)->type,
			((REG_VALUE *)keyvalue)->data,
            ((REG_VALUE *)keyvalue)->length );
}

//////////////////////////////////////////////////////////////
//
//  Enumeration of subkeys.
//

EIF_POINTER cwin_reg_enum_key(
		EIF_INTEGER key,
		EIF_INTEGER index )
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
	if (! pRK)
		goto error;

	pRK->LastWriteTime = (PFILETIME) calloc (sizeof (FILETIME), 1);
	if (! pRK->LastWriteTime)
		goto error_rk;

	result = RegEnumKeyEx	((HKEY) key,
												(DWORD) index,
												key_name,
												&key_size,
												NULL,
												class_name,
												&class_size,
												pRK->LastWriteTime);

	if (result == ERROR_SUCCESS)	{
		pRK->name = (EIF_POINTER) malloc (key_size + 1);
		if (! pRK->name)
			goto error_last_write;

		memcpy (pRK->name, key_name, key_size);
		pRK->name[key_size] = '\0';

		pRK->class = (EIF_POINTER) malloc (class_size + 1);
		if (! pRK->class)
			goto error_name;

		memcpy (pRK->class, class_name, class_size + 1);
		pRK->class[class_size] = '\0';

		return (EIF_POINTER) pRK;
	}

	if (result == ERROR_MORE_DATA)	{

		if (key_size != last_key_size)	{
			pRK->name = malloc (key_size + 1);
			if (! pRK->name)
				goto error_class;
			strcpy (pRK->name, key_name);
		}

		if (class_size != last_class_size)	{
			pRK->class = malloc (class_size + 1);
			if (! pRK->class)
				goto error_class;
			strcpy (pRK->class, class_name);
		}

		do	{
			if (key_size == last_key_size)	{
				key_size += key_size_increment;
				if (pRK->name)
					free (pRK->name);
				pRK->name = malloc (key_size);
				if (! pRK->name)
					goto error_class;
				last_key_size = key_size;
			}

			if (class_size == last_class_size)	{
				class_size += class_size_increment;
				if (pRK->class)
					free (pRK->class);
				pRK->class = malloc (class_size);
				if (! pRK->class)
					goto error_class;
				last_class_size = class_size;
			}

			result = RegEnumKeyEx	((HKEY) key,
														(DWORD) index,
														pRK->name,
														&key_size,
														NULL,
														pRK->class,
														&class_size,
														pRK->LastWriteTime);
		} while (result == ERROR_MORE_DATA);
		
		if (result == ERROR_SUCCESS)
			return (EIF_POINTER) pRK;
	}

	if (pRK->class)
		free (pRK->class);
	if (pRK->name)
		free (pRK->name);
	free (pRK->LastWriteTime);
	free (pRK);

	return 0;

error_class:
	if (pRK->class)
		free (pRK->class);
error_name:
	if (pRK->name)
		free (pRK->name);
error_last_write:
	if (pRK->LastWriteTime);
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
		EIF_INTEGER key,
		EIF_INTEGER index )
{
	REG_VALUE* RK;
	DWORD size;
	LONG result;
	CHAR *name;
	
	size = 512;
	RK = (REG_VALUE *) malloc (sizeof (REG_VALUE));
	RK->data = (EIF_POINTER) malloc(32* sizeof (BYTE));  
	name=malloc(size*sizeof(CHAR));

	result = RegEnumValue(
	(HKEY)key,
	(DWORD)index,
	(LPWSTR)name,
	(LPDWORD)&size,
	NULL,
	(LPDWORD) &(RK->type),
	//(LPBYTE) &(RK->data),
	NULL,
	(LPDWORD) &(RK->length));

	if (result == ERROR_SUCCESS) 
		return (EIF_POINTER) name;
	return NULL;

}

//////////////////////////////////////////////////////////////
/// Deleting a key value
//////////////////////////////////////////////////////////////

EIF_BOOLEAN cwin_reg_delete_value(EIF_INTEGER key, EIF_POINTER value_name)
{

	long result;
	HKEY hKey;
	LPCWSTR lpszValueName;
	
	lpszValueName=value_name;
	result = RegDeleteValue((HKEY)key, (LPCWSTR)lpszValueName);
	if (result == ERROR_SUCCESS) 
			return EIF_TRUE;
	return EIF_FALSE;
}

//////////////////////////////////////////////////////////////
//
//  Closing of a key.
//

EIF_BOOLEAN cwin_reg_close_key( EIF_INTEGER key )
{
    long result;
	
	result = RegCloseKey( (HKEY)key );
	if (result == ERROR_SUCCESS) 
		return EIF_TRUE;
	return EIF_FALSE;
}

//////////////////////////////////////////////////////////////
//
//  Value accessing of a key.
//

EIF_POINTER cwin_reg_query_value(
        EIF_INTEGER key, EIF_POINTER value_name )
{
    LONG result;
    LONG charCount;
	DWORD type;
    char* buffer;
	REG_VALUE* RV;
//	LPVOID lpMsgBuf;

	buffer = (char *)malloc (256);	
    buffer[0] = 0;
    charCount = 255;
	
    result = RegQueryValueEx( (HKEY)key ,
        (LPTSTR)value_name,
		NULL,
		&type,
        (LPTSTR)buffer,
        &charCount );
		
	if (result == ERROR_SUCCESS) {
		RV = (REG_VALUE*)malloc (sizeof (REG_VALUE));
		RV->type = type;
		RV->data = buffer;
		RV->length = charCount;
		return (EIF_POINTER) RV;	
	}

}

//////////////////////////////////////////////////////////////
//
//  Default value accessing of a key.
//

EIF_POINTER cwin_reg_def_query_value(
        EIF_INTEGER key, EIF_POINTER value_name )
{
    LONG result;
    LONG charCount;
	DWORD type;
    char *buffer;
	REG_VALUE* RV;
//	LPVOID lpMsgBuf;

	buffer = (char *)malloc (256);
    buffer[0] = 0;
    charCount = 255;
	
    result = RegQueryValue( (HKEY)key ,
        (LPTSTR)value_name,
        (LPTSTR)buffer,
        &charCount );
		
	if (result == ERROR_SUCCESS){
		RV = (REG_VALUE*)malloc (sizeof (REG_VALUE));
		RV->type = 0;
		RV->data = buffer;
		RV->length = charCount;
		return (EIF_POINTER) RV;	
	}
}

EIF_INTEGER cwin_reg_subkey_number(
        EIF_INTEGER key)
{
	LONG result;
	DWORD nbkeys;
	DWORD nbkey;
	LPDWORD lpcchMaxClassLen;
	LPDWORD lpcValues;

    result = RegQueryInfoKey ( (HKEY)key ,
        NULL,
		NULL,
		NULL,
		(LPDWORD) &nbkeys,
		(LPDWORD) &nbkey,
		(LPDWORD)lpcchMaxClassLen,
		(LPDWORD)lpcValues,
		NULL,
		NULL,
		NULL,
		NULL); 

		
	if (result == ERROR_SUCCESS)
		return (EIF_INTEGER) nbkeys;
	return (EIF_INTEGER) 0;

}

EIF_INTEGER cwin_reg_value_number(
        EIF_INTEGER key)
{
	LONG result;
	DWORD nbkeys;
	DWORD nbkey;
	LPDWORD lpcchMaxClassLen;
	DWORD Values;

    result = RegQueryInfoKey ( (HKEY)key ,
        NULL,
		NULL,
		NULL,
		(LPDWORD) &nbkeys,
		(LPDWORD) &nbkey,
		(LPDWORD)lpcchMaxClassLen,
		(LPDWORD) &Values,
		NULL,
		NULL,
		NULL,
		NULL); 

		
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

EIF_INTEGER cwin_reg_connect_key(EIF_POINTER hostname,
        EIF_INTEGER key)
{
	LONG result;
	HKEY *phkResult;  // address of buffer for remote registry handle 
  
    result = RegConnectRegistry (
		(LPTSTR)hostname, 
		(HKEY)key ,
		(PHKEY) &phkResult);

	if (result == ERROR_SUCCESS)
		return (EIF_POINTER) phkResult;
	return NULL;

}


/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, ISE Building, 2nd floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
