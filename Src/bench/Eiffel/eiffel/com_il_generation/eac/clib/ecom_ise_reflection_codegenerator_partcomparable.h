/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_CODEGENERATOR_PARTCOMPARABLE_H__
#define __ECOM_ISE_REFLECTION_CODEGENERATOR_PARTCOMPARABLE_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_ISE_Reflection_CodeGenerator_PartComparable_FWD_DEFINED__
#define __ecom_ISE_Reflection_CodeGenerator_PartComparable_FWD_DEFINED__
namespace ecom_ISE_Reflection_CodeGenerator
{
class PartComparable;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_ISE_Reflection_CodeGenerator_PartComparable_FWD_DEFINED__
#define __ecom_ISE_Reflection_CodeGenerator_PartComparable_FWD_DEFINED__
namespace ecom_ISE_Reflection_CodeGenerator
{
class PartComparable;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_ISE_Reflection_CodeGenerator_PartComparable_INTERFACE_DEFINED__
#define __ecom_ISE_Reflection_CodeGenerator_PartComparable_INTERFACE_DEFINED__
namespace ecom_ISE_Reflection_CodeGenerator
{
class PartComparable : public IDispatch
{
public:
	PartComparable () {};
	~PartComparable () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _infix_ge(  /* [in] */ ecom_ISE_Reflection_CodeGenerator::PartComparable * other, /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _infix_gt(  /* [in] */ ecom_ISE_Reflection_CodeGenerator::PartComparable * other, /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _infix_le(  /* [in] */ ecom_ISE_Reflection_CodeGenerator::PartComparable * other, /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _infix_lt(  /* [in] */ ecom_ISE_Reflection_CodeGenerator::PartComparable * other, /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;



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