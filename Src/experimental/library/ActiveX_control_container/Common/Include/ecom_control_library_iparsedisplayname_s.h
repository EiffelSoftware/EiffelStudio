/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPARSEDISPLAYNAME_S_H__
#define __ECOM_CONTROL_LIBRARY_IPARSEDISPLAYNAME_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IParseDisplayName_FWD_DEFINED__
#define __ecom_control_library_IParseDisplayName_FWD_DEFINED__
namespace ecom_control_library
{
class IParseDisplayName;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IBindCtx_FWD_DEFINED__
#define __ecom_control_library_IBindCtx_FWD_DEFINED__
namespace ecom_control_library
{
class IBindCtx;
}
#endif



#ifndef __ecom_control_library_IMoniker_FWD_DEFINED__
#define __ecom_control_library_IMoniker_FWD_DEFINED__
namespace ecom_control_library
{
class IMoniker;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IParseDisplayName_INTERFACE_DEFINED__
#define __ecom_control_library_IParseDisplayName_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IParseDisplayName : public IUnknown
{
public:
	IParseDisplayName () {};
	~IParseDisplayName () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ParseDisplayName(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ LPWSTR psz_display_name, /* [out] */ ULONG * pch_eaten, /* [out] */ ecom_control_library::IMoniker * * ppmk_out ) = 0;



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