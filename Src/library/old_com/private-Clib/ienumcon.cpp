//---------------------------------------------------------------------------
// indexing
//   title:         "IEnumConnections support";
//   cluster:       "CLIBRARY";
//   project:       "Eiffel OLE Library";
//   copyright:     "SiG Computer Inc., 1997";
//   approved_by:   "Symbol +";
//   external_name: "$RCSfile$";
//---------------------------------------------------------------------------
//-- $Log$
//-- Revision 1.2  1998/01/20 00:25:58  raphaels
//-- Modified sources to be compatible with Borland compiler.
//--
//-- Revision 1.1.1.1  1998/01/15 23:32:14  raphaels
//-- First version of EiffelCOM
//--
//---------------------------------------------------------------------------

#include "eifole.h"
#include "eif_hector.h"

int enum_connections_next_eiffel_called;

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
E_IEnumConnections::E_IEnumConnections() : E_IUnknown()
{
}

STDMETHODIMP E_IEnumConnections::Next
                         ( ULONG cConnections,
                           CONNECTDATA **rgpcd,
                           ULONG FAR* pcFetched )
{
     return E_IEnumConnections_Next
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           cConnections,
                           rgpcd,
                           pcFetched
                         );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_IEnumConnections::Skip
                         (
                           ULONG cConnections
                         )
{
     return E_IEnumConnections_Skip
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           cConnections
                         );
}

//---------------------------------------------------------------------------

STDMETHODIMP E_IEnumConnections::Reset
                         (  void
                         )
{
     return E_IEnumConnections_Reset
                         ( GetEiffelCurrentPointer(),
                           TRUE
                         );
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

extern "C" HRESULT E_IEnumConnections_Next
                         ( void * ptr,
                           BOOL incomingCall,
                           ULONG cConnections,
                           CONNECTDATA **rgpcd,
                           ULONG * pcFetched
                         )
{
     if( incomingCall )
       {
		enum_connections_next_eiffel_called = 1;
        *rgpcd = (CONNECTDATA*)Ocxdisp_EnumConnectionsNext (eif_access (eoleOcxDisp), eif_access (ptr), cConnections);
        return (HRESULT)(Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr)));
       }
     return ((E_IEnumConnections*) ptr)->Next
	 			(cConnections, rgpcd, pcFetched);
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IEnumConnections_Skip
                         ( void * ptr,
                           BOOL incomingCall,
                           ULONG cConnections
                         )
{
	if (incomingCall)
	  {
	   Ocxdisp_EnumConnectionsSkip (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER)cConnections);
	   return (HRESULT)Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
	  }
    return ((E_IEnumConnections*) ptr)->Skip ((ULONG) cConnections);
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IEnumConnections_Reset
                         ( void * ptr,
                           BOOL incomingCall
                         )
{
     if( incomingCall )
       {
        Ocxdisp_EnumConnectionsReset(eif_access (eoleOcxDisp), eif_access (ptr));
        return (HRESULT)Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
       }
     return ((E_IEnumConnections*) ptr)->Reset();
}

//---------------------------------------------------------------------------

extern "C" EIF_OBJ eole2_enum_connections_next (EIF_POINTER ptr, EIF_INTEGER count) {
	CONNECTDATA **rgpcd;
	ULONG *pcFetched;
	EIF_OBJ result;
	EIF_OBJ *connect;
	EIF_PROC eif_array_put;
	EIF_PROC eif_array_make;
	EIF_PROC eif_connect_make;
	EIF_PROC eif_connect_attach;
	EIF_TYPE_ID eif_array_id;
	EIF_TYPE_ID eif_connect_id;
	ULONG i = 0;
	
	rgpcd = (CONNECTDATA**)malloc (MaxArraySize * sizeof (CONNECTDATA*));
	pcFetched = (ULONG*)malloc (sizeof (ULONG));
	enum_connections_next_eiffel_called = 0;
	g_hrStatusCode = E_IEnumConnections_Next ((void *)ptr, FALSE, (ULONG)count, rgpcd, pcFetched);

	if (enum_connections_next_eiffel_called)
		result = (EIF_OBJ)*rgpcd;
	else {
		eif_array_id = eif_generic_id ("ARRAY", eif_type_id ("EOLE_CONNECT_DATA"));
		eif_connect_id = eif_type_id ("EOLE_CONNECTDATA");
		result = eif_create (eif_array_id);
		connect = (EIF_OBJ*)malloc (*pcFetched * sizeof (EIF_OBJ));
		eif_array_put = eif_proc ("put", eif_array_id);
		eif_array_make = eif_proc ("make", eif_array_id);
		eif_connect_make = eif_proc ("make", eif_connect_id);
		eif_connect_attach= eif_proc ("attach", eif_connect_id);
		(eif_array_make) (eif_access (result), (EIF_INTEGER)1, (EIF_INTEGER)(*pcFetched));
		while (i < *pcFetched) {
			connect[i] = eif_create (eif_connect_id);
			(eif_connect_make) (eif_access (connect[i]));
			(eif_connect_attach) (eif_access (connect[i]), (EIF_POINTER)(rgpcd [i]));
			(eif_array_put) (eif_access (result), eif_access (connect[i]), i + 1);
			i++;
		}
		result = eif_access (result);
	}
	return result;
}		

extern "C" void eole2_enum_connections_skip (EIF_POINTER ptr, EIF_INTEGER count) {
	g_hrStatusCode = E_IEnumConnections_Skip ((void *)ptr, FALSE, (ULONG)count);
	}
	
extern "C" void eole2_enum_connections_reset (EIF_POINTER ptr) {
	g_hrStatusCode = E_IEnumConnections_Reset ((void *)ptr, FALSE);
	}

//------------------------------------------------------------------------------
