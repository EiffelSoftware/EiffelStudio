// EOLE_METHODDATA structure

#include "eif_cecil.h"
#include <objbase.h>
#include <oleauto.h>

// Creation of ParamData
extern "C" EIF_POINTER eole2_methoddata_allocate (EIF_INTEGER size) {
	METHODDATA* result;
	result = (METHODDATA*)malloc (sizeof (METHODDATA));
	result->ppdata = (PARAMDATA*)malloc (sizeof (PARAMDATA) * size);
	result->cArgs = (unsigned int)size;
	return (EIF_POINTER)result;
	}
	
// Destruction of ParamData
extern "C" void eole2_methoddata_destroy (EIF_POINTER ptr) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	free (pMD->ppdata);
	free (pMD);
	}

// Set szName member of paramdata
extern "C" void eole2_methoddata_set_method_name (EIF_POINTER ptr, EIF_POINTER name) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	pMD->szName = (OLECHAR FAR *)name;
	}
	
// set dispid member of PARAMDATA
extern "C" void eole2_methoddata_set_dispid (EIF_POINTER ptr, EIF_INTEGER dispid) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	pMD->dispid = (DISPID)dispid;
	}

// set iMeth member of PARAMDATA
extern "C" void eole2_methoddata_set_method_index (EIF_POINTER ptr, EIF_INTEGER index) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	pMD->iMeth = (unsigned int)index;
	}
	
// set cc member of PARAMDATA
extern "C" void eole2_methoddata_set_calling_convention (EIF_POINTER ptr, EIF_INTEGER conv) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	pMD->cc = (CALLCONV)conv;
	}

// set wFlags member of PARAMDATA
extern "C" void eole2_methoddata_set_method_flags (EIF_POINTER ptr, EIF_INTEGER flags) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	pMD->wFlags = (unsigned short)flags;
	}

// set vtReturn member of PARAMDATA
extern "C" void eole2_methoddata_set_return_type (EIF_POINTER ptr, EIF_INTEGER typ) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	pMD->vtReturn = (VARTYPE)typ;
	}

// add a paramdata structure to member ppdata of PARAMDATA
extern "C" void eole2_methoddata_add_param_data (EIF_POINTER ptr, EIF_POINTER pardata, EIF_INTEGER index) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	PARAMDATA* pPD = (PARAMDATA*)pardata;
	(pMD->ppdata[index]) = *pPD;
	}
	
// put a paramdata structure to member ppdata of PARAMDATA
extern "C" void eole2_methoddata_put_param_data (EIF_POINTER ptr, EIF_INTEGER index, EIF_POINTER pardata) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	PARAMDATA* pPD = (PARAMDATA*)pardata;
	(pMD->ppdata[index]) = *pPD;
	}
	
// get a paramdata structure
extern "C" EIF_POINTER eole2_methoddata_get_param_data (EIF_POINTER ptr, EIF_INTEGER index) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	return (EIF_POINTER)(pMD->ppdata + index);
	}	

// szName member of methoddata
extern "C" EIF_POINTER eole2_methoddata_get_method_name (EIF_POINTER ptr) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	return (EIF_POINTER)(pMD->szName);
	}

// dispid member of methoddata
extern "C" EIF_INTEGER eole2_methoddata_get_dispid (EIF_POINTER ptr) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	return (EIF_INTEGER)(pMD->dispid);
	}

// iMeth member of methoddata
extern "C" EIF_INTEGER eole2_methoddata_get_method_index (EIF_POINTER ptr) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	return (EIF_INTEGER)(pMD->iMeth);
	}

// cc member of methoddata
extern "C" EIF_INTEGER eole2_methoddata_get_calling_convention (EIF_POINTER ptr) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	return (EIF_INTEGER)(pMD->cc);
	}
	
// cArgs member of methoddata
extern "C" EIF_INTEGER eole2_methoddata_get_arg_count (EIF_POINTER ptr) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	return (EIF_INTEGER)(pMD->cArgs);
	}

// wFlags member of methoddata
extern "C" EIF_INTEGER eole2_methoddata_get_method_flags (EIF_POINTER ptr) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	return (EIF_INTEGER)(pMD->wFlags);
	}

// vtReturn member of methoddata
extern "C" EIF_INTEGER eole2_methoddata_get_return_type (EIF_POINTER ptr) {
	METHODDATA* pMD = (METHODDATA*)ptr;
	return (EIF_INTEGER)(pMD->vtReturn);
	}