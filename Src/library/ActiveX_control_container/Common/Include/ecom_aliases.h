/*-----------------------------------------------------------
System's aliases
-----------------------------------------------------------*/

#ifndef __ECOM_ALIASES_H__
#define __ECOM_ALIASES_H__

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library__userCLIPFORMAT_s.h"

#include "ecom_control_library__userSTGMEDIUM_s.h"

#include "ecom_control_library__userFLAG_STGMEDIUM_s.h"

#include "ecom_control_library__userHGLOBAL_s.h"

#include "ecom_control_library_tagRemSNB_s.h"

#include "ecom_control_library__userHPALETTE_s.h"

#ifdef __cplusplus
extern "C" {
#endif



namespace ecom_control_library 
{
  typedef ecom_control_library::_userCLIPFORMAT * wireCLIPFORMAT;
}

namespace ecom_control_library 
{
  typedef void * wireHACCEL;
}

namespace ecom_control_library 
{
  typedef void * wireHWND;
}

namespace ecom_control_library 
{
  typedef void * wireHMENU;
}

namespace ecom_control_library 
{
  typedef ecom_control_library::_userHGLOBAL * wireHGLOBAL;
}

namespace ecom_control_library 
{
  typedef void * wireHDC;
}

namespace ecom_control_library 
{
  typedef ecom_control_library::tagRemSNB * wireSNB;
}

namespace ecom_control_library 
{
  typedef ULONG DWORD1;
}

namespace ecom_control_library 
{
  typedef ecom_control_library::_userHPALETTE * wireHPALETTE;
}
#ifdef __cplusplus
}
#endif

#endif
