//---------------------------------------------------------------------------
// indexing
//   title:         "IEnumUnknown support";
//   cluster:       "CLIBRARY";
//   project:       "Eiffel OLE Library";
//   copyright:     "SiG Computer Inc., 1997";
//   approved_by:   "Symbol +";
//   external_name: "$RCSfile$";
//---------------------------------------------------------------------------
//-- $Log$
//-- Revision 1.1  1998/01/15 23:32:14  raphaels
//-- Initial revision
//--
//---------------------------------------------------------------------------

#include "eifole.h"
#include "eif_hector.h"

int enum_unknown_next_eiffel_called;

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
E_IEnumUnknown::E_IEnumUnknown() : E_IUnknown()
{
}

STDMETHODIMP E_IEnumUnknown::Next
                         (
                           ULONG  celt,
                           IUnknown ** rgelt,
                           ULONG * pceltFetched
                         )
{
     return E_IEnumUnknown_Next
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( ULONG  )  celt,
                           ( IUnknown ** )  rgelt,
                           ( ULONG * )  pceltFetched
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IEnumUnknown::Skip (  ULONG celt )
{
     return E_IEnumUnknown_Skip
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( ULONG )  celt
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IEnumUnknown::Reset ( void )
{
     return E_IEnumUnknown_Reset
                         ( GetEiffelCurrentPointer(),
                           TRUE
                         );
}


//---------------------------------------------------------------------------



extern "C" HRESULT E_IEnumUnknown_Next
                         ( void * ptr,
                           BOOL incomingCall,
                           ULONG  celt,
                           IUnknown ** rgelt,
                           ULONG * pceltFetched
                         )
{
     if( incomingCall )
       {
		enum_unknown_next_eiffel_called = 1;
        *rgelt = (IUnknown*)Ocxdisp_EnumUnknownNext(eif_access (eoleOcxDisp), eif_access (ptr), celt);
        return (Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr)));
       }

     return ((E_IEnumUnknown*) ptr)->Next
                         (
                           ( ULONG  )  celt,
                           ( IUnknown ** )  rgelt,
                           ( ULONG * )  pceltFetched
                         );

}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IEnumUnknown_Skip
                         ( void * ptr,
                           BOOL incomingCall,
                           ULONG celt
                         )
{
	 HRESULT res;
     if( incomingCall )
       {
        Ocxdisp_EnumUnknownSkip(eif_access (eoleOcxDisp), eif_access (ptr), celt);
        res = Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
        return res;
       }

     return ((E_IEnumUnknown*) ptr)->Skip( ( ULONG )  celt );

}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IEnumUnknown_Reset
                         ( void * ptr,
                           BOOL incomingCall
                         )
{
	 HRESULT res;
     if( incomingCall )
       {
        Ocxdisp_EnumUnknownReset(eif_access (eoleOcxDisp), eif_access (ptr));
        res = Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
        return res;
       }
     return ((E_IEnumUnknown*) ptr)->Reset();

}

//---------------------------------------------------------------------------

extern "C" EIF_OBJ eole2_enum_unknown_next (EIF_POINTER ptr, EIF_INTEGER count) {
	IUnknown ** rgelt;
	ULONG *pcFetched;
	EIF_OBJ result;
	EIF_OBJ *unknown;
	EIF_PROC eif_array_put;
	EIF_PROC eif_array_make;
	EIF_PROC eif_unknown_make;
	EIF_PROC eif_unknown_attach;
	EIF_TYPE_ID eif_array_id;
	EIF_TYPE_ID eif_unknown_id;
	ULONG i = 0;

	rgelt = (IUnknown**)malloc (MaxArraySize * sizeof (IUnknown*));
	pcFetched = (ULONG*)malloc (sizeof (ULONG));
	enum_unknown_next_eiffel_called = 0;
	g_hrStatusCode = E_IEnumUnknown_Next ((void *)ptr, false, (ULONG)count, rgelt, pcFetched);

	if (enum_unknown_next_eiffel_called)
		result = (EIF_OBJ)*rgelt;
	else {
		eif_array_id = eif_generic_id ("ARRAY", eif_type_id ("EOLE_UNKNOWN"));
		eif_unknown_id = eif_type_id ("EOLE_UNKNOWN");
		result = eif_create (eif_array_id);
		unknown = (EIF_OBJ*)malloc (*pcFetched * sizeof (EIF_OBJ));
		eif_array_put = eif_proc ("put", eif_array_id);
		eif_array_make = eif_proc ("make", eif_array_id);
		eif_unknown_make = eif_proc ("make", eif_unknown_id);
		eif_unknown_attach= eif_proc ("attach_ole_interface_ptr", eif_unknown_id);
		(eif_array_make) (eif_access (result), (EIF_INTEGER)1, (EIF_INTEGER)(*pcFetched));
		while (i < *pcFetched) {
			unknown[i] = eif_create (eif_unknown_id);
			(eif_unknown_make) (eif_access (unknown[i]));
			(eif_unknown_attach) (eif_access (unknown[i]), (EIF_POINTER)(rgelt [i]));
			(eif_array_put) (eif_access (result), eif_access (unknown[i]), i + 1);
			i++;
		}
		result = eif_access (result);
	}
	return result;
}		

extern "C" void eole2_enum_unknown_skip (EIF_POINTER ptr, EIF_INTEGER count) {
	g_hrStatusCode = E_IEnumUnknown_Skip ((void *)ptr, false, (ULONG)count);
	}
	
extern "C" void eole2_enum_unknown_reset (EIF_POINTER ptr) {
	g_hrStatusCode = E_IEnumUnknown_Reset ((void *)ptr, false);
	}
