/*
 * REGISTRY.C
 *
 * Functions used by the class WEL_REGISTRY.
 *
 */

#ifndef __WEL_REGISTRY__
#	include <registry.h>
#endif

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
            (HKEY) parent_key ,		 	// handle of an open key
            (LPCTSTR)keyName,			// address of subkey name
            0,							// reserved
            REG_NONE,					// address of class string
			REG_OPTION_NON_VOLATILE,	// special options flag
			(REGSAM)access_mode,		// desired security access
			NULL,						// address of key security structure
            &phkResult,					// address of buffer for opened handle
			lpdwDisposition );			// address of disposition value buffer


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

//---------------------------------------------------------------------------

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
    if( result != ERROR_SUCCESS )
    {
        return 0;
    }
    return (EIF_INTEGER)key;
}

//---------------------------------------------------------------------------

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
//---------------------------------------------------------------------------

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



//---------------------------------------------------------------------------

void cwin_reg_close_key( EIF_INTEGER key )
{
    LONG result;

    result = RegCloseKey( (HKEY)key );
}

//---------------------------------------------------------------------------

void cwin_reg_query_value(
        EIF_INTEGER key, EIF_POINTER value_name )
{
    LONG result;
    LONG charCount;
	DWORD type;
    static char buffer[256];

    buffer[0] = 0;
    charCount = sizeof( buffer ) - 1;
    result = RegQueryValueEx( (HKEY)key ,
        (LPTSTR)value_name,
		NULL,
		&type,
        (LPTSTR)buffer,
        &charCount );
	g_type = type;
	g_buffer = buffer;
	g_length = charCount;
}

//---------------------------------------------------------------------------

EIF_INTEGER cwin_reg_value_type()
{
	return (EIF_INTEGER)g_type;
}

//---------------------------------------------------------------------------

EIF_POINTER cwin_reg_value_data()
{
	return (EIF_POINTER)g_buffer;
}

//---------------------------------------------------------------------------

EIF_INTEGER cwin_reg_value_length()
{
	return (EIF_INTEGER)g_length;
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
