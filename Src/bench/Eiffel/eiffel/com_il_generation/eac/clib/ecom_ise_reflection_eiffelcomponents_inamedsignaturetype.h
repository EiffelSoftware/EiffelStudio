/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS_INAMEDSIGNATURETYPE_H__
#define __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS_INAMEDSIGNATURETYPE_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_ISE_Reflection_EiffelComponents_INamedSignatureType_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents_INamedSignatureType_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class INamedSignatureType;
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
#ifndef __ecom_ISE_Reflection_EiffelComponents_INamedSignatureType_INTERFACE_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents_INamedSignatureType_INTERFACE_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class INamedSignatureType : public IDispatch
{
public:
	INamedSignatureType () {};
	~INamedSignatureType () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP INamedSignatureType_SetEiffelName(  /* [in] */ BSTR a_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP INamedSignatureType_ExternalName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP INamedSignatureType_EiffelName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP INamedSignatureType_SetExternalName(  /* [in] */ BSTR a_name ) = 0;



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