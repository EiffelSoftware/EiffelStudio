/*-----------------------------------------------------------
Implemented `IFont' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_IFONT_IMPL_H__
#define __ECOM_IFONT_IMPL_H__


class IFont_impl;

#include "eif_com.h"

#include "eif_eiffel.h"

#include "windows.h"

#include "ecom_rt_globals.h"

#include "ecom_IFont.h"

#ifdef __cplusplus
extern "C" {
#endif

class IFont_impl
{
public:
	IFont_impl (IUnknown * a_pointer);
	virtual ~IFont_impl ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_name(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_name(  /* [in] */ EIF_OBJECT pname );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_size(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_size(  /* [in] */ CURRENCY * psize );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_bold(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_bold(  /* [in] */ EIF_BOOLEAN pbold );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_italic(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_italic(  /* [in] */ EIF_BOOLEAN pitalic );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_underline(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_underline(  /* [in] */ EIF_BOOLEAN punderline );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_strikethrough(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_strikethrough(  /* [in] */ EIF_BOOLEAN pstrikethrough );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_weight(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_weight(  /* [in] */ EIF_INTEGER pweight );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_charset(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_charset(  /* [in] */ EIF_INTEGER pcharset );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_h_font(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_POINTER ccom_clone1( );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_is_equal1(  /* [in] */ IFont * pfont_other );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_ratio(  /* [in] */ EIF_INTEGER cy_logical,  /* [in] */ EIF_INTEGER cy_himetric );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_ref_hfont(  /* [in] */ EIF_INTEGER a_h_font );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_release_hfont(  /* [in] */ EIF_INTEGER a_h_font );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	IFont1 * p_IFont;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};


#ifdef __cplusplus
}
#endif

#endif