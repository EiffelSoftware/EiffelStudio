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



#ifndef __ecom_eiffel_compiler_IEiffelSystemExternals_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelSystemExternals_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelSystemExternals;
}
#endif



#ifndef __ecom_eiffel_compiler_IEiffelSystemAssemblies_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelSystemAssemblies_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelSystemAssemblies;
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
	Externals.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP externals(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelSystemExternals * * return_value ) = 0;


	/*-----------------------------------------------------------
	Default namespace.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP default_namespace(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Default namespace.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_default_namespace(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Assemblies.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP assemblies(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelSystemAssemblies * * return_value ) = 0;


	/*-----------------------------------------------------------
	Project title.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP title(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Project title.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_title(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Project description.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP description(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Project description.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_description(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Project company.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP company(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Project company.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_company(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Product.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP product(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Product.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_product(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Project version.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP version(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Project version.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_version(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Project trademark.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP trademark(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Project trademark.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_trademark(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Project copyright.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP copyright(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Project copyright.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_copyright(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Asembly signing key file name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP key_file_name(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Asembly signing key file name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_key_file_name(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Asembly culture.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP culture(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Asembly culture.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_culture(  /* [in] */ BSTR return_value ) = 0;


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