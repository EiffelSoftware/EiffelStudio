/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPROVIDECLASSINFO_S_H__
#define __ECOM_CONTROL_LIBRARY_IPROVIDECLASSINFO_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IProvideClassInfo_FWD_DEFINED__
#define __ecom_control_library_IProvideClassInfo_FWD_DEFINED__
namespace ecom_control_library
{
class IProvideClassInfo;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

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
#ifndef __ecom_control_library_IProvideClassInfo_INTERFACE_DEFINED__
#define __ecom_control_library_IProvideClassInfo_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IProvideClassInfo : public IUnknown
{
public:
	IProvideClassInfo () {};
	~IProvideClassInfo () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetClassInfo(  /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_ti ) = 0;



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