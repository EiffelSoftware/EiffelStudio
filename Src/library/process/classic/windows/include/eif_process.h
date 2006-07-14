/*
indexing
	description: "[	
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

#ifndef _EIF_PROCESS
#define _EIF_PROCESS


typedef struct _EIF_PEB {
    BYTE Reserved1[2];
    BYTE BeingDebugged;
    BYTE Reserved2[229];
    PVOID Reserved3[59];
    ULONG SessionId;
} EIF_PEB, *EIF_PPEB;

typedef struct _EIF_PROCESS_BASIC_INFORMATION {
    PVOID Reserved1;
    EIF_PPEB PebBaseAddress;
    PVOID Reserved2[2];
    ULONG UniqueProcessId;
    ULONG InheritedFromUniqueProcessId;
} EIF_PROCESS_BASIC_INFORMATION;

typedef enum _EIF_PROCESSINFOCLASS {
    eif_ProcessBasicInformation = 0,
    eif_ProcessWow64Information = 26
} EIF_PROCESSINFOCLASS;


#endif
