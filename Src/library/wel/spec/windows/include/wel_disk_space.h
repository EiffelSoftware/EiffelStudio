/*****************************************************************************/
/* wel_disk_space.h  [ associated WEL class: WEL_DISK_SPACE ]                */
/*                   [ associated C file: diskspace.c ]                      */
/*****************************************************************************/
/* Used to query available/total disk space on disk.                         */
/* Done			: local disk                                                 */
/* To be done	: remote disks using UNC                                     */
/*****************************************************************************/

#ifndef _WEL_DISK_SPACE_H_
#define _WEL_DISK_SPACE_H_

#include "Windows.h"
#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

/*---------------------------------------------------------------------------*/
/* Return the free disk space available for the current user in Mb.          */
/*   - If the user is Administrator or if the OS is Windows95/98             */
/*     this value is the same than returned by get_total_free_disk_space     */
/*   - If the user has a quota (Windows2000), the returned value is the      */
/*     maximum between its quota and the effective disk space                */
/*---------------------------------------------------------------------------*/
EIF_BOOLEAN cwin_query_disk_space(
#ifndef EIF_IL_DLL
		EIF_REFERENCE CurrentObject,	// Object calling this function
#endif
		EIF_CHARACTER DriveLetter,		// Letter of the drive to query
		EIF_POINTER fnptr 				// Eiffel Callback function.
		);

#ifdef __cplusplus
}
#endif

#endif
