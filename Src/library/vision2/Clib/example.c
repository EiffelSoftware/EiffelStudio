#include "png.h"

setBit(unsigned char bit, unsigned char *pData, long iData);

void read_png(char *file_name)  /* We need to open the file */
	{
	png_structp png_ptr;
	png_infop info_ptr;
	unsigned int sig_read = 0;
	png_uint_32 width, height;
	int bit_depth, color_type, interlace_type;
	FILE *fp;
	double screen_gamma;
	int intent;
	unsigned char *data;
	unsigned char *alphaData;
	unsigned char **image;
	long sDataSize;
	long sRowSize;
	int row;
	HBITMAP hbmImage;
	HBITMAP hbmMask;
	long iMaskData;

	if ((fp = fopen(file_name, "rb")) == NULL)
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

	/**********************************************************************/
	/* Set up the data transformations you want.  Note that these are all */
	/* optional.  Only call them if you want/need them.  Many of the      */
	/* transformations only work on specific types of images, and many    */
	/* are mutually exclusive.                                            */
 	/**********************************************************************/

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

	/* The easiest way to read the image: */

	image = (unsigned char **) malloc(height * sizeof(unsigned char *));

	sDataSize = 0;
	for (row = 0; row < height; row++)
		{
		sRowSize = png_get_rowbytes(png_ptr, info_ptr);
		image[row] = (unsigned char *)malloc(sRowSize);
		}


//	data = (unsigned char *)malloc(sDataSize);

	/* Now it's time to read the image.  One of these methods is REQUIRED */
	png_read_image(png_ptr, image);

	/* read rest of file, and get additional chunks in info_ptr - REQUIRED */
	png_read_end(png_ptr, info_ptr);

	/* clean up after the read, and free any memory allocated - REQUIRED */
	png_destroy_read_struct(&png_ptr, &info_ptr, NULL);

	/* close the file */
	fclose(fp);


	/* UNIX */

	/* Create the RGB data and the Alpha Data */
/*	sDataSize = width * height * 3;	// 3 bytes = R/G/B
	data = (unsigned char *) malloc(sDataSize);
	alphaData = (unsigned char *) malloc(width * height);

	for (row = 0; row < height; row++)
		{
		(unsigned char *)src = image[row];
		for (column = 0; column < width; column++)
			{
			// Copy the RGB data
			memcpy(data, src, 3);
			data += 3;
			src += 3;

			// Copy the alpha channel
			memcpy (alphaData, src, 1);
			alphaData++;
			src++;
			}
		}
*/

	sDataSize = width * height * 4;	// 4 bytes = R/G/B/A
	pData = (unsigned char *) malloc(sDataSize);
	alphaData = (unsigned char *) malloc(width * height);
	iAlphaData = 0;

	for (row = 0; row < height; row++)
		{
		(unsigned char *)pSrc = image[row];
		long nAlign;
		long iAlign;

		for (column = 0; column < width; column++)
			{
			// Copy the RGB data
			memcpy(pData, pSrc, 3);
			pData += 3;
			pSrc += 3;

			/* set the forth byte to zero */
//			*data = 0;
//			data++;

			// Copy the alpha channel
			if (*pSrc > 0x7F)
				setBit(1, pAlphaData, iAlphaData);
			else
				setBit(0, pAlphaData, iAlphaData);
			pSrc++;
			iMaskData++;
			}
		
		/* Align line to WORD padding */
		nAlign = iMaskData % 16;
		for (iAlign = 0; iAlign < nAlign; iAlign++)
			{
			setBit(0, pAlphaData, iAlphaData + iAlign);
			}
		}

	hbmImage = CreateBitmap(width, height, 1, 24, pData);
	hbmMask = CreateBitmap(width, height, 1,  1, pAlphaData);
	}

	/* that's it */
	return;
	}

setBit(unsigned char bit, unsigned char *pData, long iData)
	{
	long iOff = (iData / 8) + 1;	// Offset of the bit in byte
	long iBitPos = iData % 8;		// Position of the bit within the byte
	unsigned char byteValue = pData[iOff];
	unsigned char bitValue;

	bitValue = bit << iBitPos;
	if (bit == 0)
		pData[iOff] = pData[iOff] & (~bitValue);
	else
		pData[iOff] = pData[iOff] | bitValue;
	}

void main()
	{
	read_png("c:\image2.png");
	}
