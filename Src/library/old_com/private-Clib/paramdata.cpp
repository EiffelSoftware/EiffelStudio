// EOLE_ParamData structure

#include "eif_cecil.h"
#include <objbase.h>
#include <oleauto.h>

// Creation of ParamData
extern "C" EIF_POINTER eole2_paramdata_allocate () {
	return (EIF_POINTER)malloc (sizeof (PARAMDATA));
	}
	
// Destruction of ParamData
extern "C" void eole2_paramdata_destroy (EIF_POINTER ptr) {
	PARAMDATA* pPD = (PARAMDATA*)ptr;
	free (pPD);
	}

// Set szName member of paramdata
extern "C" void eole2_paramdata_set_name (EIF_POINTER ptr, OLECHAR FAR* name) {
	PARAMDATA* pPD = (PARAMDATA*)ptr;
	pPD->szName = name;
	}
	
// set vt member of PARAMDATA
extern "C" void eole2_paramdata_set_vartype (EIF_POINTER ptr, EIF_INTEGER typ) {
	PARAMDATA* pPD = (PARAMDATA*)ptr;
	pPD->vt = (VARTYPE)typ;
	}

// szName member of paramdata
extern "C" EIF_POINTER eole2_paramdata_get_name (EIF_POINTER ptr) {
	PARAMDATA* pPD = (PARAMDATA*)ptr;
	return (EIF_POINTER)(pPD->szName);
	}

// vt member of paramdata    
extern "C" EIF_INTEGER eole2_paramdata_get_vartype (EIF_POINTER ptr) {
	PARAMDATA* pPD = (PARAMDATA*)ptr;
	return (EIF_INTEGER)(pPD->vt);
	}