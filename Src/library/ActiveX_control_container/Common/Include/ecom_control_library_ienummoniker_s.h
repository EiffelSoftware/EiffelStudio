/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IENUMMONIKER_S_H__
#define __ECOM_CONTROL_LIBRARY_IENUMMONIKER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IEnumMoniker_FWD_DEFINED__
#define __ecom_control_library_IEnumMoniker_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumMoniker;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

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
#ifndef __ecom_control_library_IEnumMoniker_INTERFACE_DEFINED__
#define __ecom_control_library_IEnumMoniker_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IEnumMoniker : public IUnknown
{
public:
	IEnumMoniker () {};
	~IEnumMoniker () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [in] */ ULONG celt, /* [out] */ ecom_control_library::IMoniker * * rgelt, /* [out] */ ULONG * pcelt_fetched ) = 0;


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
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_control_library::IEnumMoniker * * ppenum ) = 0;



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
