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
Font Object OLE Automation. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_IFONT_X20_H__
#define __ECOM_IFONT_X20_H__
#ifdef __cplusplus
extern "C" {
#endif

#ifndef __IFont20_FWD_DEFINED__
#define __IFont20_FWD_DEFINED__
class IFont20;
#endif

#ifdef __cplusplus
}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"


#ifdef __cplusplus
extern "C" {
#endif

#ifndef __IFont20_INTERFACE_DEFINED__
#define __IFont20_INTERFACE_DEFINED__
class IFont20 : public IUnknown
{
public:
	IFont20 () {};
	~IFont20 () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_Name(  /* [out, retval] */ BSTR * pname ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_set_Name(  /* [in] */ BSTR pname ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_Size(  /* [out, retval] */ CURRENCY * psize ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_set_Size(  /* [in] */ CURRENCY psize ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_Bold(  /* [out, retval] */ VARIANT_BOOL * pbold ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_set_Bold(  /* [in] */ VARIANT_BOOL pbold ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_Italic(  /* [out, retval] */ VARIANT_BOOL * pitalic ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_set_Italic(  /* [in] */ VARIANT_BOOL pitalic ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_Underline(  /* [out, retval] */ VARIANT_BOOL * punderline ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_set_Underline(  /* [in] */ VARIANT_BOOL punderline ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_Strikethrough(  /* [out, retval] */ VARIANT_BOOL * pstrikethrough ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_set_Strikethrough(  /* [in] */ VARIANT_BOOL pstrikethrough ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_Weight(  /* [out, retval] */ SHORT * pweight ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_set_Weight(  /* [in] */ SHORT pweight ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_Charset(  /* [out, retval] */ SHORT * pcharset ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IFont20_set_Charset(  /* [in] */ SHORT pcharset ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP hFont(  /* [out, retval] */ OLE_HANDLE * phfont ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone(  /* [out] */ IFont20 * * ppfont ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsEqual(  /* [in] */ IFont20 * pfont_other ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetRatio(  /* [in] */ LONG cy_logical, /* [in] */ LONG cy_himetric ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddRefHfont(  /* [in] */ OLE_HANDLE a_h_font ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ReleaseHfont(  /* [in] */ OLE_HANDLE a_h_font ) = 0;



protected:


private:


};
#endif


#ifdef __cplusplus
}
#endif
#endif
