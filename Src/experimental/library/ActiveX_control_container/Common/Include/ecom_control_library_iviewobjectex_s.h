/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IVIEWOBJECTEX_S_H__
#define __ECOM_CONTROL_LIBRARY_IVIEWOBJECTEX_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IViewObjectEx_FWD_DEFINED__
#define __ecom_control_library_IViewObjectEx_FWD_DEFINED__
namespace ecom_control_library
{
class IViewObjectEx;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IViewObject2_s.h"

#include "ecom_control_library__RECTL_s.h"

#include "ecom_control_library_tagRECT_s.h"

#include "ecom_control_library_tagPOINT_s.h"

#include "ecom_control_library_tagDVTARGETDEVICE_s.h"

#include "ecom_aliases.h"

#include "ecom_control_library_tagExtentInfo_s.h"

#include "ecom_control_library_tagSIZEL_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IViewObjectEx_INTERFACE_DEFINED__
#define __ecom_control_library_IViewObjectEx_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IViewObjectEx : public ecom_control_library::IViewObject2
{
public:
	IViewObjectEx () {};
	~IViewObjectEx () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetRect(  /* [in] */ ULONG dw_aspect, /* [out] */ ecom_control_library::_RECTL * p_rect ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetViewStatus(  /* [out] */ ULONG * pdw_status ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP QueryHitPoint(  /* [in] */ ULONG dw_aspect, /* [in] */ ecom_control_library::tagRECT * p_rect_bounds, /* [in] */ ecom_control_library::tagPOINT ptl_loc, /* [in] */ LONG l_close_hint, /* [out] */ ULONG * p_hit_result ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP QueryHitRect(  /* [in] */ ULONG dw_aspect, /* [in] */ ecom_control_library::tagRECT * p_rect_bounds, /* [in] */ ecom_control_library::tagRECT * p_rect_loc, /* [in] */ LONG l_close_hint, /* [out] */ ULONG * p_hit_result ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetNaturalExtent(  /* [in] */ ULONG dw_aspect, /* [in] */ LONG lindex, /* [in] */ ecom_control_library::tagDVTARGETDEVICE * ptd, /* [in] */ ecom_control_library::wireHDC hic_target_dev, /* [in] */ ecom_control_library::tagExtentInfo * p_extent_info, /* [out] */ ecom_control_library::tagSIZEL * psizel ) = 0;



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