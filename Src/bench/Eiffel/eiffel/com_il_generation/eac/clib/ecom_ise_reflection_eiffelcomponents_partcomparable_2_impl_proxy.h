/*-----------------------------------------------------------
Implemented `PartComparable_2' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS_PARTCOMPARABLE_2_IMPL_PROXY_H__
#define __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS_PARTCOMPARABLE_2_IMPL_PROXY_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_ISE_Reflection_EiffelComponents
{
class PartComparable_2_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_ISE_Reflection_EiffelComponents_PartComparable_2.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_ISE_Reflection_EiffelComponents
{
class PartComparable_2_impl_proxy
{
public:
	PartComparable_2_impl_proxy (IUnknown * a_pointer);
	virtual ~PartComparable_2_impl_proxy ();

	/*-----------------------------------------------------------
	Last error code
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_last_error_code();


	/*-----------------------------------------------------------
	Last source of exception
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_source_of_exception();


	/*-----------------------------------------------------------
	Last error description
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_description();


	/*-----------------------------------------------------------
	Last error help file
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_help_file();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_x_infix_ge(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::PartComparable_2 * other );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_x_infix_gt(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::PartComparable_2 * other );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_x_infix_le(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::PartComparable_2 * other );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_x_infix_lt(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::PartComparable_2 * other );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_ISE_Reflection_EiffelComponents::PartComparable_2 * p_PartComparable_2;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;


	/*-----------------------------------------------------------
	Exception information
	-----------------------------------------------------------*/
	EXCEPINFO * excepinfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE_c.h"


#endif