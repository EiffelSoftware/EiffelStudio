// EOLE_SAFEARRAYBOUND structure
#include "eifole.h"
#include "eif_cecil.h"
#include <objbase.h>
#include <oleauto.h>

extern "C" EIF_POINTER eole2_safearraybound_allocate() {
	return (EIF_POINTER)malloc (sizeof(SAFEARRAYBOUND));
	}

extern "C" void eole2_safearraybound_set_element_count (EIF_POINTER ptr, EIF_INTEGER count) {
	SAFEARRAYBOUND* pSAB = (SAFEARRAYBOUND*)ptr;
	pSAB->cElements = (unsigned long)count;
	}

extern "C" void eole2_safearraybound_set_lower_bound (EIF_POINTER ptr, EIF_INTEGER bnd) {
	SAFEARRAYBOUND* pSAB = (SAFEARRAYBOUND*)ptr;
	pSAB->lLbound = (long)bnd;
	}

extern "C" EIF_INTEGER eole2_safearraybound_element_count (EIF_POINTER ptr) {
	SAFEARRAYBOUND* pSAB = (SAFEARRAYBOUND*)ptr;
	return (EIF_INTEGER)(pSAB->cElements);
	}

extern "C" EIF_INTEGER eole2_safearraybound_lower_bound (EIF_POINTER ptr) {
	SAFEARRAYBOUND* pSAB = (SAFEARRAYBOUND*)ptr;
	return (EIF_INTEGER)(pSAB->lLbound);
	}
