// EOLE_SELECT_PICTURE structure

#include "eifole.h"
#include "eif_cecil.h"
#include "selectpicture.h"

// Creation of SelectPicture
extern "C" EIF_POINTER eole2_select_picture_allocate() {
	return (EIF_POINTER)malloc (sizeof (SelectPicture));
	}
	
// Set hdcOut member of SelecPicture structure
extern "C" void eole2_select_picture_set_hdc_out (EIF_POINTER ptr, EIF_INTEGER hout) {
	SelectPicture *sp = (SelectPicture*)ptr;
	sp -> hdcOut = (HDC)hout;
	}
	
// Set hbmpOut member of SelecPicture structure	
extern "C" void eole2_select_picture_set_hbmp_out (EIF_POINTER ptr, EIF_INTEGER hbmpout) {
	SelectPicture *sp = (SelectPicture*)ptr;
	sp -> hbmpOut = (OLE_HANDLE)hbmpout;
	}
	
// Get hdcOut member of SelecPicture structure
extern "C" EIF_INTEGER eole2_select_picture_hdc_out (EIF_POINTER ptr) {
	SelectPicture *sp = (SelectPicture*)ptr;
	return (EIF_INTEGER)sp -> hdcOut;
	}
	
// Get hbmpOut member of SelecPicture structure
extern "C" EIF_INTEGER eole2_select_picture_hbmp_out (EIF_POINTER ptr) {
	SelectPicture *sp = (SelectPicture*)ptr;
	return (EIF_INTEGER)sp -> hbmpOut;
	}

