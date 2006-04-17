/*
indexing
	description: "EiffelCOM: library of reusable components for COM."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*-----------------------------------------------------------
Implemented `Font21' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_FONT21_IMPL_PROXY_H__
#define __ECOM_FONT21_IMPL_PROXY_H__
#ifdef __cplusplus
extern "C" {
#endif

class Font21_impl_proxy;

#ifdef __cplusplus
}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_rt_globals.h"

#include "ecom_Font.h"

#ifdef __cplusplus
extern "C" {
#endif

class Font21_impl_proxy
{
public:
	Font21_impl_proxy (IUnknown * a_pointer);
	virtual ~Font21_impl_proxy ();

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
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	Font * p_Font21;


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
