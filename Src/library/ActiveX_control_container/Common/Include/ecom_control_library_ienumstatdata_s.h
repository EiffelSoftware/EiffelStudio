/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IENUMSTATDATA_S_H__
#define __ECOM_CONTROL_LIBRARY_IENUMSTATDATA_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IEnumSTATDATA_FWD_DEFINED__
#define __ecom_control_library_IEnumSTATDATA_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumSTATDATA;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagSTATDATA_s.h"

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



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IEnumSTATDATA_INTERFACE_DEFINED__
#define __ecom_control_library_IEnumSTATDATA_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IEnumSTATDATA : public IUnknown
{
public:
	IEnumSTATDATA () {};
	~IEnumSTATDATA () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteNext(  /* [in] */ ULONG celt, /* [out] */ ecom_control_library::tagSTATDATA * rgelt, /* [out] */ ULONG * pcelt_fetched ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Skip(  /* [in] */ ULONG celt ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Reset( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_control_library::IEnumSTATDATA * * ppenum ) = 0;



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