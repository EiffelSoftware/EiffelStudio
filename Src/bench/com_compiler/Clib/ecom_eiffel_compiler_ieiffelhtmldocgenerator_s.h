/*-----------------------------------------------------------
Eiffel Project HTML Document generator.  Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELHTMLDOCGENERATOR_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELHTMLDOCGENERATOR_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_eiffel_compiler_IEiffelHTMLDocGenerator_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelHTMLDocGenerator_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocGenerator;
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
#ifndef __ecom_eiffel_compiler_IEiffelHTMLDocGenerator_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelHTMLDocGenerator_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocGenerator : public IDispatch
{
public:
	IEiffelHTMLDocGenerator () {};
	~IEiffelHTMLDocGenerator () {};

	/*-----------------------------------------------------------
	Add excluded cluster
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_excluded_cluster(  /* [in] */ BSTR cluster_to_exclude ) = 0;


	/*-----------------------------------------------------------
	Remove excluded cluster
	-----------------------------------------------------------*/
	virtual STDMETHODIMP remove_excluded_cluster(  /* [in] */ BSTR excluded_cluster ) = 0;


	/*-----------------------------------------------------------
	is the project incompatible?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_incompatible(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	is the project corrupted?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_corrupted(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	the last error
	-----------------------------------------------------------*/
	virtual STDMETHODIMP last_error(  /* [out, retval] */ BSTR * return_value ) = 0;


	/*-----------------------------------------------------------
	Load a compiled project
	-----------------------------------------------------------*/
	virtual STDMETHODIMP load_project(  /* [in] */ BSTR project_dir, /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Generate the documentation.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP generate(  /* [in] */ BSTR generation_dir ) = 0;



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