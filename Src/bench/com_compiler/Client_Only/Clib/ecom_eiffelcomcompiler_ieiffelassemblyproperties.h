/*-----------------------------------------------------------
Eiffel Assembly Properties (for Ace file). Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELASSEMBLYPROPERTIES_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELASSEMBLYPROPERTIES_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelAssemblyProperties_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelAssemblyProperties_FWD_DEFINED__
namespace ecom_EiffelComCompiler
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
#ifndef __ecom_EiffelComCompiler_IEiffelAssemblyProperties_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelAssemblyProperties_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelAssemblyProperties : public IDispatch
{
public:
	IEiffelAssemblyProperties () {};
	~IEiffelAssemblyProperties () {};

	/*-----------------------------------------------------------
	Assembly name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Name(  /* [out, retval] */ BSTR * pbstr_name ) = 0;


	/*-----------------------------------------------------------
	Assembly version.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Version(  /* [out, retval] */ BSTR * pbstr_version ) = 0;


	/*-----------------------------------------------------------
	Assembly culture.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Culture(  /* [out, retval] */ BSTR * pbstr_version ) = 0;


	/*-----------------------------------------------------------
	Assembly public key token
	-----------------------------------------------------------*/
	virtual STDMETHODIMP PublicKeyToken(  /* [out, retval] */ BSTR * pvb_public_key_token ) = 0;


	/*-----------------------------------------------------------
	Is the assembly local
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsLocal(  /* [out, retval] */ VARIANT_BOOL * pvb_is_local ) = 0;


	/*-----------------------------------------------------------
	Assembly cluster name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ClusterName(  /* [out, retval] */ BSTR * pbstr_cluster_name ) = 0;


	/*-----------------------------------------------------------
	Prefix.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Prefix(  /* [out, retval] */ BSTR * pbstr_prefix ) = 0;


	/*-----------------------------------------------------------
	Prefix.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_Prefix(  /* [in] */ BSTR pbstr_prefix ) = 0;


	/*-----------------------------------------------------------
	Is assembly prefix read only.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsPrefixReadOnly(  /* [out, retval] */ VARIANT_BOOL * pvb_read_only ) = 0;



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