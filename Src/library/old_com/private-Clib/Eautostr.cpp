//---------------------------------------------------------------------------
//indexing
//   title:         "Miscellaneous OLE structures support";
//   copyright:     "ISE Inc.", 1997;
//---------------------------------------------------------------------------

#include "eifole.h"

//---------------------------------------------------------------------------
// This file contains support for various structures necessary
// in OLE automation
//---------------------------------------------------------------------------

extern "C" void eole2_free_pointer( EIF_POINTER ptr )
{
    if( ptr != 0 )
        free( ptr );
}

//---------------------------------------------------------------------------
// VARIANT & VARIANTARG support
//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_variant_alloc( void )
{
    EIF_POINTER varPtr = 0;
    varPtr = (EIF_POINTER) malloc (sizeof(VARIANT));
    return varPtr;
}

//---------------------------------------------------------------------------

extern "C" void eole2_variant_free( EIF_POINTER ptr )
{
    if( ptr )
    {
        free( ptr );
    }
}

//---------------------------------------------------------------------------

extern "C" void eole2_variant_init( EIF_POINTER ptr )
{
    VariantInit( (VARIANTARG*)ptr );
}

//---------------------------------------------------------------------------

extern "C" void eole2_variant_clear( EIF_POINTER ptr )
{
    HRESULT result;
    result = VariantClear( (VARIANTARG*)ptr );
}

//---------------------------------------------------------------------------

extern "C" void eole2_variant_copy(
        EIF_POINTER ptr_dest, EIF_POINTER ptr_source )
{
    HRESULT result;
    result = VariantCopy( (VARIANTARG*)ptr_dest, (VARIANTARG*)ptr_source );
}

//---------------------------------------------------------------------------

extern "C" void eole2_variant_change_type( EIF_POINTER ptr,
        EIF_INTEGER newtype )
{
    HRESULT result;
    result = VariantChangeType(
            (VARIANTARG*)ptr, (VARIANTARG*)ptr,
            0, (VARTYPE)newtype );
}

//---------------------------------------------------------------------------

extern "C" void eole2_variant_clone_with_new_type( EIF_POINTER ptr_dest,
        EIF_POINTER ptr_src, EIF_INTEGER newtype )
{
    HRESULT result;
    result = VariantChangeType(
            (VARIANTARG*)ptr_dest, (VARIANTARG*)ptr_src,
            0, (VARTYPE)newtype );
}

//---------------------------------------------------------------------------

extern "C" void eole2_var_set_no_param (EIF_POINTER ptr) {
   VARIANT *v = (VARIANT*)ptr;
   v->vt    = VT_ERROR;
   v->scode = DISP_E_PARAMNOTFOUND;
}

/////////////////////////////////////////////////////////////////////////////

extern "C" void eole2_var_set_vartype (EIF_POINTER ptr, EIF_INTEGER vartype) {
   ((VARIANT*)ptr)->vt = (VARTYPE)vartype;
}

//---------------------------------------------------------------------------

extern "C" void eole2_var_set_character ( EIF_POINTER ptr, EIF_CHARACTER ch )
{
    VARIANT* v = (VARIANT*)ptr;
    v->vt = (VARTYPE)VT_I1;
    v->iVal = (unsigned char)ch;
}

//---------------------------------------------------------------------------

extern "C" void eole2_var_set_integer2( EIF_POINTER ptr, EIF_INTEGER int2 )
{
    VARIANT* v = (VARIANT*)ptr;
    v->vt = (VARTYPE)VT_I2;
    v->iVal = (short)int2;
}

//---------------------------------------------------------------------------

extern "C" void eole2_var_set_integer4( EIF_POINTER ptr, EIF_INTEGER int4 )
{
    VARIANT* v = (VARIANT*)ptr;
    v->vt = (VARTYPE)VT_I4;
    v->lVal = (long)int4;
}

//---------------------------------------------------------------------------

extern "C" void eole2_var_set_real4( EIF_POINTER ptr, EIF_REAL real4 )
{
    VARIANT* v = (VARIANT*)ptr;
    v->vt = (VARTYPE)VT_R4;
    v->fltVal = (float)real4;
}

//---------------------------------------------------------------------------

extern "C" void eole2_var_set_real8( EIF_POINTER ptr, EIF_REAL real8 )
{
    VARIANT* v = (VARIANT*)ptr;
    v->vt = (VARTYPE)VT_R8;
    v->dblVal = (float)real8;
}

//---------------------------------------------------------------------------

extern "C" void eole2_var_set_bool( EIF_POINTER ptr, EIF_BOOLEAN boolean)
{
    VARIANT* v = (VARIANT*)ptr;
    v->vt = (VARTYPE)VT_BOOL;
    v->boolVal = (VARIANT_BOOL)boolean; // VARIANT_TRUE = -1, VARIANT_FALSE = 0
}

//---------------------------------------------------------------------------


extern "C" void eole2_var_set_error (EIF_POINTER ptr, EIF_INTEGER code) {
   VARIANT FAR * v = (VARIANT FAR *)ptr;
   v->vt = (VARTYPE)VT_ERROR;
   v->scode = (SCODE)code;
}
//---------------------------------------------------------------------------

extern "C" void eole2_var_set_currency( EIF_POINTER ptr,
        EIF_INTEGER lo, EIF_INTEGER hi )
{
    VARIANT* v = (VARIANT*)ptr;
    v->vt = (VARTYPE)VT_CY;
#ifdef EIF_BORLAND
    v->cyVal.s.Lo = lo;
    v->cyVal.s.Hi = hi;
#else
    v->cyVal.Lo = lo;
    v->cyVal.Hi = hi;
#endif /* EIF_BORLAND */
}

//---------------------------------------------------------------------------

extern "C" void eole2_var_set_date( EIF_POINTER ptr, EIF_REAL date )
{
    VARIANT* v = (VARIANT*)ptr;
    v->vt = (VARTYPE)VT_DATE;
    v->date = (DATE)date;
}

//---------------------------------------------------------------------------

extern "C" void eole2_var_set_bstr( EIF_POINTER ptr, EIF_POINTER bstr )
{
    VARIANT* v = (VARIANT*)ptr;
    v->vt = (VARTYPE)VT_BSTR;
    v->bstrVal = (BSTR)bstr;
}

//---------------------------------------------------------------------------

extern "C" void eole2_var_set_unknown( EIF_POINTER ptr, EIF_POINTER unk )
{
    VARIANT* v = (VARIANT*)ptr;
    v->vt = (VARTYPE)VT_UNKNOWN;
    v->punkVal = (IUnknown*)unk;
}

//---------------------------------------------------------------------------

extern "C" void eole2_var_set_dispatch( EIF_POINTER ptr, EIF_POINTER disp )
{
    VARIANT* v = (VARIANT*)ptr;
    v->vt = (VARTYPE)VT_DISPATCH;
    v->pdispVal = (IDispatch*)disp;
}

//---------------------------------------------------------------------------

extern "C" void eole2_var_set_safearray( EIF_POINTER ptr, EIF_POINTER sa )
{
    VARIANT* v = (VARIANT*)ptr;
    v->vt = (VARTYPE)VT_ARRAY;
    v->parray = (SAFEARRAY*)sa;
}

//---------------------------------------------------------------------------

extern "C" void eole2_var_set_by_reference(
        EIF_POINTER varptr,
        EIF_POINTER value_ptr,
        EIF_INTEGER vartype )
{
    VARIANT* v = (VARIANT*)varptr;
    v->vt = (VARTYPE)vartype | VT_BYREF;
    switch( vartype )
    {
        case VT_I2:
            v->piVal = (short*)value_ptr;
        break;
        case VT_I4:
            v->plVal = (long*)value_ptr;
        break;
        case VT_R4:
            v->pfltVal = (float*)value_ptr;
        break;
        case VT_R8:
            v->pdblVal = (double*)value_ptr;
        break;
        case VT_BOOL:
#ifdef EIF_BORLAND
            v->pbool = (VARIANT_BOOL*)value_ptr;
#else
            v->pboolVal = (VARIANT_BOOL*)value_ptr;
#endif /* EIF_BORLAND */
        break;
        case VT_CY:
            v->pcyVal = (CY*)value_ptr;
        break;
        case VT_DATE:
            v->pdate = (DATE*)value_ptr;
        break;
        case VT_BSTR:
            v->pbstrVal = (BSTR*)value_ptr;
        break;
        case VT_UNKNOWN:
            v->ppunkVal = (IUnknown**)value_ptr;
        break;
        case VT_DISPATCH:
            v->ppdispVal = (IDispatch**)value_ptr;
        break;
        default:
            eole2_variant_clear( varptr );
    }
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_var_get_type( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    return (EIF_INTEGER)v->vt;
}

//---------------------------------------------------------------------------

extern "C" EIF_CHARACTER eole2_var_get_character ( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
        return (EIF_CHARACTER) *(v->piVal);
    return (EIF_CHARACTER)v->iVal;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_var_get_integer2( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
        return (EIF_INTEGER) *(v->piVal);
    return (EIF_INTEGER)v->iVal;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_var_get_integer4( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
        return (EIF_INTEGER) *(v->plVal);
    return (EIF_INTEGER)v->lVal;
}

//---------------------------------------------------------------------------

extern "C" EIF_REAL eole2_var_get_real4( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
        return (EIF_REAL) *(v->pfltVal);
    return (EIF_REAL)v->fltVal;
}

//---------------------------------------------------------------------------

extern "C" EIF_REAL eole2_var_get_real8( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
        return (EIF_REAL) *(v->pdblVal);
    return (EIF_REAL)v->dblVal;
}

//---------------------------------------------------------------------------

extern "C" EIF_BOOLEAN eole2_var_get_boolean( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
#ifdef EIF_BORLAND
        return (EIF_BOOLEAN) *(v->pbool);
#else
        return (EIF_BOOLEAN) *(v->pboolVal);
#endif /* EIF_BORLAND */
#pragma warning (disable: 4237)
    return (EIF_BOOLEAN)(v->boolVal);
#pragma warning (default: 4237)
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_var_get_error (EIF_POINTER ptr)
{
    VARIANT FAR * v = (VARIANT FAR *)ptr;
    if( v->vt & VT_BYREF )
        return (EIF_INTEGER) *(v->pscode);
    return (EIF_INTEGER)v->scode;
}


//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_var_get_currency_lo( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
#ifdef EIF_BORLAND
        return (EIF_INTEGER)v->pcyVal->s.Lo;
#else
        return (EIF_INTEGER)v->pcyVal->Lo;
#endif /* EIF_BORLAND */
#ifdef EIF_BORLAND
    return (EIF_INTEGER)v->cyVal.s.Lo;
#else
    return (EIF_INTEGER)v->cyVal.Lo;
#endif /* EIF_BORLAND */
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_var_get_currency_hi( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
#ifdef EIF_BORLAND
        return (EIF_INTEGER)v->pcyVal->s.Hi;
#else
        return (EIF_INTEGER)v->pcyVal->Hi;
#endif /* EIF_BORLAND */
#ifdef EIF_BORLAND
    return (EIF_INTEGER)v->cyVal.s.Hi;
#else
    return (EIF_INTEGER)v->cyVal.Hi;
#endif /* EIF_BORLAND */
}

//---------------------------------------------------------------------------

extern "C" EIF_REAL eole2_var_get_date( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
        return (EIF_INTEGER) *(v->pdate);
    return (EIF_INTEGER)v->date;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_var_get_bstr( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
        return (EIF_POINTER) *(v->pbstrVal);
    return (EIF_POINTER)v->bstrVal;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_var_get_unknown( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
        return (EIF_POINTER) *(v->ppunkVal);
    return (EIF_POINTER)v->punkVal;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_var_get_dispatch( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
        return (EIF_POINTER) *(v->ppdispVal);
    return (EIF_POINTER)v->pdispVal;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_var_get_safearray( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
        return 0;
    return (EIF_POINTER)v->parray;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_var_get_by_ref_type (EIF_POINTER ptr) {
   return (EIF_INTEGER)((((VARIANT*) ptr)->vt)&(~VT_BYREF));
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_var_get_by_ref_ptr (EIF_POINTER ptr)
{
    VARIANT* v = (VARIANT*)ptr;
    VARTYPE  vartype;
    EIF_POINTER result;

    vartype = (v->vt)&(~VT_BYREF);

    switch( vartype )
    {
        case VT_I2:
            result = (EIF_POINTER)v->piVal;
        break;
        case VT_I4:
            result = (EIF_POINTER)v->plVal;
        break;
        case VT_R4:
            result = (EIF_POINTER)v->pfltVal;
        break;
        case VT_R8:
            result = (EIF_POINTER)v->pdblVal;
        break;
        case VT_BOOL:
#ifdef EIF_BORLAND
            result = (EIF_POINTER)v->pbool;
#else
            result = (EIF_POINTER)v->pboolVal;
#endif /* EIF_BORLAND */
        break;
        case VT_CY:
            result = (EIF_POINTER)v->pcyVal;
        break;
        case VT_DATE:
            result = (EIF_POINTER)v->pdate;
        break;
        case VT_BSTR:
            result = (EIF_POINTER)v->pbstrVal;
        break;
        case VT_UNKNOWN:
            result = (EIF_POINTER)v->ppunkVal;
        break;
        case VT_DISPATCH:
            result = (EIF_POINTER)v->ppdispVal;
        break;
        default:
            result = 0;
    }

    return result;
}


/*extern "C" EIF_POINTER eole2_var_get_by_ref( EIF_POINTER ptr ,
                                               EIF_INTEGER vartype )
{
    VARIANT* v = (VARIANT*)ptr;
    EIF_POINTER result;

    switch( vartype )
    {
        case VT_I2:
            result = (EIF_POINTER)v->piVal;
        break;
        case VT_I4:
            result = (EIF_POINTER)v->plVal;
        break;
        case VT_R4:
            result = (EIF_POINTER)v->pfltVal;
        break;
        case VT_R8:
            result = (EIF_POINTER)v->pdblVal;
        break;
        case VT_BOOL:
            result = (EIF_POINTER)v->pbool;
        break;
        case VT_CY:
            result = (EIF_POINTER)v->pcyVal;
        break;
        case VT_DATE:
            result = (EIF_POINTER)v->pdate;
        break;
        case VT_BSTR:
            result = (EIF_POINTER)v->pbstrVal;
        break;
        case VT_UNKNOWN:
            result = (EIF_POINTER)v->ppunkVal;
        break;
        case VT_DISPATCH:
            result = (EIF_POINTER)v->ppdispVal;
        break;
        default:
            result = 0;
    }

    return result;
} */

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// DISPPARAMS support
//---------------------------------------------------------------------------

#define MAXPARAMS 40 // Like in Microsoft's TiBrowse Sample.

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_allocate_dispparams( void )
{
    DISPPARAMS* ptr = 0;
    int i;

    ptr = (DISPPARAMS*)malloc (sizeof (DISPPARAMS));
    ptr->rgvarg = (VARIANTARG FAR*)malloc (sizeof (VARIANTARG)*MAXPARAMS);
    ptr->rgdispidNamedArgs = (DISPID FAR *)malloc (sizeof (DISPID)*MAXPARAMS);
	ptr->cArgs = 0;
	ptr->cNamedArgs = 0;


    for( i = 0; i < MAXPARAMS; i++ )
    {
        VariantInit( ptr->rgvarg + i );
    }

    return (EIF_POINTER)ptr;
}

//---------------------------------------------------------------------------

extern "C" void eole2_destroy_dispparams( EIF_POINTER ptr )
{
    int i;
	HRESULT result;
    DISPPARAMS* p = (DISPPARAMS*)ptr;

    for( i = 0; i < (int)p->cArgs; i++ )
    {
        result = VariantClear( p->rgvarg + i );
    }

    free( p );
}

//---------------------------------------------------------------------------

extern "C" void eole2_reset_dispparams( EIF_POINTER ptr )
{
    int i;
    HRESULT result;
    DISPPARAMS* p = (DISPPARAMS*)ptr;

    for( i = 0; i < (int)p->cArgs; i++ )
    {
        result = VariantClear( p->rgvarg + i );
    }

    p->cArgs = 0;
    p->cNamedArgs = 0;
}

//---------------------------------------------------------------------------

extern "C" void eole2_add_dispparams_arg( EIF_POINTER ptr,
        EIF_POINTER variant )
{
    HRESULT result;
    DISPPARAMS* p = (DISPPARAMS*)ptr;

    result = VariantCopy( p->rgvarg + p->cArgs,
                    (VARIANT*)variant );
    p->cArgs++;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_get_dispparams_arg( EIF_POINTER ptr, EIF_INTEGER num )
{
    DISPPARAMS* p = (DISPPARAMS*)ptr;
    return (EIF_POINTER)(p->rgvarg + num);
}

//---------------------------------------------------------------------------

extern "C" void eole2_put_dispparams_arg( EIF_POINTER ptr,
        EIF_INTEGER num, EIF_POINTER variant )
{
    HRESULT result;
    DISPPARAMS* p = (DISPPARAMS*)ptr;

    result = VariantClear( p->rgvarg + num );
    result = VariantCopy( p->rgvarg + num, (VARIANT*)variant );
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_get_dispparams_args( EIF_POINTER ptr )
{
    DISPPARAMS* p = (DISPPARAMS*)ptr;
    return (EIF_INTEGER)p->cArgs;
}

//---------------------------------------------------------------------------

extern "C" void eole2_add_dispparams_dispid( EIF_POINTER ptr,
        EIF_INTEGER dispid )
{
    DISPPARAMS* p = (DISPPARAMS*)ptr;
    p->rgdispidNamedArgs[p->cNamedArgs] = (DISPID)dispid;
    p->cNamedArgs++;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_get_dispparams_dispid( EIF_POINTER ptr,
        EIF_INTEGER pos )
{
    DISPPARAMS* p = (DISPPARAMS*)ptr;
    return (EIF_INTEGER)p->rgdispidNamedArgs[pos];
}

//---------------------------------------------------------------------------

extern "C" void eole2_put_dispparams_dispid( EIF_POINTER ptr,
        EIF_INTEGER pos, EIF_INTEGER dispid )
{
    DISPPARAMS* p = (DISPPARAMS*)ptr;
    p->rgdispidNamedArgs[pos] = (DISPID)dispid;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_get_dispparams_dispids_number( EIF_POINTER ptr )
{
    DISPPARAMS* p = (DISPPARAMS*)ptr;
    return (EIF_INTEGER)p->cNamedArgs;
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// EXCEPINFO support
//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_excepinfo_allocate( void )
{
    return (EIF_POINTER)malloc (sizeof(EXCEPINFO));
}

//---------------------------------------------------------------------------

extern "C" void eole2_excepinfo_reset( EIF_POINTER ptr )
{
    EXCEPINFO* pEx = (EXCEPINFO*)ptr;

    SysFreeString( pEx->bstrSource );
    SysFreeString( pEx->bstrDescription );
    SysFreeString( pEx->bstrHelpFile );

    memset( pEx, 0, sizeof( EXCEPINFO));
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_excepinfo_get_error_code( EIF_POINTER ptr )
{
    EXCEPINFO* pEx = (EXCEPINFO*)ptr;
    return pEx->wCode;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_excepinfo_get_error_source( EIF_POINTER ptr )
{
    EXCEPINFO* pEx = (EXCEPINFO*)ptr;
    return (EIF_POINTER)pEx->bstrSource;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_excepinfo_get_error_description( EIF_POINTER ptr )
{
    EXCEPINFO* pEx = (EXCEPINFO*)ptr;
    return (EIF_POINTER)pEx->bstrDescription;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_excepinfo_get_help_file( EIF_POINTER ptr )
{
    EXCEPINFO* pEx = (EXCEPINFO*)ptr;
    return (EIF_POINTER)pEx->bstrHelpFile;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_excepinfo_get_ole_error_code( EIF_POINTER ptr )
{
    EXCEPINFO* pEx = (EXCEPINFO*)ptr;
    return pEx->scode;
}

//---------------------------------------------------------------------------

extern "C" void eole2_excepinfo_set_error_code(
        EIF_POINTER ptr, EIF_INTEGER code )
{
    EXCEPINFO* pEx = (EXCEPINFO*)ptr;
    pEx->wCode = (unsigned short)code;
}

//---------------------------------------------------------------------------

extern "C" void eole2_excepinfo_set_error_source(
        EIF_POINTER ptr, EIF_POINTER string )
{
    EXCEPINFO* pEx = (EXCEPINFO*)ptr;
    pEx->bstrSource = (BSTR)string;
}

//---------------------------------------------------------------------------

extern "C" void eole2_excepinfo_set_error_description(
        EIF_POINTER ptr, EIF_POINTER string )
{
    EXCEPINFO* pEx = (EXCEPINFO*)ptr;
    pEx->bstrDescription = (BSTR)string;
}

//---------------------------------------------------------------------------

extern "C" void eole2_excepinfo_set_help_file(
        EIF_POINTER ptr, EIF_POINTER string )
{
    EXCEPINFO* pEx = (EXCEPINFO*)ptr;
    pEx->bstrHelpFile = (BSTR)string;
}

//---------------------------------------------------------------------------

extern "C" void eole2_excepinfo_set_ole_error_code(
        EIF_POINTER ptr, EIF_INTEGER code )
{
    EXCEPINFO* pEx = (EXCEPINFO*)ptr;
    pEx->scode = (SCODE)code;
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// BSTR support
//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_sys_alloc_string( EIF_REFERENCE str,
        EIF_INTEGER len )
{
    LPOLESTR pOleStr;
    BSTR result;

    // Convert 1 byte character string to 2 byte character string
    pOleStr = Eif2OleString( str );
    // Create BSTR
    result = SysAllocStringLen( pOleStr, len );
    // Free tmp buffer for 2 byte character string
    free( pOleStr );

    return (EIF_POINTER)result;
}

//---------------------------------------------------------------------------

extern "C" void eole2_sys_free_string( EIF_POINTER bstr_ptr )
{
    SysFreeString( (BSTR)bstr_ptr );
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_sys_realloc_string(
        EIF_POINTER bstr_ptr, EIF_POINTER new_str_ptr )
{
    LPOLESTR pOleStr;

    // Convert 1 byte character string to 2 byte character string
    pOleStr = Eif2OleString( new_str_ptr );
    // Realloc BSTR
    SysReAllocString( (BSTR*)&bstr_ptr, pOleStr );
    // Free tmp buffer for 2 byte character string
    free( pOleStr );
    //
    return bstr_ptr;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_sys_string_len( EIF_POINTER bstr_ptr )
{
    return (EIF_INTEGER)SysStringLen( (BSTR)bstr_ptr );
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// FUNCDESC support
//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_get_fd_member_id( EIF_POINTER pThis )
{
    FUNCDESC* pFD = (FUNCDESC*)pThis;
    return (EIF_INTEGER)pFD->memid;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_get_fd_valid_scodes_count( EIF_POINTER pThis )
{
    FUNCDESC* pFD = (FUNCDESC*)pThis;
    return (EIF_INTEGER)pFD->cScodes;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_get_fd_valid_scode( EIF_POINTER pThis,
        EIF_INTEGER pos )
{
    FUNCDESC* pFD = (FUNCDESC*)pThis;
    return (EIF_INTEGER)( pFD->lprgscode[pos] );
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_get_fd_param_count( EIF_POINTER pThis )
{
    FUNCDESC* pFD = (FUNCDESC*)pThis;
    return (EIF_INTEGER)pFD->cParams;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_get_fd_optional_param_count( EIF_POINTER pThis )
{
    FUNCDESC* pFD = (FUNCDESC*)pThis;
    return (EIF_INTEGER)pFD->cParamsOpt;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_get_fd_parameter( EIF_POINTER pThis,
        EIF_INTEGER pos )
{
    FUNCDESC* pFD = (FUNCDESC*)pThis;
    return (EIF_POINTER)( pFD->lprgelemdescParam + pos );
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_get_fd_funckind( EIF_POINTER pThis )
{
    FUNCDESC* pFD = (FUNCDESC*)pThis;
    return (EIF_INTEGER)pFD->funckind;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_get_fd_invokekind( EIF_POINTER pThis )
{
    FUNCDESC* pFD = (FUNCDESC*)pThis;
    return (EIF_INTEGER)pFD->invkind;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_get_fd_callconv( EIF_POINTER pThis )
{
    FUNCDESC* pFD = (FUNCDESC*)pThis;
    return (EIF_INTEGER)pFD->callconv;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_get_fd_vtbl_offset( EIF_POINTER pThis )
{
    FUNCDESC* pFD = (FUNCDESC*)pThis;
    return (EIF_INTEGER)pFD->oVft;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_get_fd_return_type( EIF_POINTER pThis )
{
    FUNCDESC* pFD = (FUNCDESC*)pThis;
    return (EIF_POINTER) &(pFD->elemdescFunc);
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_get_fd_func_flags( EIF_POINTER pThis )
{
    FUNCDESC* pFD = (FUNCDESC*)pThis;
    return (EIF_INTEGER)pFD->wFuncFlags;
}

//---------------------------------------------------------------------------


//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// ELEMDESC support
//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_elemdesc_allocate( void )
{
    return (EIF_POINTER)malloc (sizeof(ELEMDESC));
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_get_elemdesc_typedesc( EIF_POINTER pThis )
{
    ELEMDESC* pED = (ELEMDESC*)pThis;
    return (EIF_POINTER)( &pED->tdesc );
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_get_elemdesc_idldesc( EIF_POINTER pThis )
{
    ELEMDESC* pED = (ELEMDESC*)pThis;
    return (EIF_POINTER)( &pED->idldesc );
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// ARRAYDESC support
//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_arraydesc_typedesc( EIF_POINTER pThis )
{
	ARRAYDESC* pAR = (ARRAYDESC*)pThis;
	return (EIF_POINTER)&(pAR->tdescElem);
}

extern "C" EIF_INTEGER eole2_arraydesc_count_dims( EIF_POINTER pThis )
{
	ARRAYDESC* pAR = (ARRAYDESC*)pThis;
	return (EIF_INTEGER)pAR->cDims;
}

extern "C" EIF_OBJ eole2_arraydesc_bounds( EIF_POINTER pThis )
{
	ARRAYDESC *pAR = (ARRAYDESC*)pThis;
	EIF_OBJ Result;
	EIF_OBJ Bounds;
	EIF_PROC eif_array_make;
	EIF_PROC eif_array_put;
	EIF_PROC eif_bound_init;
	EIF_PROC eif_bound_set_elem_count;
	EIF_PROC eif_bound_set_lower_bound;
	EIF_TYPE_ID eif_array_id;
	EIF_TYPE_ID eif_bound_id;
	int i=1;
	USHORT dims = pAR->cDims;

	eif_bound_id = eif_type_id ("EOLE_SAFEARRAY_BOUNDS");
	eif_array_id = eif_type_id ("ARRAY [EOLE_SAFEARRAY_BOUNDS]");
	eif_array_make = eif_proc ("make", eif_array_id);
	eif_array_put = eif_proc ("put", eif_array_id);
	eif_bound_init = eif_proc ("init", eif_bound_id);
	eif_bound_set_elem_count = eif_proc ("set_element_count", eif_bound_id);
	eif_bound_set_lower_bound = eif_proc ("set_lower_bound", eif_bound_id);
	Result = eif_create (eif_array_id);
	eif_array_make (eif_access (Result), 1, dims);
	while (i <= dims) {
		Bounds = eif_create (eif_bound_id);
		eif_bound_init (eif_access (Bounds));
		eif_bound_set_elem_count (eif_access (Bounds), pAR->rgbounds [i-1].cElements);
		eif_bound_set_lower_bound (eif_access (Bounds), pAR->rgbounds [i-1].lLbound);
		eif_array_put (eif_access (Result), eif_access (Bounds), i);
		i++;
		eif_wean (Bounds);
	}
	return eif_wean (Result);
}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// VARDESC support
//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_vardesc_allocate( void )
{
    return (EIF_POINTER)malloc (sizeof(VARDESC));
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_vardesc_get_member_id( EIF_POINTER pThis )
{
    VARDESC* pVD = (VARDESC*)pThis;
    return (EIF_INTEGER)pVD->memid;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_vardesc_get_instance_offset( EIF_POINTER pThis )
{
    VARDESC* pVD = (VARDESC*)pThis;
    return (EIF_INTEGER)pVD->oInst;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_vardesc_get_constant_variant( EIF_POINTER pThis )
{
    VARDESC* pVD = (VARDESC*)pThis;
    return (EIF_POINTER)pVD->lpvarValue;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_vardesc_get_varkind( EIF_POINTER pThis )
{
    VARDESC* pVD = (VARDESC*)pThis;
    return (EIF_INTEGER)pVD->varkind;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_vardesc_get_elemdesc( EIF_POINTER pThis )
{
    VARDESC* pVD = (VARDESC*)pThis;
    return (EIF_POINTER)&(pVD->elemdescVar);
}

//---------------------------------------------------------------------------
extern "C" EIF_INTEGER eole2_vardesc_get_varflags (EIF_POINTER pThis) {
   VARDESC *pVD = (VARDESC*)pThis;
   return (EIF_INTEGER)pVD->wVarFlags;
}

//---------------------------------------------------------------------------

extern "C" void eole2_vardesc_set_member_id( EIF_POINTER pThis,
        EIF_INTEGER id )
{
    VARDESC* pVD = (VARDESC*)pThis;
    pVD->memid = (MEMBERID)id;
}

//---------------------------------------------------------------------------

extern "C" void eole2_vardesc_set_instance_offset( EIF_POINTER pThis,
        EIF_INTEGER off )
{
    VARDESC* pVD = (VARDESC*)pThis;
    pVD->oInst = off;
}

//---------------------------------------------------------------------------

extern "C" void eole2_vardesc_set_constant_variant( EIF_POINTER pThis,
        EIF_POINTER variant )
{
    VARDESC* pVD = (VARDESC*)pThis;
    pVD->lpvarValue = (VARIANT*)variant;
}

//---------------------------------------------------------------------------

extern "C" void eole2_vardesc_set_varkind( EIF_POINTER pThis,
        EIF_INTEGER kind )
{
    VARDESC* pVD = (VARDESC*)pThis;
    pVD->varkind = (VARKIND)kind;
}

//---------------------------------------------------------------------------

extern "C" void eole2_vardesc_set_elemdesc( EIF_POINTER pThis,
        EIF_POINTER elemdescptr )
{
    VARDESC* pVD = (VARDESC*)pThis;
    pVD->elemdescVar = *((ELEMDESC*)elemdescptr);
}

//---------------------------------------------------------------------------
extern "C" void eole2_vardesc_set_varflags (EIF_POINTER pThis, EIF_INTEGER varFlags) {
   VARDESC *pVD = (VARDESC*)pThis;
   pVD->wVarFlags = (unsigned short)varFlags;
}

/////////////////////////////////////////////////////////////////////////////
//
// CURRENCY & CY support
//
/////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_currency_allocate
//
// Purpose:
//    Allocate a real CURRENCY structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pointer to alocated CURRENCY data structure.
//

extern "C" EIF_POINTER eole2_currency_allocate (void) {
   return (EIF_POINTER)malloc (sizeof (CURRENCY));
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_currency_set_Lo
//
// Purpose:
//    Set the 'Lo' member of the CURRENCY structure to the specified value.
//
// Parameters:
//    _this    EIF_POINTER pointer to the CURRENCY structure
//    Lo       EIF_INTEGER value to set.
//
// Return Value:
//    None.
//

extern "C" void eole2_currency_set_Lo (EIF_POINTER _this, EIF_INTEGER Lo) {
#ifdef EIF_BORLAND
   ((CURRENCY FAR *)_this)->s.Lo = (LONG)Lo;
#else
   ((CURRENCY FAR *)_this)->Lo = (LONG)Lo;
#endif /* EIF_BORLAND */
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_currency_set_Hi
//
// Purpose:
//    Set the 'Hi' member of the CURRENCY structure to the specified value.
//
// Parameters:
//    _this    EIF_POINTER pointer to the CURRENCY structure
//    Hi       EIF_INTEGER value to set.
//
// Return Value:
//    None.
//

extern "C" void eole2_currency_set_Hi (EIF_POINTER _this, EIF_INTEGER Hi) {
#ifdef EIF_BORLAND
   ((CURRENCY FAR *)_this)->s.Hi = (LONG)Hi;
#else
   ((CURRENCY FAR *)_this)->Hi = (LONG)Hi;
#endif /* EIF_BORLAND */
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_currency_get_Lo
//
// Purpose:
//    Obtain the value of 'Lo' member of the CURRENCY structure.
//
// Parameters:
//    _this    EIF_POINTER pointer to the CURRENCY structure.
//
// Return Value:
//    Value of the 'Lo' member
//

extern "C" EIF_INTEGER eole2_currency_get_Lo (EIF_POINTER _this) {
#ifdef EIF_BORLAND
   return (EIF_INTEGER)(((CURRENCY FAR *)_this)->s.Lo);
#else
   return (EIF_INTEGER)(((CURRENCY FAR *)_this)->Lo);
#endif /* EIF_BORLAND */
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_currency_get_Hi
//
// Purpose:
//    Obtain the value of 'Hi' member of the CURRENCY structure.
//
// Parameters:
//    _this    EIF_POINTER pointer to the CURRENCY structure.
//
// Return Value:
//    Value of the 'Hi' member
//

extern "C" EIF_INTEGER eole2_currency_get_Hi (EIF_POINTER _this) {
#ifdef EIF_BORLAND
   return (EIF_INTEGER)(((CURRENCY FAR *)_this)->s.Hi);
#else
   return (EIF_INTEGER)(((CURRENCY FAR *)_this)->Hi);
#endif /* EIF_BORLAND */
}

/////// END OF FILE /////////////////////////////////////////////////////////
