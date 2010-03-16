/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDATAADVISEHOLDER_S_H__
#define __ECOM_CONTROL_LIBRARY_IDATAADVISEHOLDER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IDataAdviseHolder_FWD_DEFINED__
#define __ecom_control_library_IDataAdviseHolder_FWD_DEFINED__
namespace ecom_control_library
{
class IDataAdviseHolder;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagFORMATETC_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IDataObject_FWD_DEFINED__
#define __ecom_control_library_IDataObject_FWD_DEFINED__
namespace ecom_control_library
{
class IDataObject;
}
#endif



#ifndef __ecom_control_library_IAdviseSink_FWD_DEFINED__
#define __ecom_control_library_IAdviseSink_FWD_DEFINED__
namespace ecom_control_library
{
class IAdviseSink;
}
#endif



#ifndef __ecom_control_library_IEnumSTATDATA_FWD_DEFINED__
#define __ecom_control_library_IEnumSTATDATA_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumSTATDATA;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IDataAdviseHolder_INTERFACE_DEFINED__
#define __ecom_control_library_IDataAdviseHolder_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IDataAdviseHolder : public IUnknown
{
public:
	IDataAdviseHolder () {};
	~IDataAdviseHolder () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Advise(  /* [in] */ ecom_control_library::IDataObject * p_data_object, /* [in] */ ecom_control_library::tagFORMATETC * p_fetc, /* [in] */ ULONG advf, /* [in] */ ecom_control_library::IAdviseSink * p_advise, /* [out] */ ULONG * pdw_connection ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Unadvise(  /* [in] */ ULONG dw_connection ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumAdvise(  /* [out] */ ecom_control_library::IEnumSTATDATA * * ppenum_advise ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SendOnDataChange(  /* [in] */ ecom_control_library::IDataObject * p_data_object, /* [in] */ ULONG dw_reserved, /* [in] */ ULONG advf ) = 0;



protected:


private:


};
}
#endif
}
#endif

#ifdef __cplusplus
}
#endif

#endif