/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ITYPECOMP_S_H__
#define __ECOM_CONTROL_LIBRARY_ITYPECOMP_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_ITypeComp_FWD_DEFINED__
#define __ecom_control_library_ITypeComp_FWD_DEFINED__
namespace ecom_control_library
{
class ITypeComp;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagFUNCDESC_s.h"

#include "ecom_control_library_tagVARDESC_s.h"

#include "ecom_aliases.h"

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



#ifndef __ecom_control_library_ITypeComp_FWD_DEFINED__
#define __ecom_control_library_ITypeComp_FWD_DEFINED__
namespace ecom_control_library
{
class ITypeComp;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_ITypeComp_INTERFACE_DEFINED__
#define __ecom_control_library_ITypeComp_INTERFACE_DEFINED__
namespace ecom_control_library
{
class ITypeComp : public IUnknown
{
public:
	ITypeComp () {};
	~ITypeComp () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteBind(  /* [in] */ LPWSTR sz_name, /* [in] */ ULONG l_hash_val, /* [in] */ USHORT w_flags, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo, /* [out] */ long * p_desc_kind, /* [out] */ ecom_control_library::tagFUNCDESC * * pp_func_desc, /* [out] */ ecom_control_library::tagVARDESC * * pp_var_desc, /* [out] */ ecom_control_library::ITypeComp * * pp_type_comp, /* [out] */ ecom_control_library::DWORD1 * p_dummy ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteBindType(  /* [in] */ LPWSTR sz_name, /* [in] */ ULONG l_hash_val, /* [out] */ ecom_control_library::ITypeInfo_2 * * pp_tinfo ) = 0;



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