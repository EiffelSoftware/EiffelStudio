/*-----------------------------------------------------------
Implemented `Picture' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_PICTURE23_IMPL_PROXY_H__
#define __ECOM_PICTURE23_IMPL_PROXY_H__
#ifdef __cplusplus
extern "C" {
#endif

class Picture23_impl_proxy;

#ifdef __cplusplus
}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_rt_globals.h"

#include "ecom_Picture23.h"


#ifdef __cplusplus
extern "C" {
#endif

class Picture23_impl_proxy
{
public:
	Picture23_impl_proxy (IUnknown * a_pointer);
	virtual ~Picture23_impl_proxy ();

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
	EIF_INTEGER ccom_handle();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_h_pal();


	/*-----------------------------------------------------------
	Set No description available.
	-----------------------------------------------------------*/
	void ccom_set_h_pal( EIF_INTEGER a_value );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_type();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_width();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_height();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_render(  /* [in] */ EIF_INTEGER hdc,  /* [in] */ EIF_INTEGER x,  /* [in] */ EIF_INTEGER y,  /* [in] */ EIF_INTEGER cx,  /* [in] */ EIF_INTEGER cy,  /* [in] */ EIF_INTEGER x_src,  /* [in] */ EIF_INTEGER y_src,  /* [in] */ EIF_INTEGER cx_src,  /* [in] */ EIF_INTEGER cy_src,  /* [in] */ EIF_POINTER prc_wbounds );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	Picture * p_Picture23;


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