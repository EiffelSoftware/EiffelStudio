#ifndef __PE_WRITER_H_
#define __PE_WRITER_H_

#include "eif_eiffel.h"
#include <windows.h>

#ifdef __cplusplus
extern "C" {
#endif

extern void com_initialize ();
extern EIF_POINTER new_fusion_support ();
extern EIF_POINTER new_cor_runtime_host (LPWSTR version, DWORD flags);
extern EIF_POINTER new_cache_manager ();
extern EIF_POINTER c_get_bstr (EIF_POINTER);
extern void c_free_bstr (EIF_POINTER);
extern EIF_POINTER new_md_dispenser ();
extern EIF_POINTER c_define_scope_for_md_emit (EIF_POINTER);
extern void c_define_option_for_md_emit (EIF_POINTER md_dispenser, EIF_INTEGER val);
extern EIF_POINTER c_query_assembly_emit (EIF_POINTER);
extern EIF_POINTER new_sym_writer ();


/* Defined an Eiffel specific version of IMAGE_COR20_HEADER in case one does not
 * have the latest version of the platform SDK. */
typedef struct _CLI_IMAGE_COR20_HEADER {
	// Header versioning
	DWORD	cb;
	WORD	MajorRuntimeVersion;
	WORD	MinorRuntimeVersion;
	
	// Symbol table and startup information
	IMAGE_DATA_DIRECTORY	MetaData;	
	DWORD	Flags;	
	DWORD	EntryPointToken;
	
	// Binding information
	IMAGE_DATA_DIRECTORY	Resources;
	IMAGE_DATA_DIRECTORY	StrongNameSignature;

	// Regular fixup and binding information
	IMAGE_DATA_DIRECTORY	CodeManagerTable;
	IMAGE_DATA_DIRECTORY	VTableFixups;
	IMAGE_DATA_DIRECTORY	ExportAddressTableJumps;

	// Precompiled image info (internal use only - set to zero)
	IMAGE_DATA_DIRECTORY	ManagedNativeHeader;
} CLI_IMAGE_COR20_HEADER;

typedef struct _CLI_IMPORT_TABLE {
  DWORD ImportLookupTable;// RVA to ImportLookupTable
  DWORD TimeDateStamp;  // 0
  DWORD ForwarderChain; // 0
  DWORD NameRVA;      // RVA to null terminated ASCII string "mscoree.dll"
  DWORD IatRVA;     // RVA to IAT
  BYTE Padding1 [20];   // Filled with 0
  DWORD ImportByNameRVA;  // RVA to null terminated ASCII string "_CorDllMain" or "_CorExeMain"
  BYTE Padding3 [6];
  char EntryPointName [12];
  char LibraryName [12];
} CLI_IMPORT_TABLE;

typedef struct _CLI_IMPORT_ADDRESS_TABLE {
  DWORD ImportByNameRVA;  // RVA to ImportByName table.
  BYTE Padding [4];
} CLI_IMPORT_ADDRESS_TABLE;

typedef struct _CLI_IMAGE_RELOCATION {
  DWORD BlockRVA;   // RVA of section in which fixup needs to be applied.
  DWORD BlockSize;  // 0x0C
  WORD Fixup;     // Fixup location from `BlockRVA'.
  BYTE Padding [2];
} CLI_IMAGE_RELOCATION;

typedef struct _CLI_ENTRY {
  BYTE Padding [2];
  BYTE JumpInstH;   // 0xFF
  BYTE JumpInstL;   // 0x25
  DWORD IAT_RVA;    // RVA to IAT
} CLI_ENTRY;

typedef struct _CLI_IMAGE_OPTIONAL_HEADER {
    //
    // Standard fields.
    //

    WORD    Magic;
    BYTE    MajorLinkerVersion;
    BYTE    MinorLinkerVersion;
    DWORD   SizeOfCode;
    DWORD   SizeOfInitializedData;
    DWORD   SizeOfUninitializedData;
    DWORD   AddressOfEntryPoint;
    DWORD   BaseOfCode;
    DWORD   BaseOfData;

    //
    // NT additional fields.
    //

    DWORD   ImageBase;
    DWORD   SectionAlignment;
    DWORD   FileAlignment;
    WORD    MajorOperatingSystemVersion;
    WORD    MinorOperatingSystemVersion;
    WORD    MajorImageVersion;
    WORD    MinorImageVersion;
    WORD    MajorSubsystemVersion;
    WORD    MinorSubsystemVersion;
    DWORD   Win32VersionValue;
    DWORD   SizeOfImage;
    DWORD   SizeOfHeaders;
    DWORD   CheckSum;
    WORD    Subsystem;
    WORD    DllCharacteristics;
    DWORD   SizeOfStackReserve;
    DWORD   SizeOfStackCommit;
    DWORD   SizeOfHeapReserve;
    DWORD   SizeOfHeapCommit;
    DWORD   LoaderFlags;
    DWORD   NumberOfRvaAndSizes;
    IMAGE_DATA_DIRECTORY DataDirectory[IMAGE_NUMBEROF_DIRECTORY_ENTRIES];
} CLI_IMAGE_OPTIONAL_HEADER;


#ifdef __cplusplus
}
#endif

#endif
