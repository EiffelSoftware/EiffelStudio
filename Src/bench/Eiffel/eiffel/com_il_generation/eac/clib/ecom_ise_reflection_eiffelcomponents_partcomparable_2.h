/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS_PARTCOMPARABLE_2_H__
#define __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS_PARTCOMPARABLE_2_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_ISE_Reflection_EiffelComponents_PartComparable_2_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents_PartComparable_2_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class PartComparable_2;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_ISE_Reflection_EiffelComponents_PartComparable_2_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents_PartComparable_2_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class PartComparable_2;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_ISE_Reflection_EiffelComponents_PartComparable_2_INTERFACE_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents_PartComparable_2_INTERFACE_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class PartComparable_2 : public IDispatch
{
public:
	PartComparable_2 () {};
	~PartComparable_2 () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _infix_ge(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::PartComparable_2 * other, /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _infix_gt(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::PartComparable_2 * other, /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _infix_le(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::PartComparable_2 * other, /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _infix_lt(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::PartComparable_2 * other, /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;



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