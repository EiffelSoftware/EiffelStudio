/*-----------------------------------------------------------
Eiffel System Assemblies. Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMASSEMBLIES_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELSYSTEMASSEMBLIES_S_H__
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
	virtual STDMETHODIMP wipe_out( void ) = 0;


	/*-----------------------------------------------------------
	Add an assembly to the project.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_assembly(  /* [in] */ BSTR a_prefix, /* [in] */ BSTR a_cluster_name, /* [in] */ BSTR a_path, /* [in] */ VARIANT_BOOL a_copy ) = 0;


	/*-----------------------------------------------------------
	Last execption to occur
	-----------------------------------------------------------*/
	virtual STDMETHODIMP last_exception(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelException * * p_exception ) = 0;


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