/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ASSEMBLYMANAGERINTERFACE_IASSEMBLYMANAGERINTERFACE_H__
#define __ECOM_ASSEMBLYMANAGERINTERFACE_IASSEMBLYMANAGERINTERFACE_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_AssemblyManagerInterface_IAssemblyManagerInterface_FWD_DEFINED__
#define __ecom_AssemblyManagerInterface_IAssemblyManagerInterface_FWD_DEFINED__
namespace ecom_AssemblyManagerInterface
{
class IAssemblyManagerInterface;
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
#ifndef __ecom_AssemblyManagerInterface_IAssemblyManagerInterface_INTERFACE_DEFINED__
#define __ecom_AssemblyManagerInterface_IAssemblyManagerInterface_INTERFACE_DEFINED__
namespace ecom_AssemblyManagerInterface
{
class IAssemblyManagerInterface : public IUnknown
{
public:
	IAssemblyManagerInterface () {};
	~IAssemblyManagerInterface () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ImportedAssemblies(  /* [out, retval] */ SAFEARRAY *  * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LastImportationSuccessful(  /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AssemblyLocation(  /* [in] */ BSTR name, /* [in] */ BSTR version, /* [in] */ BSTR culture, /* [in] */ BSTR public_key, /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LocalAssemblyDependencies(  /* [in] */ BSTR filename, /* [out, retval] */ SAFEARRAY *  * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AssemblyDependencies(  /* [in] */ BSTR name, /* [in] */ BSTR version, /* [in] */ BSTR culture, /* [in] */ BSTR public_key, /* [out, retval] */ SAFEARRAY *  * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsSigned(  /* [in] */ BSTR filename, /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CleanAssemblies( void ) = 0;



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