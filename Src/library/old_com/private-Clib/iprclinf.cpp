//---------------------------------------------------------------------------
// indexing
//   title:         "IProvideClassInfo support";
//   cluster:       "CLIBRARY";
//   project:       "Eiffel OLE Library";
//   copyright:     "SiG Computer Inc., 1997";
//   approved_by:   "Symbol +";
//   external_name: "$RCSfile$";
//---------------------------------------------------------------------------
//-- $Log$
//-- Revision 1.4  1998/02/09 19:20:17  raphaels
//-- Mainly cosmetics. Added `character' to EOLE_VARIANT.
//--
//-- Revision 1.1.1.1  1998/01/15 23:32:16  raphaels
//-- First version of EiffelCOM
//--
//---------------------------------------------------------------------------

#include "eifole.h"
#include "eif_hector.h"

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
E_IProvideClassInfo::E_IProvideClassInfo() : E_IUnknown()
{
}

STDMETHODIMP E_IProvideClassInfo::GetClassInfo ( ITypeInfo** ppTI )
{
   return E_IProvideClassInfo_GetClassInfo (
                                             GetEiffelCurrentPointer(),
                                             TRUE,
                                             ( ITypeInfo** )  ppTI
                                            );
}
//---------------------------------------------------------------------------



//---------------------------------------------------------------------------

extern "C" HRESULT E_IProvideClassInfo_GetClassInfo
                         ( void * ptr,
                           BOOL incomingCall,
                           ITypeInfo** ppTI
                         )
{
     if( incomingCall )
       {
        *ppTI = (ITypeInfo*)Ocxdisp_ProvideClassInfoGetClassInfo(eif_access (eoleOcxDisp), eif_access (ptr));
        return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
       }
     return ((E_IProvideClassInfo*) ptr)->GetClassInfo ( ( ITypeInfo** )  ppTI);

}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_provide_class_info_get_class_info( EIF_POINTER ip)
{
    ITypeInfo* pTypeInfo;

    g_hrStatusCode = E_IProvideClassInfo_GetClassInfo
                      ( ip, FALSE,( ITypeInfo** )  &pTypeInfo );

    return (EIF_POINTER)pTypeInfo;


}
//---------------------------------------------------------------------------


/////// END OF FILE /////////////////////////////////////////////////////////
