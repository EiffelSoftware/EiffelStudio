/*-----------------------------------------------------------
Implemented `IEiffelProjectProperties' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELPROJECTPROPERTIES_IMPL_STUB_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELPROJECTPROPERTIES_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelProjectProperties_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "ecom_eiffel_compiler_IEiffelProjectProperties_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelProjectProperties_impl_stub : public ecom_eiffel_compiler::IEiffelProjectProperties
{
public:
	IEiffelProjectProperties_impl_stub (EIF_OBJECT eif_obj);
	virtual ~IEiffelProjectProperties_impl_stub ();

	/*-----------------------------------------------------------
	System name.
	-----------------------------------------------------------*/
	STDMETHODIMP system_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	System name.
	-----------------------------------------------------------*/
	STDMETHODIMP set_system_name(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Root class name.
	-----------------------------------------------------------*/
	STDMETHODIMP root_class_name(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Root class name.
	-----------------------------------------------------------*/
	STDMETHODIMP set_root_class_name(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Creation routine name.
	-----------------------------------------------------------*/
	STDMETHODIMP creation_routine(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Creation routine name.
	-----------------------------------------------------------*/
	STDMETHODIMP set_creation_routine(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Compilation type.
	-----------------------------------------------------------*/
	STDMETHODIMP compilation_type(  /* [out, retval] */ long * return_value );


	/*-----------------------------------------------------------
	Compilation type.
	-----------------------------------------------------------*/
	STDMETHODIMP set_compilation_type(  /* [in] */ long return_value );


	/*-----------------------------------------------------------
	Is console application?
	-----------------------------------------------------------*/
	STDMETHODIMP console_application(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Is console application?
	-----------------------------------------------------------*/
	STDMETHODIMP set_console_application(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Should preconditions be evaluated?
	-----------------------------------------------------------*/
	STDMETHODIMP evaluate_require(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should preconditions be evaluated?
	-----------------------------------------------------------*/
	STDMETHODIMP set_evaluate_require(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Should postconditions be evaluated?
	-----------------------------------------------------------*/
	STDMETHODIMP evaluate_ensure(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should postconditions be evaluated?
	-----------------------------------------------------------*/
	STDMETHODIMP set_evaluate_ensure(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Should check assertions be evaluated?
	-----------------------------------------------------------*/
	STDMETHODIMP evaluate_check(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should check assertions be evaluated?
	-----------------------------------------------------------*/
	STDMETHODIMP set_evaluate_check(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Should loop assertions be evaluated?
	-----------------------------------------------------------*/
	STDMETHODIMP evaluate_loop(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should loop assertions be evaluated?
	-----------------------------------------------------------*/
	STDMETHODIMP set_evaluate_loop(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Should class invariants be evaluated?
	-----------------------------------------------------------*/
	STDMETHODIMP evaluate_invariant(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Should class invariants be evaluated?
	-----------------------------------------------------------*/
	STDMETHODIMP set_evaluate_invariant(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	Working directory.
	-----------------------------------------------------------*/
	STDMETHODIMP working_directory(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Working directory.
	-----------------------------------------------------------*/
	STDMETHODIMP set_working_directory(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Program arguments.
	-----------------------------------------------------------*/
	STDMETHODIMP arguments(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Program arguments.
	-----------------------------------------------------------*/
	STDMETHODIMP set_arguments(  /* [in] */ BSTR return_value );


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	STDMETHODIMP debug_info(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	STDMETHODIMP set_debug_info(  /* [in] */ VARIANT_BOOL return_value );


	/*-----------------------------------------------------------
	List of clusters in current project (list of IEiffelClusterProperties*).
	-----------------------------------------------------------*/
	STDMETHODIMP clusters(  /* [out, retval] */ VARIANT * return_value );


	/*-----------------------------------------------------------
	Add a cluster to the project.
	-----------------------------------------------------------*/
	STDMETHODIMP add_cluster(  /* [in] */ BSTR cluster_name, /* [in] */ BSTR parent_name, /* [in] */ BSTR cluster_path );


	/*-----------------------------------------------------------
	Remove a cluster from the project.
	-----------------------------------------------------------*/
	STDMETHODIMP remove_cluster(  /* [in] */ BSTR cluster_name );


	/*-----------------------------------------------------------
	Cluster properties.
	-----------------------------------------------------------*/
	STDMETHODIMP cluster_properties(  /* [in] */ BSTR cluster_name, /* [out, retval] */ ecom_eiffel_compiler::IEiffelClusterProperties * * return_value );


	/*-----------------------------------------------------------
	Imported assemblies.
	-----------------------------------------------------------*/
	STDMETHODIMP assemblies(  /* [out, retval] */ SAFEARRAY *  * return_value );


	/*-----------------------------------------------------------
	Add an assembly to the project.
	-----------------------------------------------------------*/
	STDMETHODIMP add_assembly(  /* [in] */ BSTR assembly_path );


	/*-----------------------------------------------------------
	Remove an assembly from the project.
	-----------------------------------------------------------*/
	STDMETHODIMP remove_assembly(  /* [in] */ BSTR assembly_path );


	/*-----------------------------------------------------------
	Update the project Ace file according to the current settings.
	-----------------------------------------------------------*/
	STDMETHODIMP update_project_ace_file(  /* [in] */ BSTR project_ace_file_name );


	/*-----------------------------------------------------------
	Synchronize the current settings with the project Ace file.
	-----------------------------------------------------------*/
	STDMETHODIMP synchronize_with_project_ace_file(  /* [in] */ BSTR project_ace_file_name );


	/*-----------------------------------------------------------
	Apply changes
	-----------------------------------------------------------*/
	STDMETHODIMP Apply( void );


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
#include "ecom_grt_globals_Eif_compiler.h"


#endif