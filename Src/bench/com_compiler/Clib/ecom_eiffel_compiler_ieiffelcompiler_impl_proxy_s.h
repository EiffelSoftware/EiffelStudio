/*-----------------------------------------------------------
Implemented `IEiffelCompiler' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILER_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPILER_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelCompiler_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelCompiler_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelCompiler_impl_proxy
{
public:
	IEiffelCompiler_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelCompiler_impl_proxy ();

	/*-----------------------------------------------------------
	Compile.
	-----------------------------------------------------------*/
	void ccom_compile();


	/*-----------------------------------------------------------
	Was last compilation successful?
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_successful(  );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompiler * p_IEiffelCompiler;


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