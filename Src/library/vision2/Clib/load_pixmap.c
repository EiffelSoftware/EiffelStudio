/*****************************************************************************/
/* load_pixmap.c                                                             */
/*****************************************************************************/
/* Used to read different graphical files from disk/streams                  */
/* Done			: local disk                                                 */
/* To be done	: streams                                                    */
/*                                                                           */
/* Note: This code has been successfully compiled using VC++ 6.0 in Warning  */
/*       Level 4 without issuing any warning message                         */
/*****************************************************************************/
#include "eif_portable.h"
#include "eif_malloc.h"
#include <stdio.h>
#ifdef EIF_WIN32
#include <windows.h>
#include "png.h"
#else
#include <stdlib.h>
#include <png.h>
#endif
#include "load_pixmap.h"

/* Classic constants */
#define DEBUG	1

#ifndef FALSE
#define FALSE	0
#endif

#ifndef TRUE
#define TRUE	1
#endif

#ifndef max
#define max(a, b)  (((a) > (b)) ? (a) : (b))
#endif

/* File format detected */
#define FILEFORMAT_UNKNOWN	0
#define FILEFORMAT_BMP		1
#define FILEFORMAT_ICO		2
#define FILEFORMAT_JPEG		3
#define FILEFORMAT_PNG		4

/* Header size of the different file formats */
#define ICON_HEADER_SIZE		6
#define ICON_ENTRY_SIZE			16
#define ICON_INFOHEADER_SIZE	40
#define BITMAP_HEADER_SIZE		14
#define BITMAP_INFOHEADER_SIZE	40
#define JPEG_HEADER_SIZE		16
#define PNG_HEADER_SIZE			8
#define PPM_HEADER_SIZE			2

/* Buffered File properties */
#define MINIMUM_BYTES_TO_READ_PER_ACCESS	2048
#define BUFFER_SIZE							16384

/* Bufferred File definition */
struct TBufferedFile {
		unsigned long nCurrBufferSize;
		unsigned long nBufferMaxSize;
		unsigned char *pBuffer;
		FILE *pFile;
};
typedef struct TBufferedFile  BufferedFile;


/* Bufferred File definition */
struct TLoadPixmapCtx {
		void *pCurrObject;		// Current Eiffel Object executed
		char *pszFileName;		// File name
		FILE *pFile;			// File Pointer
		void (*LoadPixmapUpdateObject)(
				void*, 
				unsigned int, 
				unsigned int, 
				unsigned int, 
				unsigned int, 
				void*, 
				void*
			);
};
typedef struct TLoadPixmapCtx  LoadPixmapCtx;

/* Fonctions declaration */
void c_ev_load_pixmap(
		void *pCurrObject, 
		char *pszFileName, 
		void (*LoadPixmapUpdateObject)(
				void*, 
				unsigned int, 
				unsigned int, 
				unsigned int, 
				unsigned int, 
				void*, 
				void*
			)
		);

unsigned char	c_ev_find_file_format(BufferedFile *);
unsigned char	c_ev_is_ico_file(BufferedFile *pBufFile);
unsigned char	c_ev_is_bmp_file(BufferedFile *pBufFile);
unsigned char	c_ev_is_jpeg_file(BufferedFile *pBufFile);
unsigned char	c_ev_is_png_file(BufferedFile *pBufFile);
unsigned char	c_ev_is_ppm_file(BufferedFile *pBufFile);
unsigned char	c_ev_read_n_bytes(unsigned long, BufferedFile *);
void			c_ev_set_bit(
					unsigned char bit, 
					unsigned char *pData, 
					long iData
				);
void 			c_ev_load_png_file(LoadPixmapCtx *pCtx);
#ifdef EIF_WIN32
void 			c_ev_load_windows_file(
					unsigned int nWindowsType, 
					LoadPixmapCtx *pCtx
				);
#endif


// Default Vision2 icon
unsigned char default_vision2_icon[833] = {
		137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 0, 0, 0, 32, 0, 
		0, 0, 32, 8, 2, 0, 0, 0, 252, 24, 237, 163, 0, 0, 0, 7, 116, 73, 77, 69, 7, 
		208, 5, 2, 2, 3, 16, 137, 29, 102, 189, 0, 0, 0, 9, 112, 72, 89, 115, 0, 0, 
		10, 240, 0, 0, 10, 240, 1, 66, 172, 52, 152, 0, 0, 2, 224, 73, 68, 65, 84, 
		120, 218, 99, 60, 198, 64, 91, 192, 2, 196, 98, 41, 41, 188, 54, 54, 84, 55, 
		250, 243, 145, 35, 175, 230, 204, 1, 89, 0, 52, 93, 200, 207, 239, 235, 249, 
		243, 4, 245, 112, 168, 168, 252, 184, 115, 135, 24, 211, 185, 13, 13, 129, 
		36, 212, 2, 32, 0, 154, 126, 205, 217, 153, 160, 54, 165, 89, 179, 238, 165, 
		165, 17, 99, 129, 214, 222, 189, 16, 6, 19, 73, 190, 102, 149, 144, 32, 53, 
		160, 72, 176, 128, 145, 157, 157, 153, 135, 71, 166, 161, 129, 86, 22, 168, 
		173, 90, 197, 103, 107, 11, 180, 131, 86, 22, 220, 244, 247, 127, 189, 120, 
		241, 135, 157, 59, 105, 101, 1, 16, 252, 253, 252, 153, 93, 78, 142, 150, 22, 
		124, 248, 192, 174, 164, 68, 67, 11, 126, 191, 126, 205, 161, 172, 76, 43, 
		11, 216, 164, 165, 153, 184, 185, 185, 180, 181, 105, 101, 1, 183, 169, 41, 
		40, 14, 20, 20, 24, 152, 72, 208, 69, 138, 5, 122, 122, 191, 159, 61, 3, 38, 
		83, 14, 82, 162, 129, 4, 11, 120, 204, 205, 127, 220, 187, 247, 231, 195, 7, 
		62, 71, 71, 62, 123, 123, 70, 54, 54, 170, 90, 192, 200, 200, 173, 175, 255, 
		255, 207, 31, 96, 248, 40, 207, 154, 165, 181, 127, 63, 191, 171, 43, 49, 
		250, 88, 136, 52, 31, 152, 252, 89, 37, 37, 117, 79, 159, 102, 230, 226, 250, 
		243, 241, 227, 117, 15, 143, 47, 39, 78, 80, 205, 2, 102, 126, 126, 229, 249, 
		243, 255, 255, 254, 253, 113, 247, 110, 102, 94, 222, 191, 31, 63, 254, 126, 
		245, 138, 72, 151, 17, 21, 68, 162, 177, 177, 108, 146, 146, 207, 39, 77, 
		186, 25, 16, 240, 118, 221, 186, 127, 63, 126, 136, 198, 197, 17, 153, 227, 
		136, 178, 224, 197, 148, 41, 192, 162, 244, 235, 217, 179, 204, 124, 124, 
		156, 106, 106, 66, 1, 1, 178, 245, 245, 250, 23, 46, 80, 45, 136, 184, 244, 
		244, 216, 229, 229, 129, 69, 169, 210, 140, 25, 44, 2, 2, 64, 145, 95, 79, 
		159, 62, 170, 169, 161, 142, 5, 64, 183, 75, 149, 148, 48, 50, 49, 137, 165, 
		166, 126, 62, 118, 236, 221, 186, 117, 188, 86, 86, 223, 175, 95, 231, 119, 
		114, 122, 189, 96, 1, 165, 22, 112, 25, 26, 202, 119, 116, 8, 184, 185, 189, 
		152, 49, 227, 81, 85, 213, 223, 247, 239, 129, 130, 223, 175, 93, 3, 90, 198, 
		169, 169, 201, 161, 166, 246, 227, 214, 45, 252, 38, 16, 136, 131, 111, 23, 
		47, 62, 237, 236, 252, 255, 255, 255, 139, 137, 19, 33, 166, 3, 193, 199, 
		125, 251, 128, 181, 255, 203, 153, 51, 229, 59, 59, 9, 250, 128, 80, 36, 255, 
		251, 39, 158, 150, 246, 253, 198, 141, 239, 183, 110, 169, 44, 93, 106, 246, 
		249, 51, 48, 139, 1, 107, 230, 103, 93, 93, 64, 31, 48, 178, 178, 10, 120, 
		122, 82, 100, 1, 176, 4, 21, 14, 14, 126, 191, 121, 179, 104, 76, 12, 191, 
		163, 227, 155, 149, 43, 129, 249, 89, 247, 228, 201, 207, 199, 143, 3, 61, 
		241, 102, 217, 50, 169, 226, 98, 86, 113, 113, 242, 45, 16, 75, 78, 6, 22, 
		18, 47, 167, 79, 23, 207, 200, 184, 108, 110, 126, 47, 37, 229, 162, 129, 1, 
		195, 223, 191, 82, 165, 165, 119, 162, 163, 197, 18, 19, 191, 223, 190, 45, 
		158, 158, 78, 166, 5, 76, 92, 92, 226, 89, 89, 159, 14, 31, 254, 247, 243, 
		231, 167, 35, 71, 126, 61, 126, 12, 20, 252, 245, 232, 209, 173, 136, 136, 
		215, 243, 231, 255, 121, 247, 238, 86, 120, 248, 191, 111, 223, 94, 205, 155, 
		135, 199, 16, 124, 169, 72, 40, 40, 136, 77, 92, 252, 78, 124, 252, 159, 183, 
		111, 159, 52, 54, 194, 197, 191, 156, 60, 9, 97, 0, 237, 120, 88, 92, 140, 
		63, 12, 160, 22, 0, 91, 122, 240, 182, 24, 28, 0, 83, 225, 191, 223, 191, 
		165, 203, 203, 165, 203, 202, 24, 72, 4, 64, 3, 127, 130, 125, 12, 178, 0, 
		216, 74, 197, 170, 8, 162, 130, 60, 0, 212, 11, 49, 150, 145, 214, 205, 119, 
		0, 239, 86, 18, 108, 118, 212, 26, 236, 0, 0, 0, 0, 73, 69, 78, 68, 174, 66, 
		96, 130
	};


/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_load_pixmap                                                    */
/* ARGS: - pszFileName: name of the graphical file to load.                  */
/*         if NULL, then the default EiffelVision2 icon is loaded            */
/*---------------------------------------------------------------------------*/
void c_ev_load_pixmap(
		void *pCurrObject, 
		char *pszFileName, 
		void (*LoadPixmapUpdateObject)(
				void*,
				unsigned int,
				unsigned int,
				unsigned int,
				unsigned int,
				void*,
				void*
			)
		)
	{
	FILE *pFile;
	unsigned char *pBuffer;
	BufferedFile stBufFile;
	unsigned char nFileFormat; // File format found: one of FILEFORMAT_XXXX
	LoadPixmapCtx stCtx;
	
	if (pszFileName == NULL)
		{
		FILE *pFile2 = fopen ("C:\\validate.png", "wb");
		fwrite (default_vision2_icon, 1, sizeof (default_vision2_icon), pFile2);
		fclose (pFile2);

		// Load the default Vision2 icon
		pFile = tmpfile(); // create a temporary file
		fwrite (default_vision2_icon, 1, sizeof (default_vision2_icon), pFile);
		fseek (pFile, 0, SEEK_SET);
		}
	else
		{
		// Open the file
		pFile = fopen ((const char *)pszFileName, "rb");
		if (pFile == NULL)
			{
			// Unable to open the file, return NULL
			LoadPixmapUpdateObject(
				pCurrObject,
				LOADPIXMAP_ERROR_UNABLE_OPEN_FILE,
				0,
				0,
				0,
				NULL,
				NULL
				);
			return;
			}
		}

	// Setup the buffered file
	pBuffer = malloc(BUFFER_SIZE*sizeof(unsigned char));
	if (pBuffer == NULL)
		{
		/* Out of memory */
		LoadPixmapUpdateObject(
			pCurrObject,
			LOADPIXMAP_ERROR_OUTOFMEMORY, 0, 0, 0, NULL, NULL);
		return;
		}
	stBufFile.nCurrBufferSize = 0;
	stBufFile.nBufferMaxSize = BUFFER_SIZE;
	stBufFile.pBuffer = pBuffer;
	stBufFile.pFile = pFile;

	/* First determine the file format of the file */
	nFileFormat = c_ev_find_file_format(&stBufFile);

	/* Free allocated memory */
	free(pBuffer);

	switch(nFileFormat)
		{
		/* Windows ICO file format */
		case FILEFORMAT_ICO:
#ifdef EIF_WIN32
			stCtx.LoadPixmapUpdateObject = LoadPixmapUpdateObject;
			stCtx.pCurrObject = pCurrObject;
			stCtx.pszFileName = pszFileName;
			c_ev_load_windows_file(IMAGE_ICON, &stCtx);
			return;
#else
			/* ICO files are currently not supported under Unix */
			LoadPixmapUpdateObject(
				pCurrObject,
				LOADPIXMAP_ERROR_UNKNOWN_FILEFORMAT,
				0,
				0,
				0,
				NULL,
				NULL
			);
			return;
#endif

		/* Windows BMP file format */
		case FILEFORMAT_BMP:
#ifdef EIF_WIN32
			stCtx.LoadPixmapUpdateObject = LoadPixmapUpdateObject;
			stCtx.pCurrObject = pCurrObject;
			stCtx.pszFileName = pszFileName;
			c_ev_load_windows_file(IMAGE_BITMAP, &stCtx);
			return;
#else
			/* BMP files are currently not supported under Unix */
			LoadPixmapUpdateObject(
				pCurrObject,
				LOADPIXMAP_ERROR_UNKNOWN_FILEFORMAT,
				0,
				0,
				0,
				NULL,
				NULL
			);
			return;
#endif

		case FILEFORMAT_PNG:
			stCtx.LoadPixmapUpdateObject = LoadPixmapUpdateObject;
			stCtx.pCurrObject = pCurrObject;
			stCtx.pszFileName = pszFileName;
			stCtx.pFile = pFile;
			c_ev_load_png_file(&stCtx);
			return;

		default:
			/* Bad file format */
			LoadPixmapUpdateObject(
				pCurrObject,
				LOADPIXMAP_ERROR_UNKNOWN_FILEFORMAT,
				0,
				0,
				0,
				NULL,
				NULL
			);
			return;
		}
	
	/* close the graphical file or the temporary file */
	fclose (pFile);
	}


/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_read_n_bytes                                                   */
/*---------------------------------------------------------------------------*/
/* Retrun TRUE if the requested size has been flushed into the buffer,       */
/* FALSE otherwise.                                                          */
/*---------------------------------------------------------------------------*/
unsigned char c_ev_read_n_bytes(
		unsigned long nRequestedBufferSize, 
		BufferedFile *pBufFile
		)
	{
	unsigned long nBytesRead = 0;
	unsigned long nBytesToRead = 0;

	if (nRequestedBufferSize > pBufFile->nBufferMaxSize)
		{
#ifdef DEBUG
		printf("Require Assertion violated in c_ev_read_n_bytes\n");
		printf("nRequestedBufferSize > pBufFile->nBufferMaxSize\n\n");
		exit(1);
#else
		return FALSE;
#endif
		}

	/* If the job is already done, exit */
	if (pBufFile->nCurrBufferSize >= nRequestedBufferSize)
		return TRUE;

	nBytesToRead = max(
		nRequestedBufferSize - pBufFile->nCurrBufferSize,
		MINIMUM_BYTES_TO_READ_PER_ACCESS
		);

	nBytesRead = fread(&(pBufFile->pBuffer[pBufFile->nCurrBufferSize]), 1, 
				       (size_t)nBytesToRead, pBufFile->pFile);
	
	/* Compute the new buffer size */
	pBufFile->nCurrBufferSize += nBytesRead;

	/* Everything went ok if the RequestedSize is loaded. */
	if (pBufFile->nCurrBufferSize >= nRequestedBufferSize)
		return TRUE;
	else
		return FALSE;
	}


#ifdef EIF_WIN32
/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_load_windows_file                                              */
/* ARGS: - nWindowsType: IMAGE_ICON or IMAGE_BITMAP                          */
/*       - pCtx: context of the application (file to read, callback, ...)    */
/*---------------------------------------------------------------------------*/
/* Load an ICO or BMP file with the Win32 API. Returns to the application    */
/* a HICON handle or two HBITMAP handles: one for the color bitmap and one   */
/* for the mask.                                                             */
/*---------------------------------------------------------------------------*/
void c_ev_load_windows_file(unsigned int nWindowsType, LoadPixmapCtx *pCtx)
		{
		HGDIOBJ handle;
		EIF_INTEGER	nErrorCode = LOADPIXMAP_ERROR_NOERROR;

		handle = (void *) LoadImage(
			NULL,				// handle to instance
			pCtx->pszFileName,	// name or identifier of the image 
			nWindowsType,		// image type
			0,					// desired width
			0,					// desired height
			LR_LOADFROMFILE		// load options
		);
		if (handle==NULL)
			{
			DWORD nErrNum = GetLastError();
			switch (nErrNum)
				{
				case 2:
				case 3:
				case 4:
				case 5:
				case 15:
				case 30:
				case 32: 
					nErrorCode = LOADPIXMAP_ERROR_UNABLE_OPEN_FILE;
					break;
				case 8:
				case 14:
					nErrorCode = LOADPIXMAP_ERROR_OUTOFMEMORY;
					break;
				case 11:
					nErrorCode = LOADPIXMAP_ERROR_UNKNOWN_FILEFORMAT;
					break;
				default:
					nErrorCode = LOADPIXMAP_ERROR_UNKNOWN_ERROR;
				}
			(pCtx->LoadPixmapUpdateObject)(
				pCtx->pCurrObject,
				nErrorCode,
				LOADPIXMAP_HBITMAP,
				0, 
				0,
				handle,
				NULL
			);
			return;
			}

		if (nWindowsType == IMAGE_ICON)
			{
			(pCtx->LoadPixmapUpdateObject)(
				pCtx->pCurrObject,
				nErrorCode,
				LOADPIXMAP_HICON,
				0,
				0,
				handle,
				NULL
			);
			}
		else
			{
			HBITMAP hbmMask = NULL;	/* Handle on the bitmap mask. */
			BITMAP	bmInfo;
			void *pBits;
			long nLineSize; /* size of a line in bytes
							 * (a line should be WORD aligned)
							 */
			long nBitmapSize; /* Size in bytes of the bits of the 
							   * monochrome bitmap.
							   */

			if (GetObject (handle, sizeof(BITMAP), &bmInfo) != 0)
				{
				nLineSize = ((bmInfo.bmWidth / 16) + 1) * 2;
				nBitmapSize = nLineSize * bmInfo.bmHeight;
				pBits = cmalloc(nBitmapSize);/* Allocate space for the mask */
				memset(pBits, 0, nBitmapSize);/* Set the mask to be empty */
				hbmMask = CreateBitmap (
							bmInfo.bmWidth,	/* Same width as the bitmap */
							bmInfo.bmHeight,/* Same height as the bitmap */
							1, 				/* number of color planes */
							1,				/* number of bits/pixel */
							pBits			/* color data array. */
						);
				if (hbmMask==NULL)
					nErrorCode = LOADPIXMAP_ERROR_UNKNOWN_ERROR;
				}
			else
				nErrorCode = LOADPIXMAP_ERROR_UNKNOWN_ERROR;
	
			/* Call the Eiffel routine back. */
			(pCtx->LoadPixmapUpdateObject)(
				pCtx->pCurrObject,
				nErrorCode,
				LOADPIXMAP_HBITMAP,
				0,
				0,
				handle,
				hbmMask
			);
			}
		return;
		}
#endif


/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_find_file_format                                               */
/* ARGS: - pFile: file descriptor of the file to find the type of.           */
/*---------------------------------------------------------------------------*/
/* Return the number of the recognized format, or 0 is none matches.         */
/* see the constants FILEFORMAT_XXXX for the possible returned values        */
/*---------------------------------------------------------------------------*/
unsigned char c_ev_find_file_format(BufferedFile *pBufFile)
	{
	/* Does the current format match against the ICO format */
	if (c_ev_is_ico_file(pBufFile))
		return FILEFORMAT_ICO;
	
	if (c_ev_is_bmp_file(pBufFile))
		return FILEFORMAT_BMP;
	
	if (c_ev_is_png_file(pBufFile))
		return FILEFORMAT_PNG;
	
	/* Unknown Format */
	return FILEFORMAT_UNKNOWN;
	}


/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_is_ico_file                                                    */
/*---------------------------------------------------------------------------*/
/* Return TRUE if the current file match the ICO file format,                */
/* FALSE otherwise.                                                          */
/*---------------------------------------------------------------------------*/
unsigned char c_ev_is_ico_file(BufferedFile *pBufFile)
	{
	int				nEntries	= 0;	/* Number of icons in the file */
	int				nCurrEntry	= 0;
	int				iCurr		= 0;
	unsigned long	iFileOffset = 0;
	unsigned char	*pBuffer = pBufFile->pBuffer;

	/* Ensure that at leat 6 bytes are available in the buffer */
	if (!c_ev_read_n_bytes(ICON_HEADER_SIZE, pBufFile))
		return FALSE;

	/* Check for the static header */
	if (!(pBuffer[0]==0 && pBuffer[1]==0 && pBuffer[2]==1 && pBuffer[3]==0))
		return FALSE;
	
	/* Check for the header of all picture inside the icon. */
	nEntries = pBuffer[4] + (pBuffer[5] << 8); /* Big endian storage */
	
	/* Ensure we have enough bytes in our buffer to check the header
	 * of each icon */
	if (!c_ev_read_n_bytes(ICON_HEADER_SIZE + nEntries * ICON_ENTRY_SIZE, 
		                   pBufFile))
		return FALSE;

	nCurrEntry = 0;
	iCurr = ICON_HEADER_SIZE;
	while (nCurrEntry < nEntries)
		{
		/* Get the position of the InfoHeader */
		iFileOffset = pBuffer[iCurr+12] + 
					  (pBuffer[iCurr+13] << 8) +
					  (pBuffer[iCurr+14] << 16) +
					  (pBuffer[iCurr+15] << 24);

		if (iFileOffset <= pBufFile->nBufferMaxSize)
			{
			/* Read the file enough to be able to reach the 
			 * location of the InfoHeader Structure
			 */
			if (!c_ev_read_n_bytes(iFileOffset+3, pBufFile))
				return FALSE;

			if (!(pBuffer[iFileOffset]==ICON_INFOHEADER_SIZE && 
				  pBuffer[iFileOffset+1]==0 &&
				  pBuffer[iFileOffset+2]==0 &&
				  pBuffer[iFileOffset+3]==0))
				return FALSE;
			}
		else
			{
			/* iFileOffset is too big to be tested. So we give up
			 * and ignore the previous test.
			 */
			}

		nCurrEntry++;
		iCurr += ICON_ENTRY_SIZE;
		}

	/* All tests were successfully. This is a valid ICO file */
	return TRUE;
	}


/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_is_bmp_file                                                    */
/*---------------------------------------------------------------------------*/
/* Return TRUE if the current file match the BMP file format,                */
/* FALSE otherwise.                                                          */
/*---------------------------------------------------------------------------*/
unsigned char c_ev_is_bmp_file(BufferedFile *pBufFile)
	{
	unsigned char	*pBuffer = pBufFile->pBuffer;

	/* Ensure that at leat 6 bytes are available in the buffer */
	if (!c_ev_read_n_bytes(
			BITMAP_HEADER_SIZE + BITMAP_INFOHEADER_SIZE,
			pBufFile)
		)
		return FALSE;

	/* Check for the static header */
	if (!(pBuffer[0]=='B' && pBuffer[1]=='M'))
		return FALSE;
	
	/* Check for the validity of the InfoHeader */
	if (!(pBuffer[BITMAP_HEADER_SIZE]==BITMAP_INFOHEADER_SIZE && 
		  pBuffer[BITMAP_HEADER_SIZE+1]==0 &&
		  pBuffer[BITMAP_HEADER_SIZE+2]==0 &&
		  pBuffer[BITMAP_HEADER_SIZE+3]==0))
		return FALSE;

	/* All tests were successfully. This is a valid BMP file */
	return TRUE;
	}

/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_is_jpeg_file                                                   */
/*---------------------------------------------------------------------------*/
/* Return TRUE if the current file match the JPEG file format,               */
/* FALSE otherwise.                                                          */
/*---------------------------------------------------------------------------*/
unsigned char c_ev_is_jpeg_file(BufferedFile *pBufFile)
	{
	unsigned char	*pBuffer = pBufFile->pBuffer;

	/* Ensure that at leat 6 bytes are available in the buffer */
	if (!c_ev_read_n_bytes(JPEG_HEADER_SIZE, pBufFile))
		return FALSE;

	/* Check for the static header (header part) */
	if (!(pBuffer[0]==0xFF && pBuffer[1]==0xD8 && 
		  pBuffer[2]==0xFF && pBuffer[3]==0xE0 ))
		return FALSE;
	
	/* Check for the static header (string part) */
	if (!(pBuffer[6]=='J' && 
		  pBuffer[7]=='F' && 
		  pBuffer[8]=='I' && 
		  pBuffer[9]=='F' ))
		return FALSE;

	/* All tests were successfully. This is a valid JPEG file */
	return TRUE;
	}


/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_is_png_file                                                    */
/*---------------------------------------------------------------------------*/
/* Return TRUE if the current file match the png file format,                */
/* FALSE otherwise.                                                          */
/*---------------------------------------------------------------------------*/
unsigned char c_ev_is_png_file(BufferedFile *pBufFile)
	{
	unsigned char	*pBuffer = pBufFile->pBuffer;

	/* Ensure that at leat 6 bytes are available in the buffer */
	if (!c_ev_read_n_bytes(PNG_HEADER_SIZE, pBufFile))
		return FALSE;

	/* Check for the static header */
	if (!(pBuffer[0]==137 && 
		  pBuffer[1]==80 && 
		  pBuffer[2]==78 && 
		  pBuffer[3]==71 &&
		  pBuffer[4]==13 &&
		  pBuffer[5]==10 &&
		  pBuffer[6]==26 &&
		  pBuffer[7]==10 ))
		return FALSE;

	/* All tests were successfully. This is a valid PNG file */
	return TRUE;
	}


/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_is_ppm_file                                                    */
/*---------------------------------------------------------------------------*/
/* Return TRUE if the current file match the PPM/PBM/PGM file format,        */
/* FALSE otherwise.                                                          */
/*---------------------------------------------------------------------------*/
unsigned char c_ev_is_ppm_file(BufferedFile *pBufFile)
	{
	unsigned char	*pBuffer = pBufFile->pBuffer;

	/* Ensure that at leat 6 bytes are available in the buffer */
	if (!c_ev_read_n_bytes(PPM_HEADER_SIZE, pBufFile))
		return FALSE;

	/* Check for the static header */
	if (pBuffer[0]!='P')
		return FALSE;

	/* Correct headers are 'P1'...'P6' */
	if (pBuffer[1]<'1' || pBuffer[1]>'6')
		return FALSE;

	/* All tests were successfully. This is a valid PGM/PBM/PPM file */
	return TRUE;
	}


/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_set_bit                                                        */
/*---------------------------------------------------------------------------*/
/* Set the bit at position `iData' in `pData' to `bit'. iData represent an   */
/* index in BITS.                                                            */
/*---------------------------------------------------------------------------*/
void c_ev_set_bit(unsigned char bit, unsigned char *pData, long iData)
	{
	long iOff = iData / 8;	// Offset of the bit in byte
	long iBitPos = 7 - (iData % 8);		// Position of the bit within the byte
	unsigned char bitValue;

	bitValue = (unsigned char)(1 << iBitPos);
	if (bit == 0)
		pData[iOff] = (unsigned char) (pData[iOff] & (~bitValue));
	else
		pData[iOff] = (unsigned char) (pData[iOff] | bitValue);
	}

/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_load_png_file                                                  */
/* ARGS: - pCtx: context of the application (file to read, callback, ...)    */
/*---------------------------------------------------------------------------*/
/* Load a PNG file                                                           */
/*                                                                           */
/* On Windows, it returns to the application two HBITMAP handles: one for    */
/* the color bitmap and one for the mask created from the alpha channel.     */
/*                                                                           */
/* On Unix, Not yet implemented                                              */
/*---------------------------------------------------------------------------*/
void c_ev_load_png_file(LoadPixmapCtx *pCtx)  
	{
	png_structp		png_ptr;
	png_infop		info_ptr;
	png_uint_32 	width;
	png_uint_32		height;
	int				bit_depth;
	int				color_type;
	int				interlace_type;
	FILE 			*fp;			// Current opened file
	unsigned char 	**ppImage;		// Pointer on an array of scan lines
	unsigned char 	*pData;			// Pointer on the RGB data
	unsigned char 	*pImage;		// Pointer on a DIB structure
	unsigned char 	*pAlphaData;	// Pointer on the Alpha data
	unsigned char 	*pAlphaImage;	// Pointer on a DIB structure
	unsigned char	bAlphaImage = FALSE;// Is there a mask for this image?
#ifdef EIF_WIN32
	unsigned long 	iData;
	unsigned long 	iAlphaData;
#endif
	unsigned long 	sRowSize;		// Size in bytes of a scan line
	unsigned long 	row;			// Current scan line
	unsigned long	nErrorCode = LOADPIXMAP_ERROR_NOERROR;

	// Retrieve File Stream
	fp = pCtx->pFile;
	if (fp == NULL)
		return;
	// reset the file pointer
	fseek (fp, 0, SEEK_SET);

	/* Create and initialize the png_struct with the desired error handler
	 * functions.  If you want to use the default stderr and longjump method,
	 * you can supply NULL for the last three parameters.  We also supply the
	 * the compiler header file version, so that we know if the application
	 * was compiled with a compatible version of the library.  REQUIRED
	 */
	png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
	if (png_ptr == NULL)
		{
		//fclose(fp);
		return;
		}

	/* Allocate/initialize the memory for image information.  REQUIRED. */
	info_ptr = png_create_info_struct(png_ptr);
	if (info_ptr == NULL)
		{
		//fclose(fp);
		png_destroy_read_struct(&png_ptr, (png_infopp)NULL, (png_infopp)NULL);
		return;
		}

	/* Set error handling if you are using the setjmp/longjmp method (this is
	 * the normal method of doing things with libpng).  REQUIRED unless you
	 * set up your own error handlers in the png_create_read_struct() earlier.
	 */
	if (setjmp(png_ptr->jmpbuf))
		{
		/* Free all of the memory associated with the png_ptr and info_ptr */
		png_destroy_read_struct(&png_ptr, &info_ptr, (png_infopp)NULL);
		//fclose(fp);

		/* If we get here, we had a problem reading the file */
		return;
		}

	/* One of the following I/O initialization methods is REQUIRED */
	/* Set up the input control if you are using standard C streams */
	png_init_io(png_ptr, fp);

	/* The call to png_read_info() gives us all of the information from the
	 * PNG file before the first IDAT (image data chunk).  REQUIRED
	 */
	png_read_info(png_ptr, info_ptr);

	png_get_IHDR(png_ptr, info_ptr, &width, &height, &bit_depth, &color_type,
		&interlace_type, NULL, NULL);

	/* Set up the data transformations you want.  Note that these are all */
	/* optional.  Only call them if you want/need them.  Many of the      */
	/* transformations only work on specific types of images, and many    */
	/* are mutually exclusive.                                            */

	/* Extract multiple pixels with bit depths of 1, 2, and 4 from a single
	 * byte into separate bytes (useful for paletted and grayscale images).
	 */
	png_set_packing(png_ptr);

	/* Expand paletted colors into true RGB triplets */
	if (color_type == PNG_COLOR_TYPE_PALETTE)
		png_set_expand(png_ptr);

	/* Expand grayscale images to the full 8 bits from 1, 2, or 4 bits/pixel */
	if (color_type == PNG_COLOR_TYPE_GRAY && bit_depth < 8)
		png_set_expand(png_ptr);

	/* Expand paletted or RGB images with transparency to full alpha channels
	 * so the data will be available as RGBA quartets.
	 */
	if (png_get_valid(png_ptr, info_ptr, PNG_INFO_tRNS))
		png_set_expand(png_ptr);

	/* invert monocrome files to have 0 as white and 1 as black */
	png_set_invert_mono(png_ptr);

	/* Add filler (or alpha) byte (before/after each RGB triplet) */
	png_set_filler(png_ptr, 0xff, PNG_FILLER_AFTER);

	/* Optional call to gamma correct and add the background to the palette
	* and update info structure.  REQUIRED if you are expecting libpng to
	* update the palette for you (ie you selected such a transform above).
	*/
	png_read_update_info(png_ptr, info_ptr);

	/* Allocate the memory to hold the image using the fields of info_ptr. */
	ppImage = (unsigned char **) malloc(height * sizeof(unsigned char *));
	for (row = 0; row < height; row++)
		{
		sRowSize = png_get_rowbytes(png_ptr, info_ptr);
		ppImage[row] = (unsigned char *)malloc(sRowSize);
		}

	/* Now it's time to read the image.  One of these methods is REQUIRED */
	png_read_image(png_ptr, ppImage);

	/* read rest of file, and get additional chunks in info_ptr - REQUIRED */
	png_read_end(png_ptr, info_ptr);

	/* clean up after the read, and free any memory allocated - REQUIRED */
	png_destroy_read_struct(&png_ptr, &info_ptr, NULL);

	/* close the file */
	//fclose(fp);

#ifdef EIF_WIN32
	sRowSize = 4 * ((width * 24 + 31) / 32);
	pImage = (unsigned char *) malloc(sRowSize * height + 40);
	pData = pImage;
	iData = 0;

	sRowSize = 4 * ((width + 31) / 32);
	pAlphaImage = (unsigned char *) malloc(sRowSize * height + 40 + 8);
	pAlphaData = pAlphaImage;
	iAlphaData = 0;

	/* Create a Windows DIB Header for the color bitmap */
	*((DWORD *)pData) = 40;			pData += 4;				// Size of header
	*((DWORD *)pData) = width;		pData += 4;				// width in pixel
	*((DWORD *)pData) = height;		pData += 4;				// height in pixel
	*((WORD *)pData) = 1;			pData += 2;				// bit plane
	*((WORD *)pData) = 24;			pData += 2;				// bits/pixel
	*((DWORD *)pData) = BI_RGB;		pData += 4;				// compression
	*((DWORD *)pData) = 0;			pData += 4;				// imageSize
	*((DWORD *)pData) = 0;			pData += 4;				// XPelPerM
	*((DWORD *)pData) = 0;			pData += 4;				// YPelPerM
	*((DWORD *)pData) = 0;			pData += 4;				// ClrUsed
	*((DWORD *)pData) = 0;			pData += 4;				// ClrImportant

	/* Create a Windows DIB Header for the mask bitmap */
	*((DWORD *)pAlphaData) = 40;		pAlphaData += 4;	// size of header
	*((DWORD *)pAlphaData) = width;		pAlphaData += 4;	// width in pixel
	*((DWORD *)pAlphaData) = height;	pAlphaData += 4;	// height in pixel
	*((WORD *)pAlphaData) = 1;			pAlphaData += 2;	// bit plane
	*((WORD *)pAlphaData) = 1;			pAlphaData += 2;	// bits/pixel
	*((DWORD *)pAlphaData) = BI_RGB;	pAlphaData += 4;	// compression
	*((DWORD *)pAlphaData) = 0;			pAlphaData += 4;	// imageSize
	*((DWORD *)pAlphaData) = 0;			pAlphaData += 4;	// XPelPerM
	*((DWORD *)pAlphaData) = 0;			pAlphaData += 4;	// YPelPerM
	*((DWORD *)pAlphaData) = 2;			pAlphaData += 4;	// ClrUsed
	*((DWORD *)pAlphaData) = 2;			pAlphaData += 4;	// ClrImportant
	/* Color Table */
	*((DWORD *)pAlphaData) = 0x00000000;pAlphaData += 4;	// Index 0 (black)
	*((DWORD *)pAlphaData) = 0x00FFFFFF;pAlphaData += 4;	// Index 1 (white)


	for (row = height; row > 0; row--)
		{
		unsigned char *pSrc = ppImage[row-1];
		unsigned long nAlign;
		unsigned long iAlign;
		unsigned long column;

		for (column = 0; column < width; column++)
			{
			/* Copy the RGB data */
			*(pData + iData + 0) = *(pSrc + 2);	// B
			*(pData + iData + 1) = *(pSrc + 1);	// G
			*(pData + iData + 2) = *(pSrc + 0);	// R

			// Copy the alpha channel */
			if (*(pSrc + 3) > 0x7F)
				c_ev_set_bit(0, pAlphaData, iAlphaData);
			else
				{
				c_ev_set_bit(1, pAlphaData, iAlphaData);
				bAlphaImage = TRUE;
				}

			iData += 3;
			pSrc += 4;
			iAlphaData++;
			}
		
		/* Align line to WORD padding - Alpha data */
		nAlign = (16 - width%16) % 16;
		for (iAlign = 0; iAlign < nAlign; iAlign++)
			{
			c_ev_set_bit(0, pAlphaData, iAlphaData);
			iAlphaData++;
			}

		/* Align RGB data as well */
		nAlign = width % 4; /* small hack to go faster */
		for (iAlign = 0; iAlign < nAlign; iAlign++)
			{
			*(pData + iData) = 0;
			iData++;
			}
		}
	
	// The mast is empty, remove it
	if (bAlphaImage == FALSE)
		{
		free (pAlphaImage);
		pAlphaImage = NULL;
		}
	
#else
	pImage = (unsigned char *) malloc(width * height * 3);
	pData = pImage;

	pAlphaImage = (unsigned char *) malloc(width * height);
	pAlphaData = pAlphaImage;

	for (row = 0; row < height; row++)
		{
		unsigned char *pSrc = ppImage[row];
		unsigned long column;

		for (column = 0; column < width; column++)
			{
			/* Copy the RGB data */
			memcpy(pData, pSrc, 3);
			pData += 3;
			pSrc += 3;

			/* Copy the Alpha data */
			memcpy(pAlphaData, pSrc, 1);
			pSrc++;
			pAlphaData++;
			}
		}
#endif // EIF_WIN32

	/* Free the memory */
	for (row = 0; row < height; row++)
		{
		free(ppImage[row]);
		}
	free(ppImage);

	/* Call the Eiffel routine back */
	(pCtx->LoadPixmapUpdateObject)(
		pCtx->pCurrObject,
		nErrorCode,
		LOADPIXMAP_RGB_DATA,
		width,
		height,
		pImage,
		pAlphaImage
	);

	// Free the image occupied by the image & the
	// mask.
	if (pImage != NULL)
		free(pImage);
	
	if (pAlphaImage != NULL)
		free(pAlphaImage);

	/* that's it */
	return;
	}
