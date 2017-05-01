/*
indexing
	description: "[
			WEL: library of reusable components for Windows.
			Custom wrapper of GDI+ runtime and structures as most C compilers do not come with
			the `gdiplus.h' header file handy. The code below gives enough to use GDI+ through
			DLL calls.
		]"
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

#ifdef __cplusplus
extern "C" {
#endif

#ifndef _GDIPLUS_H
#define _GDIPLUS_H

#include "wel.h"
#include <ole2.h>

typedef void GpBitmap;
typedef void GpMetafile;
typedef void GpImage;
typedef void GpGraphics;
typedef void GpPen;
typedef void GpImageAttributes;
typedef void GpFont;
typedef void GpFontFamily;
typedef void GpFontCollection;
typedef void GpStringFormat;
typedef void GpBrush;
typedef void GpTexture;
typedef void GpSolidFill;
typedef void GpPath;
typedef GUID CLSID;
typedef void  EncoderParameters;
typedef int GpMatrixOrder;

typedef int PixelFormat;
typedef unsigned short UINT16;

#define  WINGDIPAPI __stdcall

typedef struct {
	int X, Y, Width, Height;
} GpRect;

typedef struct {
	float X, Y, Width, Height;
} RectF;

typedef struct {   
	unsigned int Width;
	unsigned int Height;
	int          Stride;
	int          PixelFormat;
	void         *Scan0;
	unsigned int Reserved;
} BitmapData;	

typedef DWORD ARGB;

typedef struct {
	GUID Guid;
	ULONG NumberOfValues;
	ULONG Type;
	void *Value;
} ImageEncoderParameter;

typedef struct {
	int X;
	int Y;
}GpPoint;

#define GDIPCONST const

typedef enum Status
{
    Ok = 0,
    GenericError = 1,
    InvalidParameter = 2,
    OutOfMemory = 3,
    ObjectBusy = 4,
    InsufficientBuffer = 5,
    NotImplemented = 6,
    Win32Error = 7,
    WrongState = 8,
    Aborted = 9,
    FileNotFound = 10,
    ValueOverflow = 11,
    AccessDenied = 12,
    UnknownImageFormat = 13,
    FontFamilyNotFound = 14,
    FontStyleNotFound = 15,
    NotTrueTypeFont = 16,
    UnsupportedGdiplusVersion = 17,
    GdiplusNotInitialized = 18,
    PropertyNotFound = 19,
    PropertyNotSupported = 20
} GpStatus;

typedef enum
{
    Tile = 0,
    TileFlipX = 1,
    TileFlipY = 2,
    TileFlipXY = 3,
    Clamp = 4,	
} GpWrapMode;

typedef enum
{
    UnitWorld, 
    UnitDisplay,
    UnitPixel,   
    UnitPoint,    
    UnitInch,      
    UnitDocument,   
    UnitMillimeter  
} GpUnit, Unit;

typedef enum ColorAdjustTypeEnum
{
    ColorAdjustTypeDefault,
    ColorAdjustTypeBitmap,
    ColorAdjustTypeBrush,
    ColorAdjustTypePen,
    ColorAdjustTypeText,
    ColorAdjustTypeCount,
    ColorAdjustTypeAny      
}ColorAdjustType;

typedef enum ColorMatrixFlagsEnum
{
    ColorMatrixFlagsDefault   = 0,
    ColorMatrixFlagsSkipGrays = 1,
    ColorMatrixFlagsAltGray   = 2
}ColorMatrixFlags;

typedef enum CombineModeEnum
{
	Replace= 0,
	Intersect = 1,
	Union = 2,
	Xor_mode = 3,
	Exclude = 4,
	Complement = 5
}CombineMode;

typedef enum GpFillModeEnum
{
	Alternate = 0,
	Winding =1
}GpFillMode;

typedef enum
{
	FlushIntentionFlush = 0,
	FlushIntentionSync = 1
}GpFlushIntention;

typedef float REAL;

#define    PixelFormatIndexed      0x00010000 
#define    PixelFormatGDI          0x00020000 
#define    PixelFormatAlpha        0x00040000 
#define    PixelFormatPAlpha       0x00080000 
#define    PixelFormatExtended     0x00100000 
#define    PixelFormatCanonical    0x00200000 

#define    PixelFormat1bppIndexed     (1 | ( 1 << 8) | PixelFormatIndexed | PixelFormatGDI)
#define    PixelFormat24bppRGB        (8 | (24 << 8) | PixelFormatGDI)
#define    PixelFormat32bppRGB        (9 | (32 << 8) | PixelFormatGDI)
#define    PixelFormat32bppARGB       (10 | (32 << 8) | PixelFormatAlpha | PixelFormatGDI | PixelFormatCanonical)
#define    PixelFormat32bppPARGB      (11 | (32 << 8) | PixelFormatAlpha | PixelFormatPAlpha | PixelFormatGDI)

enum MetafileType
{
    MetafileTypeInvalid,            // Invalid metafile
    MetafileTypeWmf,                // Standard WMF
    MetafileTypeWmfPlaceable,       // Placeable WMF
    MetafileTypeEmf,                // EMF (not EMF+)
    MetafileTypeEmfPlusOnly,        // EMF+ without dual, down-level records
    MetafileTypeEmfPlusDual         // EMF+ with dual, down-level records
};

typedef struct
{
    DWORD   iType;              // Record type EMR_HEADER
    DWORD   nSize;              // Record size in bytes.  This may be greater
                                // than the sizeof(ENHMETAHEADER).
    RECTL   rclBounds;          // Inclusive-inclusive bounds in device units
    RECTL   rclFrame;           // Inclusive-inclusive Picture Frame .01mm unit
    DWORD   dSignature;         // Signature.  Must be ENHMETA_SIGNATURE.
    DWORD   nVersion;           // Version number
    DWORD   nBytes;             // Size of the metafile in bytes
    DWORD   nRecords;           // Number of records in the metafile
    WORD    nHandles;           // Number of handles in the handle table
                                // Handle index zero is reserved.
    WORD    sReserved;          // Reserved.  Must be zero.
    DWORD   nDescription;       // Number of chars in the unicode desc string
                                // This is 0 if there is no description string
    DWORD   offDescription;     // Offset to the metafile description record.
                                // This is 0 if there is no description string
    DWORD   nPalEntries;        // Number of entries in the metafile palette.
    SIZEL   szlDevice;          // Size of the reference device in pels
    SIZEL   szlMillimeters;     // Size of the reference device in millimeters
} ENHMETAHEADER3;

#ifdef __cplusplus
}

typedef struct
{
    MetafileType        Type;
    UINT                Size;               // Size of the metafile (in bytes)
    UINT                Version;            // EMF+, EMF, or WMF version
    UINT                EmfPlusFlags;
    REAL                DpiX;
    REAL                DpiY;
    INT                 X;                  // Bounds in device units
    INT                 Y;
    INT                 Width;
    INT                 Height;
    union
    {
        METAHEADER      WmfHeader;
        ENHMETAHEADER3  EmfHeader;
    };
    INT                 EmfPlusHeaderSize;  // size of the EMF+ header in file
    INT                 LogicalDpiX;        // Logical Dpi of reference Hdc
    INT                 LogicalDpiY;        // usually valid only for EMF+
} MetafileHeader;

extern "C" {
#endif

#endif // !_GDIPLUS_H

#ifndef _GDIPLUSCOLORMATRIX_H
#define _GDIPLUSCOLORMATRIX_H

typedef struct ColorMatrixStruct
{
    REAL m[5][5];
}ColorMatrix;

#endif // !_GDIPLUSCOLORMATRIX_H

#ifndef _GDIPLUSINIT_H
#define _GDIPLUSINIT_H

enum DebugEventLevel
{
    DebugEventLevelFatal,
    DebugEventLevelWarning
};

typedef VOID (WINAPI *DebugEventProc)(enum DebugEventLevel level, CHAR *message);

typedef enum Status (WINAPI *NotificationHookProc)(OUT ULONG_PTR *token);
typedef VOID (WINAPI *NotificationUnhookProc)(ULONG_PTR token);

typedef struct GdiplusStartupInputStruct
{
    UINT32 GdiplusVersion;             
    DebugEventProc DebugEventCallback; 
    BOOL SuppressBackgroundThread;     
    BOOL SuppressExternalCodecs; 
}GdiplusStartupInput;

typedef struct GdiplusStartupOutputStruct
{
    NotificationHookProc NotificationHook;
    NotificationUnhookProc NotificationUnhook;
}GdiplusStartupOutput;

#endif //!_GDIPLUSINIT_H

#ifndef _GDIPLUSTYPES_H
#define _GDIPLUSTYPES_H

typedef BOOL (CALLBACK * ImageAbort)(VOID *);
typedef ImageAbort DrawImageAbort;
typedef ImageAbort GetThumbnailImageAbort;

#endif // !_GDIPLUSTYPES_H

#ifndef GUID_DEFINED
#define GUID_DEFINED
#if defined(__midl)
typedef struct {
    unsigned long  Data1;
    unsigned short Data2;
    unsigned short Data3;
    byte           Data4[ 8 ];
} GUID;
#else
typedef struct _GUID {
    unsigned long  Data1;
    unsigned short Data2;
    unsigned short Data3;
    unsigned char  Data4[ 8 ];
} GUID;
#endif
#endif

#ifndef ImageCodecInfoDefined
#define ImageCodecInfoDefined
typedef struct _ImageCodecInfo
{
    CLSID Clsid;
    GUID  FormatID;
    const WCHAR* CodecName;
    const WCHAR* DllName;
    const WCHAR* FormatDescription;
    const WCHAR* FilenameExtension;
    const WCHAR* MimeType;
    DWORD Flags;
    DWORD Version;
    DWORD SigCount;
    DWORD SigSize;
    const BYTE* SigPattern;
    const BYTE* SigMask;
} ImageCodecInfo;
#endif

#ifdef __cplusplus
}
#endif

