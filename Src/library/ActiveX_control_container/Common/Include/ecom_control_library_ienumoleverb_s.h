/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IENUMOLEVERB_S_H__
#define __ECOM_CONTROL_LIBRARY_IENUMOLEVERB_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IEnumOLEVERB_FWD_DEFINED__
#define __ecom_control_library_IEnumOLEVERB_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumOLEVERB;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagOLEVERB_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IEnumOLEVERB_FWD_DEFINED__
#define __ecom_control_library_IEnumOLEVERB_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumOLEVERB;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IEnumOLEVERB_INTERFACE_DEFINED__
#define __ecom_control_library_IEnumOLEVERB_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IEnumOLEVERB : public IUnknown
{
public:
	IEnumOLEVERB () {};
	~IEnumOLEVERB () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteNext(  /* [in] */ ULONG celt, /* [out] */ ecom_control_library::tagOLEVERB * rgelt, /* [out] */ ULONG * pcelt_fetched ) = 0;


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
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_control_library::IEnumOLEVERB * * ppenum ) = 0;



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