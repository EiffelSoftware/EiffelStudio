/*-----------------------------------------------------------
No description available.
-----------------------------------------------------------*/

#ifndef __ECOM_STDFONT_H__
#define __ECOM_STDFONT_H__


class StdFont;

#include "eif_com.h"

#include "eif_eiffel.h"

#include "windows.h"

#include "ecom_rt_globals.h"

#include "ecom_Font.h"

#include "ecom_FontEvents.h"

#include "ecom_IFont.h"

#ifdef __cplusplus
extern "C" {
#endif

class StdFont
{
public:
	StdFont ();
	StdFont (IUnknown * a_pointer);
	virtual ~StdFont ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_name();


	/*-----------------------------------------------------------
	Set No description available.
	-----------------------------------------------------------*/
	void ccom_set_name( EIF_OBJECT a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_size();


	/*-----------------------------------------------------------
	Set No description available.
	-----------------------------------------------------------*/
	void ccom_set_size( CURRENCY * a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_bold();


	/*-----------------------------------------------------------
	Set No description available.
	-----------------------------------------------------------*/
	void ccom_set_bold( EIF_BOOLEAN a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_italic();


	/*-----------------------------------------------------------
	Set No description available.
	-----------------------------------------------------------*/
	void ccom_set_italic( EIF_BOOLEAN a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_underline();


	/*-----------------------------------------------------------
	Set No description available.
	-----------------------------------------------------------*/
	void ccom_set_underline( EIF_BOOLEAN a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_strikethrough();


	/*-----------------------------------------------------------
	Set No description available.
	-----------------------------------------------------------*/
	void ccom_set_strikethrough( EIF_BOOLEAN a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_weight();


	/*-----------------------------------------------------------
	Set No description available.
	-----------------------------------------------------------*/
	void ccom_set_weight( EIF_INTEGER a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_charset();


	/*-----------------------------------------------------------
	Set No description available.
	-----------------------------------------------------------*/
	void ccom_set_charset( EIF_INTEGER a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_font_changed(  /* [in] */ EIF_OBJECT property_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ifont_name(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_ifont_set_name(  /* [in] */ EIF_OBJECT pname );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ifont_size(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_ifont_set_size(  /* [in] */ CURRENCY * psize );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_ifont_bold(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_ifont_set_bold(  /* [in] */ EIF_BOOLEAN pbold );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_ifont_italic(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_ifont_set_italic(  /* [in] */ EIF_BOOLEAN pitalic );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_ifont_underline(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_ifont_set_underline(  /* [in] */ EIF_BOOLEAN punderline );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_ifont_strikethrough(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_ifont_set_strikethrough(  /* [in] */ EIF_BOOLEAN pstrikethrough );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_ifont_weight(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_ifont_set_weight(  /* [in] */ EIF_INTEGER pweight );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_ifont_charset(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_ifont_set_charset(  /* [in] */ EIF_INTEGER pcharset );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_h_font(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_POINTER ccom_clone1(  );


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
	Last error code
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_last_error_code();


	/*-----------------------------------------------------------
	Last source of exception
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_source_of_exception();


	/*-----------------------------------------------------------
	Last error description
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_description();


	/*-----------------------------------------------------------
	Last error help file
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_help_file();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	Font * p_Font;


	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	FontEvents * p_FontEvents;


	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	IFont1 * p_IFont;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;


	/*-----------------------------------------------------------
	Exception information
	-----------------------------------------------------------*/
	EXCEPINFO * excepinfo;




};


#ifdef __cplusplus
}
#endif

#endif