/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS__GENERICDERIVATION_H__
#define __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS__GENERICDERIVATION_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_ISE_Reflection_EiffelComponents__GenericDerivation_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__GenericDerivation_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _GenericDerivation;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_ISE_Reflection_EiffelComponents__SignatureType_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__SignatureType_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _SignatureType;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_ISE_Reflection_EiffelComponents__GenericDerivation_INTERFACE_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__GenericDerivation_INTERFACE_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _GenericDerivation : public IDispatch
{
public:
	_GenericDerivation () {};
	~_GenericDerivation () {};

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
	virtual STDMETHODIMP AddDerivationType(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_SignatureType * a_type ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenericTypes(  /* [out, retval] */ SAFEARRAY *  * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Make(  /* [in] */ LONG derivation_count ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_GenericTypes(  /* [out, retval] */ SAFEARRAY *  * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set__internal_GenericTypes(  /* [in] */ SAFEARRAY *  p_ret_val ) = 0;



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