/////////////////////////////////////////////////////////////////////////////
//
//     IPERSIST.CPP   Copyright (c) 1996 by SiG Computer
//
//     Version:       0.00
//
//     Eiffel OLE 2 Library
//
//     IPersist support
//
//     Functions:
//       E_IPersist::E_IPersist
//       E_IPersist::GetClassId
//       E_IPersist_GetClassId
//       eole2_get_class_id
//     Globals:
//       None.
//     Notes:
//       None.
//

#include "eifole.h"
#include "eif_hector.h"

/////////////////////////////////////////////////////////////////////////////
//
// E_IPersist::E_IPersist
//
// Purpose:
//    Object's constructor.
//
// Parameters:
//    None.
//
// Return Value:
//    None.
//

E_IPersist::E_IPersist(): E_IUnknown() {
}


/////////////////////////////////////////////////////////////////////////////
//
// E_IPersist::GetClassID
//
// Purpose:
//    Returns the class identifier (CLSID) of the component object. The CLSID
//    is a unique value that identifies the application that can manipulate
//    the component object data.
// Parameters:
//    CLSID *pClassId [out]  Points to the location where the CLSID is returned.
//                           The CLSID is a globally unique identifier (GUID)
//                           that uniquely represents an object class.
// Return Value:
//    Ole error code.
//

STDMETHODIMP E_IPersist::GetClassID (CLSID __RPC_FAR *pClassID) {
    return E_IPersist_GetClassID (
                          GetEiffelCurrentPointer (), TRUE, // Incoming Call!
                          pClassID);
}

/////////////////////////////////////////////////////////////////////////////
//
// E_IPersist_GetClassID
//
// Purpose:
//    Perform either Eiffel or C++ method invocation.
//
// Parameters:
//    void    *ptr          [in]  Pointer to corresponding Eiffel object
//                                (TRUE==incomingCall)
//                                or to C++ VTBL.
//                                (FALSE==incomingCall)
//    BOOL    incomingCall  [in]  True, if we was invoked by OLE.
//                                False, otherwise.
//    CLSID  *pClassId      [out] Points to the location where the CLSID is
//                                returned. The CLSID is a globally unique
//                                identifier (GUID) that uniquely represents
//                                an object class.
// Return Value:
//    Ole error code.
//

extern "C" HRESULT E_IPersist_GetClassID (void* ptr, BOOL incomingCall,
                                                 CLSID __RPC_FAR *pClassID) {
    if (incomingCall) {
        HRESULT hr;
        Ocxdisp_UnknownSetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr), S_OK);
        EIF_POINTER classString =
                   (EIF_POINTER)Ocxdisp_PersistGetClassId (eif_access (eoleOcxDisp), eif_access (ptr));
        hr = Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
        if (classString != 0 && pClassID != 0) {
            EiffelStringToGuid( classString, pClassID );
        }
        return hr;
    }
    return ((E_IPersist*)ptr)->GetClassID (pClassID);
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_get_class_id
//
// Purpose:
//    Performe simple call of external object.
//
// Parameters:
//    EIF_POINTER pIPersistThis [in]  Pointer to the external VTBL of
//                                    the IPersist interface.
// Return Value:
//    Eiffel string, representing the corresponding class ID.
//

extern "C" EIF_REFERENCE eole2_get_class_id (EIF_POINTER pIPersistThis) {
   GUID ClassId;

   g_hrStatusCode = E_IPersist_GetClassID (
                                   pIPersistThis, FALSE, // Call from Eiffel!
                                   &ClassId);
   return GuidToEiffelString (ClassId);
}

/////// END OF FILE /////////////////////////////////////////////////////////
