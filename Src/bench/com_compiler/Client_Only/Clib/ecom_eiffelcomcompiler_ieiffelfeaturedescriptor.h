/*-----------------------------------------------------------
Eiffel Feature Descriptor. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELFEATUREDESCRIPTOR_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELFEATUREDESCRIPTOR_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelFeatureDescriptor_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelFeatureDescriptor_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelFeatureDescriptor;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEnumParameter_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumParameter_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumParameter;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEnumFeature_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumFeature_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumFeature;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelFeatureDescriptor_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelFeatureDescriptor_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelFeatureDescriptor : public IDispatch
{
public:
	IEiffelFeatureDescriptor () {};
	~IEiffelFeatureDescriptor () {};

	/*-----------------------------------------------------------
	Feature name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Name(  /* [out, retval] */ BSTR * pbstr_name ) = 0;


	/*-----------------------------------------------------------
	Feature external name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExternalName(  /* [out, retval] */ BSTR * pbstr_external_name ) = 0;


	/*-----------------------------------------------------------
	Name of class where feature is written in.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP WrittenClass(  /* [out, retval] */ BSTR * pbstr_class ) = 0;


	/*-----------------------------------------------------------
	Name of class where feature was evaluated in.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EvaluatedClass(  /* [out, retval] */ BSTR * pbstr_class ) = 0;


	/*-----------------------------------------------------------
	Feature signature.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Signature(  /* [out, retval] */ BSTR * pbstr_signature ) = 0;


	/*-----------------------------------------------------------
	Feature description.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Description(  /* [out, retval] */ BSTR * pbstr_description ) = 0;


	/*-----------------------------------------------------------
	Feature parameters.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Parameters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumParameter * * pp_ienum_parameter ) = 0;


	/*-----------------------------------------------------------
	Feature return type.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ReturnType(  /* [out, retval] */ BSTR * pbstr_return_type ) = 0;


	/*-----------------------------------------------------------
	Feature location, full path to file and line number
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FeatureLocation(  /* [out] */ BSTR * pbstr_path, /* [out] */ ULONG * pul_line ) = 0;


	/*-----------------------------------------------------------
	List of all feature callers, including callers of ancestor and descendant versions.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AllCallers(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature ) = 0;


	/*-----------------------------------------------------------
	Number of all callers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AllCallersCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	List of feature callers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LocalCallers(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature ) = 0;


	/*-----------------------------------------------------------
	Number of local callers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LocalCallersCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	List of feature callers, including callers of descendant versions.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DescendantCallers(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature ) = 0;


	/*-----------------------------------------------------------
	Number of descendant callers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DescendantCallersCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	List of implementers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Implementers(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature ) = 0;


	/*-----------------------------------------------------------
	Number of feature implementers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ImplementersCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	List of ancestor versions.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AncestorVersions(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature ) = 0;


	/*-----------------------------------------------------------
	Number of ancestor versions.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AncestorVersionsCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	List of descendant versions.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DescendantVersions(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature ) = 0;


	/*-----------------------------------------------------------
	Number of descendant versions.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DescendantVersionsCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	Is feature exported to all classes?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExportedToAll(  /* [out, retval] */ VARIANT_BOOL * pvb_exported ) = 0;


	/*-----------------------------------------------------------
	Is once feature?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsOnce(  /* [out, retval] */ VARIANT_BOOL * pvb_once ) = 0;


	/*-----------------------------------------------------------
	Is external feature?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsExternal(  /* [out, retval] */ VARIANT_BOOL * pvb_external ) = 0;


	/*-----------------------------------------------------------
	Is deferred feature?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsDeferred(  /* [out, retval] */ VARIANT_BOOL * pvb_deferred ) = 0;


	/*-----------------------------------------------------------
	Is constant?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsConstant(  /* [out, retval] */ VARIANT_BOOL * pvb_constant ) = 0;


	/*-----------------------------------------------------------
	is frozen feature?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsFrozen(  /* [out, retval] */ VARIANT_BOOL * pvb_froze ) = 0;


	/*-----------------------------------------------------------
	Is infix?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsInfix(  /* [out, retval] */ VARIANT_BOOL * pvb_infix ) = 0;


	/*-----------------------------------------------------------
	Is prefix?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsPrefix(  /* [out, retval] */ VARIANT_BOOL * pvb_prefix ) = 0;


	/*-----------------------------------------------------------
	Is attribute?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsAttribute(  /* [out, retval] */ VARIANT_BOOL * pvb_attribute ) = 0;


	/*-----------------------------------------------------------
	Is procedure?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsProcedure(  /* [out, retval] */ VARIANT_BOOL * pvb_procedure ) = 0;


	/*-----------------------------------------------------------
	Is function?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsFunction(  /* [out, retval] */ VARIANT_BOOL * pvb_function ) = 0;


	/*-----------------------------------------------------------
	Is unique?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsUnique(  /* [out, retval] */ VARIANT_BOOL * pvb_unique ) = 0;


	/*-----------------------------------------------------------
	Is obsolete feature?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsObsolete(  /* [out, retval] */ VARIANT_BOOL * pvb_obsolete ) = 0;


	/*-----------------------------------------------------------
	Does feature have precondition?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HasPrecondition(  /* [out, retval] */ VARIANT_BOOL * pvb_precondition ) = 0;


	/*-----------------------------------------------------------
	Does feature have postcondition?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HasPostcondition(  /* [out, retval] */ VARIANT_BOOL * pvb_postcondition ) = 0;



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