/*-----------------------------------------------------------
Implemented `IDataAdviseHolder' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDATAADVISEHOLDER_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IDATAADVISEHOLDER_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IDataAdviseHolder_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IDataAdviseHolder_s.h"

#include "ecom_control_library_IDataObject_s.h"

#include "ecom_control_library_tagFORMATETC_s.h"

#include "ecom_control_library_IAdviseSink_s.h"

#include "ecom_control_library_IEnumSTATDATA_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IDataAdviseHolder_impl_proxy
{
public:
	IDataAdviseHolder_impl_proxy (IUnknown * a_pointer);
	virtual ~IDataAdviseHolder_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_advise(  /* [in] */ ecom_control_library::IDataObject * p_data_object,  /* [in] */ ecom_control_library::tagFORMATETC * p_fetc,  /* [in] */ EIF_INTEGER advf,  /* [in] */ ecom_control_library::IAdviseSink * p_advise,  /* [out] */ EIF_OBJECT pdw_connection );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_unadvise(  /* [in] */ EIF_INTEGER dw_connection );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_enum_advise(  /* [out] */ EIF_OBJECT ppenum_advise );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_send_on_data_change(  /* [in] */ ecom_control_library::IDataObject * p_data_object,  /* [in] */ EIF_INTEGER dw_reserved,  /* [in] */ EIF_INTEGER advf );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IDataAdviseHolder * p_IDataAdviseHolder;


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
#include "ecom_grt_globals_control_interfaces2.h"


#endif