/*-----------------------------------------------------------
Implemented `IEnumEiffelClass' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IENUMEIFFELCLASS_IMPL_PROXY_H__
#define __ECOM_EIFFELCOMCOMPILER_IENUMEIFFELCLASS_IMPL_PROXY_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEnumEiffelClass_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEnumEiffelClass.h"

#include "ecom_EiffelComCompiler_IEiffelClassDescriptor.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEnumEiffelClass_impl_proxy
{
public:
	IEnumEiffelClass_impl_proxy (IUnknown * a_pointer);
	virtual ~IEnumEiffelClass_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_next(  /* [out] */ EIF_OBJECT pp_ieiffel_class_descriptor,  /* [out] */ EIF_OBJECT pul_fetched );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_skip(  /* [in] */ EIF_INTEGER ul_count );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_reset();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_clone1(  /* [out] */ EIF_OBJECT pp_ienum_eiffel_class );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_ith_item(  /* [in] */ EIF_INTEGER ul_index,  /* [out] */ EIF_OBJECT pp_ieiffel_class_descriptor );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_count(  );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumEiffelClass * p_IEnumEiffelClass;


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