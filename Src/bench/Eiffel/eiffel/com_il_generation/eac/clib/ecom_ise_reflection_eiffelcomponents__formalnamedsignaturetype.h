/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS__FORMALNAMEDSIGNATURETYPE_H__
#define __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS__FORMALNAMEDSIGNATURETYPE_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_ISE_Reflection_EiffelComponents__FormalNamedSignatureType_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__FormalNamedSignatureType_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _FormalNamedSignatureType;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_ISE_Reflection_EiffelComponents__FormalNamedSignatureType_INTERFACE_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__FormalNamedSignatureType_INTERFACE_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _FormalNamedSignatureType : public IDispatch
{
public:
	_FormalNamedSignatureType () {};
	~_FormalNamedSignatureType () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ToString(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Equals(  /* [in] */ VARIANT obj, /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetHashCode(  /* [out, retval] */ LONG * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetType(  /* [out, retval] */ LONG * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InternalTypeFullExternalName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InternalTypeEiffelName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Make( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP TypeEiffelName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetTypeFullExternalName(  /* [in] */ BSTR a_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetTypeEiffelName(  /* [in] */ BSTR a_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP TypeFullExternalName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_InternalTypeFullExternalName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set__internal_InternalTypeFullExternalName(  /* [in] */ BSTR p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_InternalTypeEiffelName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set__internal_InternalTypeEiffelName(  /* [in] */ BSTR p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetGenericParameterIndex(  /* [in] */ LONG an_index ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenericParameterIndex(  /* [out, retval] */ LONG * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_GenericParameterIndex(  /* [out, retval] */ LONG * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set__internal_GenericParameterIndex(  /* [in] */ LONG p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InternalExternalName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InternalEiffelName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetEiffelName(  /* [in] */ BSTR a_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExternalName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EiffelName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetExternalName(  /* [in] */ BSTR a_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_InternalExternalName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set__internal_InternalExternalName(  /* [in] */ BSTR p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_InternalEiffelName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set__internal_InternalEiffelName(  /* [in] */ BSTR p_ret_val ) = 0;



protected:


private:


};
}
#endif
}
#endif

#ifdef __cplusplus
}
#endif

#endif