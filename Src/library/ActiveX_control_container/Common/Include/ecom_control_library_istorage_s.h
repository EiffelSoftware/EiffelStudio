/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISTORAGE_S_H__
#define __ECOM_CONTROL_LIBRARY_ISTORAGE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IStorage_FWD_DEFINED__
#define __ecom_control_library_IStorage_FWD_DEFINED__
namespace ecom_control_library
{
class IStorage;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_aliases.h"

#include "ecom_control_library__FILETIME_s.h"

#include "ecom_control_library_tagSTATSTG_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IStream_FWD_DEFINED__
#define __ecom_control_library_IStream_FWD_DEFINED__
namespace ecom_control_library
{
class IStream;
}
#endif



#ifndef __ecom_control_library_IStorage_FWD_DEFINED__
#define __ecom_control_library_IStorage_FWD_DEFINED__
namespace ecom_control_library
{
class IStorage;
}
#endif



#ifndef __ecom_control_library_IEnumSTATSTG_FWD_DEFINED__
#define __ecom_control_library_IEnumSTATSTG_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumSTATSTG;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IStorage_INTERFACE_DEFINED__
#define __ecom_control_library_IStorage_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IStorage : public IUnknown
{
public:
	IStorage () {};
	~IStorage () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreateStream(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ULONG grf_mode, /* [in] */ ULONG reserved1, /* [in] */ ULONG reserved2, /* [out] */ ecom_control_library::IStream * * ppstm ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteOpenStream(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ULONG cb_reserved1, /* [in] */ UCHAR * reserved1, /* [in] */ ULONG grf_mode, /* [in] */ ULONG reserved2, /* [out] */ ecom_control_library::IStream * * ppstm ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CreateStorage(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ULONG grf_mode, /* [in] */ ULONG reserved1, /* [in] */ ULONG reserved2, /* [out] */ ecom_control_library::IStorage * * ppstg ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OpenStorage(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ecom_control_library::IStorage * pstg_priority, /* [in] */ ULONG grf_mode, /* [in] */ ecom_control_library::wireSNB snb_exclude, /* [in] */ ULONG reserved, /* [out] */ ecom_control_library::IStorage * * ppstg ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP CopyTo(  /* [in] */ ULONG ciid_exclude, /* [in] */ GUID * rgiid_exclude, /* [in] */ ecom_control_library::wireSNB snb_exclude, /* [in] */ ecom_control_library::IStorage * pstg_dest ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP MoveElementTo(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ecom_control_library::IStorage * pstg_dest, /* [in] */ LPWSTR pwcs_new_name, /* [in] */ ULONG grf_flags ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Commit(  /* [in] */ ULONG grf_commit_flags ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Revert( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteEnumElements(  /* [in] */ ULONG reserved1, /* [in] */ ULONG cb_reserved2, /* [in] */ UCHAR * reserved2, /* [in] */ ULONG reserved3, /* [out] */ ecom_control_library::IEnumSTATSTG * * ppenum ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DestroyElement(  /* [in] */ LPWSTR pwcs_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RenameElement(  /* [in] */ LPWSTR pwcs_old_name, /* [in] */ LPWSTR pwcs_new_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetElementTimes(  /* [in] */ LPWSTR pwcs_name, /* [in] */ ecom_control_library::_FILETIME * pctime, /* [in] */ ecom_control_library::_FILETIME * patime, /* [in] */ ecom_control_library::_FILETIME * pmtime ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetClass(  /* [in] */ GUID * clsid ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetStateBits(  /* [in] */ ULONG grf_state_bits, /* [in] */ ULONG grf_mask ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Stat(  /* [out] */ ecom_control_library::tagSTATSTG * pstatstg, /* [in] */ ULONG grf_stat_flag ) = 0;



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