/*-----------------------------------------------------------
Implemented `IEiffelCompletionEntry' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPLETIONENTRY_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPLETIONENTRY_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelCompletionEntry_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelCompletionEntry_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelCompletionEntry_impl_proxy
{
public:
	IEiffelCompletionEntry_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelCompletionEntry_impl_proxy ();

	/*-----------------------------------------------------------
	Feature name.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_name(  );


	/*-----------------------------------------------------------
	Feature signature.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_signature(  );


	/*-----------------------------------------------------------
	Is entry a feature?
	-----------------------------------------------------------*/
	void ccom_is_feature(  /* [out] */ EIF_OBJECT return_value );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompletionEntry * p_IEiffelCompletionEntry;


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