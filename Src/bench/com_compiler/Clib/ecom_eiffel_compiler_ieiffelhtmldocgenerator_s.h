/*-----------------------------------------------------------
Eiffel Project HTML Documentation Generator. Eiffel language compiler library. Help file: 
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

#ifndef __ecom_eiffel_compiler_IEiffelHTMLDocEvents_FWD_DEFINED__
#define __ecom_eiffel_compiler_IEiffelHTMLDocEvents_FWD_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocEvents;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_eiffel_compiler_IEiffelHTMLDocGenerator_INTERFACE_DEFINED__
#define __ecom_eiffel_compiler_IEiffelHTMLDocGenerator_INTERFACE_DEFINED__
namespace ecom_eiffel_compiler
{
class IEiffelHTMLDocGenerator : public IUnknown
{
public:
	IEiffelHTMLDocGenerator () {};
	~IEiffelHTMLDocGenerator () {};

	/*-----------------------------------------------------------
	Is the project loaded?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_loaded(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is the project oorrupted?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_corrupted(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Is the project incompatible with the current version of the compiled?
	-----------------------------------------------------------*/
	virtual STDMETHODIMP is_incompatible(  /* [out, retval] */ VARIANT_BOOL * return_value ) = 0;


	/*-----------------------------------------------------------
	Add a callback interface.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_status_callback(  /* [in] */ ecom_eiffel_compiler::IEiffelHTMLDocEvents * new_callback ) = 0;


	/*-----------------------------------------------------------
	Remove a callback interface.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP remove_status_callback(  /* [in] */ ecom_eiffel_compiler::IEiffelHTMLDocEvents * old_callback ) = 0;


	/*-----------------------------------------------------------
	Exclude a cluster from being generated.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP add_excluded_cluster(  /* [in] */ BSTR cluster_full_name ) = 0;


	/*-----------------------------------------------------------
	Include a cluster to be generated.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP remove_excluded_cluster(  /* [in] */ BSTR cluster_full_name ) = 0;


	/*-----------------------------------------------------------
	Generate the HTML documents into path.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP generate(  /* [in] */ BSTR path ) = 0;



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