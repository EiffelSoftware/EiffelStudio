/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IMONIKER_S_H__
#define __ECOM_CONTROL_LIBRARY_IMONIKER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IMoniker_FWD_DEFINED__
#define __ecom_control_library_IMoniker_FWD_DEFINED__
namespace ecom_control_library
{
class IMoniker;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPersistStream_s.h"

#include "ecom_control_library__FILETIME_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IBindCtx_FWD_DEFINED__
#define __ecom_control_library_IBindCtx_FWD_DEFINED__
namespace ecom_control_library
{
class IBindCtx;
}
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
#ifndef __ecom_control_library_IMoniker_INTERFACE_DEFINED__
#define __ecom_control_library_IMoniker_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IMoniker : public ecom_control_library::IPersistStream
{
public:
	IMoniker () {};
	~IMoniker () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteBindToObject(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [in] */ GUID * riid_result, /* [out] */ IUnknown * * ppv_result ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteBindToStorage(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [in] */ GUID * riid, /* [out] */ IUnknown * * ppv_obj ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Reduce(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ULONG dw_reduce_how_far, /* [in, out] */ ecom_control_library::IMoniker * * ppmk_to_left, /* [out] */ ecom_control_library::IMoniker * * ppmk_reduced ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ComposeWith(  /* [in] */ ecom_control_library::IMoniker * pmk_right, /* [in] */ LONG f_only_if_not_generic, /* [out] */ ecom_control_library::IMoniker * * ppmk_composite ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Enum(  /* [in] */ LONG f_forward, /* [out] */ ecom_control_library::IEnumMoniker * * ppenum_moniker ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsEqual(  /* [in] */ ecom_control_library::IMoniker * pmk_other_moniker ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Hash(  /* [out] */ ULONG * pdw_hash ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsRunning(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [in] */ ecom_control_library::IMoniker * pmk_newly_running ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetTimeOfLastChange(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [out] */ ecom_control_library::_FILETIME * pfiletime ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Inverse(  /* [out] */ ecom_control_library::IMoniker * * ppmk ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CommonPrefixWith(  /* [in] */ ecom_control_library::IMoniker * pmk_other, /* [out] */ ecom_control_library::IMoniker * * ppmk_prefix ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RelativePathTo(  /* [in] */ ecom_control_library::IMoniker * pmk_other, /* [out] */ ecom_control_library::IMoniker * * ppmk_rel_path ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetDisplayName(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [out] */ LPWSTR * ppsz_display_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ParseDisplayName(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IMoniker * pmk_to_left, /* [in] */ LPWSTR psz_display_name, /* [out] */ ULONG * pch_eaten, /* [out] */ ecom_control_library::IMoniker * * ppmk_out ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsSystemMoniker(  /* [out] */ ULONG * pdw_mksys ) = 0;



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