/*
 * REGISTRY.C
 *
 * Functions used by the class WEL_REGISTRY.
 *
 */

#ifndef __WEL_REGISTRY__
#	include "registry.h"
#endif
		

//////////////////////////////////////////////////////////////
//
//  Creation or opening of a key.
//

EIF_INTEGER cwin_reg_create_key(
		EIF_OBJ main_obj,
        EIF_INTEGER parent_key,
        EIF_POINTER keyName,
        EIF_INTEGER access_mode )
{
    HKEY phkResult;
    LONG result;
    EIF_PROC ep;
    EIF_TYPE_ID eti;
    EIF_OBJ eo;
	EIF_PROC SetDisposition;
	LPDWORD lpdwDisposition;

	// Get the cecil Id of class WEL_REGISTRY
    eti = eif_type_id ("WEL_REGISTRY");
    SetDisposition = eif_proc ("set_create_disposition_result", eti);
	lpdwDisposition = (LPDWORD)malloc(sizeof (DWORD));

    result = RegCreateKeyEx(
            (HKEY) parent_key ,						 	// handle of an open key
            (LPCTSTR)keyName,							// address of subkey name
            0,											// reserved
            REG_NONE,									// address of class string
			REG_OPTION_NON_VOLATILE,					// special options flag
			(REGSAM)access_mode,						// desired security access
			NULL,										// address of key security structure
            &phkResult,                                 // address of buffer for opened handle
			lpdwDisposition );							// address of disposition value buffer


	if (*lpdwDisposition==REG_CREATED_NEW_KEY)
		(SetDisposition)( eif_access (main_obj), EIF_TRUE  );
	else
		(SetDisposition)( eif_access (main_obj), EIF_FALSE );

    if( result != ERROR_SUCCESS )
    {
        return 0;
    }
    return (EIF_INTEGER)phkResult;
}

//////////////////////////////////////////////////////////////
//
//  Opening of a key.
//

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
//
//  Deletion of a key.
//

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
            (LPCTSTR)keyname,
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
	REG_KEY* RK;
	DWORD size;
	LONG result;

	
	size = 128;
	RK = (REG_KEY*)malloc (sizeof (REG_KEY));
	RK->name = (EIF_POINTER)malloc (size * sizeof (char));
	RK->class = (EIF_POINTER)malloc (size * sizeof (char));
	RK->LastWriteTime = (PFILETIME)malloc (sizeof (FILETIME));
	
	result = RegEnumKeyEx(
	(HKEY)key,
	(DWORD)index,
	(LPTSTR)RK->name,
	(LPDWORD)&size,
	NULL,
	(LPTSTR)RK->class,
	(LPDWORD)&size,
	RK->LastWriteTime );

	if (result == ERROR_SUCCESS) 
		return (EIF_POINTER)RK;
	return NULL;
}

//////////////////////////////////////////////////////////////
//
//  Closing of a key.
//

void cwin_reg_close_key( EIF_INTEGER key )
{
    RegCloseKey( (HKEY)key );
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
	
/*	FormatMessage (FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,    NULL,
			result, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
			(LPTSTR) &lpMsgBuf,    0,    NULL );// Display the string.

	MessageBox( NULL, lpMsgBuf, "GetLastError", MB_OK|MB_ICONINFORMATION );

	// Free the buffer.

	LocalFree( lpMsgBuf );*/

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
