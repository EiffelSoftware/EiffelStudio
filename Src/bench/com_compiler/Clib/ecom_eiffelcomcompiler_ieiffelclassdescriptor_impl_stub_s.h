/*-----------------------------------------------------------
Implemented `IEiffelClassDescriptor' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCLASSDESCRIPTOR_IMPL_STUB_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCLASSDESCRIPTOR_IMPL_STUB_S_H__
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

#include "server_registration.h"

#include "ecom_EiffelComCompiler_IEiffelClassDescriptor_s.h"

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
	STDMETHODIMP name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Class description.
	-----------------------------------------------------------*/
	STDMETHODIMP description(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Class external name.
	-----------------------------------------------------------*/
	STDMETHODIMP external_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Class Tool Tip.
	-----------------------------------------------------------*/
	STDMETHODIMP tool_tip(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Is class in system?
	-----------------------------------------------------------*/
	STDMETHODIMP is_in_system(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	List of names of class features.
	-----------------------------------------------------------*/
	STDMETHODIMP feature_names(  /* [out, retval] */ SAFEARRAY *  * names );


	/*-----------------------------------------------------------
	List of class features.
	-----------------------------------------------------------*/
	STDMETHODIMP features(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * some_features );


	/*-----------------------------------------------------------
	Number of class features.
	-----------------------------------------------------------*/
	STDMETHODIMP feature_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of class features including ancestor features.
	-----------------------------------------------------------*/
	STDMETHODIMP flat_features(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * some_features );


	/*-----------------------------------------------------------
	Number of flat class features.
	-----------------------------------------------------------*/
	STDMETHODIMP flat_feature_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of class inherited features.
	-----------------------------------------------------------*/
	STDMETHODIMP inherited_features(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * some_features );


	/*-----------------------------------------------------------
	Number of inherited features.
	-----------------------------------------------------------*/
	STDMETHODIMP inherited_feature_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of class creation routines.
	-----------------------------------------------------------*/
	STDMETHODIMP creation_routines(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * some_features );


	/*-----------------------------------------------------------
	Number of creation routines.
	-----------------------------------------------------------*/
	STDMETHODIMP creation_routine_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of class clients.
	-----------------------------------------------------------*/
	STDMETHODIMP clients(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * some_clients );


	/*-----------------------------------------------------------
	Number of class clients.
	-----------------------------------------------------------*/
	STDMETHODIMP client_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of class suppliers.
	-----------------------------------------------------------*/
	STDMETHODIMP suppliers(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * some_suppliers );


	/*-----------------------------------------------------------
	Number of class suppliers.
	-----------------------------------------------------------*/
	STDMETHODIMP supplier_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of direct ancestors of class.
	-----------------------------------------------------------*/
	STDMETHODIMP ancestors(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * some_ancestors );


	/*-----------------------------------------------------------
	Number of direct ancestors.
	-----------------------------------------------------------*/
	STDMETHODIMP ancestor_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	List of direct descendants of class.
	-----------------------------------------------------------*/
	STDMETHODIMP descendants(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * some_descendants );


	/*-----------------------------------------------------------
	Number of direct descendants.
	-----------------------------------------------------------*/
	STDMETHODIMP descendant_count(  /* [out, retval] */ ULONG * return_value );


	/*-----------------------------------------------------------
	Full path to file.
	-----------------------------------------------------------*/
	STDMETHODIMP class_path(  /* [out, retval] */ BSTR * path );


	/*-----------------------------------------------------------
	Is class deferred?
	-----------------------------------------------------------*/
	STDMETHODIMP is_deferred(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is class external?
	-----------------------------------------------------------*/
	STDMETHODIMP is_external(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is class generic?
	-----------------------------------------------------------*/
	STDMETHODIMP is_generic(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is class part of a library?
	-----------------------------------------------------------*/
	STDMETHODIMP is_library(  /* [out, retval] */ VARIANT_BOOL * return_value );


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