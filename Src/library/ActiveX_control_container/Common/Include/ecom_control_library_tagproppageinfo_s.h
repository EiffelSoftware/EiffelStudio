/*-----------------------------------------------------------
"Automatically generated by the EiffelCOM Wizard."Added Record tagPROPPAGEINFO
	cb: ULONG
			-- No description available.
	pszTitle: LPWSTR
			-- No description available.
	size: typedef
			-- No description available.
	pszDocString: LPWSTR
			-- No description available.
	pszHelpFile: LPWSTR
			-- No description available.
	dwHelpContext: ULONG
			-- No description available.
	
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_TAGPROPPAGEINFO_S_H__
#define __ECOM_CONTROL_LIBRARY_TAGPROPPAGEINFO_S_H__
#ifdef __cplusplus
extern "C" {
#endif


namespace ecom_control_library
{
struct tagtagPROPPAGEINFO;
typedef struct ecom_control_library::tagtagPROPPAGEINFO tagPROPPAGEINFO;
}

#ifdef __cplusplus
}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagSIZE_s.h"

#ifdef __cplusplus
extern "C" {
#endif



namespace ecom_control_library
{
struct tagtagPROPPAGEINFO
{	ULONG cb;
	LPWSTR pszTitle;
	ecom_control_library::tagSIZE size;
	LPWSTR pszDocString;
	LPWSTR pszHelpFile;
	ULONG dwHelpContext;
};
}
#ifdef __cplusplus
}
#endif

#endif