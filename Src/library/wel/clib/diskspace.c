/*****************************************************************************/
/* diskspace.c  [ associated WEL class: WEL_DISK_SPACE ]                     */
/*****************************************************************************/
/* Used to query available/total disk space on disk.                         */
/* Done			: local disk                                                 */
/* To be done	: remote disks using UNC                                     */
/*****************************************************************************/
#include <windows.h>
#include "eif_portable.h"

/*---------------------------------------------------------------------------*/
/* Return the free disk space available for the current user in Mb.          */
/*   - If the user is Administrator or if the OS is Windows95/98             */
/*     this value is the same than returned by get_total_free_disk_space     */
/*   - If the user has a quota (Windows2000), the returned value is the      */
/*     maximum between its quota and the effective disk space                */
/*                                                                           */
/* Note: We do not protect the `CurrentObject' because Eiffel callback is    */
/*       the last call in the function body.                                 */
/*---------------------------------------------------------------------------*/
EIF_BOOLEAN cwin_query_disk_space(
		EIF_POINTER CurrentObject,					// Object calling this function
		EIF_CHARACTER DriveLetter,					// Letter of the drive to query
		void *fnptr									// EiffelCallback
		)
	{
	char szRootPath[3];				// Path to root directory of requested drive.
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

	void (*SetAttributeFunction)(				// Eiffel Callback function.
		EIF_POINTER	ObjectToUse,
		EIF_INTEGER MBytes_FreeSpace, 	
		EIF_INTEGER MBytes_TotalSpace,
		EIF_INTEGER Bytes_FreeSpace,
		EIF_INTEGER Bytes_TotalSpace
		);

	SetAttributeFunction = (void (*) (
		EIF_POINTER,
		EIF_INTEGER,
		EIF_INTEGER,
		EIF_INTEGER,
		EIF_INTEGER)) fnptr;

	szRootPath[0] = (char) DriveLetter;
	szRootPath[1] = ':';
	szRootPath[2] = '\\';

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
	SetAttributeFunction(CurrentObject, MBytes_FreeSpace, MBytes_TotalSpace, Bytes_FreeSpace, Bytes_TotalSpace);

	// Success
	return TRUE;
	}
