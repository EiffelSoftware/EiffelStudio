/*****************************************************************************/
/* load_pixmap.h                                                             */
/*****************************************************************************/
/* Used to read different graphical files from disk/streams                  */
/* Done			: local disk                                                 */
/* To be done	: streams                                                    */
/*****************************************************************************/

#ifndef __LOAD_PIXMAP_H_
#define __LOAD_PIXMAP_H_

#ifdef __cplusplus
extern "C" {
#endif

/* Format returned by the function ev_load_pixmap */
#define LOADPIXMAP_RGB_DATA		0		// Pointer on an RGB array.
#define LOADPIXMAP_ALPHA_DATA	1		// Pointer on an Alpha array.
#define LOADPIXMAP_HICON		2		// handle on an Icon
#define LOADPIXMAP_HBITMAP		3		// handle on a Bitmap

/* Error constants */
#define LOADPIXMAP_ERROR_NOERROR			0
#define LOADPIXMAP_ERROR_UNKNOWN_ERROR		1
#define LOADPIXMAP_ERROR_UNKNOWN_FILEFORMAT	2
#define LOADPIXMAP_ERROR_UNABLE_OPEN_FILE	3
#define LOADPIXMAP_ERROR_OUTOFMEMORY		4


/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_load_pixmap                                                    */
/* ARGS: - pszFileName: name of the graphical file to load.                  */
/*---------------------------------------------------------------------------*/
/* Return a pointer onto raw graphical data (4 bytes/pixels: R/G/B/Alpha)    */
/* NULL if an error occurred while reading the file or if the file format is  */
/* not recognized.                                                           */
/*---------------------------------------------------------------------------*/
void c_ev_load_pixmap(
		void *pCurrObject, 
		char *pszFileName, 
		void *fnptr
	);

void c_ev_save_png(
		char *,
		char *,
		int,
		int,
		int,
		int,
		int
		);

//FIXME put this somewhere else!!

unsigned long time_msec (void);

#ifdef __cplusplus
}
#endif

#endif /* __LOAD_PIXMAP_H_ */
