/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IENUMSTATSTG_S_H__
#define __ECOM_CONTROL_LIBRARY_IENUMSTATSTG_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IEnumSTATSTG_FWD_DEFINED__
#define __ecom_control_library_IEnumSTATSTG_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumSTATSTG;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagSTATSTG_s.h"

#ifdef __cplusplus
extern "C" {
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
#ifndef __ecom_control_library_IEnumSTATSTG_INTERFACE_DEFINED__
#define __ecom_control_library_IEnumSTATSTG_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IEnumSTATSTG : public IUnknown
{
public:
	IEnumSTATSTG () {};
	~IEnumSTATSTG () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteNext(  /* [in] */ ULONG celt, /* [out] */ ecom_control_library::tagSTATSTG * rgelt, /* [out] */ ULONG * pcelt_fetched ) = 0;


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
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_control_library::IEnumSTATSTG * * ppenum ) = 0;



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