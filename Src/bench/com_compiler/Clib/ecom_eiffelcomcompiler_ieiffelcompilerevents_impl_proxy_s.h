/*-----------------------------------------------------------
Implemented `IEiffelCompilerEvents' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELCOMPILEREVENTS_IMPL_PROXY_S_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELCOMPILEREVENTS_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelCompilerEvents_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelCompilerEvents_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelCompilerEvents_impl_proxy
{
public:
	IEiffelCompilerEvents_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelCompilerEvents_impl_proxy ();

	/*-----------------------------------------------------------
	Beginning compilation.
	-----------------------------------------------------------*/
	void ccom_begin_compile();


	/*-----------------------------------------------------------
	Start of new degree phase in compilation.
	-----------------------------------------------------------*/
	void ccom_begin_degree(  /* [in] */ EIF_INTEGER ul_degree );


	/*-----------------------------------------------------------
	Finished compilation.
	-----------------------------------------------------------*/
	void ccom_end_compile(  /* [in] */ EIF_BOOLEAN vb_sucessful );


	/*-----------------------------------------------------------
	Should compilation continue.
	-----------------------------------------------------------*/
	void ccom_should_continue(  /* [in, out] */ EIF_OBJECT pvb_continue );


	/*-----------------------------------------------------------
	Output string.
	-----------------------------------------------------------*/
	void ccom_output_string(  /* [in] */ EIF_OBJECT bstr_output );


	/*-----------------------------------------------------------
	Last error.
	-----------------------------------------------------------*/
	void ccom_output_error(  /* [in] */ EIF_OBJECT bstr_full_error,  /* [in] */ EIF_OBJECT bstr_short_error,  /* [in] */ EIF_OBJECT bstr_code,  /* [in] */ EIF_OBJECT bstr_file_name,  /* [in] */ EIF_INTEGER ul_line,  /* [in] */ EIF_INTEGER ul_col );


	/*-----------------------------------------------------------
	Last warning.
	-----------------------------------------------------------*/
	void ccom_output_warning(  /* [in] */ EIF_OBJECT bstr_full_warning,  /* [in] */ EIF_OBJECT bstr_short_warning,  /* [in] */ EIF_OBJECT bstr_code,  /* [in] */ EIF_OBJECT bstr_file_name,  /* [in] */ EIF_INTEGER ul_line,  /* [in] */ EIF_INTEGER ul_col );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelCompilerEvents * p_IEiffelCompilerEvents;


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