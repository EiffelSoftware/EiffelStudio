/*-----------------------------------------------------------
Implemented `IEiffelFeatureDescriptor' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELFEATUREDESCRIPTOR_IMPL_STUB_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELFEATUREDESCRIPTOR_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelFeatureDescriptor_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_EiffelComCompiler_IEiffelFeatureDescriptor_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelFeatureDescriptor_impl_stub : public ecom_EiffelComCompiler::IEiffelFeatureDescriptor
{
public:
	IEiffelFeatureDescriptor_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelFeatureDescriptor_impl_stub ();

	/*-----------------------------------------------------------
	Feature name.
	-----------------------------------------------------------*/
	STDMETHODIMP Name(  /* [out, retval] */ BSTR * pbstr_name );


	/*-----------------------------------------------------------
	Feature external name.
	-----------------------------------------------------------*/
	STDMETHODIMP ExternalName(  /* [out, retval] */ BSTR * pbstr_external_name );


	/*-----------------------------------------------------------
	Name of class where feature is written in.
	-----------------------------------------------------------*/
	STDMETHODIMP WrittenClass(  /* [out, retval] */ BSTR * pbstr_class );


	/*-----------------------------------------------------------
	Name of class where feature was evaluated in.
	-----------------------------------------------------------*/
	STDMETHODIMP EvaluatedClass(  /* [out, retval] */ BSTR * pbstr_class );


	/*-----------------------------------------------------------
	Feature signature.
	-----------------------------------------------------------*/
	STDMETHODIMP Signature(  /* [out, retval] */ BSTR * pbstr_signature );


	/*-----------------------------------------------------------
	Feature description.
	-----------------------------------------------------------*/
	STDMETHODIMP Description(  /* [out, retval] */ BSTR * pbstr_description );


	/*-----------------------------------------------------------
	Feature parameters.
	-----------------------------------------------------------*/
	STDMETHODIMP Parameters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumParameter * * pp_ienum_parameter );


	/*-----------------------------------------------------------
	Feature return type.
	-----------------------------------------------------------*/
	STDMETHODIMP ReturnType(  /* [out, retval] */ BSTR * pbstr_return_type );


	/*-----------------------------------------------------------
	Feature location, full path to file and line number
	-----------------------------------------------------------*/
	STDMETHODIMP FeatureLocation(  /* [out] */ BSTR * pbstr_path, /* [out] */ ULONG * pul_line );


	/*-----------------------------------------------------------
	List of all feature callers, including callers of ancestor and descendant versions.
	-----------------------------------------------------------*/
	STDMETHODIMP AllCallers(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature );


	/*-----------------------------------------------------------
	Number of all callers.
	-----------------------------------------------------------*/
	STDMETHODIMP AllCallersCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	List of feature callers.
	-----------------------------------------------------------*/
	STDMETHODIMP LocalCallers(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature );


	/*-----------------------------------------------------------
	Number of local callers.
	-----------------------------------------------------------*/
	STDMETHODIMP LocalCallersCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	List of feature callers, including callers of descendant versions.
	-----------------------------------------------------------*/
	STDMETHODIMP DescendantCallers(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature );


	/*-----------------------------------------------------------
	Number of descendant callers.
	-----------------------------------------------------------*/
	STDMETHODIMP DescendantCallersCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	List of implementers.
	-----------------------------------------------------------*/
	STDMETHODIMP Implementers(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature );


	/*-----------------------------------------------------------
	Number of feature implementers.
	-----------------------------------------------------------*/
	STDMETHODIMP ImplementersCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	List of ancestor versions.
	-----------------------------------------------------------*/
	STDMETHODIMP AncestorVersions(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature );


	/*-----------------------------------------------------------
	Number of ancestor versions.
	-----------------------------------------------------------*/
	STDMETHODIMP AncestorVersionsCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	List of descendant versions.
	-----------------------------------------------------------*/
	STDMETHODIMP DescendantVersions(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature );


	/*-----------------------------------------------------------
	Number of descendant versions.
	-----------------------------------------------------------*/
	STDMETHODIMP DescendantVersionsCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	Is feature exported to all classes?
	-----------------------------------------------------------*/
	STDMETHODIMP ExportedToAll(  /* [out, retval] */ VARIANT_BOOL * pvb_exported );


	/*-----------------------------------------------------------
	Is once feature?
	-----------------------------------------------------------*/
	STDMETHODIMP IsOnce(  /* [out, retval] */ VARIANT_BOOL * pvb_once );


	/*-----------------------------------------------------------
	Is external feature?
	-----------------------------------------------------------*/
	STDMETHODIMP IsExternal(  /* [out, retval] */ VARIANT_BOOL * pvb_external );


	/*-----------------------------------------------------------
	Is deferred feature?
	-----------------------------------------------------------*/
	STDMETHODIMP IsDeferred(  /* [out, retval] */ VARIANT_BOOL * pvb_deferred );


	/*-----------------------------------------------------------
	Is constant?
	-----------------------------------------------------------*/
	STDMETHODIMP IsConstant(  /* [out, retval] */ VARIANT_BOOL * pvb_constant );


	/*-----------------------------------------------------------
	is frozen feature?
	-----------------------------------------------------------*/
	STDMETHODIMP IsFrozen(  /* [out, retval] */ VARIANT_BOOL * pvb_froze );


	/*-----------------------------------------------------------
	Is infix?
	-----------------------------------------------------------*/
	STDMETHODIMP IsInfix(  /* [out, retval] */ VARIANT_BOOL * pvb_infix );


	/*-----------------------------------------------------------
	Is prefix?
	-----------------------------------------------------------*/
	STDMETHODIMP IsPrefix(  /* [out, retval] */ VARIANT_BOOL * pvb_prefix );


	/*-----------------------------------------------------------
	Is attribute?
	-----------------------------------------------------------*/
	STDMETHODIMP IsAttribute(  /* [out, retval] */ VARIANT_BOOL * pvb_attribute );


	/*-----------------------------------------------------------
	Is procedure?
	-----------------------------------------------------------*/
	STDMETHODIMP IsProcedure(  /* [out, retval] */ VARIANT_BOOL * pvb_procedure );


	/*-----------------------------------------------------------
	Is function?
	-----------------------------------------------------------*/
	STDMETHODIMP IsFunction(  /* [out, retval] */ VARIANT_BOOL * pvb_function );


	/*-----------------------------------------------------------
	Is unique?
	-----------------------------------------------------------*/
	STDMETHODIMP IsUnique(  /* [out, retval] */ VARIANT_BOOL * pvb_unique );


	/*-----------------------------------------------------------
	Is obsolete feature?
	-----------------------------------------------------------*/
	STDMETHODIMP IsObsolete(  /* [out, retval] */ VARIANT_BOOL * pvb_obsolete );


	/*-----------------------------------------------------------
	Does feature have precondition?
	-----------------------------------------------------------*/
	STDMETHODIMP HasPrecondition(  /* [out, retval] */ VARIANT_BOOL * pvb_precondition );


	/*-----------------------------------------------------------
	Does feature have postcondition?
	-----------------------------------------------------------*/
	STDMETHODIMP HasPostcondition(  /* [out, retval] */ VARIANT_BOOL * pvb_postcondition );


	/*-----------------------------------------------------------
	Get type info
	-----------------------------------------------------------*/
	STDMETHODIMP GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo );


	/*-----------------------------------------------------------
	Get type info count
	-----------------------------------------------------------*/
	STDMETHODIMP GetTypeInfoCount( unsigned int * pctinfo );


	/*-----------------------------------------------------------
	IDs of function names 'rgszNames'
	-----------------------------------------------------------*/
	STDMETHODIMP GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid );


	/*-----------------------------------------------------------
	Invoke function.
	-----------------------------------------------------------*/
	STDMETHODIMP Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr );


	/*-----------------------------------------------------------
	Decrement reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) Release();


	/*-----------------------------------------------------------
	Increment reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) AddRef();


	/*-----------------------------------------------------------
	Query Interface
	-----------------------------------------------------------*/
	STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );



protected:


private:
	/*-----------------------------------------------------------
	Reference counter
	-----------------------------------------------------------*/
	LONG ref_count;


	/*-----------------------------------------------------------
	Corresponding Eiffel object
	-----------------------------------------------------------*/
	EIF_OBJECT eiffel_object;


	/*-----------------------------------------------------------
	Eiffel type id
	-----------------------------------------------------------*/
	EIF_TYPE_ID type_id;


	/*-----------------------------------------------------------
	Type information
	-----------------------------------------------------------*/
	ITypeInfo * pTypeInfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif