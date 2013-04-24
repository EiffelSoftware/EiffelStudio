/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROVIDEMULTIPLECLASSINFO_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROVIDEMULTIPLECLASSINFO_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IProvideMultipleClassInfo_FWD_DEFINED__
#define __ecom_control_library_IProvideMultipleClassInfo_FWD_DEFINED__
namespace ecom_control_library
{
class IProvideMultipleClassInfo;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IProvideClassInfo2_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_ITypeInfo_2_FWD_DEFINED__
#define __ecom_control_library_ITypeInfo_2_FWD_DEFINED__
namespace ecom_control_library
{
class ITypeInfo_2;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IProvideMultipleClassInfo_INTERFACE_DEFINED__
#define __ecom_control_library_IProvideMultipleClassInfo_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IProvideMultipleClassInfo : public ecom_control_library::IProvideClassInfo2
{
public:
	IProvideMultipleClassInfo () {};
	~IProvideMultipleClassInfo () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetMultiTypeInfoCount(  /* [out] */ ULONG * pcti ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetInfoOfIndex(  /* [in] */ ULONG iti, /* [in] */ ULONG dw_flags, /* [out] */ ecom_control_library::ITypeInfo_2 * * ppti_co_class, /* [out] */ ULONG * pdw_tiflags, /* [out] */ ULONG * pcdispid_reserved, /* [out] */ GUID * piid_primary, /* [out] */ GUID * piid_source ) = 0;



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