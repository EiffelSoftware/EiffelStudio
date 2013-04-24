/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IENUMUNKNOWN_S_H__
#define __ECOM_CONTROL_LIBRARY_IENUMUNKNOWN_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IEnumUnknown_FWD_DEFINED__
#define __ecom_control_library_IEnumUnknown_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumUnknown;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IEnumUnknown_FWD_DEFINED__
#define __ecom_control_library_IEnumUnknown_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumUnknown;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IEnumUnknown_INTERFACE_DEFINED__
#define __ecom_control_library_IEnumUnknown_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IEnumUnknown : public IUnknown
{
public:
	IEnumUnknown () {};
	~IEnumUnknown () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Next(  /* [in] */ ULONG celt, /* [out] */ IUnknown * * rgelt, /* [out] */ ULONG * pcelt_fetched ) = 0;


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
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_control_library::IEnumUnknown * * ppenum ) = 0;



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
