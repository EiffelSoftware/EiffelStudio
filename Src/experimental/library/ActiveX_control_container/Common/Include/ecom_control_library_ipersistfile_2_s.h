/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERSISTFILE_2_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERSISTFILE_2_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPersistFile_2_FWD_DEFINED__
#define __ecom_control_library_IPersistFile_2_FWD_DEFINED__
namespace ecom_control_library
{
class IPersistFile_2;
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
#ifndef __ecom_control_library_IPersistFile_2_INTERFACE_DEFINED__
#define __ecom_control_library_IPersistFile_2_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPersistFile_2 : public ecom_control_library::IPersist
{
public:
	IPersistFile_2 () {};
	~IPersistFile_2 () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsDirty( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Load(  /* [in] */ LPWSTR psz_file_name, /* [in] */ ULONG dw_mode ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Save(  /* [in] */ LPWSTR psz_file_name, /* [in] */ LONG f_remember ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SaveCompleted(  /* [in] */ LPWSTR psz_file_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetCurFile(  /* [out] */ LPWSTR * ppsz_file_name ) = 0;



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