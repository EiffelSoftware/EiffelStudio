/*-----------------------------------------------------------
Implemented `IEiffelParameterDescriptor' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFELCOMCOMPILER_IEIFFELPARAMETERDESCRIPTOR_IMPL_PROXY_H__
#define __ECOM_EIFFELCOMCOMPILER_IEIFFELPARAMETERDESCRIPTOR_IMPL_PROXY_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_EiffelComCompiler
{
class IEiffelParameterDescriptor_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_EiffelComCompiler_IEiffelParameterDescriptor.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_EiffelComCompiler
{
class IEiffelParameterDescriptor_impl_proxy
{
public:
	IEiffelParameterDescriptor_impl_proxy (IUnknown * a_pointer);
	virtual ~IEiffelParameterDescriptor_impl_proxy ();

	/*-----------------------------------------------------------
	Parameter name
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_name(  );


	/*-----------------------------------------------------------
	Parameter display
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_display(  );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelParameterDescriptor * p_IEiffelParameterDescriptor;


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