/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS_ISIGNATURETYPE_H__
#define __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS_ISIGNATURETYPE_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_ISE_Reflection_EiffelComponents_ISignatureType_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents_ISignatureType_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class ISignatureType;
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
#ifndef __ecom_ISE_Reflection_EiffelComponents_ISignatureType_INTERFACE_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents_ISignatureType_INTERFACE_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class ISignatureType : public IDispatch
{
public:
	ISignatureType () {};
	~ISignatureType () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ISignatureType_TypeEiffelName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ISignatureType_SetTypeFullExternalName(  /* [in] */ BSTR a_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ISignatureType_SetTypeEiffelName(  /* [in] */ BSTR a_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ISignatureType_TypeFullExternalName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;



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