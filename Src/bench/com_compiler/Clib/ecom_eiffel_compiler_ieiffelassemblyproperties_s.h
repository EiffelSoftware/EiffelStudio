/*-----------------------------------------------------------
Eiffel Assembly Properties (for Ace file).  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELASSEMBLYPROPERTIES_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELASSEMBLYPROPERTIES_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelAssemblyProperties_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelAssemblyProperties_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelAssemblyProperties;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEiffelAssemblyProperties_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelAssemblyProperties_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelAssemblyProperties : public IDispatch
{
public:
	IEiffelAssemblyProperties () {};
	~IEiffelAssemblyProperties () {};

	/*-----------------------------------------------------------
	Assembly name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP assembly_name(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Assembly version.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP assembly_version(  /* [out, retval] */ BSTR * path ) = 0;


	/*-----------------------------------------------------------
	Assembly culture.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP assembly_culture(  /* [out, retval] */ BSTR * path ) = 0;


	/*-----------------------------------------------------------
	Assembly public key token
	-----------------------------------------------------------*/
	virtual STDMETHODIMP assembly_public_key(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Assembly path
	-----------------------------------------------------------*/
	virtual STDMETHODIMP assembly_path(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Assembly path
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_assembly_path(  /* [in] */ BSTR return_value ) = 0;


	/*-----------------------------------------------------------
	Is the assembly local
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_local(  /* [out, retval] */ VARIANT_BOOL * a_bool ) = 0;


	/*-----------------------------------------------------------
	Is the assembly local
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_signed(  /* [out, retval] */ VARIANT_BOOL * a_bool ) = 0;


	/*-----------------------------------------------------------
	Assembly identifier.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP assembly_identifier(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Prefix.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP assembly_prefix(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Prefix.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_assembly_prefix(  /* [in] */ BSTR return_value ) = 0;



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