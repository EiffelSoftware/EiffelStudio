/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERSISTMEMORY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERSISTMEMORY_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPersistMemory_FWD_DEFINED__
#define __ecom_control_library_IPersistMemory_FWD_DEFINED__
namespace ecom_control_library
{
class IPersistMemory;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPersist_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IPersistMemory_INTERFACE_DEFINED__
#define __ecom_control_library_IPersistMemory_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPersistMemory : public ecom_control_library::IPersist
{
public:
	IPersistMemory () {};
	~IPersistMemory () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsDirty( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteLoad(  /* [in] */ UCHAR * p_mem, /* [in] */ ULONG cb_size ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteSave(  /* [out] */ UCHAR * p_mem, /* [in] */ LONG f_clear_dirty, /* [in] */ ULONG cb_size ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetSizeMax(  /* [out] */ ULONG * pcb_size ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InitNew( void ) = 0;



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