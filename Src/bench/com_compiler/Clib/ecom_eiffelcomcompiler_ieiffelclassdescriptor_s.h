/*-----------------------------------------------------------
Eiffel Class Descriptor. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCLASSDESCRIPTOR_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCLASSDESCRIPTOR_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelClassDescriptor_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelClassDescriptor_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelClassDescriptor;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEnumFeature_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumFeature_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumFeature;
}
#endif



#ifndef __ecom_EiffelComCompiler_IEnumEiffelClass_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEnumEiffelClass_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEnumEiffelClass;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelClassDescriptor_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelClassDescriptor_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelClassDescriptor : public IDispatch
{
public:
	IEiffelClassDescriptor () {};
	~IEiffelClassDescriptor () {};

	/*-----------------------------------------------------------
	Class name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Name(  /* [out, retval] */ BSTR * pbstr_name ) = 0;


	/*-----------------------------------------------------------
	Class description.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Description(  /* [out, retval] */ BSTR * pbstr_description ) = 0;


	/*-----------------------------------------------------------
	Class external name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExternalName(  /* [out, retval] */ BSTR * pbstr_external_name ) = 0;


	/*-----------------------------------------------------------
	Class Tool Tip.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ToolTip(  /* [out, retval] */ BSTR * pbstr_tool_tip ) = 0;


	/*-----------------------------------------------------------
	Is class in system?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsInSystem(  /* [out, retval] */ VARIANT_BOOL * pvb_in_system ) = 0;


	/*-----------------------------------------------------------
	List of names of class features.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FeatureNames(  /* [out, retval] */ SAFEARRAY *  * psabstr_feature_names ) = 0;


	/*-----------------------------------------------------------
	List of class features.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Features(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature ) = 0;


	/*-----------------------------------------------------------
	Number of class features.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FeatureCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	List of class features including ancestor features.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FlatFeatures(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature ) = 0;


	/*-----------------------------------------------------------
	Number of flat class features.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FlatFeatureCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	List of class inherited features.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InheritedFeatures(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature ) = 0;


	/*-----------------------------------------------------------
	Number of inherited features.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InheritedFeatureCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	List of class creation routines.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreationRoutines(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature ) = 0;


	/*-----------------------------------------------------------
	Number of creation routines.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreationRoutineCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	List of class clients.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clients(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class ) = 0;


	/*-----------------------------------------------------------
	Number of class clients.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClientCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	List of class suppliers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Suppliers(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class ) = 0;


	/*-----------------------------------------------------------
	Number of class suppliers.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SupplierCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	List of direct ancestors of class.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Ancestors(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class ) = 0;


	/*-----------------------------------------------------------
	Number of direct ancestors.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AncestorCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	List of direct descendants of class.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Descendants(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class ) = 0;


	/*-----------------------------------------------------------
	Number of direct descendants.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DescendantCount(  /* [out, retval] */ ULONG * pul_count ) = 0;


	/*-----------------------------------------------------------
	Full path to file.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClassPath(  /* [out, retval] */ BSTR * pbstr_path ) = 0;


	/*-----------------------------------------------------------
	Is class deferred?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsDeferred(  /* [out, retval] */ VARIANT_BOOL * pvb_defferred ) = 0;


	/*-----------------------------------------------------------
	Is class external?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsExternal(  /* [out, retval] */ VARIANT_BOOL * pvb_external ) = 0;


	/*-----------------------------------------------------------
	Is class generic?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsGeneric(  /* [out, retval] */ VARIANT_BOOL * pvb_generic ) = 0;


	/*-----------------------------------------------------------
	Is class part of a library?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsLibrary(  /* [out, retval] */ VARIANT_BOOL * pvb_library ) = 0;



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