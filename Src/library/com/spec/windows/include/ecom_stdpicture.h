/*-----------------------------------------------------------
No description available.
-----------------------------------------------------------*/

#ifndef __ECOM_STDPICTURE_H__
#define __ECOM_STDPICTURE_H__
#ifdef __cplusplus
extern "C" {
#endif

class StdPicture;

#include "eif_com.h"

#include "eif_eiffel.h"

#include "windows.h"

#include "ecom_rt_globals.h"

#include "ecom_Picture.h"

#include "ecom_IPicture.h"

class StdPicture
{
public:
	StdPicture ();
	StdPicture (IUnknown * a_pointer);
	virtual ~StdPicture ();

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
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_ipicture_handle(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_ipicture_h_pal(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_ipicture_type(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_ipicture_width(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_ipicture_height(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_ipicture_render(  /* [in] */ EIF_INTEGER hdc,  /* [in] */ EIF_INTEGER x,  /* [in] */ EIF_INTEGER y,  /* [in] */ EIF_INTEGER cx,  /* [in] */ EIF_INTEGER cy,  /* [in] */ EIF_INTEGER x_src,  /* [in] */ EIF_INTEGER y_src,  /* [in] */ EIF_INTEGER cx_src,  /* [in] */ EIF_INTEGER cy_src,  /* [in] */ EIF_POINTER prc_wbounds );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_ipicture_set_h_pal(  /* [in] */ EIF_INTEGER phpal );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_cur_dc(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_select_picture(  /* [in] */ EIF_INTEGER hdc_in,  /* [out] */ EIF_OBJECT phdc_out,  /* [out] */ EIF_OBJECT phbmp_out );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_keep_original_format(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_keep_original_format(  /* [in] */ EIF_BOOLEAN pfkeep );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_picture_changed();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_save_as_file(  /* [in] */ EIF_POINTER pstm,  /* [in] */ EIF_BOOLEAN f_save_mem_copy,  /* [out] */ EIF_OBJECT pcb_size );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_attributes(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_hdc(  /* [in] */ EIF_INTEGER hdc );


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
	Picture * p_Picture;


	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	IPicture1 * p_IPicture;


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