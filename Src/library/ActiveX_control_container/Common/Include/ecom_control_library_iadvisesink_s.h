/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IADVISESINK_S_H__
#define __ECOM_CONTROL_LIBRARY_IADVISESINK_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IAdviseSink_FWD_DEFINED__
#define __ecom_control_library_IAdviseSink_FWD_DEFINED__
namespace ecom_control_library
{
class IAdviseSink;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagFORMATETC_s.h"

#include "ecom_aliases.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IMoniker_FWD_DEFINED__
#define __ecom_control_library_IMoniker_FWD_DEFINED__
namespace ecom_control_library
{
class IMoniker;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IAdviseSink_INTERFACE_DEFINED__
#define __ecom_control_library_IAdviseSink_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IAdviseSink : public IUnknown
{
public:
	IAdviseSink () {};
	~IAdviseSink () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteOnDataChange(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in] */ ecom_control_library::wireASYNC_STGMEDIUM * p_stgmed ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteOnViewChange(  /* [in] */ ULONG dw_aspect, /* [in] */ LONG lindex ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteOnRename(  /* [in] */ ecom_control_library::IMoniker * pmk ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteOnSave( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteOnClose( void ) = 0;



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