/*-----------------------------------------------------------
Implemented `IEiffelHTMLDocGenerator' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCGENERATOR_IMPL_PROXY_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELHTMLDOCGENERATOR_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelHTMLDocGenerator_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelHTMLDocGenerator_s.h"

#include "ecom_EiffelComCompiler_IEiffelHTMLDocEvents_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelHTMLDocGenerator_impl_proxy
{
public:
	IEiffelHTMLDocGenerator_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelHTMLDocGenerator_impl_proxy ();

	/*-----------------------------------------------------------
	Is the project loaded?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_loaded(  );


	/*-----------------------------------------------------------
	Is the project oorrupted?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_corrupted(  );


	/*-----------------------------------------------------------
	Is the project incompatible with the current version of the compiled?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_incompatible(  );


	/*-----------------------------------------------------------
	Add a callback interface.
	-----------------------------------------------------------*/
	void ccom_add_status_callback(  /* [in] */ ecom_EiffelComCompiler::IEiffelHTMLDocEvents * new_callback );


	/*-----------------------------------------------------------
	Remove a callback interface.
	-----------------------------------------------------------*/
	void ccom_remove_status_callback(  /* [in] */ ecom_EiffelComCompiler::IEiffelHTMLDocEvents * old_callback );


	/*-----------------------------------------------------------
	Exclude a cluster from being generated.
	-----------------------------------------------------------*/
	void ccom_add_excluded_cluster(  /* [in] */ EIF_OBJECT cluster_full_name );


	/*-----------------------------------------------------------
	Include a cluster to be generated.
	-----------------------------------------------------------*/
	void ccom_remove_excluded_cluster(  /* [in] */ EIF_OBJECT cluster_full_name );


	/*-----------------------------------------------------------
	Generate the HTML documents into path.
	-----------------------------------------------------------*/
	void ccom_generate(  /* [in] */ EIF_OBJECT path );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelHTMLDocGenerator * p_IEiffelHTMLDocGenerator;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif