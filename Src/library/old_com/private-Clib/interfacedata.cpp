// EOLE_INTERFACEDATA structure

#include "eif_cecil.h"
#include <objbase.h>
#include <oleauto.h>

// Creation of INTERFACEDATA
extern "C" EIF_POINTER eole2_interfacedata_allocate (EIF_INTEGER size) {
	INTERFACEDATA* result;
	result = (INTERFACEDATA*)malloc (sizeof (INTERFACEDATA));
	result->pmethdata = (METHODDATA*)malloc (sizeof (METHODDATA) * size);
	result->cMembers = (unsigned int)size;
	return (EIF_POINTER)result;
	}
	
// Destruction of INTERFACEDATA
extern "C" void eole2_interfacedata_destroy (EIF_POINTER ptr) {
	INTERFACEDATA* pID = (INTERFACEDATA*)ptr;	
	free (pID->pmethdata);
	free (pID);
	}

// add a METHODDATA structure to member pmethdata of INTERFACEDATA
extern "C" void eole2_interfacedata_add_method_data (EIF_POINTER ptr, EIF_INTEGER index, EIF_POINTER pardata) {
	INTERFACEDATA* pID = (INTERFACEDATA*)ptr;
	METHODDATA* pMD = (METHODDATA*)pardata;
	(pID->pmethdata[index]) = *pMD;
	}
	
// put a METHODDATA structure to member ppdata of INTERFACEDATA
extern "C" void eole2_interfacedata_put_method_data (INTERFACEDATA* ptr, EIF_INTEGER index, EIF_POINTER pardata) {
	INTERFACEDATA* pID = (INTERFACEDATA*)ptr;	
	METHODDATA* pMD = (METHODDATA*)pardata;
	(pID->pmethdata[index]) = *pMD;
	}
	
// get a METHODDATA structure
extern "C" EIF_POINTER eole2_interfacedata_get_method_data (EIF_POINTER ptr, EIF_INTEGER index) {
	INTERFACEDATA* pID = (INTERFACEDATA*)ptr;	
	return (EIF_POINTER)(pID->pmethdata + index);
	}	

// get cMembers member of structure
extern "C" EIF_INTEGER eole2_interfacedata_get_method_count (EIF_POINTER ptr) {
	INTERFACEDATA* pID = (INTERFACEDATA*)ptr;	
	return (EIF_INTEGER)(pID->cMembers);
	}