//---------------------------------------------------------------------------
// indexing
//   title:         "IConnectionPoint support";
//   cluster:       "CLIBRARY";
//   project:       "Eiffel OLE Library";
//   copyright:     "SiG Computer Inc., 1997";
//   approved_by:   "Symbol +";
//   external_name: "$RCSfile$";
//---------------------------------------------------------------------------
//-- $Log$
//-- Revision 1.3  1998/02/02 18:10:35  raphaels
//-- Added ITypeComp support.
//-- Corrected some bugs in ITypeLib and ITypeInfo.
//--
//-- Revision 1.1.1.1  1998/01/15 23:32:14  raphaels
//-- First version of EiffelCOM
//--
//---------------------------------------------------------------------------


#include "eifole.h"
#include "eif_hector.h"

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
E_IConnectionPoint::E_IConnectionPoint() : E_IUnknown()
{
}


STDMETHODIMP E_IConnectionPoint::Advise
                         (
                           IUnknown * pUnk,
                           DWORD * pdwCookie
                         )
{
     return E_IConnectionPoint_Advise
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( IUnknown * )  pUnk,
                           ( DWORD * )  pdwCookie
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IConnectionPoint::Unadvise
                         (
                           DWORD    dwCookie
                         )
{
     return E_IConnectionPoint_Unadvise
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( DWORD    )  dwCookie
                         );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_IConnectionPoint::GetConnectionInterface
                         (
                           IID  * pIID
                         )
{
     return E_IConnectionPoint_GetConnectionInterface
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           (IID*) pIID
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IConnectionPoint::GetConnectionPointContainer
                         (
                           IConnectionPointContainer ** ppCPC
                         )
{
     return E_IConnectionPoint_GetConnectionPointContainer
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( IConnectionPointContainer ** )  ppCPC
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IConnectionPoint::EnumConnections
                         (
                           IEnumConnections ** ppEnum
                         )
{
     return E_IConnectionPoint_EnumConnections
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( IEnumConnections ** )  ppEnum
                         );
}
//---------------------------------------------------------------------------



//---------------------------------------------------------------------------


extern "C" HRESULT E_IConnectionPoint_Advise
                         ( void * ptr,
                           BOOL incomingCall,
                           IUnknown * pUnk,
                           DWORD * pdwCookie
                         )
{
	 if( incomingCall )
          {
        	*pdwCookie = (DWORD)
						Ocxdisp_ConnectionPointAdvise(eif_access (eoleOcxDisp), eif_access (ptr));
        	return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IConnectionPoint*) ptr)->Advise
                         (
                           ( IUnknown * )  pUnk,
                           ( DWORD * )  pdwCookie
                         );

}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IConnectionPoint_Unadvise
                         ( void * ptr,
                           BOOL incomingCall,
                           DWORD    dwCookie
                         )
{
	 if( incomingCall )
          {
			Ocxdisp_ConnectionPointUnadvise(eif_access (eoleOcxDisp), eif_access (ptr), dwCookie);
        	return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IConnectionPoint*) ptr)->Unadvise
                         (
                           ( DWORD    )  dwCookie
                         );

}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IConnectionPoint_GetConnectionInterface
                         ( void * ptr,
                           BOOL incomingCall,
                           IID* pIID
                         )
{
	 if( incomingCall )
          {
        	EiffelStringToGuid (
						Ocxdisp_ConnectionPointGetConnectionInterface (eif_access (eoleOcxDisp), eif_access (ptr)), pIID);
        	return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IConnectionPoint*) ptr)->GetConnectionInterface
                         (
                           ( IID * )  pIID
                         );

}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IConnectionPoint_GetConnectionPointContainer
                         ( void * ptr,
                           BOOL incomingCall,
                           IConnectionPointContainer ** ppCPC
                         )
{
	 if( incomingCall )
          {
        	*ppCPC = (IConnectionPointContainer*)
						Ocxdisp_ConnectionPointGetConnectionPointContainer(eif_access (eoleOcxDisp), eif_access (ptr));
        	return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
    return ((E_IConnectionPoint*) ptr)->GetConnectionPointContainer
                         (
                           ( IConnectionPointContainer ** )  ppCPC
                         );

}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IConnectionPoint_EnumConnections
                         ( void * ptr,
                           BOOL incomingCall,
                           IEnumConnections ** ppEnum
                         )
{
	 if( incomingCall )
          {
        	*ppEnum = (IEnumConnections*)
						Ocxdisp_ConnectionPointEnumConnections(eif_access (eoleOcxDisp), eif_access (ptr));
        	return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IConnectionPoint*) ptr)->EnumConnections
                         (
                           ( IEnumConnections ** )  ppEnum
                         );

}

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------


extern "C"  EIF_REFERENCE eole2_connection_point_get_connection_interface ( EIF_POINTER ip )
{
  GUID iid;

  g_hrStatusCode = E_IConnectionPoint_GetConnectionInterface
                    ( ip, FALSE,
                     (IID*)  &iid

					 );

  return (EIF_OBJ) GuidToEiffelString(iid);
}
//---------------------------------------------------------------------------
extern "C" EIF_POINTER eole2_connection_point_get_connection_point_container
                       ( EIF_POINTER ip)
{
	IConnectionPointContainer * pIConnectionPointContainer;
   
	g_hrStatusCode = E_IConnectionPoint_GetConnectionPointContainer
                          ( ip, FALSE,
                           ( IConnectionPointContainer ** )  &pIConnectionPointContainer
                          );

    return (EIF_POINTER)pIConnectionPointContainer;

}
//---------------------------------------------------------------------------
extern "C" EIF_INTEGER eole2_connection_point_advise
                          ( EIF_POINTER ip,
                            EIF_POINTER i_unknown
                          )
{
  DWORD   cookie;

   g_hrStatusCode = E_IConnectionPoint_Advise
                          ( ip, FALSE,
                           ( IUnknown * )  i_unknown,
                           ( DWORD * )  &cookie
                          );

  return  (EIF_INTEGER) cookie;
}
//---------------------------------------------------------------------------
extern "C" void eole2_connection_point_unadvise
                                               ( EIF_POINTER ip,
                                                 EIF_INTEGER cookie
                                               )
{
  g_hrStatusCode = E_IConnectionPoint_Unadvise ( ip, FALSE, ( DWORD )  cookie );

}
//---------------------------------------------------------------------------
extern "C" EIF_POINTER eole2_connection_point_enum_connections ( EIF_POINTER ip)
{
	IEnumConnections * pIEnumConnections;

	g_hrStatusCode = E_IConnectionPoint_EnumConnections
                          ( ip, FALSE,
                           ( IEnumConnections ** )  &pIEnumConnections
                          );

    return (EIF_POINTER)pIEnumConnections;

}
//---------------------------------------------------------------------------
