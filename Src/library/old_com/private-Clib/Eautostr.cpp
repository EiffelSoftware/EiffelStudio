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

extern "C" void eole2_var_set_bool( EIF_POINTER ptr,

#pragma warning (disable: 4237)
                                    EIF_BOOLEAN bool)
#pragma warning (default: 4237)
{
    VARIANT* v = (VARIANT*)ptr;
    v->vt = (VARTYPE)VT_BOOL;
#pragma warning (disable: 4237)
    v->boolVal = (VARIANT_BOOL)bool; // VARIANT_TRUE = -1, VARIANT_FALSE = 0
#pragma warning (default: 4237)
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
    v->cyVal.Lo = lo;
    v->cyVal.Hi = hi;
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
            v->pboolVal = (VARIANT_BOOL*)value_ptr;
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
        return (EIF_BOOLEAN) *(v->pboolVal);
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
        return (EIF_INTEGER)v->pcyVal->Lo;
    return (EIF_INTEGER)v->cyVal.Lo;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_var_get_currency_hi( EIF_POINTER ptr )
{
    VARIANT* v = (VARIANT*)ptr;
    if( v->vt & VT_BYREF )
        return (EIF_INTEGER)v->pcyVal->Hi;
    return (EIF_INTEGER)v->cyVal.Hi;
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
            result = (EIF_POINTER)v->pboolVal;
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

extern "C" EIF_INTEGER eole2_get_elemdesc_idldesc( EIF_POINTER pThis )
{
    ELEMDESC* pED = (ELEMDESC*)pThis;
    return (EIF_INTEGER)pED->idldesc.wIDLFlags;
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// TYPEDESC support
//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_typedesc_allocate( void )
{
    return (EIF_POINTER)malloc (sizeof(TYPEDESC));
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typedesc_get_vartype( EIF_POINTER pThis )
{
    TYPEDESC* pTD = (TYPEDESC*)pThis;
    return (EIF_INTEGER)pTD->vt;
}

extern "C" EIF_POINTER eole2_typedesc_get_typedesc (EIF_POINTER pThis) {
    TYPEDESC* pTD = (TYPEDESC*)pThis;
    return (EIF_POINTER)pTD->lptdesc;
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

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// TYPEATTR support
//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_typeattr_allocate( void )
{
    return (EIF_POINTER)malloc (sizeof(TYPEATTR));
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_typeattr_get_guid( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (char*)GuidToCString( pTA->guid );
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_locale( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->lcid;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_constructor_id( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->memidConstructor;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_destructor_id( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->memidDestructor;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_instance_size( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->cbSizeInstance;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_typekind( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->typekind;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_num_functions( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->cFuncs;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_num_vars( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->cVars;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_num_interfaces( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->cImplTypes;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_vtbl_size( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->cbSizeVft;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_instance_alignment( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->cbAlignment;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_type_flags( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->wTypeFlags;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_major_version( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->wMajorVerNum;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_minor_version( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->wMinorVerNum;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_typeattr_get_typedesc( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_POINTER)&(pTA->tdescAlias);
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_typeattr_get_idldesc( EIF_POINTER pThis )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    return (EIF_INTEGER)pTA->idldescType.wIDLFlags;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_guid( EIF_POINTER pThis,
        EIF_POINTER guid_string )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    EiffelStringToGuid( guid_string, &pTA->guid );
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_locale( EIF_POINTER pThis,
        EIF_INTEGER locale )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->lcid = (LCID)locale;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_constructor_id( EIF_POINTER pThis,
        EIF_INTEGER id )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->memidConstructor = (MEMBERID)id;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_destructor_id( EIF_POINTER pThis,
        EIF_INTEGER id )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->memidDestructor = (MEMBERID)id;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_instance_size( EIF_POINTER pThis,
        EIF_INTEGER sz )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->cbSizeInstance = sz;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_typekind( EIF_POINTER pThis,
        EIF_INTEGER typekind )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->typekind = (TYPEKIND)typekind;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_num_functions( EIF_POINTER pThis,
        EIF_INTEGER num )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->cFuncs = (unsigned short)num;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_num_vars( EIF_POINTER pThis,
        EIF_INTEGER num )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->cVars = (unsigned short)num;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_num_interfaces( EIF_POINTER pThis,
        EIF_INTEGER num )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->cImplTypes = (unsigned short)num;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_vtbl_size( EIF_POINTER pThis,
        EIF_INTEGER sz )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->cbSizeVft = (unsigned short)sz;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_instance_alignment( EIF_POINTER pThis,
        EIF_INTEGER al )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->cbAlignment = (unsigned short)al;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_type_flags( EIF_POINTER pThis,
        EIF_INTEGER flags )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->wTypeFlags = (unsigned short)flags;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_major_version( EIF_POINTER pThis,
        EIF_INTEGER ver )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->wMajorVerNum = (unsigned short)ver;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_minor_version( EIF_POINTER pThis,
        EIF_INTEGER ver )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->wMinorVerNum = (unsigned short)ver;
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_typedesc( EIF_POINTER pThis,
        EIF_POINTER typedesc )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->tdescAlias = *( (TYPEDESC*)typedesc );
}

//---------------------------------------------------------------------------

extern "C" void eole2_typeattr_set_idldesc( EIF_POINTER pThis,
        EIF_INTEGER idldesc )
{
    TYPEATTR* pTA = (TYPEATTR*)pThis;
    pTA->idldescType.wIDLFlags = (unsigned short)idldesc;
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
   ((CURRENCY FAR *)_this)->Lo = (ULONG)Lo;
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
   ((CURRENCY FAR *)_this)->Hi = (LONG)Hi;
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
   return (EIF_INTEGER)(((CURRENCY FAR *)_this)->Lo);
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
   return (EIF_INTEGER)(((CURRENCY FAR *)_this)->Hi);
}

/////// END OF FILE /////////////////////////////////////////////////////////
