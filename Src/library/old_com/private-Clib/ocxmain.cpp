//---------------------------------------------------------------------------
//indexing
//   title:         "OCX Initialization and shutdown support";
//   cluster:       "CLIBRARY";
//   project:       "Eiffel OLE Library";
//   copyright:     "SiG Computer Inc.", 1996;
//   approved_by:   "Dmitry Mastrukov (DLM)";
//   done_at:       "SIG Computer Inc, Moscow (info@eiffel.ru)";
//   external_name: "$RCSfile$";
//---------------------------------------------------------------------------
// $Log$
// Revision 1.2  1998/02/02 18:05:21  raphaels
// Added TypeComp support.
// Updated TypeLib and TypeInfo support.
// Modified some file names.
//
// Revision 1.1.1.1  1998/01/15 23:32:17  raphaels
// First version of EiffelCOM
//
//---------------------------------------------------------------------------

#include "eifole.h"

/*---------------------------------------------------------------------------*/
// This is an important place. The initialization of OleControls related
// GUIDs is done in the following two lines.
// They are initialized in the code segment of the object module.

#include <initguid.h>
#include <olectl.h>

/*---------------------------------------------------------------------------*/
/*
    This is an Instance handle of the Windows DLL, containing Eiffel Ole
    Custom control.
*/

// This 'pInst' is an undocumented name from the Eiffel/X runtime
//extern "C" HINSTANCE pInst;

//HINSTANCE GetEocxInstance( void )
///{
//    return pInst;
//}

/*---------------------------------------------------------------------------*/
/*
    Updates the Windows Registry file.
    We must create all entries for every component that we support,
    including any entries for the type libraries.
    The return value should be SELFREG_E_CLASS or SELFREG_E_TYPELIB in
    case of error.
*/
//extern "C" STDAPI DllRegisterServer( void )
//{
//    HRESULT hr;
// /   Ocxdisp_ModuleSetStatusCode(eoleOcxDisp, eiffelOcxModule, S_OK);
//    Ocxdisp_ModuleRegister (eoleOcxDisp, eiffelOcxModule);
//    hr = Ocxdisp_ModuleGetStatusCode (eoleOcxDisp, eiffelOcxModule);
//    return hr;
//}

/*---------------------------------------------------------------------------*/
/*
    Updates the Windows Registry file.
    We must remove any entries created in 'DllRegisterServer'.
*/
//extern "C" STDAPI DllUnregisterServer (void)
//{
//    HRESULT hr;
//    __CallbackEnter
 //   Ocxdisp_ModuleSetStatusCode (eoleOcxDisp, eiffelOcxModule, S_OK);
//    Ocxdisp_ModuleUnregister (eoleOcxDisp, eiffelOcxModule);
//    hr = Ocxdisp_ModuleGetStatusCode (eoleOcxDisp, eiffelOcxModule);
//    __CallbackLeave
//    return hr;
//}

/*---------------------------------------------------------------------------*/
/*
    This function should create a class factory for a given CLSID and
    returns an appropriate interface pointer for the reguested IID, which
    is usually IClassFactory or IClassFactory2.
*/
extern "C" STDAPI DllGetClassObject (REFCLSID rclsid, REFIID riid, LPVOID FAR* ppv)
{
    RegisterEiffelControlClass();
    HRESULT hr;
    Ocxdisp_ModuleSetStatusCode (eoleOcxDisp, eiffelOcxModule, S_OK);
    *ppv = (void*)Ocxdisp_ModuleGetClassFactory (
                                          eoleOcxDisp,
                                          eiffelOcxModule,
                                          GuidToEiffelString (rclsid),
                                          GuidToEiffelString (riid));
    hr = Ocxdisp_ModuleGetStatusCode (eoleOcxDisp, eiffelOcxModule);
    return hr;
}

/*---------------------------------------------------------------------------*/
/*
    When COM calls this function: it is necessary to return S_FALSE to
    indicate that any objects or any locks exist. If there are no objects
    and no locks it necessary to return S_OK or NO_ERROR.
*/
extern "C" STDAPI DllCanUnloadNow( void )
{
    HRESULT hr;
    Ocxdisp_ModuleSetStatusCode (eoleOcxDisp, eiffelOcxModule, S_OK);
    hr = Ocxdisp_ModuleCanUnloadNow (eoleOcxDisp, eiffelOcxModule);
    return (EIF_BOOLEAN)hr;
}

/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/


