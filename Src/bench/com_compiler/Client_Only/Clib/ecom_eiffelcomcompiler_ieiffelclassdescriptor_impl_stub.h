/*-----------------------------------------------------------
Implemented `IEiffelClassDescriptor' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCLASSDESCRIPTOR_IMPL_STUB_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCLASSDESCRIPTOR_IMPL_STUB_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelClassDescriptor_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "ecom_EiffelComCompiler_IEiffelClassDescriptor.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelClassDescriptor_impl_stub : public ecom_EiffelComCompiler::IEiffelClassDescriptor
{
public:
	IEiffelClassDescriptor_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelClassDescriptor_impl_stub ();

	/*-----------------------------------------------------------
	Class name.
	-----------------------------------------------------------*/
	STDMETHODIMP Name(  /* [out, retval] */ BSTR * pbstr_name );


	/*-----------------------------------------------------------
	Class description.
	-----------------------------------------------------------*/
	STDMETHODIMP Description(  /* [out, retval] */ BSTR * pbstr_description );


	/*-----------------------------------------------------------
	Class external name.
	-----------------------------------------------------------*/
	STDMETHODIMP ExternalName(  /* [out, retval] */ BSTR * pbstr_external_name );


	/*-----------------------------------------------------------
	Class Tool Tip.
	-----------------------------------------------------------*/
	STDMETHODIMP ToolTip(  /* [out, retval] */ BSTR * pbstr_tool_tip );


	/*-----------------------------------------------------------
	Is class in system?
	-----------------------------------------------------------*/
	STDMETHODIMP IsInSystem(  /* [out, retval] */ VARIANT_BOOL * pvb_in_system );


	/*-----------------------------------------------------------
	List of names of class features.
	-----------------------------------------------------------*/
	STDMETHODIMP FeatureNames(  /* [out, retval] */ SAFEARRAY *  * psabstr_feature_names );


	/*-----------------------------------------------------------
	List of class features.
	-----------------------------------------------------------*/
	STDMETHODIMP Features(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature );


	/*-----------------------------------------------------------
	Number of class features.
	-----------------------------------------------------------*/
	STDMETHODIMP FeatureCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	List of class features including ancestor features.
	-----------------------------------------------------------*/
	STDMETHODIMP FlatFeatures(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature );


	/*-----------------------------------------------------------
	Number of flat class features.
	-----------------------------------------------------------*/
	STDMETHODIMP FlatFeatureCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	List of class inherited features.
	-----------------------------------------------------------*/
	STDMETHODIMP InheritedFeatures(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature );


	/*-----------------------------------------------------------
	Number of inherited features.
	-----------------------------------------------------------*/
	STDMETHODIMP InheritedFeatureCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	List of class creation routines.
	-----------------------------------------------------------*/
	STDMETHODIMP CreationRoutines(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature );


	/*-----------------------------------------------------------
	Number of creation routines.
	-----------------------------------------------------------*/
	STDMETHODIMP CreationRoutineCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	List of class clients.
	-----------------------------------------------------------*/
	STDMETHODIMP Clients(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class );


	/*-----------------------------------------------------------
	Number of class clients.
	-----------------------------------------------------------*/
	STDMETHODIMP ClientCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	List of class suppliers.
	-----------------------------------------------------------*/
	STDMETHODIMP Suppliers(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class );


	/*-----------------------------------------------------------
	Number of class suppliers.
	-----------------------------------------------------------*/
	STDMETHODIMP SupplierCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	List of direct ancestors of class.
	-----------------------------------------------------------*/
	STDMETHODIMP Ancestors(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class );


	/*-----------------------------------------------------------
	Number of direct ancestors.
	-----------------------------------------------------------*/
	STDMETHODIMP AncestorCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	List of direct descendants of class.
	-----------------------------------------------------------*/
	STDMETHODIMP Descendants(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class );


	/*-----------------------------------------------------------
	Number of direct descendants.
	-----------------------------------------------------------*/
	STDMETHODIMP DescendantCount(  /* [out, retval] */ ULONG * pul_count );


	/*-----------------------------------------------------------
	Full path to file.
	-----------------------------------------------------------*/
	STDMETHODIMP ClassPath(  /* [out, retval] */ BSTR * pbstr_path );


	/*-----------------------------------------------------------
	Is class deferred?
	-----------------------------------------------------------*/
	STDMETHODIMP IsDeferred(  /* [out, retval] */ VARIANT_BOOL * pvb_defferred );


	/*-----------------------------------------------------------
	Is class external?
	-----------------------------------------------------------*/
	STDMETHODIMP IsExternal(  /* [out, retval] */ VARIANT_BOOL * pvb_external );


	/*-----------------------------------------------------------
	Is class generic?
	-----------------------------------------------------------*/
	STDMETHODIMP IsGeneric(  /* [out, retval] */ VARIANT_BOOL * pvb_generic );


	/*-----------------------------------------------------------
	Is class part of a library?
	-----------------------------------------------------------*/
	STDMETHODIMP IsLibrary(  /* [out, retval] */ VARIANT_BOOL * pvb_library );


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
#include "ecom_grt_globals_ISE_c.h"


#endif