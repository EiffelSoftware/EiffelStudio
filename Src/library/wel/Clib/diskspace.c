/*
indexing
	description: "Functions used by the class WEL_DISK_SPACE."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*****************************************************************************/
/* diskspace.c  [ associated WEL class: WEL_DISK_SPACE ]                     */
/*****************************************************************************/
/* Used to query available/total disk space on disk.                         */
/* Done			: local disk                                                 */
/* To be done	: remote disks using UNC                                     */
/*****************************************************************************/
#include <windows.h>
#include "eif_portable.h"

#ifndef EIF_IL_DLL
typedef void (* EIF_DISK_PROC) (
	EIF_REFERENCE,     /* WEL_DISK_SPACE Eiffel object */
#else
typedef void (__stdcall* EIF_DISK_PROC) (
#endif
	 EIF_INTEGER, /* free_space */
	 EIF_INTEGER, /* total_space */
	 EIF_INTEGER, /* free_space_in_bytes */
	 EIF_INTEGER  /* total_space_in_bytes */
	 );

/*---------------------------------------------------------------------------*/
/* Return the free disk space available for the current user in Mb.          */
/*   - If the user is Administrator or if the OS is Windows95/98             */
/*     this value is the same than returned by get_total_free_disk_space     */
/*   - If the user has a quota (Windows2000), the returned value is the      */
/*     maximum between its quota and the effective disk space                */
/*                                                                           */
/* Note: We do not protect the `CurrentObject' because Eiffel callback is    */
/*       the last call in the function body.                                 */
/* Note: `CurrentObject' is not used in .NET mode.                           */
/*---------------------------------------------------------------------------*/
EIF_BOOLEAN cwin_query_disk_space(
#ifndef EIF_IL_DLL
		EIF_REFERENCE CurrentObject,				// Object calling this function
#endif
		EIF_CHARACTER DriveLetter,					// Letter of the drive to query
		EIF_POINTER fnptr							// EiffelCallback
		)
	{
	TCHAR szRootPath[4];				// Path to root directory of requested drive.
	BOOL bRes;						// Success of operation
	unsigned long MBytes_FreeSpace; 
	unsigned long MBytes_TotalSpace;
	unsigned long Bytes_FreeSpace;
	unsigned long Bytes_TotalSpace;
	ULARGE_INTEGER FreeBytesAvailable;		// bytes available to caller
	ULARGE_INTEGER TotalNumberOfBytes;		// bytes on disk
	ULARGE_INTEGER TotalNumberOfFreeBytes;	// free bytes on disk
	unsigned long ResultHigh;
	unsigned long ResultLow;
	unsigned long Result;
	EIF_DISK_PROC SetAttributeFunction;				// Eiffel Callback function.

	SetAttributeFunction = (EIF_DISK_PROC) fnptr;

	szRootPath[0] = (char) DriveLetter;
	szRootPath[1] = ':';
	szRootPath[2] = '\\';
	szRootPath[3] = (char) 0;

	// We will use a call to GetDiskFreeSpaceEx since it is present
	bRes = GetDiskFreeSpaceEx(
				szRootPath, 
				&FreeBytesAvailable,
				&TotalNumberOfBytes,
				&TotalNumberOfFreeBytes
				);

	if (bRes == 0)
		return FALSE; // failure

	// Retrieve Free/Total disk space in Bytes up to 2 Gb
	Bytes_FreeSpace = FreeBytesAvailable.LowPart;
	Bytes_TotalSpace = TotalNumberOfBytes.LowPart;

	// Compute Free Disk Space in Mb	
	ResultHigh = (FreeBytesAvailable.HighPart << 12);
	ResultLow = (FreeBytesAvailable.LowPart >> 20);
	Result = ResultHigh | ResultLow;
	MBytes_FreeSpace = Result & 0x7FFF;	// mask to prevent returning a negative value

	// Compute Total Disk Space in Mb	
	ResultHigh = (TotalNumberOfBytes.HighPart << 12);
	ResultLow = (TotalNumberOfBytes.LowPart >> 20);
	Result = ResultHigh | ResultLow;
	MBytes_TotalSpace = Result & 0x7FFF;	// mask to prevent returning a negative value

	// Call the Eiffel routine to update the attribute of our object
	SetAttributeFunction(
#ifndef EIF_IL_DLL
		CurrentObject,
#endif
		MBytes_FreeSpace, MBytes_TotalSpace, Bytes_FreeSpace, Bytes_TotalSpace);

	// Success
	return TRUE;
	}
