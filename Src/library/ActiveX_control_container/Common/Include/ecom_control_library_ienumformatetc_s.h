/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IENUMFORMATETC_S_H__
#define __ECOM_CONTROL_LIBRARY_IENUMFORMATETC_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IEnumFORMATETC_FWD_DEFINED__
#define __ecom_control_library_IEnumFORMATETC_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumFORMATETC;
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

#ifndef __ecom_control_library_IEnumFORMATETC_FWD_DEFINED__
#define __ecom_control_library_IEnumFORMATETC_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumFORMATETC;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IEnumFORMATETC_INTERFACE_DEFINED__
#define __ecom_control_library_IEnumFORMATETC_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IEnumFORMATETC : public IUnknown
{
public:
	IEnumFORMATETC () {};
	~IEnumFORMATETC () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteNext(  /* [in] */ ULONG celt, /* [out] */ ecom_control_library::tagFORMATETC * rgelt, /* [out] */ ULONG * pcelt_fetched ) = 0;


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
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_control_library::IEnumFORMATETC * * ppenum ) = 0;



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