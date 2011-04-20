#include "simple_property_set.h"

EIF_OBJECT eiffel_simple_property_set_object = NULL;
	/* Address of Eiffel object EV_SIMPLE_PROPERTY_SET */
	
EIF_RIBBON_SIMPLE_PROPERTY_SET_GET_VALUE_PROC eiffel_get_value_function = NULL;
	/* Address of Eiffel EV_SIMPLE_PROPERTY_SET.get_value */

HRESULT STDMETHODCALLTYPE QueryInterface3(IUISimplePropertySet *This, REFIID vtblID, void **ppv);
ULONG STDMETHODCALLTYPE AddRef3(IUISimplePropertySet *This);
ULONG STDMETHODCALLTYPE Release3(IUISimplePropertySet *This);
HRESULT STDMETHODCALLTYPE GetValue(IUISimplePropertySet *This, REFPROPERTYKEY key, PROPVARIANT* value);


IUISimplePropertySetVtbl mySimplePropertySet_Vtbl = {QueryInterface3,
	AddRef3,
	Release3,
	GetValue	
	};
	

long OutstandingSimplePropertySet = 0;

IUISimplePropertySet * CreateInstanceSimplePropertySet ()
{
		IUISimplePropertySet	*pSimplePropertySet = NULL;
		/* allocate pSimplePropertySet */
		pSimplePropertySet = (IUISimplePropertySet *)GlobalAlloc(GMEM_FIXED, sizeof(IUISimplePropertySet));
		if(!pSimplePropertySet) {
			return(FALSE);
		}
				/*
				Point our pSimplePropertySet to mySimpleProperty_Vtbl that contains standard IUnknown method (QueryInterface, AddRef, Release)
				and callback for our IUISimplePropertySet interface (GetValue).
				*/
		(IUISimplePropertySetVtbl *)pSimplePropertySet->lpVtbl = &mySimplePropertySet_Vtbl;
		
		return pSimplePropertySet;
}
HRESULT STDMETHODCALLTYPE QueryInterface3(IUISimplePropertySet *This, REFIID vtblID, void **ppv)
{
	/* No match */
	if(!IsEqualIID(vtblID, &IID_IUISimplePropertySet) && !IsEqualIID(vtblID, &IID_IUnknown)) {
		*ppv = 0;
	

		return(E_NOINTERFACE);
	}

	/* Point our IUISimplePropertySet interface to our command handler obj */
	*ppv = This;

	/* Ref count */
	This->lpVtbl->AddRef(This);

	return(NOERROR);
}

ULONG STDMETHODCALLTYPE AddRef3(IUISimplePropertySet *This)
{
	return(InterlockedIncrement(&OutstandingSimplePropertySet));
}

ULONG STDMETHODCALLTYPE Release3(IUISimplePropertySet *This)
{
	return InterlockedDecrement(&OutstandingSimplePropertySet);
}

HRESULT STDMETHODCALLTYPE GetValue(IUISimplePropertySet *This, REFPROPERTYKEY key, PROPVARIANT* value)
{
/* 	Eiffel function for Ribbon UISimplePropertySet get value
		Eiffel function call need first parameter as EIF_REFERENCE. */

	if (eiffel_simple_property_set_object) {
			return (EIF_NATURAL_32) ((eiffel_get_value_function) (
	#ifndef EIF_IL_DLL
				(EIF_REFERENCE) eif_access (eiffel_simple_property_set_object),
	#endif
				(EIF_POINTER) This,
				(EIF_POINTER) key,
				(EIF_POINTER) value));
		} else {
			return 0;
		}  
	
	//return S_OK;
}

/* Set Eiffel EV_SIMPLE_PROPERTY_SET object address */
void c_set_simple_property_set_object(EIF_REFERENCE a_address)
{
	if (a_address) {
		eiffel_simple_property_set_object = eif_protect (a_address);
	} else {
		eiffel_simple_property_set_object = NULL;
	}
}

/* Release Eiffel EV_SIMPLE_PROPERTY_SET object address */
void c_release_simple_property_set_object()
{
	eif_wean (eiffel_simple_property_set_object);
}

/* Set EV_SIMPLE_PROPERTY_SET.get_value */
void c_set_get_value_address (EIF_POINTER a_address)
{
	eiffel_get_value_function = (EIF_RIBBON_SIMPLE_PROPERTY_SET_GET_VALUE_PROC)a_address;
}
