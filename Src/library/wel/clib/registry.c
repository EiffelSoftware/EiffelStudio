/*
 * ESTREAM.C
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

	// Get the cecil Id of class EOLE_REGISTRY
    eti = Dtype( eif_access(main_obj) ) ;
    SetDisposition = eif_proc("set_create_disposition_result",eti);
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

EIF_INTEGER cwin_reg_set_key_value(
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
            REG_SZ,
			(CONST BYTE *)keyvalue,
            strlen(keyvalue)*sizeof(char) );
}



//---------------------------------------------------------------------------

void cwin_reg_close_key( EIF_INTEGER key )
{
    LONG result;

    result = RegCloseKey( (HKEY)key );
}

//---------------------------------------------------------------------------

EIF_POINTER cwin_reg_query_value(
        EIF_INTEGER key, EIF_POINTER value_name )
{
    LONG result;
    LONG charCount;
    static char buffer[256];

    buffer[0] = 0;
    charCount = sizeof( buffer ) - 1;
    result = RegQueryValue( (HKEY)key ,
        (LPCTSTR)value_name,
        (LPTSTR)buffer,
        &charCount );

    return (EIF_POINTER)buffer;
}

