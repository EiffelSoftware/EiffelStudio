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
#endif
#include "load_pixmap.h"
#include "png.h"

/* Classic constants */
#define DEBUG	1

#ifndef FALSE
#define FALSE	0
#endif

#ifndef TRUE
#define TRUE	1
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
		void *pCurrObject;
		char *pszFileName;
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



/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_load_pixmap                                                    */
/* ARGS: - pszFileName: name of the graphical file to load.                  */
/*---------------------------------------------------------------------------*/
/* Return a pointer onto raw graphical data (4 bytes/pixels: R/G/B/Alpha)    */
/* NULL if an error occured while reading the file or if the file format is  */
/* not recognized.                                                           */
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
	unsigned char nFileFormat; /* File format found: one of FILEFORMAT_XXXX */
	LoadPixmapCtx stCtx;
	
	/* Open the file */
	pFile = fopen ((const char *)pszFileName, "rb");
	if (pFile == NULL)
		{
		/* Unable to open the file, return NULL */
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

	/* Setup the buffered file */
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
	unsigned long 	iData;
	unsigned long 	iAlphaData;
	unsigned long 	sRowSize;		// Size in bytes of a scan line
	unsigned long 	row;			// Current scan line
	unsigned long	nErrorCode = LOADPIXMAP_ERROR_NOERROR;
#ifdef EIF_WIN32
	HBITMAP 		hbmImage;
	HBITMAP 		hbmMask;
#endif

	if ((fp = fopen(pCtx->pszFileName, "rb")) == NULL)
		return;

	/* Create and initialize the png_struct with the desired error handler
	 * functions.  If you want to use the default stderr and longjump method,
	 * you can supply NULL for the last three parameters.  We also supply the
	 * the compiler header file version, so that we know if the application
	 * was compiled with a compatible version of the library.  REQUIRED
	 */
	png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
	if (png_ptr == NULL)
		{
		fclose(fp);
		return;
		}

	/* Allocate/initialize the memory for image information.  REQUIRED. */
	info_ptr = png_create_info_struct(png_ptr);
	if (info_ptr == NULL)
		{
		fclose(fp);
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
		fclose(fp);

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
	fclose(fp);



	sRowSize = 4 * ((width * 24 + 31) / 32);
	pImage = (unsigned char *) malloc(sRowSize * height + 40);
	pData = pImage;
	iData = 0;

	sRowSize = 4 * ((width + 31) / 32);
	pAlphaImage = (unsigned char *) malloc(sRowSize * height + 40 + 8);
	pAlphaData = pAlphaImage;
	iAlphaData = 0;

	/* Create a Windows DIB Header for the color bitmap */
	*((DWORD *)pData) = 40;			pData += 4;	// Size of header
	*((DWORD *)pData) = width;		pData += 4;	// width in pixel
	*((DWORD *)pData) = height;		pData += 4;	// height in pixel
	*((WORD *)pData) = 1;			pData += 2;	// bit plane
	*((WORD *)pData) = 24;			pData += 2;	// bits/pixel
	*((DWORD *)pData) = BI_RGB;		pData += 4;	// compression
	*((DWORD *)pData) = 0;			pData += 4;	// imageSize
	*((DWORD *)pData) = 0;			pData += 4;	// XPelPerM
	*((DWORD *)pData) = 0;			pData += 4;	// YPelPerM
	*((DWORD *)pData) = 0;			pData += 4;	// ClrUsed
	*((DWORD *)pData) = 0;			pData += 4;	// ClrImportant

	/* Create a Windows DIB Header for the mask bitmap */
	*((DWORD *)pAlphaData) = 40;		pAlphaData += 4;/* size of header */
	*((DWORD *)pAlphaData) = width;		pAlphaData += 4;/* width in pixel */
	*((DWORD *)pAlphaData) = height;	pAlphaData += 4;/* height in pixel */
	*((WORD *)pAlphaData) = 1;			pAlphaData += 2;/* bit plane */
	*((WORD *)pAlphaData) = 1;			pAlphaData += 2;/* bits/pixel */
	*((DWORD *)pAlphaData) = BI_RGB;	pAlphaData += 4;/* compression */
	*((DWORD *)pAlphaData) = 0;			pAlphaData += 4;/* imageSize */
	*((DWORD *)pAlphaData) = 0;			pAlphaData += 4;/* XPelPerM */
	*((DWORD *)pAlphaData) = 0;			pAlphaData += 4;/* YPelPerM */
	*((DWORD *)pAlphaData) = 2;			pAlphaData += 4;/* ClrUsed */
	*((DWORD *)pAlphaData) = 2;			pAlphaData += 4;/* ClrImportant */
	/* Color Table */
	*((DWORD *)pAlphaData) = 0x00000000;pAlphaData += 4;/* Index 0 (black) */
	*((DWORD *)pAlphaData) = 0x00FFFFFF;pAlphaData += 4;/* Index 1 (white) */


	for (row = height; row > 0; row--)
		{
		unsigned char *pSrc = ppImage[row-1];
		unsigned long nAlign;
		unsigned long iAlign;
		unsigned long column;

		for (column = 0; column < width; column++)
			{
			/* Copy the RGB data */
			//memcpy(pData + iData, pSrc, 3);
			*(pData + iData + 0) = *(pSrc + 2);	// B
			*(pData + iData + 1) = *(pSrc + 1);	// G
			*(pData + iData + 2) = *(pSrc + 0);	// R

			// Copy the alpha channel */
			if (*(pSrc + 3) > 0x7F)
				c_ev_set_bit(0, pAlphaData, iAlphaData);
			else
				c_ev_set_bit(1, pAlphaData, iAlphaData);

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

	free(pImage);
	free(pAlphaImage);

	/* that's it */
	return;
	}
