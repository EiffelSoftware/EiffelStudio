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

#ifdef EIF_WIN32
#include <windows.h>
#include "png.h"
#else
#include <stdlib.h>
#include <png.h>
#endif

#include "eif_portable.h"
#include "eif_malloc.h"
#include <stdio.h>

#include <sys/timeb.h>
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

/* Other constants */
#define TEMP_PATH_MAX_LENGTH	1024

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
		void *pCurrObject;		/* Current Eiffel Object executed */
		char *pszFileName;		/* File name */
		FILE *pFile;			/* File Pointer */
		void (*LoadPixmapUpdateObject)(
#ifndef EIF_IL_DLL
				void*, 
#endif
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
#ifndef EIF_IL_DLL
		void *pCurrObject, 
#endif
		char *pszFileName, 
		void *fnptr
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


/* Default Vision2 icon (32x32 png) */
/*unsigned char default_vision2_icon[833] = {
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
*/

/* Default Vision2 icon (png, 16x16) */
unsigned char default_vision2_icon[275] = {
		137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, 
		0, 0, 0, 16, 0, 0, 0, 16, 8, 3, 0, 0, 0, 40, 45, 15, 83, 0, 
		0, 0, 7, 116, 73, 77, 69, 7, 208, 10, 26, 21, 49, 34, 162, 
		46, 62, 24, 0, 0, 0, 9, 112, 72, 89, 115, 0, 0, 10, 240, 0, 
		0, 10, 240, 1, 66, 172, 52, 152, 0, 0, 0, 78, 80, 76, 84, 69, 
		198, 0, 0, 255, 255, 255, 181, 0, 0, 214, 123, 123, 173, 0, 
		0, 198, 57, 57, 231, 189, 189, 206, 66, 66, 214, 99, 99, 255, 
		239, 239, 214, 132, 132, 247, 198, 198, 206, 74, 74, 231, 
		181, 181, 156, 0, 0, 255, 247, 247, 247, 214, 214, 239, 189, 
		189, 231, 140, 140, 181, 33, 33, 239, 156, 156, 231, 165, 
		165, 206, 123, 123, 222, 90, 90, 231, 148, 148, 222, 115, 
		115, 224, 47, 91, 56, 0, 0, 0, 88, 73, 68, 65, 84, 120, 218, 
		109, 207, 201, 14, 128, 32, 12, 69, 81, 104, 41, 162, 136, 
		117, 30, 254, 255, 71, 13, 154, 144, 82, 189, 203, 211, 205, 
		171, 49, 159, 108, 85, 134, 135, 145, 222, 107, 1, 223, 40, 
		192, 160, 224, 66, 5, 167, 2, 216, 227, 81, 1, 49, 67, 5, 
		105, 89, 55, 9, 224, 199, 105, 6, 1, 125, 26, 28, 147, 0, 12, 
		173, 239, 34, 20, 0, 139, 142, 40, 143, 181, 127, 207, 169, 
		110, 231, 244, 2, 2, 235, 107, 53, 211, 0, 0, 0, 0, 73, 69, 
		78, 68, 174, 66, 96, 130
	};


/* Default Vision2 icon (ico) */
unsigned char default_vision2_icon_for_windows[4710] = {
		0, 0, 1, 0, 4, 0, 16, 16, 16, 0, 0, 0, 0, 0, 40, 1, 0, 0, 
		70, 0, 0, 0, 16, 16, 0, 0, 0, 0, 0, 0, 104, 5, 0, 0, 110, 1, 
		0, 0, 32, 32, 16, 0, 0, 0, 0, 0, 232, 2, 0, 0, 214, 6, 0, 0, 
		32, 32, 0, 0, 0, 0, 0, 0, 168, 8, 0, 0, 190, 9, 0, 0, 40, 0, 
		0, 0, 16, 0, 0, 0, 32, 0, 0, 0, 1, 0, 4, 0, 0, 0, 0, 0, 192, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 128, 0, 0, 128, 0, 0, 0, 128, 128, 0, 128, 0, 
		0, 0, 128, 0, 128, 0, 128, 128, 0, 0, 192, 192, 192, 0, 128, 
		128, 128, 0, 0, 0, 255, 0, 0, 255, 0, 0, 0, 255, 255, 0, 
		255, 0, 0, 0, 255, 0, 255, 0, 255, 255, 0, 0, 255, 255, 255, 
		0, 145, 145, 145, 145, 145, 145, 145, 145, 31, 255, 255, 
		255, 255, 255, 255, 249, 159, 145, 159, 113, 129, 248, 145, 
		241, 31, 25, 23, 127, 247, 121, 25, 249, 159, 145, 152, 113, 
		159, 129, 145, 241, 31, 25, 25, 255, 247, 25, 25, 249, 159, 
		145, 145, 113, 247, 145, 145, 241, 31, 25, 25, 143, 249, 25, 
		25, 249, 159, 145, 145, 151, 119, 145, 145, 241, 31, 25, 25, 
		23, 121, 25, 25, 249, 159, 145, 145, 151, 113, 145, 145, 
		241, 31, 25, 25, 23, 137, 25, 25, 249, 159, 145, 145, 159, 
		129, 145, 145, 241, 31, 25, 25, 23, 25, 25, 25, 249, 159, 
		255, 255, 255, 255, 255, 255, 241, 25, 25, 25, 25, 25, 25, 
		25, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 40, 0, 0, 0, 16, 0, 0, 0, 32, 0, 0, 0, 
		1, 0, 8, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 249, 249, 254, 0, 245, 245, 253, 0, 
		235, 235, 251, 0, 225, 225, 248, 0, 212, 212, 246, 0, 200, 
		200, 243, 0, 193, 193, 242, 0, 191, 191, 235, 0, 191, 191, 
		230, 0, 177, 177, 232, 0, 178, 178, 227, 0, 165, 165, 230, 
		0, 157, 157, 233, 0, 149, 149, 231, 0, 143, 143, 230, 0, 
		129, 129, 215, 0, 127, 127, 212, 0, 112, 112, 216, 0, 127, 
		127, 205, 0, 100, 100, 210, 0, 93, 93, 216, 0, 76, 76, 206, 
		0, 67, 67, 205, 0, 63, 63, 200, 0, 62, 62, 195, 0, 0, 0, 
		198, 0, 36, 36, 176, 0, 0, 0, 185, 0, 0, 0, 179, 0, 0, 0, 
		169, 0, 0, 0, 158, 0, 0, 0, 198, 0, 0, 0, 188, 0, 0, 0, 180, 
		0, 0, 0, 171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 255, 255, 255, 0, 25, 25, 25, 25, 25, 25, 
		25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 255, 255, 255, 
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 25, 
		25, 255, 25, 25, 28, 255, 16, 29, 24, 24, 7, 23, 25, 25, 
		255, 25, 25, 255, 25, 25, 25, 16, 19, 2, 8, 15, 5, 27, 25, 
		25, 255, 25, 25, 255, 25, 25, 25, 21, 9, 30, 29, 0, 24, 25, 
		25, 25, 255, 25, 25, 255, 25, 25, 25, 28, 7, 4, 6, 14, 28, 
		25, 25, 25, 255, 25, 25, 255, 25, 25, 25, 25, 10, 26, 12, 
		11, 25, 25, 25, 25, 255, 25, 25, 255, 25, 25, 25, 25, 24, 1, 
		0, 28, 25, 25, 25, 25, 255, 25, 25, 255, 25, 25, 25, 25, 28, 
		18, 5, 20, 25, 25, 25, 25, 255, 25, 25, 255, 25, 25, 25, 25, 
		25, 13, 16, 25, 25, 25, 25, 25, 255, 25, 25, 255, 25, 25, 
		25, 25, 25, 17, 16, 25, 25, 25, 25, 25, 255, 25, 25, 255, 
		25, 25, 25, 25, 25, 16, 19, 25, 25, 25, 25, 25, 255, 25, 25, 
		255, 25, 25, 25, 25, 25, 8, 22, 25, 25, 25, 25, 25, 255, 25, 
		25, 255, 25, 25, 25, 25, 25, 16, 24, 25, 25, 25, 25, 25, 
		255, 25, 25, 255, 255, 255, 255, 255, 255, 255, 255, 255, 
		255, 255, 255, 255, 255, 25, 25, 25, 25, 25, 25, 25, 25, 25, 
		25, 25, 25, 25, 25, 25, 25, 25, 0, 0, 255, 255, 0, 0, 255, 
		255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 
		255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 
		0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 
		0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 40, 0, 0, 0, 
		32, 0, 0, 0, 64, 0, 0, 0, 1, 0, 4, 0, 0, 0, 0, 0, 128, 2, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 128, 0, 0, 128, 0, 0, 0, 128, 128, 0, 128, 0, 0, 0, 
		128, 0, 128, 0, 128, 128, 0, 0, 192, 192, 192, 0, 128, 128, 
		128, 0, 0, 0, 255, 0, 0, 255, 0, 0, 0, 255, 255, 0, 255, 0, 
		0, 0, 255, 0, 255, 0, 255, 255, 0, 0, 255, 255, 255, 0, 145, 
		145, 145, 145, 145, 145, 145, 145, 145, 145, 145, 145, 145, 
		145, 145, 145, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 
		25, 25, 25, 25, 25, 145, 255, 255, 255, 255, 255, 255, 255, 
		255, 255, 255, 255, 255, 255, 255, 145, 25, 249, 25, 25, 24, 
		249, 25, 25, 25, 25, 25, 25, 25, 25, 31, 25, 145, 241, 145, 
		145, 145, 255, 159, 145, 145, 129, 159, 145, 145, 145, 159, 
		145, 25, 249, 25, 25, 25, 127, 31, 25, 31, 249, 255, 121, 
		25, 25, 31, 25, 145, 241, 145, 145, 145, 159, 113, 247, 255, 
		159, 255, 145, 145, 145, 159, 145, 25, 249, 25, 25, 25, 31, 
		249, 255, 249, 119, 249, 25, 25, 25, 31, 25, 145, 241, 145, 
		145, 145, 145, 241, 152, 145, 255, 241, 145, 145, 145, 159, 
		145, 25, 249, 25, 25, 25, 31, 247, 25, 24, 127, 25, 25, 25, 
		25, 31, 25, 145, 241, 145, 145, 145, 145, 255, 255, 135, 
		127, 145, 145, 145, 145, 159, 145, 25, 249, 25, 25, 25, 25, 
		31, 127, 255, 249, 25, 25, 25, 25, 31, 25, 145, 241, 145, 
		145, 145, 145, 159, 145, 127, 255, 145, 145, 145, 145, 159, 
		145, 25, 249, 25, 25, 25, 25, 127, 121, 119, 121, 25, 25, 
		25, 25, 31, 25, 145, 241, 145, 145, 145, 145, 159, 247, 255, 
		145, 145, 145, 145, 145, 159, 145, 25, 249, 25, 25, 25, 25, 
		25, 255, 255, 25, 25, 25, 25, 25, 31, 25, 145, 241, 145, 
		145, 145, 145, 145, 241, 255, 247, 145, 145, 145, 145, 159, 
		145, 25, 249, 25, 25, 25, 25, 25, 249, 248, 25, 25, 25, 25, 
		25, 31, 25, 145, 241, 145, 145, 145, 145, 145, 241, 241, 
		145, 145, 145, 145, 145, 159, 145, 25, 249, 25, 25, 25, 25, 
		25, 247, 249, 25, 25, 25, 25, 25, 31, 25, 145, 241, 145, 
		145, 145, 145, 145, 151, 241, 145, 145, 145, 145, 145, 159, 
		145, 25, 249, 25, 25, 25, 25, 25, 23, 249, 25, 25, 25, 25, 
		25, 31, 25, 145, 241, 145, 145, 145, 145, 145, 159, 113, 
		145, 145, 145, 145, 145, 159, 145, 25, 249, 25, 25, 25, 25, 
		25, 31, 121, 25, 25, 25, 25, 25, 31, 25, 145, 241, 145, 145, 
		145, 145, 145, 159, 145, 145, 145, 145, 145, 145, 159, 145, 
		25, 249, 25, 25, 25, 25, 25, 255, 121, 25, 25, 25, 25, 25, 
		31, 25, 145, 241, 145, 145, 145, 145, 145, 159, 113, 145, 
		145, 145, 145, 145, 159, 145, 25, 249, 25, 25, 25, 25, 25, 
		31, 25, 25, 25, 25, 25, 25, 31, 25, 145, 241, 145, 145, 145, 
		145, 145, 159, 145, 145, 145, 145, 145, 145, 159, 145, 25, 
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 
		255, 255, 25, 145, 145, 145, 145, 145, 145, 145, 145, 145, 
		145, 145, 145, 145, 145, 145, 145, 25, 25, 25, 25, 25, 25, 
		25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 40, 0, 0, 0, 32, 0, 0, 0, 64, 0, 0, 0, 1, 0, 8, 0, 0, 0, 
		0, 0, 128, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
		0, 0, 0, 255, 255, 255, 0, 245, 245, 252, 0, 236, 236, 250, 
		0, 231, 231, 249, 0, 220, 220, 246, 0, 210, 210, 244, 0, 
		203, 203, 243, 0, 197, 197, 241, 0, 191, 191, 240, 0, 188, 
		188, 239, 0, 178, 178, 237, 0, 167, 167, 235, 0, 156, 156, 
		232, 0, 155, 155, 231, 0, 140, 140, 228, 0, 130, 130, 226, 
		0, 124, 124, 225, 0, 108, 108, 222, 0, 91, 91, 217, 0, 81, 
		81, 215, 0, 77, 77, 215, 0, 70, 70, 213, 0, 60, 60, 211, 0, 
		51, 51, 209, 0, 50, 50, 207, 0, 44, 44, 208, 0, 46, 46, 207, 
		0, 0, 0, 198, 0, 0, 0, 187, 0, 0, 0, 181, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 255, 255, 
		0, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 
		27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 
		27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 
		27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 
		27, 27, 27, 27, 27, 27, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27, 27, 
		27, 27, 0, 27, 27, 27, 27, 27, 27, 21, 0, 27, 27, 27, 27, 
		27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 0, 
		27, 27, 27, 27, 0, 27, 27, 27, 27, 27, 27, 27, 0, 4, 27, 9, 
		27, 27, 27, 25, 23, 27, 27, 6, 27, 27, 27, 27, 27, 27, 27, 
		0, 27, 27, 27, 27, 0, 27, 27, 27, 27, 27, 27, 27, 16, 0, 27, 
		0, 27, 27, 27, 0, 9, 28, 0, 7, 10, 27, 27, 27, 27, 27, 27, 
		0, 27, 27, 27, 27, 0, 27, 27, 27, 27, 27, 27, 27, 27, 0, 15, 
		22, 0, 14, 0, 0, 28, 0, 5, 0, 27, 27, 27, 27, 27, 27, 27, 0,
		27, 27, 27, 27, 0, 27, 27, 27, 27, 27, 27, 27, 27, 9, 0, 29,
		7, 0, 2, 28, 20, 10, 4, 22, 27, 27, 27, 27, 27, 27, 27, 0,
		27, 27, 27, 27, 0, 27, 27, 27, 27, 27, 27, 27, 27, 27, 0,
		27, 28, 28, 28, 28, 0, 2, 2, 27, 27, 27, 27, 27, 27, 27, 27,
		0, 27, 27, 27, 27, 0, 27, 27, 27, 27, 27, 27, 27, 24, 1, 0,
		12, 28, 28, 28, 23, 10, 0, 27, 27, 27, 27, 27, 27, 27, 27,
		27, 0, 27, 27, 27, 27, 0, 27, 27, 27, 27, 27, 27, 27, 27,
		27, 10, 0, 0, 4, 20, 9, 18, 7, 27, 27, 27, 27, 27, 27, 27,
		27, 27, 0, 27, 27, 27, 27, 0, 27, 27, 27, 27, 27, 27, 27,
		27, 27, 27, 0, 17, 0, 0, 0, 0, 23, 27, 27, 27, 27, 27, 27,
		27, 27, 27, 0, 27, 27, 27, 27, 0, 27, 27, 27, 27, 27, 27,
		27, 27, 27, 28, 0, 22, 28, 14, 0, 0, 0, 27, 27, 27, 27, 27,
		27, 27, 27, 27, 0, 27, 27, 27, 27, 0, 27, 27, 27, 27, 27,
		27, 27, 27, 27, 14, 0, 14, 29, 18, 11, 15, 27, 27, 27, 27,
		27, 27, 27, 27, 27, 27, 0, 27, 27, 27, 27, 0, 27, 27, 27,
		27, 27, 27, 27, 27, 27, 27, 3, 0, 10, 7, 9, 27, 27, 27, 27,
		27, 27, 27, 27, 27, 27, 27, 0, 27, 27, 27, 27, 0, 27, 27,
		27, 27, 27, 27, 27, 27, 27, 27, 27, 0, 0, 0, 0, 27, 27, 27,
		27, 27, 27, 27, 27, 27, 27, 27, 0, 27, 27, 27, 27, 0, 27,
		27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 0, 28, 0, 0, 0, 19,
		27, 27, 27, 27, 27, 27, 27, 27, 27, 0, 27, 27, 27, 27, 0,
		27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 2, 27, 0, 21,
		25, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 0, 27, 27, 27,
		27, 0, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 2, 25, 0,
		27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 0, 27, 27,
		27, 27, 0, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 2,
		18, 0, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 0,
		27, 27, 27, 27, 0, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
		27, 27, 12, 0, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
		27, 0, 27, 27, 27, 27, 0, 27, 27, 27, 27, 27, 27, 27, 27,
		27, 27, 27, 27, 12, 2, 27, 27, 27, 27, 27, 27, 27, 27, 27,
		27, 27, 27, 0, 27, 27, 27, 27, 0, 27, 27, 27, 27, 27, 27,
		27, 27, 27, 27, 27, 27, 6, 13, 27, 27, 27, 27, 27, 27, 27,
		27, 27, 27, 27, 27, 0, 27, 27, 27, 27, 0, 27, 27, 27, 27,
		27, 27, 27, 27, 27, 27, 27, 27, 6, 17, 27, 27, 27, 27, 27,
		27, 27, 27, 27, 27, 27, 27, 0, 27, 27, 27, 27, 0, 27, 27,
		27, 27, 27, 27, 27, 27, 27, 27, 27, 28, 2, 23, 27, 27, 27,
		27, 27, 27, 27, 27, 27, 27, 27, 27, 0, 27, 27, 27, 27, 0,
		27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 0, 0, 12, 27,
		27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 0, 27, 27, 27,
		27, 0, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 4,
		12, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 0, 27,
		27, 27, 27, 0, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
		27, 2, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
		0, 27, 27, 27, 27, 0, 27, 27, 27, 27, 27, 27, 27, 27, 27,
		27, 27, 28, 9, 28, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
		27, 27, 0, 27, 27, 27, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27, 27,
		27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
		27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
		27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
		27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27,
		27, 27, 27, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	};

void c_ev_save_png (char image[], char *path, int array_width, int array_height, int a_width, int a_height, int colormode)
{
	FILE *fp;
    png_structp png_ptr;
    png_infop info_ptr;
    //png_colorp palette;
    png_uint_32 k;
	//png_bytep row_pointers[32];
	png_bytep *row_pointers;
	int pic_depth = 8;

    // Create a new file handle

    fp = fopen (path, "wb");
    if (fp == NULL)
    {
        //Raise Eiffel exception
        printf ("File could not be created\n");
        //return (0);
    }

    png_ptr = png_create_write_struct (PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

    if (png_ptr == NULL)
    {
        // Raise eiffel exception
        printf ("Png Write struct could not be created\n");
        fclose (fp);
        //return (0);
    }

    info_ptr = png_create_info_struct (png_ptr);
    if (info_ptr == NULL)
    {
        printf ("Png info struct could not be created\n");
        fclose (fp);
        png_destroy_write_struct (&png_ptr, (png_infopp)NULL);
        //return (0);
    }

    if (setjmp (png_ptr->jmpbuf))
    {
        //Eiffel exception, file could not be read
        fclose (fp);
        png_destroy_write_struct (&png_ptr, (png_infopp)NULL);
        //return (0);
    }

   // Set up output control using c streams
    png_init_io (png_ptr, fp);

    //Set up PNG header info
    png_set_IHDR (
        png_ptr,
        info_ptr,
        a_width,
        a_height,
        pic_depth,
        PNG_COLOR_TYPE_RGB_ALPHA,
        PNG_INTERLACE_NONE,
        PNG_COMPRESSION_TYPE_BASE,
        PNG_FILTER_TYPE_BASE
    );
	
    png_write_info (png_ptr, info_ptr);
	row_pointers = malloc (array_height*sizeof (png_bytep));
    for (k = 0; k < array_height; k++){
	row_pointers[k] = (png_bytep) ((png_byte *)image +k* (array_width * 4));
      //printf ("Pointer value is %p\n", row_pointers[k]);
    }

//png_write_rows (png_ptr, (png_bytepp) &image, array_height);

	png_write_image (png_ptr, row_pointers);
    png_write_end (png_ptr, info_ptr);

    //memory deallocation
    fclose (fp);
    png_destroy_write_struct (&png_ptr, &info_ptr);
	free (row_pointers);
  //  return (0);

}


/*---------------------------------------------------------------------------*/
/* FUNC: c_ev_load_pixmap                                                    */
/* ARGS: - pszFileName: name of the graphical file to load.                  */
/*         if NULL, then the default EiffelVision2 icon is loaded            */
/*---------------------------------------------------------------------------*/
void c_ev_load_pixmap(
#ifndef EIF_IL_DLL
		void *pCurrObject, 
#endif
		char *pszFileName, 
		void *fnptr
		)
	{
	FILE *pFile;
	void (*LoadPixmapUpdateObject)(
#ifndef EIF_IL_DLL
			void*,
#endif
			unsigned int,
			unsigned int,
			unsigned int,
			unsigned int,
			void*,
			void*
		);
	unsigned char*	pBuffer;
	BufferedFile	stBufFile;
	unsigned char	nFileFormat; /* File format found: one of FILEFORMAT_XXXX */
	LoadPixmapCtx	stCtx;
	unsigned char	bFileToBeDeleted = FALSE;
	int				bFreeFileName = FALSE;
	
	LoadPixmapUpdateObject = (void (*) (
#ifndef EIF_IL_DLL
			void*,
#endif
			unsigned int,
			unsigned int,
			unsigned int,
			unsigned int,
			void*,
			void*
		)) fnptr;

	if (pszFileName == NULL)
		{
		/* Load the default Vision2 icon */
#ifdef EIF_WIN32
		char szTempDir[TEMP_PATH_MAX_LENGTH];
		char szPrefix[TEMP_PATH_MAX_LENGTH];
		if (GetTempPath(TEMP_PATH_MAX_LENGTH, szTempDir) == 0)
			{
			/* Function failed, Set szTempDir to Current directory. */
			strcpy (szTempDir, ".");
			}
		/* We got the path, now get the filename */
		strcpy (szPrefix, "vision2_");
		pszFileName = (char *) malloc (MAX_PATH);
		bFreeFileName = TRUE;
		if (GetTempFileName(szTempDir, szPrefix, 0, pszFileName)==0)
			{
			free(pszFileName);
			bFreeFileName = FALSE;

			/* Function failed, use "tmpnam" instead */
			pszFileName = tmpnam(NULL);
			}
		
		/* Open the temporary file */
		pFile = fopen ((const char *)pszFileName, "w+b");
		if (pFile==NULL && bFreeFileName==TRUE)
			{
			/* Unable to open temporary file created with GetTempFileName,
			 * try "tmpnam"
			 */
			free(pszFileName);
			bFreeFileName = FALSE;

			/* Function failed, use "tmpnam" instead */
			pszFileName = tmpnam(NULL);

			/* Open the temporary file */
			pFile = fopen ((const char *)pszFileName, "w+b");
			}

		if (pFile == NULL)
			{
			/* Unable to create the file, return NULL */
			LoadPixmapUpdateObject(
#ifndef EIF_IL_DLL
				pCurrObject,
#endif
				LOADPIXMAP_ERROR_UNABLE_OPEN_FILE,
				0,
				0,
				0,
				NULL,
				NULL);
			return;
			}
		bFileToBeDeleted = TRUE;
		fwrite (default_vision2_icon_for_windows, 1, sizeof (default_vision2_icon_for_windows), pFile);
#else
		pFile = tmpfile(); /* create a temporary file */
		fwrite (default_vision2_icon, 1, sizeof (default_vision2_icon), pFile);
#endif /* EIF_WIN32 */
		fseek (pFile, 0, SEEK_SET);
		}
	else
		{
		/* Open the file */
		pFile = fopen ((const char *)pszFileName, "rb");
		if (pFile == NULL)
			{
			/* Unable to open the file, return NULL */
			LoadPixmapUpdateObject(
#ifndef EIF_IL_DLL
				pCurrObject,
#endif
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

	/* Setup the buffered file */
	pBuffer = malloc(BUFFER_SIZE*sizeof(unsigned char));
	if (pBuffer == NULL)
		{
		/* Out of memory */
		LoadPixmapUpdateObject(
#ifndef EIF_IL_DLL
			pCurrObject,
#endif
			LOADPIXMAP_ERROR_OUTOFMEMORY,
			0,
			0,
			0,
			NULL,
			NULL);
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
			/* close the graphical file or the temporary file */
			fclose (pFile);
#ifdef EIF_WIN32
			stCtx.LoadPixmapUpdateObject = LoadPixmapUpdateObject;
#ifndef EIF_IL_DLL
			stCtx.pCurrObject = pCurrObject;
#endif
			stCtx.pszFileName = pszFileName;
			c_ev_load_windows_file(IMAGE_ICON, &stCtx);
#else
			/* ICO files are currently not supported under Unix */
			LoadPixmapUpdateObject(
#ifndef EIF_IL_DLL
				pCurrObject,
#endif
				LOADPIXMAP_ERROR_UNKNOWN_FILEFORMAT,
				0,
				0,
				0,
				NULL,
				NULL
			);
#endif
			if (bFileToBeDeleted)
				unlink(pszFileName);
			if (bFreeFileName)
				free(pszFileName);
			return;

		/* Windows BMP file format */
		case FILEFORMAT_BMP:
			/* close the graphical file or the temporary file */
			fclose (pFile);
#ifdef EIF_WIN32
			stCtx.LoadPixmapUpdateObject = LoadPixmapUpdateObject;
#ifndef EIF_IL_DLL
			stCtx.pCurrObject = pCurrObject;
#endif
			stCtx.pszFileName = pszFileName;
			c_ev_load_windows_file(IMAGE_BITMAP, &stCtx);
#else
			/* BMP files are currently not supported under Unix */
			LoadPixmapUpdateObject(
#ifndef EIF_IL_DLL
				pCurrObject,
#endif
				LOADPIXMAP_ERROR_UNKNOWN_FILEFORMAT,
				0,
				0,
				0,
				NULL,
				NULL
			);
#endif
			if (bFileToBeDeleted)
				unlink(pszFileName);
			if (bFreeFileName)
				free(pszFileName);
			return;

		case FILEFORMAT_PNG:
			stCtx.LoadPixmapUpdateObject = LoadPixmapUpdateObject;
#ifndef EIF_IL_DLL
			stCtx.pCurrObject = pCurrObject;
#endif
			stCtx.pszFileName = pszFileName;
			stCtx.pFile = pFile;
			c_ev_load_png_file(&stCtx);
			/* close the graphical file or the temporary file */
			fclose (pFile);
			if (bFileToBeDeleted)
				unlink(pszFileName);
			if (bFreeFileName)
				free(pszFileName);
			return;

		default:
			/* Bad file format */
			LoadPixmapUpdateObject(
#ifndef EIF_IL_DLL
				pCurrObject,
#endif
				LOADPIXMAP_ERROR_UNKNOWN_FILEFORMAT,
				0,
				0,
				0,
				NULL,
				NULL
			);
			/* close the graphical file or the temporary file */
			fclose (pFile);
			if (bFileToBeDeleted)
				unlink(pszFileName);
			if (bFreeFileName)
				free(pszFileName);
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

		{
			int j = ftell (pBufFile->pFile);
			int i = j;
		}

	nBytesRead = fread(pBufFile->pBuffer + pBufFile->nCurrBufferSize, 1, 
				       (size_t) nBytesToRead, pBufFile->pFile);
	
	/* Compute the new buffer size */
	pBufFile->nCurrBufferSize += nBytesRead;

		{
			int j = ftell (pBufFile->pFile);
			int i = j;
		}


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
			NULL,				/* handle to instance */
			pCtx->pszFileName,	/* name or identifier of the image  */
			nWindowsType,		/* image type */
			0,					/* desired width */
			0,					/* desired height */
			LR_LOADFROMFILE		/* load options */
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
#ifndef EIF_IL_DLL
				pCtx->pCurrObject,
#endif
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
#ifndef EIF_IL_DLL
				pCtx->pCurrObject,
#endif
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
				pBits = malloc(nBitmapSize);/* Allocate space for the mask */
				memset(pBits, 0, nBitmapSize);/* Set the mask to be empty */
				hbmMask = CreateBitmap (
							bmInfo.bmWidth,	/* Same width as the bitmap */
							bmInfo.bmHeight,/* Same height as the bitmap */
							1, 				/* number of color planes */
							1,				/* number of bits/pixel */
							pBits			/* color data array. */
						);
				free (pBits);
				if (hbmMask==NULL)
					nErrorCode = LOADPIXMAP_ERROR_UNKNOWN_ERROR;
				}
			else
				nErrorCode = LOADPIXMAP_ERROR_UNKNOWN_ERROR;
	
			/* Call the Eiffel routine back. */
			(pCtx->LoadPixmapUpdateObject)(
#ifndef EIF_IL_DLL
				pCtx->pCurrObject,
#endif
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
	long iOff = iData / 8;	/* Offset of the bit in byte */
#ifdef EIF_WIN32
	long iBitPos = 7 - (iData % 8);		/* Position of the bit within the byte */
#else
	long iBitPos = iData % 8;		/* Position of the bit within the byte */
#endif
	unsigned char bitValue;

	bitValue = (unsigned char)(1 << iBitPos);
#ifdef EIF_WIN32
	if (bit == 0)
#else
	if (bit == 1)
#endif
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
	FILE 			*fp;			/* Current opened file */
	unsigned char 	**ppImage;		/* Pointer on an array of scan lines */
	unsigned char 	*pData;			/* Pointer on the RGB data */
	unsigned char 	*pImage;		/* Pointer on a DIB structure */
	unsigned char 	*pAlphaData;	/* Pointer on the Alpha data */
	unsigned char 	*pAlphaImage;	/* Pointer on a DIB structure */
	volatile unsigned char	bAlphaImage = FALSE;/* Is there a mask for this image? */
	volatile unsigned long 	iAlphaData = 0;
#ifdef EIF_WIN32
	unsigned long 	iData;
#endif
	unsigned long 	sRowSize;		/* Size in bytes of a scan line */
	unsigned long 	row;			/* Current scan line */
	volatile unsigned long	nErrorCode = LOADPIXMAP_ERROR_NOERROR;

	/* Retrieve File Stream */
	fp = pCtx->pFile;
	if (fp == NULL)
		return;
	/* reset the file pointer */
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
		return;
		}

	/* Allocate/initialize the memory for image information.  REQUIRED. */
	info_ptr = png_create_info_struct(png_ptr);
	if (info_ptr == NULL)
		{
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

#ifdef EIF_WIN32
	sRowSize = 4 * ((width * 24 + 31) / 32);
	pImage = (unsigned char *) malloc(sRowSize * height + 40);
	pData = pImage;
	iData = 0;

	sRowSize = 4 * ((width + 31) / 32);
	pAlphaImage = (unsigned char *) malloc(sRowSize * height + 40 + 8);
	pAlphaData = pAlphaImage;

	/* Create a Windows DIB Header for the color bitmap */
	*((DWORD *)pData) = 40;			pData += 4;				/* Size of header */
	*((DWORD *)pData) = width;		pData += 4;				/* width in pixel */
	*((DWORD *)pData) = height;		pData += 4;				/* height in pixel */
	*((WORD *)pData) = 1;			pData += 2;				/* bit plane */
	*((WORD *)pData) = 24;			pData += 2;				/* bits/pixel */
	*((DWORD *)pData) = BI_RGB;		pData += 4;				/* compression */
	*((DWORD *)pData) = 0;			pData += 4;				/* imageSize */
	*((DWORD *)pData) = 0;			pData += 4;				/* XPelPerM */
	*((DWORD *)pData) = 0;			pData += 4;				/* YPelPerM */
	*((DWORD *)pData) = 0;			pData += 4;				/* ClrUsed */
	*((DWORD *)pData) = 0;			pData += 4;				/* ClrImportant */

	/* Create a Windows DIB Header for the mask bitmap */
	*((DWORD *)pAlphaData) = 40;		pAlphaData += 4;	/* size of header */
	*((DWORD *)pAlphaData) = width;		pAlphaData += 4;	/* width in pixel */
	*((DWORD *)pAlphaData) = height;	pAlphaData += 4;	/* height in pixel */
	*((WORD *)pAlphaData) = 1;			pAlphaData += 2;	/* bit plane */
	*((WORD *)pAlphaData) = 1;			pAlphaData += 2;	/* bits/pixel */
	*((DWORD *)pAlphaData) = BI_RGB;	pAlphaData += 4;	/* compression */
	*((DWORD *)pAlphaData) = 0;			pAlphaData += 4;	/* imageSize */
	*((DWORD *)pAlphaData) = 0;			pAlphaData += 4;	/* XPelPerM */
	*((DWORD *)pAlphaData) = 0;			pAlphaData += 4;	/* YPelPerM */
	*((DWORD *)pAlphaData) = 2;			pAlphaData += 4;	/* ClrUsed */
	*((DWORD *)pAlphaData) = 2;			pAlphaData += 4;	/* ClrImportant */
	/* Color Table */
	*((DWORD *)pAlphaData) = 0x00000000;pAlphaData += 4;	/* Index 0 (black) */
	*((DWORD *)pAlphaData) = 0x00FFFFFF;pAlphaData += 4;	/* Index 1 (white) */


	for (row = height; row > 0; row--)
		{
		unsigned char *pSrc = ppImage[row-1];
		unsigned long nAlign;
		unsigned long iAlign;
		unsigned long column;

		for (column = 0; column < width; column++)
			{
			/* Copy the RGB data */
			*(pData + iData + 0) = *(pSrc + 2);	/* B */
			*(pData + iData + 1) = *(pSrc + 1);	/* G */
			*(pData + iData + 2) = *(pSrc + 0);	/* R */

			/* Copy the alpha channel */
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
#else
	pImage = (unsigned char *) malloc(width * height * 3);
	pData = pImage;

	pAlphaImage = (unsigned char *) malloc(height * (1 + (width >> 3)));
	pAlphaData = pAlphaImage;

	for (row = 0; row < height; row++)
		{
		unsigned char *pSrc = ppImage[row];
		unsigned long column;
		unsigned long nAlign;
		unsigned long iAlign;

		for (column = 0; column < width; column++)
			{
			/* Copy the RGB data */
			memcpy(pData, pSrc, 3);
			pData += 3;

			/* Copy the alpha channel */
			if (*(pSrc + 3) > 0x7F)
				c_ev_set_bit(0, pAlphaData, iAlphaData);
			else
				{
				c_ev_set_bit(1, pAlphaData, iAlphaData);
				bAlphaImage = TRUE;
				}

			pSrc += 4;
			iAlphaData++;
			}

		/* Align line to BYTE padding - Alpha data */
		nAlign = (8 - width%8) % 8;
		for (iAlign = 0; iAlign < nAlign; iAlign++)
			{
			c_ev_set_bit(0, pAlphaData, iAlphaData);
			iAlphaData++;
			}
		}

#endif /* EIF_WIN32 */

	/* The mast is empty, remove it */
	if (bAlphaImage == FALSE)
		{
		free (pAlphaImage);
		pAlphaImage = NULL;
		}
	
	/* Free the memory */
	for (row = 0; row < height; row++)
		{
		free(ppImage[row]);
		}
	free(ppImage);

	/* Call the Eiffel routine back */
	(pCtx->LoadPixmapUpdateObject)(
#ifndef EIF_IL_DLL
		pCtx->pCurrObject,
#endif
		nErrorCode,
		LOADPIXMAP_RGB_DATA,
		width,
		height,
		pImage,
		pAlphaImage
	);

	/* Free the image occupied by the image & the mask. */
	if (pImage != NULL)
		free(pImage);
	
	if (pAlphaImage != NULL)
		free(pAlphaImage);

	/* that's it */
	return;
	}

/*<HACK>*/
/*FIXME this puts milliseconds into 32 bit, it doesn't last long.*/
unsigned long time_msec (void)
{
	struct timeb tb;
	static time_t begining = 0;
	if (!begining) begining = time (NULL);
	ftime (&tb);
	return (((tb.time - begining) * 1000) + tb.millitm);
}

/*</HACK>*/
