/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IRUNNINGOBJECTTABLE_S_H__
#define __ECOM_CONTROL_LIBRARY_IRUNNINGOBJECTTABLE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IRunningObjectTable_FWD_DEFINED__
#define __ecom_control_library_IRunningObjectTable_FWD_DEFINED__
namespace ecom_control_library
{
class IRunningObjectTable;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library__FILETIME_s.h"

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



#ifndef __ecom_control_library_IEnumMoniker_FWD_DEFINED__
#define __ecom_control_library_IEnumMoniker_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumMoniker;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IRunningObjectTable_INTERFACE_DEFINED__
#define __ecom_control_library_IRunningObjectTable_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IRunningObjectTable : public IUnknown
{
public:
	IRunningObjectTable () {};
	~IRunningObjectTable () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Register(  /* [in] */ ULONG grf_flags, /* [in] */ IUnknown * punk_object, /* [in] */ ecom_control_library::IMoniker * pmk_object_name, /* [out] */ ULONG * pdw_register ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Revoke(  /* [in] */ ULONG dw_register ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsRunning(  /* [in] */ ecom_control_library::IMoniker * pmk_object_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetObject(  /* [in] */ ecom_control_library::IMoniker * pmk_object_name, /* [out] */ IUnknown * * ppunk_object ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP NoteChangeTime(  /* [in] */ ULONG dw_register, /* [in] */ ecom_control_library::_FILETIME * pfiletime ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetTimeOfLastChange(  /* [in] */ ecom_control_library::IMoniker * pmk_object_name, /* [out] */ ecom_control_library::_FILETIME * pfiletime ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumRunning(  /* [out] */ ecom_control_library::IEnumMoniker * * ppenum_moniker ) = 0;



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