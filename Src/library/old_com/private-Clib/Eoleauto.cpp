//---------------------------------------------------------------------------
//indexing
//   title:         "IDispatch & ITypeInfo support";
//   cluster:       "CLIBRARY";
//   project:       "Eiffel OLE Library";
//   copyright:     "SiG Computer Inc.", 1996;
//   approved_by:   "Dmitry Mastrukov (DLM)";
//   done_at:       "SIG Computer Inc, Moscow (info@eiffel.ru)";
//   external_name: "$RCSfile$";
//---------------------------------------------------------------------------
// $Log$
// Revision 1.7  1999/01/22 18:51:10  marina
//  Modified Files:
//  	Eautostr.cpp Eoleauto.cpp eifole.h ieconpnt.cpp ienumcon.cpp
//  	ienumukn.cpp
// 		-- removed use of `eif_generic_id'
//
// Revision 1.6  1998/02/09 19:20:08  raphaels
// Mainly cosmetics. Added `character' to EOLE_VARIANT.
//
// Revision 1.3  1998/01/20 23:47:54  raphaels
// Removed obsolete files.
//
// Revision 1.2  1998/01/20 00:25:54  raphaels
// Modified sources to be compatible with Borland compiler.
//
// Revision 1.1.1.1  1998/01/15 23:32:14  raphaels
// First version of EiffelCOM
//
//---------------------------------------------------------------------------

#include "eifole.h"

// dispatch_get_type_info_eiffel_called is 0 if eiffel has not been called during 
// eole2_dispatch_get_type_info or 1 if it has been called.

int dispatch_get_type_info_eiffel_called;
//---------------------------------------------------------------------------
// IDispatch support
//
//---------------------------------------------------------------------------
//  class E_IDispatch : necessary for exporting Eiffel automation servers
//  The following member functions can only be called from the "outer space",
//  NOT from the eiffel application, which created this object.
//

E_IDispatch::E_IDispatch() : E_IUnknown()
{
}

//---------------------------------------------------------------------------

STDMETHODIMP E_IDispatch::GetTypeInfoCount( UINT __RPC_FAR *pctinfo )
{
    return E_IDispatch_GetTypeInfoCount(
            GetEiffelCurrentPointer(), TRUE, pctinfo );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_IDispatch::GetTypeInfo(
        UINT itinfo,
        LCID lcid,
        ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo )
{
    return E_IDispatch_GetTypeInfo(
            GetEiffelCurrentPointer(), TRUE,
            itinfo,
            lcid,
            pptinfo );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_IDispatch::GetIDsOfNames(
        REFIID riid,
        LPOLESTR __RPC_FAR *rgszNames,
        UINT cNames,
        LCID lcid,
        DISPID __RPC_FAR *rgdispid )
{
    return E_IDispatch_GetIDsOfNames(
            GetEiffelCurrentPointer(), TRUE,
            riid, rgszNames, cNames, lcid, rgdispid );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_IDispatch::Invoke(
        DISPID dispidMember, REFIID riid,
        LCID lcid,
        WORD wFlags,
        DISPPARAMS __RPC_FAR *pdispparams,
        VARIANT __RPC_FAR *pvarResult,
        EXCEPINFO __RPC_FAR *pexcepinfo,
        UINT __RPC_FAR *puArgErr )
{
    return E_IDispatch_Invoke(
            GetEiffelCurrentPointer(), TRUE,
            dispidMember, riid, lcid, wFlags,
            pdispparams, pvarResult, pexcepinfo, puArgErr );
}

//---------------------------------------------------------------------------
// Basic direction wrappers around IDispatch Interface: necessary
// to pass calls: space->Eiffel or Eiffel->space
//
//---------------------------------------------------------------------------

extern "C" HRESULT E_IDispatch_GetTypeInfoCount(
        void* ptr, BOOL incomingCall,
        UINT __RPC_FAR *pctinfo )
{
    if( incomingCall )
    {
      *pctinfo = (UINT)Ocxdisp_DispatchGetTypeInfoCount (eif_access (eoleOcxDisp), eif_access (ptr));
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_IDispatch*)ptr)->GetTypeInfoCount( pctinfo );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IDispatch_GetTypeInfo(
        void* ptr, BOOL incomingCall,
        UINT itinfo, LCID lcid,
        ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo )
{
    if( incomingCall )
    {
      *pptinfo = (ITypeInfo __RPC_FAR*)Ocxdisp_DispatchGetTypeInfo (eif_access (eoleOcxDisp), eif_access (ptr));
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_IDispatch*)ptr)->GetTypeInfo( itinfo, lcid, pptinfo );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IDispatch_GetIDsOfNames(
        void* ptr, BOOL incomingCall,
        REFIID riid, LPOLESTR __RPC_FAR *rgszNames,
        UINT cNames, LCID lcid, DISPID __RPC_FAR *rgdispid )
{
    if( incomingCall )
    {	EIF_OBJ eif_array;
		EIF_PROC eif_put;
		EIF_PROC eif_make;
		UINT i = 0;
		EIF_POINTER result;
		EIF_FN_POINTER eif_to_c;
		EIF_TYPE_ID eif_array_id;
		char *name;

		eif_array = eif_create (eif_type_id ("ARRAY [STRING]"));
		eif_array_id = eif_type (eif_array);
		eif_make = eif_proc ("make", eif_array_id);
		eif_put = eif_proc ("put", eif_array_id);
		(eif_make) (eif_array, 0, cNames - 1);
		while (i < cNames,i++) {
			Ole2CString (rgszNames [i], &name);
			(eif_put) (eif_array, makestr (name, strlen (name)), i);
		}
		result = Ocxdisp_DispatchGetIdsOfNames (eif_access (eoleOcxDisp), eif_access (ptr), eif_array);
		eif_to_c = eif_fn_pointer ("to_c", eif_type_id ("ARRAY [STRING]"));
		*rgdispid = (DISPID __RPC_FAR) (eif_to_c) (result);
		return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
	
    return ((E_IDispatch*)ptr)->GetIDsOfNames(
            riid,
            rgszNames,
            cNames,
            lcid,
            rgdispid );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IDispatch_Invoke(
        void* ptr, BOOL incomingCall,
        DISPID dispidMember, REFIID riid,
        LCID lcid,
        WORD wFlags,
        DISPPARAMS __RPC_FAR *pdispparams,
        VARIANT __RPC_FAR *pvarResult,
        EXCEPINFO __RPC_FAR *pexcepinfo,
        UINT __RPC_FAR *puArgErr )
{
    if( incomingCall )
    {
      Ocxdisp_DispatchInvoke (eif_access (eoleOcxDisp), eif_access (ptr), dispidMember,
                                      wFlags, pdispparams, pvarResult, pexcepinfo);
      return (Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr)));
    }
    return ((E_IDispatch*)ptr)->Invoke (
                                dispidMember, riid,
                                lcid, wFlags, pdispparams,
                                pvarResult, pexcepinfo, puArgErr);
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// The following functions are called from the Eiffel code as an attempt
// to use features or foreign OLE automation server.
//
extern "C" void eole2_dispatch_invoke(
        EIF_POINTER iDispatch,
        EIF_INTEGER dispid,
        EIF_INTEGER flags,
        EIF_POINTER dispparams,
        EIF_POINTER variant_result,
        EIF_POINTER exception )
{
    UINT argError;

    g_hrStatusCode = E_IDispatch_Invoke(
            (void*)iDispatch, FALSE,
            (DISPID)dispid, IID_NULL,
            MAKELCID( MAKELANGID( LANG_NEUTRAL, SUBLANG_NEUTRAL ), SORT_DEFAULT ),
            (WORD)flags,
            (DISPPARAMS*)dispparams,
            (VARIANT*)variant_result,
            (EXCEPINFO*)exception,
            &argError );
}

//---------------------------------------------------------------------------

#define EOLE_DISP_MAXSTRSIZE 64
#define EOLE_DISP_MAXSTRCOUNT 40
static OLECHAR mappableNamesBuffer[EOLE_DISP_MAXSTRCOUNT * EOLE_DISP_MAXSTRSIZE];
static LPOLESTR mappableNames[EOLE_DISP_MAXSTRCOUNT];
static int mappableNamesCount;
static DISPID mappableDispids[EOLE_DISP_MAXSTRCOUNT];

//---------------------------------------------------------------------------

extern "C" void eole2_auto_erase_names( void )
{
    int i;

    memset( &mappableNamesBuffer, 0, sizeof( mappableNamesBuffer ) );
    memset( &mappableNames, 0, sizeof( mappableNames ) );
    memset( &mappableDispids, 0, sizeof( mappableDispids ) );
    mappableNamesCount = 0;

    for( i = 0; i < EOLE_DISP_MAXSTRCOUNT; i++ )
    {
        mappableNames[i] = &(mappableNamesBuffer[i * EOLE_DISP_MAXSTRSIZE]);
    }
}

//---------------------------------------------------------------------------

extern "C" void eole2_auto_add_name( EIF_POINTER str_ptr )
{
    LPOLESTR oleStr = Eif2OleString( str_ptr );
    /*wcscpy( &( mappableNamesBuffer[mappableNamesCount * EOLE_DISP_MAXSTRSIZE] ),
            oleStr );*/
	int i;
	int nBytes;
	
    for (i = 0; oleStr[i]; i++); // Count the length of the OLE string
    nBytes = i * 2;              // Calculate the number of bytes to copy
    memmove (&( mappableNamesBuffer[mappableNamesCount * EOLE_DISP_MAXSTRSIZE]),
      oleStr, nBytes);
    free( oleStr );
    mappableNamesCount++;
}

//---------------------------------------------------------------------------

extern "C" void eole2_dispatch_map_names( EIF_POINTER iDispatch )
{
    g_hrStatusCode = E_IDispatch_GetIDsOfNames(
            iDispatch, FALSE,
            IID_NULL, mappableNames,
            mappableNamesCount,
            MAKELCID( MAKELANGID( LANG_NEUTRAL, SUBLANG_NEUTRAL ), SORT_DEFAULT ),
            mappableDispids );
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_auto_get_name_id( EIF_INTEGER pos )
{
    EIF_INTEGER g_hrStatusCode = 0;

    if( pos >= 0 && pos < mappableNamesCount )
    {
        return (EIF_INTEGER)mappableDispids[pos];
    }
    return 0;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_dispatch_get_type_info(
        EIF_POINTER iDispatch )
{
    ITypeInfo* pptinfo;

    g_hrStatusCode = E_IDispatch_GetTypeInfo(
        iDispatch, FALSE,
        0,
        MAKELCID( MAKELANGID( LANG_NEUTRAL, SUBLANG_NEUTRAL ), SORT_DEFAULT ),
        &pptinfo );
	
	return (EIF_POINTER)pptinfo;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_dispatch_get_type_info_count(
        EIF_POINTER iDispatch )
{
    HRESULT oleg_hrStatusCode = 0;
    UINT pctinfo = 0;

    oleg_hrStatusCode = E_IDispatch_GetTypeInfoCount(
        iDispatch, FALSE,
        &pctinfo );

    return (EIF_INTEGER) pctinfo;
}
 
/////////////////////////////////////////////////////////////////////////////
// ITypeLib

E_ITypeLib::E_ITypeLib(): E_IUnknown() {
}

STDMETHODIMP E_ITypeLib::GetTypeInfoCount (void) {
   return E_NOTIMPL;
}

STDMETHODIMP E_ITypeLib::GetTypeInfo (UINT index,
                                    ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo) {
	return E_ITypeLib_GetTypeInfo (GetEiffelCurrentPointer(), index,
                                          				pptinfo );
}

STDMETHODIMP E_ITypeLib::GetTypeInfoOfGuid (REFGUID guid,
                                    ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo) {
	return E_ITypeLib_GetTypeInfoOfGuid (GetEiffelCurrentPointer(), guid,
                                          				pptinfo );
}

STDMETHODIMP E_ITypeLib::GetTypeComp (ITypeComp FAR* FAR* ppTComp) {
	return E_ITypeLib_GetTypeComp (GetEiffelCurrentPointer(), ppTComp);
}

STDMETHODIMP E_ITypeLib::GetLibAttr ( TLIBATTR __RPC_FAR *__RPC_FAR *pptlibattr ) {
	return E_ITypeLib_GetLibAttr (GetEiffelCurrentPointer(), pptlibattr);
}

void E_ITypeLib::ReleaseTLibAttr ( TLIBATTR __RPC_FAR *ptlibattr ) {
	E_ITypeLib_ReleaseTLibAttr (GetEiffelCurrentPointer(), ptlibattr);
}

STDMETHODIMP E_ITypeLib::IsName ( LPOLESTR szNameBuf, ULONG lHashVal,
								 BOOL __RPC_FAR *pfName ) {
	return E_ITypeLib_IsName (GetEiffelCurrentPointer(), szNameBuf, lHashVal, pfName);
}

STDMETHODIMP E_ITypeLib::GetTypeInfoType (UINT index,
                                    TYPEKIND FAR* pTKind) {
	return E_ITypeLib_GetTypeInfoType (GetEiffelCurrentPointer(), index,
                                          				pTKind );
}

STDMETHODIMP E_ITypeLib::GetDocumentation (INT index, BSTR __RPC_FAR *pbstrName,
                                          BSTR __RPC_FAR *pbstrDocString,
                                          DWORD __RPC_FAR *pdwHelpContext,
                                          BSTR __RPC_FAR *pbstrHelpFile) {
   return E_ITypeLib_GetDocumentation (
        GetEiffelCurrentPointer(), index, pbstrName, pbstrDocString, 
		pdwHelpContext, pbstrHelpFile );
}

STDMETHODIMP E_ITypeLib::FindName (LPOLESTR szNameBuf, ULONG lHashVal,
                                    ITypeInfo __RPC_FAR *__RPC_FAR *rgptinfo,
                                    MEMBERID __RPC_FAR *rgmemid,
                                    USHORT __RPC_FAR *pcFound) {
   return E_ITypeLib_FindName (GetEiffelCurrentPointer(), szNameBuf, 
										rgptinfo, rgmemid, pcFound);
}

extern "C" HRESULT E_ITypeLib_FindName (void *ptr, LPOLESTR szNameBuf, 
										ITypeInfo __RPC_FAR *__RPC_FAR *ppTInfo,
										MEMBERID __RPC_FAR *rgMemId, 
										USHORT __RPC_FAR *pcFound) {
   return ((ITypeLib *)ptr)->FindName (szNameBuf, 0, ppTInfo, rgMemId, pcFound);
}

extern "C" HRESULT E_ITypeLib_GetTypeInfoCount (void *ptr) {
   return ((ITypeLib *)ptr)->GetTypeInfoCount ();
}

extern "C" HRESULT E_ITypeLib_GetTypeInfo (void *ptr, UINT index,
                                           ITypeInfo __RPC_FAR *__RPC_FAR *ppTinfo ) {
   return ((ITypeLib*)ptr)->GetTypeInfo (index, ppTinfo);
}

extern "C" HRESULT E_ITypeLib_GetTypeInfoOfGuid (void *ptr, REFGUID guid,
                                           ITypeInfo __RPC_FAR *__RPC_FAR *ppTinfo ) {
   return ((ITypeLib*)ptr)->GetTypeInfoOfGuid (guid, ppTinfo);
}

extern "C" HRESULT E_ITypeLib_GetTypeInfoType (void *ptr, UINT index,
                                           TYPEKIND FAR* pTKind) {
   return ((ITypeLib*)ptr)->GetTypeInfoType (index, pTKind);
}

extern "C" HRESULT E_ITypeLib_GetTypeComp (void *ptr,
                                           ITypeComp FAR* FAR* ppTComp) {
   return ((ITypeLib*)ptr)->GetTypeComp (ppTComp);
}

extern "C" HRESULT E_ITypeLib_GetLibAttr (void *ptr, TLIBATTR __RPC_FAR *__RPC_FAR *pptlibattr ) {
   return ((ITypeLib*)ptr)->GetLibAttr (pptlibattr);
}

extern "C" void E_ITypeLib_ReleaseTLibAttr (void *ptr, TLIBATTR __RPC_FAR *ptlibattr ) {
   ((ITypeLib*)ptr)->ReleaseTLibAttr (ptlibattr);
}

extern "C" HRESULT E_ITypeLib_IsName (void *ptr, LPOLESTR szNameBuf, ULONG lHashVal,
								 BOOL __RPC_FAR *pfName ) {
   return ((ITypeLib*)ptr)->IsName (szNameBuf, lHashVal, pfName);
}

extern "C" HRESULT E_ITypeLib_GetDocumentation (
        void* ptr, int index, 
        BSTR __RPC_FAR *pbstrName,
        BSTR __RPC_FAR *pbstrDocString, DWORD __RPC_FAR *pdwHelpContext,
        BSTR __RPC_FAR *pbstrHelpFile )
{
    return ((ITypeLib*)ptr)->GetDocumentation(
            index, pbstrName,
            pbstrDocString, pdwHelpContext,
            pbstrHelpFile );
}

extern "C" EIF_OBJ eole2_typelib_find_name (EIF_POINTER pTypeLib, EIF_POINTER name, EIF_INTEGER count) {
	OLECHAR FAR* szNameBuf;
	ITypeInfo FAR* FAR* ppTInfo;
	MEMBERID FAR* rgMemId;
	unsigned short FAR* pcFound;
	EIF_OBJ Result;
	EIF_PROC eif_make;
	EIF_PROC eif_put_member_ids;
	EIF_PROC eif_put_type_info;
	EIF_TYPE_ID type_id;
	int i = 0;
	
    szNameBuf = Eif2OleString (name);
	pcFound = (unsigned short FAR*)malloc (sizeof (unsigned short));
	*pcFound = (unsigned short)count;
	rgMemId = (MEMBERID FAR *)malloc (count * sizeof (MEMBERID));
	ppTInfo = (ITypeInfo FAR* FAR*)malloc (count * sizeof (ITypeInfo FAR*));
	g_hrStatusCode = E_ITypeLib_FindName (pTypeLib, szNameBuf, ppTInfo, rgMemId, pcFound);
	type_id = eif_type_id ("EOLE_TYPE_LIB_RESULT");
	Result = eif_create (type_id);
	eif_make = eif_proc ("make", type_id);
	eif_put_member_ids = eif_proc ("put_member_ids", type_id);
	eif_put_type_info = eif_proc ("put_type_info", type_id);
	eif_make (eif_access (Result), (EIF_INTEGER)*pcFound);
	while (i != *pcFound) {
		eif_put_member_ids (eif_access (Result), (EIF_INTEGER)rgMemId [i], i + 1);
		eif_put_type_info (eif_access (Result), (EIF_POINTER)ppTInfo [i], i + 1);
		i++;
	}
	free (pcFound);
	free (rgMemId);
	free (ppTInfo);
	return eif_access (Result);
}

extern "C" EIF_INTEGER eole2_typelib_get_type_info_count (EIF_POINTER pTypeLib) {	
   g_hrStatusCode = E_ITypeLib_GetTypeInfoCount (pTypeLib);
   return (EIF_INTEGER)g_hrStatusCode;
}


extern "C" EIF_POINTER eole2_typelib_get_type_info (EIF_POINTER pTypeLib, EIF_INTEGER index) {
   ITypeInfo *pTypeInfo;
   g_hrStatusCode = E_ITypeLib_GetTypeInfo (pTypeLib, index, &pTypeInfo);
   return (EIF_POINTER)pTypeInfo;
}

extern "C" EIF_POINTER eole2_typelib_get_type_info_of_guid (EIF_POINTER pTypeLib, EIF_POINTER guid) {
   ITypeInfo *pTypeInfo;
   GUID tmpIID;
   
   EiffelStringToGuid( guid, &tmpIID );
   g_hrStatusCode = E_ITypeLib_GetTypeInfoOfGuid (pTypeLib, tmpIID, &pTypeInfo);
   return (EIF_POINTER)pTypeInfo;
}

extern "C" EIF_INTEGER eole2_typelib_get_type_info_type (EIF_POINTER pTypeLib, EIF_INTEGER index) {
   TYPEKIND TKind;

   g_hrStatusCode = E_ITypeLib_GetTypeInfoType (pTypeLib, index, &TKind);
   return (EIF_INTEGER)TKind;
}

extern "C" EIF_POINTER eole2_typelib_get_type_comp (EIF_POINTER pTypeLib) {
   ITypeComp FAR* FAR* ppTComp;

    OLECHAR FAR* szName;
  
    unsigned long lHashVal;  
  
    ITypeInfo FAR*FAR* ppTInfo;
  
    DESCKIND FAR* pDescKind;
  
    BINDPTR FAR* pBindPtr;
	char name[5] = "pget";
	HRESULT res;

   ppTInfo = (ITypeInfo FAR* FAR*)malloc (sizeof (ITypeInfo FAR*));
   pDescKind = (DESCKIND*)malloc (sizeof (DESCKIND));
   pBindPtr = (BINDPTR*)malloc (sizeof (BINDPTR));
   szName = Eif2OleString (name);
   lHashVal = LHashValOfName (0, szName);

   ppTComp = (ITypeComp FAR* FAR*)malloc (sizeof (ITypeComp FAR*));
   g_hrStatusCode = E_ITypeLib_GetTypeComp (pTypeLib, ppTComp);

   res = (((ITypeComp*)(*ppTComp))->Bind (szName, lHashVal, 0, ppTInfo, pDescKind, pBindPtr));
 

   return (EIF_POINTER)(*ppTComp);
}

extern "C" EIF_POINTER eole2_typelib_get_lib_attr (EIF_POINTER pTypeLib) {
   tagTLIBATTR **pptlibattr;

   pptlibattr = (tagTLIBATTR**)malloc (sizeof (tagTLIBATTR*));
   E_ITypeLib_GetLibAttr (pTypeLib, pptlibattr);
   return (EIF_POINTER)*pptlibattr;
}

extern "C" void eole2_typelib_release_lib_attr (EIF_POINTER pTypeLib, EIF_POINTER ptlibattr) {
   E_ITypeLib_ReleaseTLibAttr (pTypeLib, (struct tagTLIBATTR *)ptlibattr);
}

extern "C" EIF_BOOLEAN eole2_typelib_is_name (EIF_POINTER pTypeLib, EIF_POINTER name, EIF_INTEGER lcid) {
   OLECHAR FAR* szNameBuf;
   BOOL fName;

   szNameBuf = Eif2OleString (name);
   g_hrStatusCode = E_ITypeLib_IsName (pTypeLib, (LPOLESTR) szNameBuf, 0,
								 &fName );
   return (EIF_BOOLEAN)(fName);

}

extern "C" void eole2_typelib_get_documentation(EIF_POINTER pTypeLib,
                EIF_INTEGER index, EIF_POINTER pbstrName, EIF_POINTER pbstrDocString,
                EIF_POINTER pbstrHelpFile)
{
    DWORD context;

    g_hrStatusCode = E_ITypeLib_GetDocumentation (
            pTypeLib,
            (int)index,
            (BSTR*)pbstrName,
            (BSTR*)pbstrDocString,
            &context,
            (BSTR*)pbstrHelpFile);
}


extern "C" EIF_POINTER eole2_typelib_load_type_lib (EIF_POINTER lpszFileName) {
   ITypeLib *pTypeLib;
   g_hrStatusCode = LoadTypeLib (Eif2OleString (lpszFileName), &pTypeLib);
   return (EIF_POINTER)pTypeLib;
}

//---------------------------------------------------------------------------
// ITypeInfo support
//
//---------------------------------------------------------------------------
// class E_ITypeInfo : necessary for accessing type information of various
// OLE automation servers, present in the system.
//
//---------------------------------------------------------------------------

E_ITypeInfo::E_ITypeInfo() : E_IUnknown()
{
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::GetTypeAttr(
        TYPEATTR __RPC_FAR *__RPC_FAR *pptypeattr )
{
    return E_ITypeInfo_GetTypeAttr(
            GetEiffelCurrentPointer(), TRUE, pptypeattr );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::GetTypeComp(
        ITypeComp __RPC_FAR *__RPC_FAR *pptcomp )
{
    return E_ITypeInfo_GetTypeComp(
            GetEiffelCurrentPointer(), TRUE, pptcomp );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::GetFuncDesc(
        UINT index, FUNCDESC __RPC_FAR *__RPC_FAR *ppfuncdesc )
{
    return E_ITypeInfo_GetFuncDesc(
            GetEiffelCurrentPointer(), TRUE,
            index, ppfuncdesc );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::GetVarDesc(
        UINT index, VARDESC __RPC_FAR *__RPC_FAR *ppvardesc )
{
    return E_ITypeInfo_GetVarDesc(
            GetEiffelCurrentPointer(), TRUE,
            index, ppvardesc );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::GetNames(
        MEMBERID memid, BSTR __RPC_FAR *rgbstrNames,
        UINT cMaxNames, UINT __RPC_FAR *pcNames )
{
    return E_ITypeInfo_GetNames(
            GetEiffelCurrentPointer(), TRUE,
            memid, rgbstrNames,
            cMaxNames, pcNames );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::GetRefTypeOfImplType(
        UINT index, HREFTYPE __RPC_FAR *hpreftype )
{
    return E_ITypeInfo_GetRefTypeOfImplType(
            GetEiffelCurrentPointer(), TRUE,
            index, hpreftype );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::GetImplTypeFlags(
        UINT index, INT __RPC_FAR *pimpltypeflags )
{
    return E_ITypeInfo_GetImplTypeFlags(
            GetEiffelCurrentPointer(), TRUE,
            index, pimpltypeflags );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::GetIDsOfNames(
        OLECHAR __RPC_FAR *__RPC_FAR *rglpszNames,
        UINT cNames, MEMBERID __RPC_FAR *rgmemid )
{
    return E_ITypeInfo_GetIDsOfNames(
            GetEiffelCurrentPointer(), TRUE,
            rglpszNames, cNames, rgmemid );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::Invoke(
        void __RPC_FAR *pvInstance, MEMBERID memid,
        WORD wFlags, DISPPARAMS __RPC_FAR *pdispparams,
        VARIANT __RPC_FAR *pvarResult, EXCEPINFO __RPC_FAR *pexcepinfo,
        UINT __RPC_FAR *puArgErr )
{
    return E_ITypeInfo_Invoke(
            GetEiffelCurrentPointer(), TRUE,
            pvInstance, memid,
            wFlags, pdispparams,
            pvarResult, pexcepinfo,
            puArgErr );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::GetDocumentation(
        MEMBERID memid, BSTR __RPC_FAR *pbstrName,
        BSTR __RPC_FAR *pbstrDocString, DWORD __RPC_FAR *pdwHelpContext,
        BSTR __RPC_FAR *pbstrHelpFile )
{
    return E_ITypeInfo_GetDocumentation(
            GetEiffelCurrentPointer(), TRUE,
            memid, pbstrName,
            pbstrDocString, pdwHelpContext,
            pbstrHelpFile );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::GetDllEntry(
        MEMBERID memid, INVOKEKIND invkind,
        BSTR __RPC_FAR *pbstrDllName, BSTR __RPC_FAR *pbstrName,
        WORD __RPC_FAR *pwOrdinal )
{
    return E_ITypeInfo_GetDllEntry(
            GetEiffelCurrentPointer(), TRUE,
            memid, invkind,
            pbstrDllName, pbstrName,
            pwOrdinal );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::GetRefTypeInfo(
        HREFTYPE hreftype,
        ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo )
{
    return E_ITypeInfo_GetRefTypeInfo(
            GetEiffelCurrentPointer(), TRUE,
            hreftype, pptinfo );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::AddressOfMember(
        MEMBERID memid, INVOKEKIND invkind,
        void __RPC_FAR *__RPC_FAR *ppv )
{
    return E_ITypeInfo_AddressOfMember(
            GetEiffelCurrentPointer(), TRUE,
            memid, invkind, ppv );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::CreateInstance(
        IUnknown __RPC_FAR *puncOuter,
        REFIID riid, void __RPC_FAR *__RPC_FAR *ppvObj )
{
    return E_ITypeInfo_CreateInstance(
            GetEiffelCurrentPointer(), TRUE,
            puncOuter, riid, ppvObj );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::GetMops(
        MEMBERID memid, BSTR __RPC_FAR *pbstrMops )
{
    return E_ITypeInfo_GetMops(
            GetEiffelCurrentPointer(), TRUE,
            memid, pbstrMops );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::GetContainingTypeLib(
        ITypeLib __RPC_FAR *__RPC_FAR *pptlib,
        UINT __RPC_FAR *pindex )
{
    return E_ITypeInfo_GetContainingTypeLib(
            GetEiffelCurrentPointer(), TRUE,
            pptlib, pindex );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::ReleaseTypeAttr( TYPEATTR __RPC_FAR *ptypeattr )
{
    return E_ITypeInfo_ReleaseTypeAttr(
            GetEiffelCurrentPointer(), TRUE,
            ptypeattr );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::ReleaseFuncDesc( FUNCDESC __RPC_FAR *pfuncdesc )
{
    return E_ITypeInfo_ReleaseFuncDesc(
            GetEiffelCurrentPointer(), TRUE,
            pfuncdesc );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_ITypeInfo::ReleaseVarDesc( VARDESC __RPC_FAR *pvardesc )
{
    return E_ITypeInfo_ReleaseVarDesc(
            GetEiffelCurrentPointer(), TRUE,
            pvardesc );
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_GetTypeAttr(
        void* ptr, BOOL incomingCall,
        TYPEATTR __RPC_FAR *__RPC_FAR *pptypeattr )
{
   if( incomingCall )
    {
      *pptypeattr = (TYPEATTR __RPC_FAR*)Ocxdisp_TypeInfoGetTypeAttr (eif_access (eoleOcxDisp), eif_access (ptr));
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
	}
    return ((E_ITypeInfo*)ptr)->GetTypeAttr( pptypeattr );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_GetTypeComp(
        void* ptr, BOOL incomingCall,
        ITypeComp __RPC_FAR *__RPC_FAR *pptcomp )
{
    if( incomingCall )
    {
      *pptcomp = (ITypeComp __RPC_FAR*)Ocxdisp_TypeInfoGetTypeComp (eif_access (eoleOcxDisp), eif_access (ptr));
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->GetTypeComp( pptcomp );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_GetFuncDesc(
        void* ptr, BOOL incomingCall,
        UINT index, FUNCDESC __RPC_FAR *__RPC_FAR *ppfuncdesc )
{
    if( incomingCall )
    {
      *ppfuncdesc = (FUNCDESC __RPC_FAR*)Ocxdisp_TypeInfoGetFuncDesc (eif_access (eoleOcxDisp), eif_access (ptr));
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->GetFuncDesc( index, ppfuncdesc );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_GetVarDesc(
        void* ptr, BOOL incomingCall,
        UINT index,
        VARDESC __RPC_FAR *__RPC_FAR *ppvardesc )
{
    if( incomingCall )
    {
      *ppvardesc = (VARDESC __RPC_FAR*)Ocxdisp_TypeInfoGetVarDesc (eif_access (eoleOcxDisp), eif_access (ptr));
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->GetVarDesc( index, ppvardesc );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_GetNames(
        void* ptr, BOOL incomingCall,
        MEMBERID memid, BSTR __RPC_FAR *rgbstrNames,
        UINT cMaxNames, UINT __RPC_FAR *pcNames )
{
    if( incomingCall )
    {
      EIF_POINTER result;
	  EIF_FN_POINTER eif_item;
	  EIF_FN_INT eif_count;
	  int size;
	  int i = 0;
	  
      result = Ocxdisp_TypeInfoGetNames (eif_access (eoleOcxDisp), eif_access (ptr));
      eif_item = eif_fn_pointer ("item", eif_type_id ("ARRAY [STRING]"));
	  eif_count = eif_fn_int ("count", eif_type_id ("ARRAY [STRING]"));
	  size = (eif_count) (result);
	  while (i < size, i++) {
	  	*(rgbstrNames + i) = (BSTR) Eif2OleString ((eif_item) (result, i));
	  }
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->GetNames(
            memid, rgbstrNames,
            cMaxNames, pcNames );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_GetRefTypeOfImplType(
        void* ptr, BOOL incomingCall,
        UINT index, HREFTYPE __RPC_FAR *hpreftype )
{
    if( incomingCall )
    {
	  hpreftype = (HREFTYPE __RPC_FAR*) Ocxdisp_TypeInfoGetRefTypeOfImplType (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER) index);
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->GetRefTypeOfImplType( index, hpreftype );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_GetImplTypeFlags(
        void* ptr, BOOL incomingCall,
        UINT index, INT __RPC_FAR *pimpltypeflags )
{
    if( incomingCall )
    {
      pimpltypeflags = (INT __RPC_FAR*)Ocxdisp_TypeInfoGetImplTypeFlags (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER) index);
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->GetImplTypeFlags( index, pimpltypeflags );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_GetIDsOfNames(
        void* ptr, BOOL incomingCall,
        OLECHAR __RPC_FAR *__RPC_FAR *rglpszNames,
        UINT cNames, MEMBERID __RPC_FAR *rgmemid )
{    
	if( incomingCall )
    {	EIF_OBJ eif_array;
		EIF_PROC eif_put;
		EIF_PROC eif_make;
		UINT i = 0;
		EIF_POINTER result;
		EIF_FN_POINTER eif_to_c;
		EIF_TYPE_ID eif_array_id;
		char *name;

		eif_array = eif_create (eif_type_id ("ARRAY [STRING]"));
		eif_array_id = eif_type (eif_array);
		eif_make = eif_proc ("make", eif_array_id);
		eif_put = eif_proc ("put", eif_array_id);
		(eif_make) (eif_array, 0, cNames - 1);
		while (i < cNames,i++) {
			Ole2CString ((LPCOLESTR)rglpszNames [i], &name);
			(eif_put) (eif_array, makestr (name, strlen (name)), i);
		}
		result = Ocxdisp_DispatchGetIdsOfNames (eif_access (eoleOcxDisp), eif_access (ptr), eif_array);
		eif_to_c = eif_fn_pointer ("to_c", eif_type_id ("ARRAY [STRING]"));
		rgmemid = (MEMBERID __RPC_FAR*) (eif_to_c) (result);
		return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
	}
    return ((E_ITypeInfo*)ptr)->GetIDsOfNames( rglpszNames, cNames, rgmemid );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_Invoke(
        void* ptr, BOOL incomingCall,
        void __RPC_FAR *pvInstance, MEMBERID memid,
        WORD wFlags, DISPPARAMS __RPC_FAR *pdispparams,
        VARIANT __RPC_FAR *pvarResult, EXCEPINFO __RPC_FAR *pexcepinfo,
        UINT __RPC_FAR *puArgErr )
{
    if( incomingCall )
    {
      Ocxdisp_TypeInfoInvoke (eif_access (eoleOcxDisp), eif_access (ptr), pvInstance,
                                      memid, wFlags, pdispparams, pvarResult, pexcepinfo, puArgErr);
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->Invoke(
            pvInstance, memid, wFlags, pdispparams,
            pvarResult, pexcepinfo,puArgErr );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_GetDocumentation(
        void* ptr, BOOL incomingCall,
        MEMBERID memid, BSTR __RPC_FAR *pbstrName,
        BSTR __RPC_FAR *pbstrDocString, DWORD __RPC_FAR *pdwHelpContext,
        BSTR __RPC_FAR *pbstrHelpFile )
{
    if( incomingCall )
    {
	   EIF_POINTER result;
	   EIF_FN_POINTER eif_get_name;
	   EIF_FN_POINTER eif_get_doc_string;
	   EIF_FN_POINTER eif_get_help_file;
	   EIF_FN_POINTER eif_bstr_ole_ptr;
	   EIF_TYPE_ID doc_id;
	   EIF_TYPE_ID bstr_id;
       result = Ocxdisp_TypeInfoGetDocumentation (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER) memid);
	   doc_id = eif_type_id ("EOLE_DOCUMENTATION");
	   bstr_id = eif_type_id ("EOLE_BSTR");
	   eif_get_name = eif_fn_pointer ("name", doc_id);
	   eif_get_doc_string = eif_fn_pointer ("doc_string", doc_id);
	   eif_get_help_file = eif_fn_pointer ("help_file", doc_id);
	   eif_bstr_ole_ptr = eif_fn_pointer ("ole_ptr", bstr_id);
	   pbstrName = (BSTR*)(eif_bstr_ole_ptr) ((eif_get_name) (result));
	   pbstrDocString = (BSTR*)(eif_bstr_ole_ptr) ((eif_get_doc_string) (result));
	   pbstrHelpFile = (BSTR*)(eif_bstr_ole_ptr) ((eif_get_help_file) (result));
       return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->GetDocumentation(
            memid, pbstrName,
            pbstrDocString, pdwHelpContext,
            pbstrHelpFile );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_GetDllEntry(
        void* ptr, BOOL incomingCall,
        MEMBERID memid, INVOKEKIND invkind,
        BSTR __RPC_FAR *pbstrDllName, BSTR __RPC_FAR *pbstrName,
        WORD __RPC_FAR *pwOrdinal )
{
    if( incomingCall )
    {
	   EIF_POINTER result;
	   EIF_FN_POINTER eif_get_name;
	   EIF_FN_POINTER eif_get_entry_point;
	   EIF_FN_POINTER eif_get_ordinal;
	   EIF_FN_POINTER eif_bstr_ole_ptr;
	   EIF_TYPE_ID eif_bstr_id;
	   EIF_TYPE_ID eif_dll_entry_id;
       result = Ocxdisp_TypeInfoGetDllEntry (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER)memid, (EIF_INTEGER)invkind);
	   eif_dll_entry_id = eif_type_id ("EOLE_DLL_ENTRY");
	   eif_bstr_id = eif_type_id ("EOLE_BSTR");
	   eif_get_name = eif_fn_pointer ("name", eif_dll_entry_id);
	   eif_get_entry_point = eif_fn_pointer ("entry_point", eif_dll_entry_id);
	   eif_get_ordinal = eif_fn_pointer ("ordinal", eif_dll_entry_id);
	   eif_bstr_ole_ptr = eif_fn_pointer ("ole_ptr", eif_bstr_id);
	   pbstrDllName = (BSTR __RPC_FAR *)(eif_bstr_ole_ptr) ((eif_get_name) (result));
	   pbstrName = (BSTR __RPC_FAR *)(eif_bstr_ole_ptr) ((eif_get_entry_point) (result));
	   pwOrdinal = (WORD __RPC_FAR *)(eif_get_ordinal) (result);
       return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));    
	}
    return ((E_ITypeInfo*)ptr)->GetDllEntry(
            memid, invkind,
            pbstrDllName, pbstrName,
            pwOrdinal );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_GetRefTypeInfo(
        void* ptr, BOOL incomingCall,
        HREFTYPE hreftype,
        ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo )
{
    if( incomingCall ) // Always false
    {
      *pptinfo = (ITypeInfo __RPC_FAR *) Ocxdisp_TypeInfoGetRefTypeInfo (eif_access (eoleOcxDisp), eif_access (ptr), 
	  																(EIF_INTEGER)hreftype);
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->GetRefTypeInfo( hreftype, pptinfo );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_AddressOfMember(
        void* ptr, BOOL incomingCall,
        MEMBERID memid, INVOKEKIND invkind,
        void __RPC_FAR *__RPC_FAR *ppv )
{
    if( incomingCall )
    {
      *ppv = (void __RPC_FAR *) Ocxdisp_TypeInfoAddressOfMember (eif_access (eoleOcxDisp), eif_access (ptr), 
	  													(EIF_INTEGER)memid, (EIF_INTEGER)invkind);
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->AddressOfMember( memid, invkind, ppv );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_CreateInstance(
        void* ptr, BOOL incomingCall,
        IUnknown __RPC_FAR *puncOuter,
        REFIID riid, void __RPC_FAR *__RPC_FAR *ppvObj )
{
    if( incomingCall )
    {
      *ppvObj = (void __RPC_FAR *) Ocxdisp_TypeInfoCreateInstance (eif_access (eoleOcxDisp), eif_access (ptr), 
	  								(EIF_POINTER)puncOuter, GuidToEiffelString (riid));
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->CreateInstance( puncOuter, riid, ppvObj );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_GetMops(
        void* ptr, BOOL incomingCall,
        MEMBERID memid, BSTR __RPC_FAR *pbstrMops )
{
    if( incomingCall )
    {
      pbstrMops = (BSTR __RPC_FAR *) Ocxdisp_TypeInfoGetMops (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER)memid);
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->GetMops( memid, pbstrMops );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_GetContainingTypeLib(
        void* ptr, BOOL incomingCall,
        ITypeLib __RPC_FAR *__RPC_FAR *pptlib,
        UINT __RPC_FAR *pindex )
{
    if( incomingCall )
    {
      *pptlib = (ITypeLib __RPC_FAR *) Ocxdisp_TypeInfoGetContainingTypeLib (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER)*pindex);
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->GetContainingTypeLib( pptlib, pindex );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_ReleaseTypeAttr(
        void* ptr, BOOL incomingCall,
        TYPEATTR __RPC_FAR *ptypeattr )
{
    if( incomingCall )
    {
      Ocxdisp_TypeInfoReleaseTypeAttr (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_POINTER)ptypeattr);
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->ReleaseTypeAttr( ptypeattr );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_ReleaseFuncDesc(
        void* ptr, BOOL incomingCall,
        FUNCDESC __RPC_FAR *pfuncdesc )
{
    if( incomingCall )
    {
      Ocxdisp_TypeInfoReleaseFuncDesc (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_POINTER)pfuncdesc);
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
	}
    return ((E_ITypeInfo*)ptr)->ReleaseFuncDesc( pfuncdesc );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_ITypeInfo_ReleaseVarDesc(
        void* ptr, BOOL incomingCall,
        VARDESC __RPC_FAR *pvardesc )
{

    if( incomingCall )
    {
  
      Ocxdisp_TypeInfoReleaseVarDesc (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_POINTER)pvardesc);
      return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
    return ((E_ITypeInfo*)ptr)->ReleaseVarDesc( pvardesc );
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_create_disp_type_info(
      EIF_POINTER interfaceData )
{
    ITypeInfo* ptInfo = 0;

    g_hrStatusCode = CreateDispTypeInfo(
            (INTERFACEDATA*)interfaceData,
            MAKELCID( MAKELANGID( LANG_NEUTRAL, SUBLANG_NEUTRAL ), SORT_DEFAULT ),
            &ptInfo );
    return (EIF_POINTER)ptInfo;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_tinfo_address_of_member(
      EIF_POINTER ptInfo,
      EIF_INTEGER member_id,
      EIF_INTEGER invoke_ind )
{
    void* address = 0;

    g_hrStatusCode = E_ITypeInfo_AddressOfMember( ptInfo, FALSE,
            (MEMBERID)member_id, (INVOKEKIND)invoke_ind,
            &address );

    return (EIF_POINTER)address;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_tinfo_create_instance(
      EIF_POINTER ptInfo,
      EIF_POINTER punk_outer,
      EIF_POINTER clsid )
{
    void* ppvObj = 0;
    GUID guid;

    EiffelStringToGuid( clsid, &guid );

    g_hrStatusCode = E_ITypeInfo_CreateInstance( ptInfo, FALSE,
            (IUnknown*)punk_outer, guid, &ppvObj );

    return (EIF_POINTER)ppvObj;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_tinfo_get_containing_typelib (
                                    EIF_POINTER ptInfo, EIF_POINTER *ppTypeLib)
{
    UINT index;
    g_hrStatusCode = E_ITypeInfo_GetContainingTypeLib (
                     ptInfo, FALSE, (ITypeLib __RPC_FAR *__RPC_FAR *)ppTypeLib, &index);
    return (EIF_INTEGER)index;
}

//---------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////
// The following function needs special implementation since it returns
// an Eiffel object (EOLE_DLL_ENTRY)
////////////////////////////////////////////////////////////////////////////

extern "C" EIF_OBJ eole2_tinfo_get_dll_entry(
      EIF_POINTER ptInfo,
      EIF_INTEGER mem_id,
      EIF_INTEGER invoke_ind)
{
    BSTR* dll_name;							// C++ in/out parameter
	BSTR* entry_point_name;					// C++ in/out paramter
	WORD* ordinal;							// C++ in/out parameter

	EIF_OBJ result;								// Result of type EOLE_DLL_ENTRY			
	EIF_OBJ eif_bstr_name;						// Attribut `dll_name' of EOLE_DLL_ENTRY
	EIF_OBJ eif_bstr_entry_point;				// Attribut `entry_point_name' of EOLE_DLL_ENTRY
	EIF_TYPE_ID eif_dll_entry_id;				// Type id of EOLE_DLL_ENTRY
	EIF_TYPE_ID eif_bstr_id;					// Type id of EOLE_BSTR
	EIF_PROC eif_dll_entry_set_name;			// Feature `set_name' of EOLE_DLL_ENTRY
	EIF_PROC eif_dll_entry_set_entry_point;		// Feature `set_entry_point' of EOLE_DLL_ENTRY
	EIF_PROC eif_dll_entry_set_ordinal;			// Feature `set_ordinal' of EOLE_DLL_ENTRY
	EIF_PROC eif_bstr_make_from_ptr;            // Feature `make_from_ptr'of EOLE_BSTR

	entry_point_name = (BSTR*)malloc (sizeof (BSTR));				// Allocate
	dll_name = (BSTR*)malloc (sizeof (BSTR));						// arguments
	ordinal = (WORD*)malloc (sizeof (WORD));
    g_hrStatusCode = E_ITypeInfo_GetDllEntry( ptInfo, FALSE,		// Call to the function that will set C++ out arguments
            (MEMBERID)mem_id, (INVOKEKIND)invoke_ind,
            dll_name, entry_point_name, ordinal );

	if (SUCCEEDED (g_hrStatusCode)) {
		eif_dll_entry_id = eif_type_id ("EOLE_DLL_ENTRY");	// Initialization of all type ids and features
		eif_bstr_id = eif_type_id ("EOLE_BSTR");
		eif_dll_entry_set_name = eif_proc ("set_name", eif_dll_entry_id);
		eif_dll_entry_set_entry_point = eif_proc ("set_entry_point", eif_dll_entry_id);
		eif_dll_entry_set_ordinal = eif_proc ("set_ordinal", eif_dll_entry_id);
		eif_bstr_make_from_ptr = eif_proc ("make_from_ptr", eif_bstr_id);
		result = eif_create (eif_dll_entry_id);		// Creation of Eiffel result object
		eif_bstr_name = eif_create (eif_bstr_id);
		eif_bstr_entry_point = eif_create (eif_bstr_id);
		eif_bstr_make_from_ptr (eif_access (eif_bstr_name), dll_name);
		eif_bstr_make_from_ptr (eif_access (eif_bstr_entry_point), entry_point_name);
		eif_dll_entry_set_name (eif_access (result), eif_access (eif_bstr_name));
		eif_dll_entry_set_entry_point (eif_access (result), eif_access (eif_bstr_entry_point));
		eif_dll_entry_set_ordinal (eif_access (result), (EIF_POINTER)*ordinal);
	
		return eif_access (result);
	}
	return NULL;
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_tinfo_get_documentation(
      EIF_POINTER ptInfo,
      EIF_INTEGER member_id,
      EIF_POINTER name,
      EIF_POINTER doc_string,
      EIF_POINTER help_file )
{
    DWORD context;

    g_hrStatusCode = E_ITypeInfo_GetDocumentation(
            ptInfo, FALSE,
            (MEMBERID)member_id,
            (BSTR*)name,
            (BSTR*)doc_string,
            &context,
            (BSTR*)help_file );

    return (EIF_INTEGER) context;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_tinfo_get_func_desc(
      EIF_POINTER ptInfo,
      EIF_INTEGER index )
{
    FUNCDESC* pDesc = 0;

    g_hrStatusCode = E_ITypeInfo_GetFuncDesc( ptInfo, FALSE, (UINT)index, &pDesc );
    return (EIF_POINTER)pDesc;
}

//---------------------------------------------------------------------------

extern "C" void eole2_tinfo_map_names( EIF_POINTER ptInfo )
{
    g_hrStatusCode = E_ITypeInfo_GetIDsOfNames(
            ptInfo, FALSE,
            mappableNames,
            mappableNamesCount,
            mappableDispids );
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_tinfo_get_impl_type_flags(
      EIF_POINTER ptInfo,
      EIF_INTEGER index )
{
    INT typeFlags = 0;

    g_hrStatusCode = E_ITypeInfo_GetImplTypeFlags( ptInfo, FALSE,
            index, &typeFlags );
    return typeFlags;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_tinfo_get_mops(
      EIF_POINTER ptInfo,
      EIF_INTEGER mem_id )
{
    BSTR bstr;

    g_hrStatusCode = E_ITypeInfo_GetMops( ptInfo, FALSE, (MEMBERID)mem_id, &bstr );
    return (EIF_POINTER)bstr;
}

//---------------------------------------------------------------------------

static BSTR namesArray[32];
static int namesCount;

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_tinfo_get_names_and_count(
      EIF_POINTER ptInfo,
      EIF_INTEGER mem_id )
{
    UINT filledNames = 0;

    g_hrStatusCode = E_ITypeInfo_GetNames( ptInfo, FALSE,
            (MEMBERID)mem_id, namesArray, 32, &filledNames );
    namesCount = filledNames;
    return filledNames;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_tinfo_get_name(
      EIF_POINTER ptInfo,
      EIF_INTEGER i )
{
	char *result;
    if( ptInfo )
    {
    }
    if( i >= 0 && i < namesCount )
    {
        Ole2CString( namesArray[i], &result);
        return (EIF_POINTER)result;
    }
    return 0;
}

//---------------------------------------------------------------------------

extern "C" void eole2_tinfo_wipe_names( void )
{
    int i;

    for( i = 0; i < namesCount; i++ )
    {
        SysFreeString( namesArray[i] );
        namesArray[i] = NULL;
    }
    namesCount = 0;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_tinfo_get_ref_type_info(
      EIF_POINTER ptInfo,
      EIF_INTEGER type_ref_handle )
{
    ITypeInfo FAR* FAR* ppInfo;

	ppInfo = (ITypeInfo FAR* FAR*)malloc (sizeof (ITypeInfo FAR*));
    g_hrStatusCode = E_ITypeInfo_GetRefTypeInfo( ptInfo, FALSE,
            type_ref_handle, ppInfo );

    return (EIF_POINTER)(FAR *ppInfo);
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_tinfo_get_ref_type_of_impl_type(
      EIF_POINTER ptInfo,
      EIF_INTEGER index )
{
    HREFTYPE type = 0;
    g_hrStatusCode = E_ITypeInfo_GetRefTypeOfImplType( ptInfo, FALSE, index, &type );
    return type;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_tinfo_get_type_attr( EIF_POINTER ptInfo )
{
    TYPEATTR* ptAttr = 0;
    g_hrStatusCode = E_ITypeInfo_GetTypeAttr( ptInfo, FALSE, &ptAttr );
    return (EIF_POINTER)ptAttr;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_tinfo_get_type_comp( EIF_POINTER ptInfo )
{
    ITypeComp** ppTypeComp;

	ppTypeComp = (ITypeComp **)malloc (sizeof (ITypeComp *));
    g_hrStatusCode = E_ITypeInfo_GetTypeComp( ptInfo, FALSE, ppTypeComp );
    return (EIF_POINTER)(*ppTypeComp);
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_tinfo_get_var_desc(
      EIF_POINTER ptInfo,
      EIF_INTEGER var_index )
{
    VARDESC* pVarDesc = 0;

    g_hrStatusCode = E_ITypeInfo_GetVarDesc( ptInfo, FALSE, var_index, &pVarDesc );
    return (EIF_POINTER)pVarDesc;
}

//---------------------------------------------------------------------------

extern "C" void eole2_tinfo_invoke(
      EIF_POINTER ptInfo,
      EIF_INTEGER dispid,
      EIF_INTEGER flags,
      EIF_POINTER dispparams,
      EIF_POINTER variant_result,
      EIF_POINTER exception )
{
    UINT argErr;

    g_hrStatusCode = E_ITypeInfo_Invoke( ptInfo, FALSE,
            ptInfo, // Pointer to the instance of an interface,
                    // described by this Info ????????????????
            (MEMBERID)dispid,
            (WORD)flags,
            (DISPPARAMS*)dispparams,
            (VARIANT*)variant_result,
            (EXCEPINFO*)exception,
            &argErr );
}

//---------------------------------------------------------------------------

extern "C" void eole2_tinfo_release_func_desc(
      EIF_POINTER ptInfo, EIF_POINTER fd )
{
    g_hrStatusCode = E_ITypeInfo_ReleaseFuncDesc( ptInfo, FALSE, (FUNCDESC*)fd );
}

//---------------------------------------------------------------------------

extern "C" void eole2_tinfo_release_type_attr(
      EIF_POINTER ptInfo, EIF_POINTER pTypeAttr )
{
    g_hrStatusCode = E_ITypeInfo_ReleaseTypeAttr( ptInfo, FALSE, (TYPEATTR*)pTypeAttr );
}

//---------------------------------------------------------------------------

extern "C" void eole2_tinfo_release_var_desc(
      EIF_POINTER ptInfo, EIF_POINTER vd )
{
    g_hrStatusCode = E_ITypeInfo_ReleaseVarDesc( ptInfo, FALSE, (VARDESC*)vd );
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

