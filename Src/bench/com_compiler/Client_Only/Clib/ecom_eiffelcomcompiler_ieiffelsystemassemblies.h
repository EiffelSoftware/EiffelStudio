/*-----------------------------------------------------------
Eiffel System Assemblies. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMASSEMBLIES_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMASSEMBLIES_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_EiffelComCompiler_IEiffelSystemAssemblies_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelSystemAssemblies_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelSystemAssemblies;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_EiffelComCompiler_IEiffelException_FWD_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelException_FWD_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelException;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_EiffelComCompiler_IEiffelSystemAssemblies_INTERFACE_DEFINED__
#define __ecom_EiffelComCompiler_IEiffelSystemAssemblies_INTERFACE_DEFINED__
namespace ecom_EiffelComCompiler
{
class IEiffelSystemAssemblies : public IDispatch
{
public:
	IEiffelSystemAssemblies () {};
	~IEiffelSystemAssemblies () {};

	/*-----------------------------------------------------------
	Wipe out current list of assemblies
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FlushAssemblies( void ) = 0;


	/*-----------------------------------------------------------
	Add an assembly to the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddAssembly(  /* [in] */ BSTR bstr_prefix, /* [in] */ BSTR bstr_cluster_name, /* [in] */ BSTR bstr_file_name, /* [in] */ VARIANT_BOOL vb_copy_locally ) = 0;


	/*-----------------------------------------------------------
	Last execption to occur
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LastException(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelException * * p_exception ) = 0;


	/*-----------------------------------------------------------
	Save changes.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Store( void ) = 0;



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