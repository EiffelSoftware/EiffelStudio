/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROVIDECLASSINFO2_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROVIDECLASSINFO2_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IProvideClassInfo2_FWD_DEFINED__
#define __ecom_control_library_IProvideClassInfo2_FWD_DEFINED__
namespace ecom_control_library
{
class IProvideClassInfo2;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IProvideClassInfo_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IProvideClassInfo2_INTERFACE_DEFINED__
#define __ecom_control_library_IProvideClassInfo2_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IProvideClassInfo2 : public ecom_control_library::IProvideClassInfo
{
public:
	IProvideClassInfo2 () {};
	~IProvideClassInfo2 () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetGUID(  /* [in] */ ULONG dw_guid_kind, /* [out] */ GUID * p_guid ) = 0;



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