/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECACHE_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECACHE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleCache_FWD_DEFINED__
#define __ecom_control_library_IOleCache_FWD_DEFINED__
namespace ecom_control_library
{
class IOleCache;
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

#ifndef __ecom_control_library_IEnumSTATDATA_FWD_DEFINED__
#define __ecom_control_library_IEnumSTATDATA_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumSTATDATA;
}
#endif



#ifndef __ecom_control_library_IDataObject_FWD_DEFINED__
#define __ecom_control_library_IDataObject_FWD_DEFINED__
namespace ecom_control_library
{
class IDataObject;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleCache_INTERFACE_DEFINED__
#define __ecom_control_library_IOleCache_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleCache : public IUnknown
{
public:
	IOleCache () {};
	~IOleCache () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Cache(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in] */ ULONG advf, /* [out] */ ULONG * pdw_connection ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Uncache(  /* [in] */ ULONG dw_connection ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumCache(  /* [out] */ ecom_control_library::IEnumSTATDATA * * ppenum_statdata ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InitCache(  /* [in] */ ecom_control_library::IDataObject * p_data_object ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetData(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in] */ ecom_control_library::wireSTGMEDIUM * pmedium, /* [in] */ LONG f_release ) = 0;



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