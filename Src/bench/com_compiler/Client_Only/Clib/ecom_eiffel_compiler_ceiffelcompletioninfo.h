/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_CEIFFELCOMPLETIONINFO_H__
#define __ECOM_EIFFEL_COMPILER_CEIFFELCOMPLETIONINFO_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class CEiffelCompletionInfo;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelCompletionInfo.h"

#include "ecom_eiffel_compiler_IEnumCompletionEntry.h"

#include "ecom_eiffel_compiler_IEiffelFeatureDescriptor.h"

#include "ecom_grt_globals_ISE_c.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class CEiffelCompletionInfo
{
public:
	CEiffelCompletionInfo (IUnknown * a_pointer);
	virtual ~CEiffelCompletionInfo ();

	/*-----------------------------------------------------------
	Add a local variable used for solving member completion list
	-----------------------------------------------------------*/
	void ccom_add_local(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_OBJECT type );


	/*-----------------------------------------------------------
	Add an argument used for solving member completion list
	-----------------------------------------------------------*/
	void ccom_add_argument(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_OBJECT type );


	/*-----------------------------------------------------------
	Features accessible from target.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_target_features(  /* [in] */ EIF_OBJECT target,  /* [in] */ EIF_OBJECT feature_name,  /* [in] */ EIF_OBJECT file_name );


	/*-----------------------------------------------------------
	Feature information
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_target_feature(  /* [in] */ EIF_OBJECT target,  /* [in] */ EIF_OBJECT feature_name,  /* [in] */ EIF_OBJECT file_name );


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
#include "ecom_grt_globals_ISE_c.h"


#endif