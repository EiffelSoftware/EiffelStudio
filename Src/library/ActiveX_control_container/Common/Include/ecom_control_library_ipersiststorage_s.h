/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERSISTSTORAGE_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERSISTSTORAGE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPersistStorage_FWD_DEFINED__
#define __ecom_control_library_IPersistStorage_FWD_DEFINED__
namespace ecom_control_library
{
class IPersistStorage;
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

#ifndef __ecom_control_library_IStorage_FWD_DEFINED__
#define __ecom_control_library_IStorage_FWD_DEFINED__
namespace ecom_control_library
{
class IStorage;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IPersistStorage_INTERFACE_DEFINED__
#define __ecom_control_library_IPersistStorage_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPersistStorage : public ecom_control_library::IPersist
{
public:
	IPersistStorage () {};
	~IPersistStorage () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IsDirty( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP InitNew(  /* [in] */ ecom_control_library::IStorage * pstg ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Load(  /* [in] */ ecom_control_library::IStorage * pstg ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Save(  /* [in] */ ecom_control_library::IStorage * p_stg_save, /* [in] */ LONG f_same_as_load ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SaveCompleted(  /* [in] */ ecom_control_library::IStorage * p_stg_new ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP HandsOffStorage( void ) = 0;



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