/*-----------------------------------------------------------
Implemented `IEiffelCompilerEvents' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILEREVENTS_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILEREVENTS_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelCompilerEvents_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelCompilerEvents_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelCompilerEvents_impl_proxy
{
public:
	IEiffelCompilerEvents_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelCompilerEvents_impl_proxy ();

	/*-----------------------------------------------------------
	Should compilation continue.
	-----------------------------------------------------------*/
	void ccom_should_continue(  /* [in, out] */ EIF_OBJECT a_boolean );


	/*-----------------------------------------------------------
	Output string.
	-----------------------------------------------------------*/
	void ccom_output_string(  /* [in] */ EIF_OBJECT a_string );


	/*-----------------------------------------------------------
	Last error.
	-----------------------------------------------------------*/
	void ccom_last_error(  /* [in] */ EIF_OBJECT error_message,  /* [in] */ EIF_OBJECT file_name,  /* [in] */ EIF_INTEGER line_number );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompilerEvents * p_IEiffelCompilerEvents;


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
#include "ecom_grt_globals_Eif_compiler.h"


#endif