/*-----------------------------------------------------------
Eiffel Project Properties.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELPROJECTPROPERTIES_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELPROJECTPROPERTIES_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelProjectProperties_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelProjectProperties_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelProjectProperties;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_eiffel_compiler_IEiffelSystemClusters_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelSystemClusters_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelSystemClusters;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEiffelProjectProperties_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelProjectProperties_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelProjectProperties : public IDispatch
{
public:
	IEiffelProjectProperties () {};
	~IEiffelProjectProperties () {};

	/*-----------------------------------------------------------
	System name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP system_name(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	System name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_system_name(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Root class name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP root_class_name(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Root class name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_root_class_name(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Creation routine name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP creation_routine(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Creation routine name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_creation_routine(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Compilation type.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP compilation_type(  /* [out, retval] */ long * return_value ) = 0;


	/*-----------------------------------------------------------
	Compilation type.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_compilation_type(  /* [in] */ long return_value ) = 0;


	/*-----------------------------------------------------------
	Is console application?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP console_application(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is console application?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_console_application(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Should preconditions be evaluated?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_require(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should preconditions be evaluated?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_evaluate_require(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Should postconditions be evaluated?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_ensure(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should postconditions be evaluated?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_evaluate_ensure(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Should check assertions be evaluated?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_check(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should check assertions be evaluated?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_evaluate_check(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Should loop assertions be evaluated?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_loop(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should loop assertions be evaluated?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_evaluate_loop(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Should class invariants be evaluated?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP evaluate_invariant(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Should class invariants be evaluated?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_evaluate_invariant(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP debug_info(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Generate debug info?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_debug_info(  /* [in] */ VARIANT_BOOL return_value ) = 0;


	/*-----------------------------------------------------------
	Project Clusters.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP clusters(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelSystemClusters * * return_value ) = 0;


	/*-----------------------------------------------------------
	Imported assemblies.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP assemblies(  /* [out, retval] */ SAFEARRAY *  * return_value ) = 0;


	/*-----------------------------------------------------------
	Add an assembly to the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_assembly(  /* [in] */ BSTR assembly_path ) = 0;


	/*-----------------------------------------------------------
	Remove an assembly from the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP remove_assembly(  /* [in] */ BSTR assembly_path ) = 0;


	/*-----------------------------------------------------------
	Update the project Ace file according to the current settings.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP update_project_ace_file(  /* [in] */ BSTR project_ace_file_name ) = 0;


	/*-----------------------------------------------------------
	Synchronize the current settings with the project Ace file.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP synchronize_with_project_ace_file(  /* [in] */ BSTR project_ace_file_name ) = 0;


	/*-----------------------------------------------------------
	Apply changes
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Apply( void ) = 0;



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