/*-----------------------------------------------------------
Font Object
-----------------------------------------------------------*/

#ifndef __ECOM_IFONT_H__
#define __ECOM_IFONT_H__
#ifdef __cplusplus
extern "C" {
#endif

class IFont1;

#include "eif_com.h"

#include "eif_eiffel.h"

#include "windows.h"

#include "ecom_rt_globals.h"

class IFont1 : public IUnknown
{
public:
	IFont1 () {};
	~IFont1 () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_Name( BSTR * pname ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_set_Name( BSTR pname ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_Size( CURRENCY * psize ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_set_Size( CURRENCY psize ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_Bold( VARIANT_BOOL * pbold ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_set_Bold( VARIANT_BOOL pbold ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_Italic( VARIANT_BOOL * pitalic ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_set_Italic( VARIANT_BOOL pitalic ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_Underline( VARIANT_BOOL * punderline ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_set_Underline( VARIANT_BOOL punderline ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_Strikethrough( VARIANT_BOOL * pstrikethrough ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_set_Strikethrough( VARIANT_BOOL pstrikethrough ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_Weight( SHORT * pweight ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_set_Weight( SHORT pweight ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_Charset( SHORT * pcharset ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont_set_Charset( SHORT pcharset ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP hFont( OLE_HANDLE * phfont ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone1( IFont * * ppfont ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsEqual( IFont * pfont_other ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetRatio( LONG cy_logical,LONG cy_himetric ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddRefHfont( OLE_HANDLE a_h_font ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ReleaseHfont( OLE_HANDLE a_h_font ) = 0;



protected:


private:


};


#ifdef __cplusplus
}
#endif

#endif