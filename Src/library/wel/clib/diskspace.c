/*****************************************************************************/
/* diskspace.c  [ associated WEL class: WEL_DISK_SPACE ]                     */
/*****************************************************************************/
/* Used to query available/total disk space on disk.                         */
/* Done			: local disk                                                 */
/* To be done	: remote disks using UNC                                     */
/*****************************************************************************/
#include "Windows.h"
#include "eif_portable.h"

/*---------------------------------------------------------------------------*/
/* Return the free disk space available for the current user in Mb.          */
/*   - If the user is Administrator or if the OS is Windows95/98             */
/*     this value is the same than returned by get_total_free_disk_space     */
/*   - If the user has a quota (Windows2000), the returned value is the      */
/*     maximum between its quota and the effective disk space                */
/*                                                                           */
/* Note: We do not protect the
/*---------------------------------------------------------------------------*/
EIF_BOOLEAN cwin_query_disk_space(
		EIF_POINTER CurrentObject,					// Object calling this function
		EIF_CHARACTER DriveLetter,					// Letter of the drive to query
		void (*SetAttributeFunction)(				// Eiffel Callback function.
					EIF_POINTER	ObjectToUse,
					EIF_INTEGER MBytes_FreeSpace, 	
					EIF_INTEGER MBytes_TotalSpace,
					EIF_INTEGER Bytes_FreeSpace,
					EIF_INTEGER Bytes_TotalSpace
					)
		)
	{
	FARPROC pGetDiskFreeSpaceEx;	// Test whether this function is present on system (i.e. WinNT4, Win95 OSR2, Win2K, Win98)
	char szRootPath[3];				// Path to root directory of requested drive.
	BOOL bRes;						// Success of operation
	unsigned long MBytes_FreeSpace; 
	unsigned long MBytes_TotalSpace;
	unsigned long Bytes_FreeSpace;
	unsigned long Bytes_TotalSpace;

	szRootPath[0] = (char)DriveLetter;
	szRootPath[1] = ':';
	szRootPath[2] = '\\';


	// Retrieve Address of the Extended function
	pGetDiskFreeSpaceEx = GetProcAddress(GetModuleHandle("kernel32.dll"), "GetDiskFreeSpaceExA");

	if (pGetDiskFreeSpaceEx != NULL)
		{
		ULARGE_INTEGER FreeBytesAvailable;		// bytes available to caller
		ULARGE_INTEGER TotalNumberOfBytes;		// bytes on disk
		ULARGE_INTEGER TotalNumberOfFreeBytes;	// free bytes on disk
		unsigned long ResultHigh;
		unsigned long ResultLow;
		unsigned long Result;

		// We will use a call to GetDiskFreeSpaceEx since it is present
		bRes = pGetDiskFreeSpaceEx(
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
		}	
	else
		{
		DWORD SectorsPerCluster;     // sectors per cluster
		DWORD BytesPerSector;        // bytes per sector
		DWORD NumberOfFreeClusters;  // free clusters
		DWORD TotalNumberOfClusters; // total clusters
		double dResult;				// Temporary double value used to compute the result

		// We will use a call to GetDiskFreeSpace since GetDiskFreeSpaceEx is not present
		bRes = GetDiskFreeSpace(
					szRootPath,
					&SectorsPerCluster,
					&BytesPerSector,
					&NumberOfFreeClusters,
					&TotalNumberOfClusters
					);

		if (bRes == 0)
			return FALSE; // failure

		// Retrieve Free/Total disk space in Bytes (if result if >2Gb, the result should be used)
		dResult = (double)NumberOfFreeClusters * (double)BytesPerSector * (double)SectorsPerCluster;
		Bytes_FreeSpace = (unsigned long)dResult;

		dResult = (double)TotalNumberOfClusters * (double)BytesPerSector * (double)SectorsPerCluster;
		Bytes_TotalSpace = (unsigned long)dResult;

		// Compute Free Disk Space in Mb	
		dResult = (double)NumberOfFreeClusters * (double)BytesPerSector * (double)SectorsPerCluster / 1048576.00f;
		MBytes_FreeSpace = (unsigned long)dResult;

		// Compute Total Disk Space in Mb	
		dResult = (double)TotalNumberOfClusters * (double)BytesPerSector * (double)SectorsPerCluster / 1048576.00f;
		MBytes_TotalSpace = (unsigned long)dResult;
		}

	// Call the Eiffel routine to update the attribute of our object
	SetAttributeFunction(CurrentObject, MBytes_FreeSpace, MBytes_TotalSpace, Bytes_FreeSpace, Bytes_TotalSpace);

	// Success
	return TRUE;
	}
