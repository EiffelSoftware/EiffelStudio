//---------------------------------------------------------------------------
// indexing
//   title:         "IEnumConnectionPoints support";
//   cluster:       "CLIBRARY";
//   project:       "Eiffel OLE Library";
//   copyright:     "SiG Computer Inc., 1997";
//   approved_by:   "Symbol +";
//   external_name: "$RCSfile$";
//---------------------------------------------------------------------------
//-- $Log$
//-- Revision 1.8  1999/01/22 18:51:13  marina
//--  Modified Files:
//--  	Eautostr.cpp Eoleauto.cpp eifole.h ieconpnt.cpp ienumcon.cpp
//--  	ienumukn.cpp
//-- 		-- removed use of `eif_generic_id'
//--
//-- Revision 1.7  1998/02/09 19:20:14  raphaels
//-- Mainly cosmetics. Added `character' to EOLE_VARIANT.
//--
//-- Revision 1.3  1998/01/20 23:47:58  raphaels
//-- Removed obsolete files.
//--
//---------------------------------------------------------------------------

#include "eifole.h"

int enum_connection_points_next_eiffel_called;

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
E_IEnumConnectionPoints::E_IEnumConnectionPoints() : E_IUnknown()
{
}

STDMETHODIMP E_IEnumConnectionPoints::Next
                         (
                           ULONG cConnections,
                           IConnectionPoint ** rgpcn,
                           ULONG * pcFetched
                         )
{
     return E_IEnumConnectionPoints_Next
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( ULONG )  cConnections,
                           ( IConnectionPoint ** )  rgpcn,
                           ( ULONG * )  pcFetched
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IEnumConnectionPoints::Skip
                         (
                           ULONG cConnections
                         )
{
     return E_IEnumConnectionPoints_Skip
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( ULONG )  cConnections
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IEnumConnectionPoints::Reset
                         (  void
                         )
{
     return E_IEnumConnectionPoints_Reset
                         ( GetEiffelCurrentPointer(),
                           TRUE
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IEnumConnectionPoints::Clone
                         (
                           IEnumConnectionPoints ** ppEnum
                         )
{
     return E_IEnumConnectionPoints_Clone
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                          ( IEnumConnectionPoints ** )  ppEnum
                         );
}
//---------------------------------------------------------------------------



//---------------------------------------------------------------------------

extern "C" HRESULT E_IEnumConnectionPoints_Next
                         ( void * ptr,
                           BOOL incomingCall,
                           ULONG cConnections,
                           IConnectionPoint ** rgpcn,
                           ULONG * pcFetched
                         )
{
     if( incomingCall )
       {
		enum_connection_points_next_eiffel_called = 1;
        *rgpcn = (IConnectionPoint *)Ocxdisp_EnumConnPointNext(eif_access (eoleOcxDisp), eif_access (ptr), cConnections);
        return (Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr)));
       }
     return ((E_IEnumConnectionPoints*) ptr)->Next
                         (
                           ( ULONG )  cConnections,
                           ( IConnectionPoint ** )  rgpcn,
                           ( ULONG * )  pcFetched
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IEnumConnectionPoints_Skip
                         ( void * ptr,
                           BOOL incomingCall,
                           ULONG cConnections
                         )
{
     if( incomingCall )
       {
        Ocxdisp_EnumConnPointSkip(eif_access (eoleOcxDisp), eif_access (ptr), cConnections);
        return (Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr)));
       }

     return ((E_IEnumConnectionPoints*) ptr)->Skip
                         (
                           ( ULONG )  cConnections
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IEnumConnectionPoints_Reset
                         ( void * ptr,
                           BOOL incomingCall
                         )
{
     if( incomingCall )
       {
        Ocxdisp_EnumConnPointReset(eif_access (eoleOcxDisp), eif_access (ptr));
        return (Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr)));
       }
     return ((E_IEnumConnectionPoints*) ptr)->Reset();
}

//------------------------------------------------------------------------

extern "C" HRESULT E_IEnumConnectionPoints_Clone
                         ( void * ptr,
                           BOOL incomingCall,
						   IEnumConnectionPoints **  ppEnum
                         )
{
     if( incomingCall )
       {
        *ppEnum = (IEnumConnectionPoints*)Ocxdisp_EnumConnPointClone(eif_access (eoleOcxDisp), eif_access (ptr));
        return (Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr)));
       }
     return ((E_IEnumConnectionPoints*) ptr)->Clone (ppEnum);
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------

extern "C" EIF_OBJ eole2_enum_connection_points_next (EIF_POINTER ptr, EIF_INTEGER count) 

{
	IConnectionPoint **rgpcn;
	ULONG *pcFetched;
	EIF_OBJ result;
	EIF_OBJ *connpt;
	EIF_PROC eif_array_put;
	EIF_PROC eif_array_make;
	EIF_PROC eif_connpt_make;
	EIF_PROC eif_connpt_attach;
	EIF_TYPE_ID eif_array_id;
	EIF_TYPE_ID eif_connpt_id;
	ULONG i = 0;
	
	rgpcn = (IConnectionPoint **)malloc (MaxArraySize * sizeof (IConnectionPoint *));
	pcFetched = (ULONG*)malloc (sizeof (ULONG));
	enum_connection_points_next_eiffel_called = 0;
	g_hrStatusCode = E_IEnumConnectionPoints_Next ((void *)ptr, FALSE, (ULONG)count, rgpcn, pcFetched);

	if (enum_connection_points_next_eiffel_called)
		result = (EIF_OBJ)*rgpcn;
	else {
		eif_array_id = eif_type_id ("ARRAY [EOLE_CONNECTION_POINT]");
		eif_connpt_id = eif_type_id ("EOLE_CONNECTION_POINT");
		result = eif_create (eif_array_id);
		connpt = (EIF_OBJ*)malloc (*pcFetched * sizeof (EIF_OBJ));
		eif_array_put = eif_proc ("put", eif_array_id);
		eif_array_make = eif_proc ("make", eif_array_id);
		eif_connpt_make = eif_proc ("make", eif_connpt_id);
		eif_connpt_attach= eif_proc ("attach_ole_interface_ptr", eif_connpt_id);
		(eif_array_make) (eif_access (result), (EIF_INTEGER)1, (EIF_INTEGER)(*pcFetched));
		while (i < *pcFetched) {
			connpt[i] = eif_create (eif_connpt_id);
			(eif_connpt_make) (eif_access (connpt[i]));
			(eif_connpt_attach) (eif_access (connpt[i]), (EIF_POINTER)(rgpcn [i]));
			(eif_array_put) (eif_access (result), eif_access (connpt[i]), i + 1);
			i++;
		}
		result = eif_access (result);
	}
	return result;
}	


extern "C" void eole2_enum_connection_points_skip (EIF_POINTER ptr, EIF_INTEGER count) {
	g_hrStatusCode = E_IEnumConnectionPoints_Skip ((void *)ptr, FALSE, (ULONG)count);
	}
	
extern "C" void eole2_enum_connection_points_reset (EIF_POINTER ptr) {
	g_hrStatusCode = E_IEnumConnectionPoints_Reset ((void *)ptr, FALSE);
	}

extern "C" EIF_POINTER eole2_enum_connection_points_clone (EIF_POINTER ptr) {
	LPENUMCONNECTIONPOINTS FAR* ppecnpt;

	ppecnpt = (IEnumConnectionPoints __RPC_FAR *__RPC_FAR *)malloc (sizeof (IEnumConnectionPoints __RPC_FAR *));
	g_hrStatusCode = E_IEnumConnectionPoints_Clone ((void *)ptr, FALSE, ppecnpt);
	return (EIF_POINTER)*ppecnpt;
	}
