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
//-- Revision 1.8  1999/01/22 18:51:16  marina
//--  Modified Files:
//--  	Eautostr.cpp Eoleauto.cpp eifole.h ieconpnt.cpp ienumcon.cpp
//--  	ienumukn.cpp
//-- 		-- removed use of `eif_generic_id'
//--
//-- Revision 1.7  1998/02/09 19:20:15  raphaels
//-- Mainly cosmetics. Added `character' to EOLE_VARIANT.
//--
//-- Revision 1.3  1998/01/20 23:48:00  raphaels
//-- Removed obsolete files.
//--
//---------------------------------------------------------------------------

#include "eifole.h"

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

STDMETHODIMP E_IEnumUnknown::Clone ( IEnumUnknown __RPC_FAR *__RPC_FAR *ppenum )
{
     return E_IEnumUnknown_Clone
                         ( GetEiffelCurrentPointer(),
                           TRUE,
						   ppenum
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

extern "C" HRESULT E_IEnumUnknown_Clone
                         ( void * ptr,
                           BOOL incomingCall,
						   IEnumUnknown __RPC_FAR *__RPC_FAR *ppenum
                         )
{
	 HRESULT res;
     if( incomingCall )
       {
        *ppenum = (IEnumUnknown __RPC_FAR *) Ocxdisp_EnumUnknownClone(eif_access (eoleOcxDisp), eif_access (ptr));
        res = Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
        return res;
       }
     return ((E_IEnumUnknown*) ptr)->Clone (ppenum);

}

//----------------------------------------------------------------------------

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
	g_hrStatusCode = E_IEnumUnknown_Next ((void *)ptr, FALSE, (ULONG)count, rgelt, pcFetched);

	if (enum_unknown_next_eiffel_called)
		result = (EIF_OBJ)*rgelt;
	else {
		eif_array_id = eif_type_id ("ARRAY [EOLE_UNKNOWN]");
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
	g_hrStatusCode = E_IEnumUnknown_Skip ((void *)ptr, FALSE, (ULONG)count);
	}
	
extern "C" void eole2_enum_unknown_reset (EIF_POINTER ptr) {
	g_hrStatusCode = E_IEnumUnknown_Reset ((void *)ptr, FALSE);
	}

extern "C" EIF_POINTER eole2_enum_unknown_clone (EIF_POINTER ptr) {
	IEnumUnknown __RPC_FAR *__RPC_FAR *ppenum;

	ppenum = (IEnumUnknown __RPC_FAR *__RPC_FAR *)malloc (sizeof (IEnumUnknown __RPC_FAR *));
	g_hrStatusCode = E_IEnumUnknown_Clone ((void *)ptr, FALSE, ppenum);
	return (EIF_POINTER)*ppenum;
	}