//---------------------------------------------------------------------------
//indexing
//   title:         "IClassFactory support";
//   cluster:       "CLIBRARY";
//   project:       "Eiffel OLE Library";
//   copyright:     "SiG Computer Inc.", 1996;
//   approved_by:   "Dmitry Mastrukov (DLM)";
//   done_at:       "SIG Computer Inc, Moscow (info@eiffel.ru)";
//   external_name: "$RCSfile$";
//---------------------------------------------------------------------------
// $Log$
// Revision 1.2  1998/02/02 18:05:09  raphaels
// Added TypeComp support.
// Updated TypeLib and TypeInfo support.
// Modified some file names.
//
// Revision 1.1.1.1  1998/01/15 23:32:14  raphaels
// First version of EiffelCOM
//
//---------------------------------------------------------------------------

#include "eifole.h"
#include "eif_hector.h"

//---------------------------------------------------------------------------

E_IClassFactory::E_IClassFactory() : E_IUnknown()
{
}

//---------------------------------------------------------------------------

STDMETHODIMP E_IClassFactory::CreateInstance( LPUNKNOWN pUnkOuter,
                                                REFIID riid,
                                                LPVOID FAR* ppvObject )
{ 
   return E_IClassFactory_CreateInstance( GetEiffelCurrentPointer(), TRUE,
         pUnkOuter, riid, ppvObject );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_IClassFactory::LockServer( BOOL fLock )
{
   return E_IClassFactory_LockServer(
        GetEiffelCurrentPointer(), TRUE, fLock );
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

extern "C" HRESULT E_IClassFactory_CreateInstance(
        void* ptr, BOOL incomingCall,
        IUnknown __RPC_FAR *pUnkOuter,
        REFIID riid, void __RPC_FAR *__RPC_FAR *ppvObj )
{
    if( incomingCall )
    { 
        *ppvObj = (void*)Ocxdisp_ClassFactoryCreateInstance (
                                                eif_access (eoleOcxDisp),
                                                eif_access (ptr),
                                                pUnkOuter,
                                                GuidToEiffelString (riid));
        return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }

   return ((E_IClassFactory*)ptr)->CreateInstance( pUnkOuter,
         riid,
         ppvObj );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IClassFactory_LockServer(
        void* ptr, BOOL incomingCall,
        BOOL fLock )
{
    if( incomingCall )
    {
        Ocxdisp_UnknownSetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr), S_OK);
        Ocxdisp_ClassFactoryLockServer (eif_access (eoleOcxDisp), eif_access (ptr), fLock);
        return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }

    return ((E_IClassFactory*)ptr)->LockServer( fLock );
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_clsfact_create_instance( EIF_POINTER ip,
      EIF_POINTER ipController, EIF_POINTER clsidString )
{

    void* result_ptr = 0;
    GUID tmpIID;

    EiffelStringToGuid( clsidString, &tmpIID );
    g_hrStatusCode = E_IClassFactory_CreateInstance( ip, FALSE,
            (IUnknown __RPC_FAR *)ipController,
            tmpIID,
            &result_ptr );
   return (EIF_POINTER)result_ptr;
}

//---------------------------------------------------------------------------

extern "C" void eole2_clsfact_lock_server( EIF_POINTER ip, EIF_BOOLEAN lock )
{
   g_hrStatusCode = E_IClassFactory_LockServer( ip, FALSE, lock );
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------


