// EOLE_SAFEARRAY structure

#include "eifole.h"
#include "eif_cecil.h"
#include <objbase.h>
#include <oleauto.h>

// Creation of SafeArray
extern "C" EIF_POINTER eole2_safearray_allocate (EIF_INTEGER typ, EIF_INTEGER dims, EIF_POINTER bounds) {
	return (EIF_POINTER)SafeArrayCreate ((VARTYPE)typ, (unsigned int)dims, (SAFEARRAYBOUND *)bounds);
	}

// Destruction of SafeArray
extern "C" void eole2_safearray_destroy (EIF_POINTER ptr) {
	SafeArrayDestroy ((SAFEARRAY FAR *)ptr);
	}
	
// Destruction of SafeArray data
extern "C" void eole2_safearray_destroy_data (EIF_POINTER ptr) {
	SafeArrayDestroyData ((SAFEARRAY FAR *)ptr);
	}

// Copy of SafeArray
extern "C" EIF_POINTER eole2_safearray_copy (EIF_POINTER ptr) {
	SAFEARRAY FAR * FAR * safearray_copy;
	SafeArrayCopy ((SAFEARRAY FAR *)ptr, safearray_copy);
	return (EIF_POINTER) safearray_copy;
	}
	
// Add an element to SafeArray
extern "C" void eole2_safearray_put_element (EIF_POINTER ptr, EIF_REFERENCE index, EIF_POINTER var) {
	SafeArrayPutElement ((SAFEARRAY FAR *)ptr, (long FAR *)index, (void FAR *)var); 
	}

// Upper bound of dimension 'dim_number'	
extern "C" EIF_INTEGER eole2_safearray_upper_bound (EIF_POINTER ptr, EIF_INTEGER dim_number) {
	long FAR* plUbound;
	SafeArrayGetUBound ((SAFEARRAY FAR *)ptr, (unsigned int) dim_number, plUbound);
	return (EIF_INTEGER) *plUbound;
	}

// Lower bound of dimension 'dim_number'	    
extern "C" EIF_INTEGER eole2_safearray_lower_bound ( EIF_POINTER ptr, EIF_INTEGER dim_number) {
	long FAR* plLbound;
	SafeArrayGetLBound ((SAFEARRAY FAR *)ptr, (unsigned int) dim_number, plLbound);
	return (EIF_INTEGER) *plLbound;
	}

// Element at 'index'
extern "C" EIF_POINTER eole2_safearray_element (EIF_POINTER ptr, EIF_REFERENCE index) {
	void FAR* pv;	
	SafeArrayGetElement ((SAFEARRAY FAR *) ptr, (long FAR *)index, pv); 
	return (EIF_POINTER)pv;
	}
	
// Dimension of SafeArray	
extern "C" EIF_INTEGER eole2_safearray_dim (EIF_POINTER ptr) {
	return (EIF_INTEGER)SafeArrayGetDim ((SAFEARRAY FAR *)ptr);
	}
	
// SafeArray element size
extern "C" EIF_INTEGER eole2_safearray_element_size (EIF_POINTER ptr) {
	return (EIF_INTEGER)SafeArrayGetElemsize ((SAFEARRAY FAR *)ptr);
	}

