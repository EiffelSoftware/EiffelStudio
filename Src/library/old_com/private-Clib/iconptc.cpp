//---------------------------------------------------------------------------
// indexing
//   title:         "IConnectionPointContainer support";
//   cluster:       "CLIBRARY";
//   project:       "Eiffel OLE Library";
//   copyright:     "SiG Computer Inc., 1997";
//   approved_by:   "Symbol +";
//   external_name: "$RCSfile$";
//---------------------------------------------------------------------------
//-- $Log$
//-- Revision 1.3  1998/02/02 18:10:36  raphaels
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
E_IConnectionPointContainer::E_IConnectionPointContainer() : E_IUnknown()
{
}

STDMETHODIMP E_IConnectionPointContainer::EnumConnectionPoints
                         (
                           IEnumConnectionPoints ** ppEnum
                         )
{
     return E_IConnectionPointContainer_EnumConnectionPoints
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( IEnumConnectionPoints ** )  ppEnum
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IConnectionPointContainer::FindConnectionPoint
                         (
                           REFIID riid,
                           IConnectionPoint ** ppCP
                         )
{
     return E_IConnectionPointContainer_FindConnectionPoint
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( REFIID )  riid,
                           ( IConnectionPoint ** )  ppCP
                         );
}
//---------------------------------------------------------------------------



//---------------------------------------------------------------------------

extern "C" HRESULT E_IConnectionPointContainer_EnumConnectionPoints
                         ( void * ptr,
                           BOOL incomingCall,
                           IEnumConnectionPoints ** ppEnum
                         )
{
	 if( incomingCall )
          {
        	*ppEnum = (IEnumConnectionPoints*)Ocxdisp_ConnectionPointContainerEnumConnectionPoints(eif_access (eoleOcxDisp), eif_access (ptr));
        	return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IConnectionPointContainer*) ptr)->EnumConnectionPoints
                         (
                           ( IEnumConnectionPoints ** )  ppEnum
                         );

}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IConnectionPointContainer_FindConnectionPoint
                         ( void * ptr,
                           BOOL incomingCall,
                           REFIID riid,
                           IConnectionPoint ** ppCP
                         )
{
	if( incomingCall )
          {
        	*ppCP = (IConnectionPoint*)
					Ocxdisp_ConnectionPointContainerFindConnectionPoint(eif_access (eoleOcxDisp), eif_access (ptr), GuidToEiffelString (riid));
        	return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IConnectionPointContainer*) ptr)->FindConnectionPoint
                         (
                           ( REFIID )  riid,
                           ( IConnectionPoint ** )  ppCP
                         );

}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_connection_point_container_enum_connection_points
                          ( EIF_POINTER ip)
{
    IEnumConnectionPoints *  pIEnumConnectionPoints;
    
	g_hrStatusCode = E_IConnectionPointContainer_EnumConnectionPoints
                          ( ip, FALSE,
                           ( IEnumConnectionPoints ** )  &pIEnumConnectionPoints
                          );
    return (EIF_POINTER)pIEnumConnectionPoints;

}
//---------------------------------------------------------------------------
extern "C" EIF_POINTER  eole2_connection_point_container_find_connection_point
                          ( EIF_POINTER ip, EIF_POINTER riid)
{
    GUID                tmp_riid;
    IConnectionPoint *  pIConnectionPoint;
    
	EiffelStringToGuid (riid, &tmp_riid);
    g_hrStatusCode = E_IConnectionPointContainer_FindConnectionPoint
                          ( ip, FALSE,
                            (REFIID) tmp_riid,
                           ( IConnectionPoint ** )  &pIConnectionPoint
                          );

    return (EIF_POINTER)pIConnectionPoint;


}
//---------------------------------------------------------------------------
