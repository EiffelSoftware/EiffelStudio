/*-----------------------------------------------------------
Implemented `IEiffelCompletionInfo' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_IEIFFELCOMPLETIONINFO_IMPL_PROXY_S_H__
#define __ECOM_EIFFEL_COMPILER_IEIFFELCOMPLETIONINFO_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class IEiffelCompletionInfo_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelCompletionInfo_s.h"

#include "ecom_eiffel_compiler_IEnumCompletionEntry_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class IEiffelCompletionInfo_impl_proxy
{
public:
	IEiffelCompletionInfo_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelCompletionInfo_impl_proxy ();

	/*-----------------------------------------------------------
	Features accessible from target.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_target_features(  /* [in] */ EIF_OBJECT target,  /* [in] */ EIF_OBJECT feature_name,  /* [in] */ EIF_OBJECT file_name );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompletionInfo * p_IEiffelCompletionInfo;


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