/*-----------------------------------------------------------
Picture Object
-----------------------------------------------------------*/

#ifndef __ECOM_IPICTURE_H__
#define __ECOM_IPICTURE_H__
#ifdef __cplusplus
extern "C" {
#endif

class IPicture1;

#include "eif_com.h"

#include "eif_eiffel.h"

#include "windows.h"

#include "ecom_rt_globals.h"



class IPicture1 : public IUnknown
{
public:
	IPicture1 () {};
	~IPicture1 () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IPicture_Handle( OLE_HANDLE * phandle ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IPicture_hPal( OLE_HANDLE * phpal ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IPicture_Type( SHORT * ptype ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IPicture_Width( OLE_XSIZE_HIMETRIC * pwidth ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IPicture_Height( OLE_YSIZE_HIMETRIC * pheight ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IPicture_Render( INT hdc,LONG x,LONG y,LONG cx,LONG cy,OLE_XPOS_HIMETRIC x_src,OLE_YPOS_HIMETRIC y_src,OLE_XSIZE_HIMETRIC cx_src,OLE_YSIZE_HIMETRIC cy_src,void * prc_wbounds ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IPicture_set_hPal( OLE_HANDLE phpal ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CurDC( INT * phdc_out ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SelectPicture( INT hdc_in,INT * phdc_out,OLE_HANDLE * phbmp_out ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP KeepOriginalFormat( VARIANT_BOOL * pfkeep ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_KeepOriginalFormat( VARIANT_BOOL pfkeep ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PictureChanged(  ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SaveAsFile( void * pstm,VARIANT_BOOL f_save_mem_copy,LONG * pcb_size ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Attributes( LONG * pdw_attr ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetHdc( OLE_HANDLE hdc ) = 0;



protected:


private:


};


#ifdef __cplusplus
}
#endif

#endif