/*
	description:

		"C declarations for the Gobo Eiffel runtime."

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2005-2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef GE_EIFFEL_H
#define GE_EIFFEL_H

#if defined(__USE_POSIX) || defined(__unix__) || defined(_POSIX_C_SOURCE)
#include <unistd.h>
#endif
#if !defined(WIN32) && \
	(defined(WINVER) || defined(_WIN32_WINNT) || defined(_WIN32) || \
	defined(__WIN32__) || defined(__TOS_WIN__) || defined(_MSC_VER) || \
	defined(__MINGW32__))
#define WIN32 1
#endif
#ifdef WIN32
#define EIF_WINDOWS 1
#include <windows.h>
#endif

#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>

/* Platform definition */
/* Unix definition */
#define EIF_IS_UNIX EIF_TRUE
/* Windows definition */
#ifdef EIF_WINDOWS
#define EIF_IS_WINDOWS EIF_TRUE
#undef EIF_IS_UNIX
#define EIF_IS_UNIX EIF_FALSE
#else
#define EIF_IS_WINDOWS EIF_FALSE
#endif
/* VMS definition */
#ifdef EIF_VMS
#define EIF_IS_VMS EIF_TRUE
#undef EIF_IS_UNIX
#define EIF_IS_UNIX EIF_FALSE
#else
#define EIF_IS_VMS EIF_FALSE
#endif
/* MAC definition */
#ifdef EIF_MAC
#define EIF_IS_MAC EIF_TRUE
#undef EIF_IS_UNIX
#define EIF_IS_UNIX EIF_FALSE
#else
#define EIF_IS_MAC EIF_FALSE
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef _MSC_VER /* MSVC */
typedef signed char int8_t;
typedef signed short int16_t;
typedef signed int int32_t;
typedef signed __int64 int64_t;
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned __int64 uint64_t;
#else
#if defined (__BORLANDC__) && (__BORLANDC__ < 0x600) /* Borland before 6.0 */
typedef signed char int8_t;
typedef signed short int16_t;
typedef signed long int int32_t;
typedef signed __int64 int64_t;
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned long int uint32_t;
typedef unsigned __int64 uint64_t;
#else
#include <inttypes.h>
#endif
#endif

/* Portable integer pointers */
#ifdef EIF_WINDOWS
#ifndef _INTPTR_T_DEFINED
#define _INTPTR_T_DEFINED
#ifdef _WIN64
typedef __int64 intptr_t;
#else
typedef int intptr_t;
#endif
#endif
#endif

/* Basic Eiffel types */
typedef struct {int id;} EIF_ANY;
#define EIF_REFERENCE EIF_ANY*
typedef char EIF_BOOLEAN;
typedef unsigned char EIF_CHARACTER_8;
typedef uint32_t EIF_CHARACTER_32;
typedef int8_t EIF_INTEGER_8;
typedef int16_t EIF_INTEGER_16;
typedef int32_t EIF_INTEGER_32;
typedef int64_t EIF_INTEGER_64;
typedef uint8_t EIF_NATURAL_8;
typedef uint16_t EIF_NATURAL_16;
typedef uint32_t EIF_NATURAL_32;
typedef uint64_t EIF_NATURAL_64;
typedef void* EIF_POINTER;
typedef float EIF_REAL_32;
typedef double EIF_REAL_64;

#define EIF_VOID ((EIF_REFERENCE)0)
#define EIF_FALSE ((EIF_BOOLEAN)'\0')
#define EIF_TRUE ((EIF_BOOLEAN)'\1')
#define EIF_TEST(x) ((x) ? EIF_TRUE : EIF_FALSE)

/* For INTEGER and NATURAL manifest constants */
#define GE_int8(x) x
#define GE_nat8(x) x
#define GE_int16(x) x
#define GE_nat16(x) x
#define GE_int32(x) x##L
#define GE_nat32(x) x##U
#if defined (_MSC_VER) && (_MSC_VER < 1400) /* MSC older than v8 */
#define GE_int64(x) x##i64
#define GE_nat64(x) x##ui64
#else
#if defined (__BORLANDC__) && (__BORLANDC__ < 0x600) /* Borland before 6.0 */
#define GE_int64(x) x##i64
#define GE_nat64(x) x##ui64
#else /* ISO C 99 */
#define GE_int64(x) x##LL
#define GE_nat64(x) x##ULL
#endif 
#endif 

#ifdef _MSC_VER /* MSVC */
/* MSVC does not support ISO C 99's 'snprintf' from stdio.h */
#define snprintf(a,b,c,d) sprintf(a,c,d)
#endif

/*
	Interoperability with ISE.
*/
#define RTI64C(x) GE_int64(x)
#define EIF_PROCEDURE EIF_POINTER
#define EIF_OBJECT EIF_REFERENCE
#define EIF_OBJ EIF_OBJECT
/* Function pointer call to make sure all arguments are correctly pushed onto stack. */
/* FUNCTION_CAST is for standard C calls. */
/* FUNCTION_CAST_TYPE is for non-standard C calls. */
#define FUNCTION_CAST(r_type,arg_types) (r_type (*) arg_types)
#define FUNCTION_CAST_TYPE(r_type,call_type,arg_types) (r_type (call_type *) arg_types)

#ifdef __cplusplus
}
#endif

#endif

/*
	description:

		"C functions used to implement class ARGUMENTS"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef GE_ARGUMENTS_H
#define GE_ARGUMENTS_H

#ifdef __cplusplus
extern "C" {
#endif

extern int GE_argc;
extern char** GE_argv;

#ifdef __cplusplus
}
#endif

#endif

/*
	description:

		"C functions used to implement class EXCEPTION"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef GE_EXCEPTION_H
#define GE_EXCEPTION_H

#include <setjmp.h>

/*
	On Linux glibc systems, we need to use sig* versions of jmp_buf,
	setjmp and longjmp to preserve the signal handling context.
	One way to detect this is if _SIGSET_H_types has
	been defined in /usr/include/setjmp.h.
	NOTE: ANSI only recognizes the non-sig versions.
*/
#if (defined(_SIGSET_H_types) && !defined(__STRICT_ANSI__))
#define GE_jmp_buf sigjmp_buf
#define GE_setjmp(x) sigsetjmp((x),1)
#define GE_longjmp(x,y) siglongjmp((x),(y))
#else
#define GE_jmp_buf jmp_buf
#define GE_setjmp(x) setjmp((x))
#define GE_longjmp(x,y) longjmp((x),(y))
#endif

#ifdef __cplusplus
extern "C" {
#endif

/*
	Information about the feature being executed.
*/
typedef struct GE_call_struct GE_call;
struct GE_call_struct {
	char* feature_name;
	char* type_name;
	GE_call* caller; /* previous feature in the call chain */
};

/*
	Context of features containing a rescue clause.
*/
typedef struct GE_rescue_struct GE_rescue;
struct GE_rescue_struct {
	GE_jmp_buf jb;
	GE_rescue* previous; /* previous context in the call chain */
};

/*
	Context of last feature entered containing a rescue clause.
	Warning: this is not thread-safe.
*/
extern GE_rescue* GE_last_rescue;

/*
	Raise an exception with code 'code'.
*/
extern void GE_raise(int code);

/*
	Check whether the type id of 'obj' is not in 'type_ids'.
	If it is, then raise a CAT-call exception. Don't do anything if 'obj' is Void.
	'nb' is the number of ids in 'type_ids' and is expected to be >0.
	'type_ids' is sorted in increasing order.
	Return 'obj'.
*/
#define GE_catcall(obj,type_ids,nb) GE_check_catcall((obj),(type_ids),(nb))
EIF_REFERENCE GE_check_catcall(EIF_REFERENCE obj, int type_ids[], int nb);

/*
	Check whether 'obj' is Void.
	If it is, then raise a call-on-void-target exception.
	Return 'obj'
*/
#define GE_void(obj) (!(obj)?GE_check_void(obj):(obj))
extern EIF_REFERENCE GE_check_void(EIF_REFERENCE obj);

/*
	Check whether 'ptr' is a null pointer.
	If it is, then raise a no-more-memory exception.
	Return 'ptr'
*/
#define GE_null(ptr) GE_check_null(ptr)
extern void* GE_check_null(void* ptr);

#ifdef __cplusplus
}
#endif

#endif

/*
	description:

		"C functions used to implement class CONSOLE"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef GE_CONSOLE_H
#define GE_CONSOLE_H

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_WINDOWS

/*
	Create a new DOS console if needed (i.e. in case of a Windows application).
*/
extern void GE_show_console(void);

#endif

#ifdef __cplusplus
}
#endif

#endif

/*
	description:

		"C functions used to implement the program initialization"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef GE_MAIN_H
#define GE_MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_WINDOWS

#include <windows.h>

/*
	Main entry point when compiling a Windows application.
	See:
		http://en.wikipedia.org/wiki/WinMain
		http://msdn2.microsoft.com/en-us/library/ms633559.aspx
*/
extern int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow);

#endif

#ifdef __cplusplus
}
#endif

#endif

/*
	description:

		"C functions used to access garbage collector facilities"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef GE_GC_H
#define GE_GC_H

#ifdef EIF_BOEHM_GC

/*
	Use the Boehm garbage collector.
	See:
		http://en.wikipedia.org/wiki/Boehm_GC
		http://www.hpl.hp.com/personal/Hans_Boehm/gc/
*/

#include "gc.h"

/*
	GC initialization.
*/
#define GE_init_gc() GC_INIT(); GC_enable_incremental()

/*
	Memory allocation.
*/

/*
 * GE_alloc allocates memory that can contain pointers to collectable objects.
 */
#define GE_alloc(x) GE_null(GC_MALLOC(x))

/*
 * When defined, GE_alloc_cleared means that GE_alloc makes sure that the allocated memory is zeroed.
 */
#define GE_alloc_cleared

/*
 * GE_alloc_atomic allocates memory that does not contain pointers to collectable objects.
 */
#define GE_alloc_atomic(x) GE_null(GC_MALLOC_ATOMIC(x))

/*
 * When defined, GE_alloc_atomic_cleared means that GE_alloc_atomic makes sure that the allocated memory is zeroed.
 */
/* #define GE_alloc_atomic_cleared */

/*
	Dispose
*/

/*
 * Call dispose routine `disp' on object `C'.
 */
extern void GE_boehm_dispose(void*, void*);

/*
 * Register dispose routine `disp' to be called on object `obj' when it will be collected.
 */
#define GE_register_dispose(obj, disp) GC_REGISTER_FINALIZER((void*)(obj), (void (*) (void*, void*)) &GE_boehm_dispose, NULL, NULL, NULL)

#else

/*
	No garbage collector.
*/

/*
	GC initialization.
*/
#define GE_init_gc() /* do nothing */

/*
	Memory allocation.
*/

/*
 * GE_alloc allocates memory that can contain pointers to collectable objects.
 */
#define GE_alloc(x) GE_null(malloc(x))

/*
 * When defined, GE_alloc_cleared means that GE_alloc makes sure that the allocated memory is zeroed.
 */
/* #define GE_alloc_cleared */

/*
 * GE_alloc_atomic allocates memory that does not contain pointers to collectable objects.
 */
#define GE_alloc_atomic(x) GE_null(malloc(x))

/*
 * When defined, GE_alloc_atomic_cleared means that GE_alloc_atomic makes sure that the allocated memory is zeroed.
 */
/* #define GE_alloc_atomic_cleared */

/*
	Dispose
*/

/*
 * Register dispose routine `disp' to be called on object `obj' when it will be collected.
 */
#define GE_register_dispose(obj, disp) /* do nothing */

#endif


/*
	Access to objects, useful with GCs which move objects in memory.
	This is not the case here, since the Boehm GC is not a moving GC.
*/

/* Access object through hector */
#define eif_access(obj) (obj)
/* Freeze memory address */
#define eif_freeze(obj) (obj)
/* The C side adopts an object */
#define eif_adopt(obj) (obj)
/* The C side protects an object */
#define eif_protect(obj) (obj)
/* The C side weans adopted object */
#define eif_wean(obj) (obj)
/* Forget a frozen memory address */
#define eif_unfreeze(obj)
/* Always frozen since they do not move */
#define eif_frozen(obj) 1
/* Always frozen since they do not move */
#define spfrozen(obj) 1

#endif

#ifdef __cplusplus
extern "C" {
#endif

#define T0 EIF_ANY

/* CHARACTER */
#define EIF_CHARACTER EIF_CHARACTER_8

/* WIDE_CHARACTER */
#define EIF_WIDE_CHAR EIF_CHARACTER_32

/* INTEGER */
#define EIF_INTEGER EIF_INTEGER_32

/* NATURAL */
#define EIF_NATURAL EIF_NATURAL_32

/* REAL */
#define EIF_REAL EIF_REAL_32

/* DOUBLE */
#define EIF_DOUBLE EIF_REAL_64

/* BOOLEAN */
#define T1 EIF_BOOLEAN
extern T0* GE_boxed1(T1 a1);
typedef struct Sb1 Tb1;

/* CHARACTER_8 */
#define T2 EIF_CHARACTER_8
extern T0* GE_boxed2(T2 a1);
typedef struct Sb2 Tb2;

/* CHARACTER_32 */
#define T3 EIF_CHARACTER_32
extern T0* GE_boxed3(T3 a1);
typedef struct Sb3 Tb3;

/* INTEGER_8 */
#define T4 EIF_INTEGER_8
extern T0* GE_boxed4(T4 a1);
typedef struct Sb4 Tb4;

/* INTEGER_16 */
#define T5 EIF_INTEGER_16
extern T0* GE_boxed5(T5 a1);
typedef struct Sb5 Tb5;

/* INTEGER_32 */
#define T6 EIF_INTEGER_32
extern T0* GE_boxed6(T6 a1);
typedef struct Sb6 Tb6;

/* INTEGER_64 */
#define T7 EIF_INTEGER_64
extern T0* GE_boxed7(T7 a1);
typedef struct Sb7 Tb7;

/* NATURAL_8 */
#define T8 EIF_NATURAL_8
extern T0* GE_boxed8(T8 a1);
typedef struct Sb8 Tb8;

/* NATURAL_16 */
#define T9 EIF_NATURAL_16
extern T0* GE_boxed9(T9 a1);
typedef struct Sb9 Tb9;

/* NATURAL_32 */
#define T10 EIF_NATURAL_32
extern T0* GE_boxed10(T10 a1);
typedef struct Sb10 Tb10;

/* NATURAL_64 */
#define T11 EIF_NATURAL_64
extern T0* GE_boxed11(T11 a1);
typedef struct Sb11 Tb11;

/* REAL_32 */
#define T12 EIF_REAL_32
extern T0* GE_boxed12(T12 a1);
typedef struct Sb12 Tb12;

/* REAL_64 */
#define T13 EIF_REAL_64
extern T0* GE_boxed13(T13 a1);
typedef struct Sb13 Tb13;

/* POINTER */
#define T14 EIF_POINTER
extern T0* GE_boxed14(T14 a1);
typedef struct Sb14 Tb14;

/* SPECIAL [CHARACTER_8] */
typedef struct S15 T15;

/* STRING_8 */
typedef struct S17 T17;

/* GEANT */
typedef struct S21 T21;

/* GEANT_PROJECT */
typedef struct S22 T22;

/* GEANT_PROJECT_LOADER */
typedef struct S23 T23;

/* GEANT_PROJECT_OPTIONS */
typedef struct S24 T24;

/* GEANT_PROJECT_VARIABLES */
typedef struct S25 T25;

/* GEANT_TARGET */
typedef struct S26 T26;

/* KL_ARGUMENTS */
typedef struct S27 T27;

/* UT_ERROR_HANDLER */
typedef struct S28 T28;

/* GEANT_VARIABLES */
typedef struct S29 T29;

/* GEANT_PROJECT_ELEMENT */
typedef struct S30 T30;

/* DS_HASH_TABLE [GEANT_TARGET, STRING_8] */
typedef struct S31 T31;

/* SPECIAL [STRING_8] */
typedef struct S32 T32;

/* ARRAY [STRING_8] */
typedef struct S33 T33;

/* GEANT_ARGUMENT_VARIABLES */
typedef struct S34 T34;

/* AP_FLAG */
typedef struct S35 T35;

/* AP_ALTERNATIVE_OPTIONS_LIST */
typedef struct S36 T36;

/* AP_STRING_OPTION */
typedef struct S37 T37;

/* AP_PARSER */
typedef struct S38 T38;

/* AP_ERROR */
typedef struct S40 T40;

/* AP_ERROR_HANDLER */
typedef struct S45 T45;

/* KL_STANDARD_FILES */
typedef struct S46 T46;

/* KL_STDERR_FILE */
typedef struct S47 T47;

/* KL_EXCEPTIONS */
typedef struct S48 T48;

/* UT_VERSION_NUMBER */
typedef struct S49 T49;

/* KL_OPERATING_SYSTEM */
typedef struct S51 T51;

/* KL_WINDOWS_FILE_SYSTEM */
typedef struct S53 T53;

/* KL_UNIX_FILE_SYSTEM */
typedef struct S54 T54;

/* KL_TEXT_INPUT_FILE */
typedef struct S55 T55;

/* GEANT_PROJECT_PARSER */
typedef struct S56 T56;

/* GEANT_PROJECT_VARIABLE_RESOLVER */
typedef struct S58 T58;

/* UC_STRING_EQUALITY_TESTER */
typedef struct S59 T59;

/* DS_SPARSE_TABLE_KEYS [STRING_8, STRING_8] */
typedef struct S61 T61;

/* SPECIAL [INTEGER_32] */
typedef struct S63 T63;

/* DS_HASH_TABLE_CURSOR [STRING_8, STRING_8] */
typedef struct S64 T64;

/* KL_SPECIAL_ROUTINES [INTEGER_32] */
typedef struct S65 T65;

/* KL_SPECIAL_ROUTINES [STRING_8] */
typedef struct S66 T66;

/* KL_STDOUT_FILE */
typedef struct S68 T68;

/* DS_LINKED_LIST_CURSOR [AP_OPTION] */
typedef struct S69 T69;

/* DS_ARRAYED_LIST [STRING_8] */
typedef struct S71 T71;

/* DS_ARRAYED_LIST_CURSOR [STRING_8] */
typedef struct S72 T72;

/* AP_DISPLAY_HELP_FLAG */
typedef struct S73 T73;

/* DS_ARRAYED_LIST [AP_OPTION] */
typedef struct S74 T74;

/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST] */
typedef struct S75 T75;

/* KL_STRING_ROUTINES */
typedef struct S76 T76;

/* TYPED_POINTER [ANY] */
typedef struct S77 T77;

/* DS_HASH_TABLE [STRING_8, STRING_8] */
typedef struct S81 T81;

/* EXECUTION_ENVIRONMENT */
typedef struct S83 T83;

/* KL_ANY_ROUTINES */
typedef struct S84 T84;

/* KL_PATHNAME */
typedef struct S86 T86;

/* UNIX_FILE_INFO */
typedef struct S87 T87;

/* ? KL_LINKABLE [CHARACTER_8] */
typedef struct S89 T89;

/* XM_EXPAT_PARSER_FACTORY */
typedef struct S91 T91;

/* XM_EIFFEL_PARSER */
typedef struct S93 T93;

/* XM_TREE_CALLBACKS_PIPE */
typedef struct S94 T94;

/* XM_CALLBACKS_TO_TREE_FILTER */
typedef struct S97 T97;

/* XM_DOCUMENT */
typedef struct S98 T98;

/* XM_ELEMENT */
typedef struct S99 T99;

/* XM_STOP_ON_ERROR_FILTER */
typedef struct S100 T100;

/* XM_POSITION_TABLE */
typedef struct S101 T101;

/* KL_EXECUTION_ENVIRONMENT */
typedef struct S104 T104;

/* DS_ARRAYED_STACK [GEANT_ARGUMENT_VARIABLES] */
typedef struct S105 T105;

/* DS_ARRAYED_STACK [GEANT_VARIABLES] */
typedef struct S106 T106;

/* DS_SPARSE_TABLE_KEYS_CURSOR [STRING_8, STRING_8] */
typedef struct S107 T107;

/* TO_SPECIAL [INTEGER_32] */
typedef struct S108 T108;

/* TO_SPECIAL [STRING_8] */
typedef struct S109 T109;

/* DS_ARRAYED_LIST_CURSOR [AP_OPTION] */
typedef struct S110 T110;

/* SPECIAL [AP_OPTION] */
typedef struct S112 T112;

/* KL_SPECIAL_ROUTINES [AP_OPTION] */
typedef struct S113 T113;

/* DS_ARRAYED_LIST_CURSOR [AP_ALTERNATIVE_OPTIONS_LIST] */
typedef struct S114 T114;

/* SPECIAL [AP_ALTERNATIVE_OPTIONS_LIST] */
typedef struct S115 T115;

/* KL_SPECIAL_ROUTINES [AP_ALTERNATIVE_OPTIONS_LIST] */
typedef struct S116 T116;

/* UC_STRING */
typedef struct S117 T117;

/* STRING_TO_INTEGER_CONVERTOR */
typedef struct S119 T119;

/* DS_LINKED_LIST [XM_ELEMENT] */
typedef struct S121 T121;

/* DS_LINKED_LIST_CURSOR [XM_ELEMENT] */
typedef struct S122 T122;

/* GEANT_INHERIT_ELEMENT */
typedef struct S123 T123;

/* GEANT_INHERIT */
typedef struct S124 T124;

/* SPECIAL [GEANT_TARGET] */
typedef struct S125 T125;

/* DS_SPARSE_TABLE_KEYS [GEANT_TARGET, STRING_8] */
typedef struct S127 T127;

/* DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8] */
typedef struct S129 T129;

/* KL_SPECIAL_ROUTINES [GEANT_TARGET] */
typedef struct S130 T130;

/* TYPED_POINTER [SPECIAL [CHARACTER_8]] */
typedef struct S131 T131;

/* XM_EIFFEL_SCANNER */
typedef struct S133 T133;

/* XM_DEFAULT_POSITION */
typedef struct S134 T134;

/* DS_BILINKED_LIST [XM_POSITION] */
typedef struct S136 T136;

/* DS_LINKED_STACK [XM_EIFFEL_SCANNER] */
typedef struct S137 T137;

/* XM_CALLBACKS_NULL */
typedef struct S138 T138;

/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8] */
typedef struct S139 T139;

/* XM_NULL_EXTERNAL_RESOLVER */
typedef struct S141 T141;

/* SPECIAL [ANY] */
typedef struct S142 T142;

/* KL_SPECIAL_ROUTINES [ANY] */
typedef struct S143 T143;

/* XM_EIFFEL_PARSER_NAME */
typedef struct S144 T144;

/* XM_EIFFEL_DECLARATION */
typedef struct S145 T145;

/* XM_DTD_EXTERNAL_ID */
typedef struct S146 T146;

/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME] */
typedef struct S147 T147;

/* XM_DTD_ELEMENT_CONTENT */
typedef struct S148 T148;

/* DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT] */
typedef struct S149 T149;

/* XM_DTD_ATTRIBUTE_CONTENT */
typedef struct S150 T150;

/* DS_BILINKED_LIST [STRING_8] */
typedef struct S151 T151;

/* SPECIAL [XM_EIFFEL_PARSER_NAME] */
typedef struct S152 T152;

/* KL_SPECIAL_ROUTINES [XM_EIFFEL_PARSER_NAME] */
typedef struct S153 T153;

/* SPECIAL [XM_EIFFEL_DECLARATION] */
typedef struct S154 T154;

/* KL_SPECIAL_ROUTINES [XM_EIFFEL_DECLARATION] */
typedef struct S155 T155;

/* SPECIAL [BOOLEAN] */
typedef struct S156 T156;

/* SPECIAL [XM_DTD_EXTERNAL_ID] */
typedef struct S157 T157;

/* KL_SPECIAL_ROUTINES [BOOLEAN] */
typedef struct S158 T158;

/* SPECIAL [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]] */
typedef struct S159 T159;

/* KL_SPECIAL_ROUTINES [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]] */
typedef struct S160 T160;

/* SPECIAL [XM_DTD_ELEMENT_CONTENT] */
typedef struct S161 T161;

/* KL_SPECIAL_ROUTINES [XM_DTD_ELEMENT_CONTENT] */
typedef struct S162 T162;

/* SPECIAL [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]] */
typedef struct S164 T164;

/* SPECIAL [XM_DTD_ATTRIBUTE_CONTENT] */
typedef struct S166 T166;

/* KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]] */
typedef struct S167 T167;

/* KL_SPECIAL_ROUTINES [XM_DTD_ATTRIBUTE_CONTENT] */
typedef struct S168 T168;

/* SPECIAL [DS_BILINKED_LIST [STRING_8]] */
typedef struct S169 T169;

/* KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [STRING_8]] */
typedef struct S170 T170;

/* XM_EIFFEL_ENTITY_DEF */
typedef struct S171 T171;

/* KL_SPECIAL_ROUTINES [XM_DTD_EXTERNAL_ID] */
typedef struct S172 T172;

/* XM_DTD_CALLBACKS_NULL */
typedef struct S174 T174;

/* XM_EIFFEL_SCANNER_DTD */
typedef struct S175 T175;

/* XM_EIFFEL_PE_ENTITY_DEF */
typedef struct S177 T177;

/* XM_NAMESPACE_RESOLVER */
typedef struct S178 T178;

/* SPECIAL [XM_CALLBACKS_FILTER] */
typedef struct S179 T179;

/* ARRAY [XM_CALLBACKS_FILTER] */
typedef struct S180 T180;

/* DS_LINKED_LIST [DS_PAIR [XM_POSITION, XM_NODE]] */
typedef struct S181 T181;

/* SPECIAL [GEANT_ARGUMENT_VARIABLES] */
typedef struct S182 T182;

/* KL_SPECIAL_ROUTINES [GEANT_ARGUMENT_VARIABLES] */
typedef struct S183 T183;

/* SPECIAL [GEANT_VARIABLES] */
typedef struct S184 T184;

/* KL_SPECIAL_ROUTINES [GEANT_VARIABLES] */
typedef struct S185 T185;

/* TO_SPECIAL [AP_OPTION] */
typedef struct S187 T187;

/* TO_SPECIAL [AP_ALTERNATIVE_OPTIONS_LIST] */
typedef struct S188 T188;

/* C_STRING */
typedef struct S189 T189;

/* DS_ARRAYED_STACK [GEANT_TARGET] */
typedef struct S191 T191;

/* GEANT_TASK_FACTORY */
typedef struct S192 T192;

/* GEANT_PARENT */
typedef struct S193 T193;

/* DS_ARRAYED_LIST [GEANT_PARENT] */
typedef struct S195 T195;

/* DS_ARRAYED_LIST_CURSOR [GEANT_PARENT] */
typedef struct S196 T196;

/* GEANT_INTERPRETING_ELEMENT */
typedef struct S197 T197;

/* GEANT_ARGUMENT_ELEMENT */
typedef struct S198 T198;

/* GEANT_LOCAL_ELEMENT */
typedef struct S199 T199;

/* GEANT_GLOBAL_ELEMENT */
typedef struct S200 T200;

/* XM_ATTRIBUTE */
typedef struct S201 T201;

/* GEANT_GROUP */
typedef struct S202 T202;

/* DS_LINKED_LIST_CURSOR [XM_NODE] */
typedef struct S204 T204;

/* ARRAY [INTEGER_32] */
typedef struct S205 T205;

/* UC_UTF8_ROUTINES */
typedef struct S206 T206;

/* UC_UTF8_STRING */
typedef struct S207 T207;

/* XM_EIFFEL_INPUT_STREAM */
typedef struct S209 T209;

/* KL_INTEGER_ROUTINES */
typedef struct S210 T210;

/* KL_PLATFORM */
typedef struct S211 T211;

/* DS_LINKED_LIST_CURSOR [DS_PAIR [XM_POSITION, XM_NODE]] */
typedef struct S212 T212;

/* DS_PAIR [XM_POSITION, XM_NODE] */
typedef struct S213 T213;

/* INTEGER_OVERFLOW_CHECKER */
typedef struct S214 T214;

/* DS_LINKABLE [XM_ELEMENT] */
typedef struct S215 T215;

/* GEANT_PARENT_ELEMENT */
typedef struct S216 T216;

/* DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_TARGET, STRING_8] */
typedef struct S218 T218;

/* TO_SPECIAL [GEANT_TARGET] */
typedef struct S219 T219;

/* XM_EIFFEL_CHARACTER_ENTITY */
typedef struct S220 T220;

/* YY_BUFFER */
typedef struct S221 T221;

/* YY_FILE_BUFFER */
typedef struct S222 T222;

/* DS_LINKED_STACK [INTEGER_32] */
typedef struct S224 T224;

/* DS_BILINKABLE [XM_POSITION] */
typedef struct S226 T226;

/* DS_BILINKED_LIST_CURSOR [XM_POSITION] */
typedef struct S227 T227;

/* DS_LINKABLE [XM_EIFFEL_SCANNER] */
typedef struct S228 T228;

/* SPECIAL [XM_EIFFEL_ENTITY_DEF] */
typedef struct S229 T229;

/* DS_SPARSE_TABLE_KEYS [XM_EIFFEL_ENTITY_DEF, STRING_8] */
typedef struct S230 T230;

/* DS_HASH_TABLE_CURSOR [XM_EIFFEL_ENTITY_DEF, STRING_8] */
typedef struct S232 T232;

/* KL_SPECIAL_ROUTINES [XM_EIFFEL_ENTITY_DEF] */
typedef struct S234 T234;

/* TO_SPECIAL [ANY] */
typedef struct S235 T235;

/* KL_EQUALITY_TESTER [XM_EIFFEL_PARSER_NAME] */
typedef struct S236 T236;

/* DS_HASH_SET_CURSOR [XM_EIFFEL_PARSER_NAME] */
typedef struct S237 T237;

/* DS_BILINKED_LIST [XM_DTD_ELEMENT_CONTENT] */
typedef struct S238 T238;

/* DS_BILINKED_LIST_CURSOR [XM_DTD_ATTRIBUTE_CONTENT] */
typedef struct S239 T239;

/* DS_BILINKABLE [XM_DTD_ATTRIBUTE_CONTENT] */
typedef struct S240 T240;

/* DS_LINKED_LIST [STRING_8] */
typedef struct S241 T241;

/* DS_BILINKED_LIST_CURSOR [STRING_8] */
typedef struct S242 T242;

/* DS_BILINKABLE [STRING_8] */
typedef struct S243 T243;

/* TO_SPECIAL [XM_EIFFEL_PARSER_NAME] */
typedef struct S244 T244;

/* TO_SPECIAL [XM_EIFFEL_DECLARATION] */
typedef struct S245 T245;

/* TO_SPECIAL [BOOLEAN] */
typedef struct S246 T246;

/* TO_SPECIAL [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]] */
typedef struct S247 T247;

/* TO_SPECIAL [XM_DTD_ELEMENT_CONTENT] */
typedef struct S248 T248;

/* TO_SPECIAL [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]] */
typedef struct S249 T249;

/* TO_SPECIAL [XM_DTD_ATTRIBUTE_CONTENT] */
typedef struct S250 T250;

/* TO_SPECIAL [DS_BILINKED_LIST [STRING_8]] */
typedef struct S251 T251;

/* TO_SPECIAL [XM_DTD_EXTERNAL_ID] */
typedef struct S252 T252;

/* XM_NAMESPACE_RESOLVER_CONTEXT */
typedef struct S253 T253;

/* DS_LINKED_QUEUE [STRING_8] */
typedef struct S255 T255;

/* TO_SPECIAL [GEANT_ARGUMENT_VARIABLES] */
typedef struct S256 T256;

/* TO_SPECIAL [GEANT_VARIABLES] */
typedef struct S257 T257;

/* SPECIAL [NATURAL_8] */
typedef struct S258 T258;

/* GEANT_STRING_INTERPRETER */
typedef struct S259 T259;

/* KL_ARRAY_ROUTINES [INTEGER_32] */
typedef struct S262 T262;

/* MANAGED_POINTER */
typedef struct S264 T264;

/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8] */
typedef struct S265 T265;

/* GEANT_GEC_TASK */
typedef struct S266 T266;

/* TUPLE [XM_ELEMENT] */
typedef struct S267 T267;

/* TUPLE */
typedef struct S268 T268;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEC_TASK] */
typedef struct S269 T269;

/* TUPLE [GEANT_TASK_FACTORY] */
typedef struct S270 T270;

/* GEANT_ISE_TASK */
typedef struct S273 T273;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_ISE_TASK] */
typedef struct S274 T274;

/* GEANT_EXEC_TASK */
typedef struct S275 T275;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_EXEC_TASK] */
typedef struct S276 T276;

/* GEANT_LCC_TASK */
typedef struct S277 T277;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_LCC_TASK] */
typedef struct S278 T278;

/* GEANT_SET_TASK */
typedef struct S279 T279;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_SET_TASK] */
typedef struct S280 T280;

/* GEANT_UNSET_TASK */
typedef struct S281 T281;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_UNSET_TASK] */
typedef struct S282 T282;

/* GEANT_GEXACE_TASK */
typedef struct S283 T283;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEXACE_TASK] */
typedef struct S284 T284;

/* GEANT_GELEX_TASK */
typedef struct S285 T285;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GELEX_TASK] */
typedef struct S286 T286;

/* GEANT_GEYACC_TASK */
typedef struct S287 T287;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEYACC_TASK] */
typedef struct S288 T288;

/* GEANT_GEPP_TASK */
typedef struct S289 T289;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEPP_TASK] */
typedef struct S290 T290;

/* GEANT_GETEST_TASK */
typedef struct S291 T291;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GETEST_TASK] */
typedef struct S292 T292;

/* GEANT_GEANT_TASK */
typedef struct S293 T293;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEANT_TASK] */
typedef struct S294 T294;

/* GEANT_ECHO_TASK */
typedef struct S295 T295;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_ECHO_TASK] */
typedef struct S296 T296;

/* GEANT_MKDIR_TASK */
typedef struct S297 T297;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_MKDIR_TASK] */
typedef struct S298 T298;

/* GEANT_DELETE_TASK */
typedef struct S299 T299;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_DELETE_TASK] */
typedef struct S300 T300;

/* GEANT_COPY_TASK */
typedef struct S301 T301;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_COPY_TASK] */
typedef struct S302 T302;

/* GEANT_MOVE_TASK */
typedef struct S303 T303;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_MOVE_TASK] */
typedef struct S304 T304;

/* GEANT_SETENV_TASK */
typedef struct S305 T305;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_SETENV_TASK] */
typedef struct S306 T306;

/* GEANT_XSLT_TASK */
typedef struct S307 T307;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_XSLT_TASK] */
typedef struct S308 T308;

/* GEANT_OUTOFDATE_TASK */
typedef struct S309 T309;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_OUTOFDATE_TASK] */
typedef struct S310 T310;

/* GEANT_EXIT_TASK */
typedef struct S311 T311;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_EXIT_TASK] */
typedef struct S312 T312;

/* GEANT_PRECURSOR_TASK */
typedef struct S313 T313;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_PRECURSOR_TASK] */
typedef struct S314 T314;

/* GEANT_AVAILABLE_TASK */
typedef struct S315 T315;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_AVAILABLE_TASK] */
typedef struct S316 T316;

/* GEANT_INPUT_TASK */
typedef struct S317 T317;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_INPUT_TASK] */
typedef struct S318 T318;

/* GEANT_REPLACE_TASK */
typedef struct S319 T319;

/* FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_REPLACE_TASK] */
typedef struct S320 T320;

/* KL_SPECIAL_ROUTINES [GEANT_PARENT] */
typedef struct S321 T321;

/* SPECIAL [GEANT_PARENT] */
typedef struct S322 T322;

/* UC_UNICODE_ROUTINES */
typedef struct S324 T324;

/* DS_LINKED_QUEUE [CHARACTER_8] */
typedef struct S326 T326;

/* UC_UTF16_ROUTINES */
typedef struct S327 T327;

/* DS_LINKABLE [DS_PAIR [XM_POSITION, XM_NODE]] */
typedef struct S328 T328;

/* SPECIAL [NATURAL_64] */
typedef struct S329 T329;

/* GEANT_RENAME_ELEMENT */
typedef struct S330 T330;

/* GEANT_REDEFINE_ELEMENT */
typedef struct S331 T331;

/* GEANT_SELECT_ELEMENT */
typedef struct S332 T332;

/* GEANT_RENAME */
typedef struct S333 T333;

/* DS_HASH_TABLE [GEANT_RENAME, STRING_8] */
typedef struct S334 T334;

/* GEANT_REDEFINE */
typedef struct S335 T335;

/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8] */
typedef struct S336 T336;

/* GEANT_SELECT */
typedef struct S337 T337;

/* DS_HASH_TABLE [GEANT_SELECT, STRING_8] */
typedef struct S338 T338;

/* DS_LINKABLE [INTEGER_32] */
typedef struct S340 T340;

/* DS_SPARSE_TABLE_KEYS_CURSOR [XM_EIFFEL_ENTITY_DEF, STRING_8] */
typedef struct S341 T341;

/* TO_SPECIAL [XM_EIFFEL_ENTITY_DEF] */
typedef struct S342 T342;

/* DS_BILINKED_LIST_CURSOR [XM_DTD_ELEMENT_CONTENT] */
typedef struct S343 T343;

/* DS_BILINKABLE [XM_DTD_ELEMENT_CONTENT] */
typedef struct S344 T344;

/* DS_LINKED_LIST_CURSOR [STRING_8] */
typedef struct S345 T345;

/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]] */
typedef struct S347 T347;

/* DS_BILINKED_LIST_CURSOR [DS_HASH_TABLE [STRING_8, STRING_8]] */
typedef struct S348 T348;

/* DS_LINKABLE [STRING_8] */
typedef struct S349 T349;

/* GEANT_NAME_VALUE_ELEMENT */
typedef struct S350 T350;

/* AP_OPTION_COMPARATOR */
typedef struct S351 T351;

/* DS_QUICK_SORTER [AP_OPTION] */
typedef struct S352 T352;

/* ST_WORD_WRAPPER */
typedef struct S354 T354;

/* DS_HASH_SET [XM_NAMESPACE] */
typedef struct S356 T356;

/* XM_COMMENT */
typedef struct S357 T357;

/* XM_PROCESSING_INSTRUCTION */
typedef struct S358 T358;

/* XM_CHARACTER_DATA */
typedef struct S359 T359;

/* XM_NAMESPACE */
typedef struct S360 T360;

/* DS_LINKABLE [XM_NODE] */
typedef struct S363 T363;

/* XM_NODE_TYPER */
typedef struct S365 T365;

/* KL_CHARACTER_BUFFER */
typedef struct S369 T369;

/* TYPED_POINTER [NATURAL_8] */
typedef struct S370 T370;

/* EXCEPTIONS */
typedef struct S371 T371;

/* DS_SPARSE_TABLE_KEYS [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8] */
typedef struct S373 T373;

/* SPECIAL [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]] */
typedef struct S375 T375;

/* DS_HASH_TABLE_CURSOR [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8] */
typedef struct S376 T376;

/* KL_SPECIAL_ROUTINES [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]] */
typedef struct S377 T377;

/* GEANT_GEC_COMMAND */
typedef struct S378 T378;

/* DS_CELL [PROCEDURE [ANY, TUPLE]] */
typedef struct S379 T379;

/* PROCEDURE [GEANT_GEC_TASK, TUPLE] */
typedef struct S380 T380;

/* TUPLE [GEANT_GEC_TASK] */
typedef struct S381 T381;

/* GEANT_ISE_COMMAND */
typedef struct S382 T382;

/* PROCEDURE [GEANT_ISE_TASK, TUPLE] */
typedef struct S383 T383;

/* TUPLE [GEANT_ISE_TASK] */
typedef struct S384 T384;

/* GEANT_FILESET_ELEMENT */
typedef struct S385 T385;

/* GEANT_EXEC_COMMAND */
typedef struct S386 T386;

/* GEANT_STRING_PROPERTY */
typedef struct S387 T387;

/* FUNCTION [GEANT_INTERPRETING_ELEMENT, TUPLE, STRING_8] */
typedef struct S388 T388;

/* TUPLE [GEANT_INTERPRETING_ELEMENT, STRING_8] */
typedef struct S389 T389;

/* GEANT_BOOLEAN_PROPERTY */
typedef struct S390 T390;

/* GEANT_FILESET */
typedef struct S391 T391;

/* PROCEDURE [GEANT_EXEC_TASK, TUPLE] */
typedef struct S392 T392;

/* TUPLE [GEANT_EXEC_TASK] */
typedef struct S393 T393;

/* GEANT_LCC_COMMAND */
typedef struct S394 T394;

/* PROCEDURE [GEANT_LCC_TASK, TUPLE] */
typedef struct S395 T395;

/* TUPLE [GEANT_LCC_TASK] */
typedef struct S396 T396;

/* GEANT_SET_COMMAND */
typedef struct S397 T397;

/* PROCEDURE [GEANT_SET_TASK, TUPLE] */
typedef struct S398 T398;

/* TUPLE [GEANT_SET_TASK] */
typedef struct S399 T399;

/* GEANT_UNSET_COMMAND */
typedef struct S400 T400;

/* PROCEDURE [GEANT_UNSET_TASK, TUPLE] */
typedef struct S401 T401;

/* TUPLE [GEANT_UNSET_TASK] */
typedef struct S402 T402;

/* GEANT_DEFINE_ELEMENT */
typedef struct S403 T403;

/* GEANT_GEXACE_COMMAND */
typedef struct S404 T404;

/* PROCEDURE [GEANT_GEXACE_TASK, TUPLE] */
typedef struct S405 T405;

/* TUPLE [GEANT_GEXACE_TASK] */
typedef struct S406 T406;

/* GEANT_GELEX_COMMAND */
typedef struct S407 T407;

/* PROCEDURE [GEANT_GELEX_TASK, TUPLE] */
typedef struct S408 T408;

/* TUPLE [GEANT_GELEX_TASK] */
typedef struct S409 T409;

/* GEANT_GEYACC_COMMAND */
typedef struct S410 T410;

/* PROCEDURE [GEANT_GEYACC_TASK, TUPLE] */
typedef struct S411 T411;

/* TUPLE [GEANT_GEYACC_TASK] */
typedef struct S412 T412;

/* GEANT_GEPP_COMMAND */
typedef struct S413 T413;

/* PROCEDURE [GEANT_GEPP_TASK, TUPLE] */
typedef struct S414 T414;

/* TUPLE [GEANT_GEPP_TASK] */
typedef struct S415 T415;

/* GEANT_GETEST_COMMAND */
typedef struct S416 T416;

/* PROCEDURE [GEANT_GETEST_TASK, TUPLE] */
typedef struct S417 T417;

/* TUPLE [GEANT_GETEST_TASK] */
typedef struct S418 T418;

/* GEANT_GEANT_COMMAND */
typedef struct S419 T419;

/* ST_SPLITTER */
typedef struct S420 T420;

/* PROCEDURE [GEANT_GEANT_TASK, TUPLE] */
typedef struct S421 T421;

/* TUPLE [GEANT_GEANT_TASK] */
typedef struct S422 T422;

/* GEANT_ECHO_COMMAND */
typedef struct S423 T423;

/* PROCEDURE [GEANT_ECHO_TASK, TUPLE] */
typedef struct S424 T424;

/* TUPLE [GEANT_ECHO_TASK] */
typedef struct S425 T425;

/* GEANT_MKDIR_COMMAND */
typedef struct S426 T426;

/* PROCEDURE [GEANT_MKDIR_TASK, TUPLE] */
typedef struct S427 T427;

/* TUPLE [GEANT_MKDIR_TASK] */
typedef struct S428 T428;

/* GEANT_DIRECTORYSET_ELEMENT */
typedef struct S429 T429;

/* GEANT_DELETE_COMMAND */
typedef struct S430 T430;

/* GEANT_DIRECTORYSET */
typedef struct S431 T431;

/* PROCEDURE [GEANT_DELETE_TASK, TUPLE] */
typedef struct S432 T432;

/* TUPLE [GEANT_DELETE_TASK] */
typedef struct S433 T433;

/* GEANT_COPY_COMMAND */
typedef struct S434 T434;

/* PROCEDURE [GEANT_COPY_TASK, TUPLE] */
typedef struct S435 T435;

/* TUPLE [GEANT_COPY_TASK] */
typedef struct S436 T436;

/* GEANT_MOVE_COMMAND */
typedef struct S437 T437;

/* PROCEDURE [GEANT_MOVE_TASK, TUPLE] */
typedef struct S438 T438;

/* TUPLE [GEANT_MOVE_TASK] */
typedef struct S439 T439;

/* GEANT_SETENV_COMMAND */
typedef struct S440 T440;

/* PROCEDURE [GEANT_SETENV_TASK, TUPLE] */
typedef struct S441 T441;

/* TUPLE [GEANT_SETENV_TASK] */
typedef struct S442 T442;

/* DS_PAIR [STRING_8, STRING_8] */
typedef struct S443 T443;

/* GEANT_XSLT_COMMAND */
typedef struct S444 T444;

/* DS_ARRAYED_LIST [DS_PAIR [STRING_8, STRING_8]] */
typedef struct S445 T445;

/* PROCEDURE [GEANT_XSLT_TASK, TUPLE] */
typedef struct S446 T446;

/* TUPLE [GEANT_XSLT_TASK] */
typedef struct S447 T447;

/* GEANT_OUTOFDATE_COMMAND */
typedef struct S448 T448;

/* PROCEDURE [GEANT_OUTOFDATE_TASK, TUPLE] */
typedef struct S449 T449;

/* TUPLE [GEANT_OUTOFDATE_TASK] */
typedef struct S450 T450;

/* GEANT_EXIT_COMMAND */
typedef struct S451 T451;

/* PROCEDURE [GEANT_EXIT_TASK, TUPLE] */
typedef struct S452 T452;

/* TUPLE [GEANT_EXIT_TASK] */
typedef struct S453 T453;

/* GEANT_PRECURSOR_COMMAND */
typedef struct S454 T454;

/* PROCEDURE [GEANT_PRECURSOR_TASK, TUPLE] */
typedef struct S455 T455;

/* TUPLE [GEANT_PRECURSOR_TASK] */
typedef struct S456 T456;

/* GEANT_AVAILABLE_COMMAND */
typedef struct S457 T457;

/* PROCEDURE [GEANT_AVAILABLE_TASK, TUPLE] */
typedef struct S458 T458;

/* TUPLE [GEANT_AVAILABLE_TASK] */
typedef struct S459 T459;

/* GEANT_INPUT_COMMAND */
typedef struct S460 T460;

/* PROCEDURE [GEANT_INPUT_TASK, TUPLE] */
typedef struct S461 T461;

/* TUPLE [GEANT_INPUT_TASK] */
typedef struct S462 T462;

/* GEANT_REPLACE_COMMAND */
typedef struct S463 T463;

/* PROCEDURE [GEANT_REPLACE_TASK, TUPLE] */
typedef struct S464 T464;

/* TUPLE [GEANT_REPLACE_TASK] */
typedef struct S465 T465;

/* TO_SPECIAL [GEANT_PARENT] */
typedef struct S466 T466;

/* SPECIAL [ARRAY [INTEGER_32]] */
typedef struct S467 T467;

/* SPECIAL [SPECIAL [ARRAY [INTEGER_32]]] */
typedef struct S468 T468;

/* DS_LINKABLE [CHARACTER_8] */
typedef struct S469 T469;

/* KL_EQUALITY_TESTER [GEANT_RENAME] */
typedef struct S470 T470;

/* DS_SPARSE_TABLE_KEYS [GEANT_RENAME, STRING_8] */
typedef struct S471 T471;

/* SPECIAL [GEANT_RENAME] */
typedef struct S473 T473;

/* DS_HASH_TABLE_CURSOR [GEANT_RENAME, STRING_8] */
typedef struct S474 T474;

/* KL_SPECIAL_ROUTINES [GEANT_RENAME] */
typedef struct S475 T475;

/* KL_EQUALITY_TESTER [GEANT_REDEFINE] */
typedef struct S476 T476;

/* DS_SPARSE_TABLE_KEYS [GEANT_REDEFINE, STRING_8] */
typedef struct S477 T477;

/* SPECIAL [GEANT_REDEFINE] */
typedef struct S479 T479;

/* DS_HASH_TABLE_CURSOR [GEANT_REDEFINE, STRING_8] */
typedef struct S480 T480;

/* KL_SPECIAL_ROUTINES [GEANT_REDEFINE] */
typedef struct S481 T481;

/* KL_EQUALITY_TESTER [GEANT_SELECT] */
typedef struct S482 T482;

/* DS_SPARSE_TABLE_KEYS [GEANT_SELECT, STRING_8] */
typedef struct S483 T483;

/* SPECIAL [GEANT_SELECT] */
typedef struct S485 T485;

/* DS_HASH_TABLE_CURSOR [GEANT_SELECT, STRING_8] */
typedef struct S486 T486;

/* KL_SPECIAL_ROUTINES [GEANT_SELECT] */
typedef struct S487 T487;

/* DS_BILINKABLE [DS_HASH_TABLE [STRING_8, STRING_8]] */
typedef struct S489 T489;

/* KL_DIRECTORY */
typedef struct S490 T490;

/* KL_STRING_INPUT_STREAM */
typedef struct S491 T491;

/* SPECIAL [XM_NAMESPACE] */
typedef struct S492 T492;

/* KL_EQUALITY_TESTER [XM_NAMESPACE] */
typedef struct S493 T493;

/* DS_HASH_SET_CURSOR [XM_NAMESPACE] */
typedef struct S494 T494;

/* KL_SPECIAL_ROUTINES [XM_NAMESPACE] */
typedef struct S495 T495;

/* DS_SPARSE_TABLE_KEYS_CURSOR [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8] */
typedef struct S496 T496;

/* TO_SPECIAL [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]] */
typedef struct S497 T497;

/* GEANT_MAP_ELEMENT */
typedef struct S500 T500;

/* GEANT_MAP */
typedef struct S501 T501;

/* DS_HASH_SET [GEANT_FILESET_ENTRY] */
typedef struct S504 T504;

/* DS_HASH_SET [STRING_8] */
typedef struct S506 T506;

/* LX_DFA_WILDCARD */
typedef struct S508 T508;

/* DS_HASH_SET [INTEGER_32] */
typedef struct S510 T510;

/* DS_CELL [PROCEDURE [ANY, TUPLE [STRING_8]]] */
typedef struct S511 T511;

/* TUPLE [STRING_8] */
typedef struct S512 T512;

/* PROCEDURE [GEANT_ECHO_COMMAND, TUPLE [STRING_8]] */
typedef struct S513 T513;

/* TUPLE [GEANT_ECHO_COMMAND] */
typedef struct S514 T514;

/* DS_CELL [PROCEDURE [ANY, TUPLE [STRING_8, KL_TEXT_OUTPUT_FILE, BOOLEAN]]] */
typedef struct S516 T516;

/* KL_TEXT_OUTPUT_FILE */
typedef struct S517 T517;

/* TUPLE [STRING_8, KL_TEXT_OUTPUT_FILE, BOOLEAN] */
typedef struct S518 T518;

/* PROCEDURE [GEANT_ECHO_COMMAND, TUPLE [STRING_8, KL_TEXT_OUTPUT_FILE, BOOLEAN]] */
typedef struct S519 T519;

/* PROCEDURE [GEANT_MKDIR_COMMAND, TUPLE [STRING_8]] */
typedef struct S521 T521;

/* TUPLE [GEANT_MKDIR_COMMAND] */
typedef struct S522 T522;

/* KL_SPECIAL_ROUTINES [DS_PAIR [STRING_8, STRING_8]] */
typedef struct S523 T523;

/* SPECIAL [DS_PAIR [STRING_8, STRING_8]] */
typedef struct S524 T524;

/* DS_ARRAYED_LIST_CURSOR [DS_PAIR [STRING_8, STRING_8]] */
typedef struct S525 T525;

/* DS_CELL [FUNCTION [ANY, TUPLE [STRING_8], BOOLEAN]] */
typedef struct S526 T526;

/* PREDICATE [GEANT_AVAILABLE_COMMAND, TUPLE [STRING_8]] */
typedef struct S527 T527;

/* TUPLE [GEANT_AVAILABLE_COMMAND] */
typedef struct S528 T528;

/* DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_RENAME, STRING_8] */
typedef struct S530 T530;

/* TO_SPECIAL [GEANT_RENAME] */
typedef struct S531 T531;

/* DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_REDEFINE, STRING_8] */
typedef struct S532 T532;

/* TO_SPECIAL [GEANT_REDEFINE] */
typedef struct S533 T533;

/* DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_SELECT, STRING_8] */
typedef struct S534 T534;

/* TO_SPECIAL [GEANT_SELECT] */
typedef struct S535 T535;

/* TO_SPECIAL [XM_NAMESPACE] */
typedef struct S540 T540;

/* KL_EQUALITY_TESTER [GEANT_FILESET_ENTRY] */
typedef struct S542 T542;

/* DS_HASH_SET_CURSOR [GEANT_FILESET_ENTRY] */
typedef struct S543 T543;

/* KL_SPECIAL_ROUTINES [GEANT_FILESET_ENTRY] */
typedef struct S544 T544;

/* GEANT_FILESET_ENTRY */
typedef struct S545 T545;

/* SPECIAL [GEANT_FILESET_ENTRY] */
typedef struct S546 T546;

/* DS_HASH_SET_CURSOR [STRING_8] */
typedef struct S547 T547;

/* LX_WILDCARD_PARSER */
typedef struct S548 T548;

/* LX_DESCRIPTION */
typedef struct S549 T549;

/* LX_FULL_DFA */
typedef struct S550 T550;

/* DS_HASH_SET_CURSOR [INTEGER_32] */
typedef struct S552 T552;

/* KL_EQUALITY_TESTER [INTEGER_32] */
typedef struct S553 T553;

/* TO_SPECIAL [DS_PAIR [STRING_8, STRING_8]] */
typedef struct S554 T554;

/* KL_NULL_TEXT_OUTPUT_STREAM */
typedef struct S558 T558;

/* DP_SHELL_COMMAND */
typedef struct S560 T560;

/* DS_CELL [BOOLEAN] */
typedef struct S561 T561;

/* KL_BOOLEAN_ROUTINES */
typedef struct S563 T563;

/* ARRAY [BOOLEAN] */
typedef struct S564 T564;

/* GEANT_VARIABLES_VARIABLE_RESOLVER */
typedef struct S565 T565;

/* RX_PCRE_REGULAR_EXPRESSION */
typedef struct S566 T566;

/* KL_STRING_EQUALITY_TESTER */
typedef struct S567 T567;

/* KL_STDIN_FILE */
typedef struct S568 T568;

/* ARRAY [GEANT_VARIABLES] */
typedef struct S569 T569;

/* TO_SPECIAL [GEANT_FILESET_ENTRY] */
typedef struct S572 T572;

/* DS_ARRAYED_LIST [LX_RULE] */
typedef struct S573 T573;

/* LX_START_CONDITIONS */
typedef struct S574 T574;

/* LX_ACTION_FACTORY */
typedef struct S575 T575;

/* DS_ARRAYED_STACK [INTEGER_32] */
typedef struct S576 T576;

/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8] */
typedef struct S577 T577;

/* LX_SYMBOL_CLASS */
typedef struct S578 T578;

/* SPECIAL [LX_SYMBOL_CLASS] */
typedef struct S579 T579;

/* KL_SPECIAL_ROUTINES [LX_SYMBOL_CLASS] */
typedef struct S580 T580;

/* LX_NFA */
typedef struct S581 T581;

/* LX_EQUIVALENCE_CLASSES */
typedef struct S582 T582;

/* LX_RULE */
typedef struct S583 T583;

/* SPECIAL [LX_NFA] */
typedef struct S584 T584;

/* KL_SPECIAL_ROUTINES [LX_NFA] */
typedef struct S585 T585;

/* UT_SYNTAX_ERROR */
typedef struct S586 T586;

/* DS_HASH_TABLE_CURSOR [LX_SYMBOL_CLASS, STRING_8] */
typedef struct S587 T587;

/* LX_UNRECOGNIZED_RULE_ERROR */
typedef struct S588 T588;

/* LX_MISSING_QUOTE_ERROR */
typedef struct S589 T589;

/* LX_BAD_CHARACTER_CLASS_ERROR */
typedef struct S590 T590;

/* LX_BAD_CHARACTER_ERROR */
typedef struct S591 T591;

/* LX_FULL_AND_META_ERROR */
typedef struct S592 T592;

/* LX_FULL_AND_REJECT_ERROR */
typedef struct S593 T593;

/* LX_FULL_AND_VARIABLE_TRAILING_CONTEXT_ERROR */
typedef struct S594 T594;

/* LX_CHARACTER_OUT_OF_RANGE_ERROR */
typedef struct S595 T595;

/* SPECIAL [LX_RULE] */
typedef struct S596 T596;

/* ARRAY [LX_RULE] */
typedef struct S597 T597;

/* LX_DFA_STATE */
typedef struct S598 T598;

/* DS_ARRAYED_LIST [LX_NFA_STATE] */
typedef struct S599 T599;

/* DS_ARRAYED_LIST [LX_DFA_STATE] */
typedef struct S600 T600;

/* LX_SYMBOL_PARTITIONS */
typedef struct S601 T601;

/* LX_START_CONDITION */
typedef struct S602 T602;

/* LX_TRANSITION_TABLE [LX_DFA_STATE] */
typedef struct S603 T603;

/* DS_ARRAYED_LIST [LX_NFA] */
typedef struct S604 T604;

/* DS_HASH_TABLE [LX_NFA, INTEGER_32] */
typedef struct S605 T605;

/* LX_NFA_STATE */
typedef struct S606 T606;

/* LX_NEGATIVE_RANGE_IN_CHARACTER_CLASS_ERROR */
typedef struct S608 T608;

/* RX_BYTE_CODE */
typedef struct S610 T610;

/* RX_CASE_MAPPING */
typedef struct S611 T611;

/* RX_CHARACTER_SET */
typedef struct S612 T612;

/* SPECIAL [RX_CHARACTER_SET] */
typedef struct S614 T614;

/* ARRAY [RX_CHARACTER_SET] */
typedef struct S615 T615;

/* KL_SPECIAL_ROUTINES [LX_RULE] */
typedef struct S616 T616;

/* DS_ARRAYED_LIST_CURSOR [LX_RULE] */
typedef struct S617 T617;

/* SPECIAL [LX_START_CONDITION] */
typedef struct S618 T618;

/* KL_SPECIAL_ROUTINES [LX_START_CONDITION] */
typedef struct S619 T619;

/* DS_ARRAYED_LIST_CURSOR [LX_START_CONDITION] */
typedef struct S620 T620;

/* DS_SPARSE_TABLE_KEYS [LX_SYMBOL_CLASS, STRING_8] */
typedef struct S622 T622;

/* DS_ARRAYED_LIST_CURSOR [INTEGER_32] */
typedef struct S624 T624;

/* TO_SPECIAL [LX_SYMBOL_CLASS] */
typedef struct S625 T625;

/* LX_SYMBOL_CLASS_TRANSITION [LX_NFA_STATE] */
typedef struct S626 T626;

/* LX_EPSILON_TRANSITION [LX_NFA_STATE] */
typedef struct S628 T628;

/* LX_SYMBOL_TRANSITION [LX_NFA_STATE] */
typedef struct S630 T630;

/* DS_BILINKABLE [INTEGER_32] */
typedef struct S631 T631;

/* SPECIAL [DS_BILINKABLE [INTEGER_32]] */
typedef struct S632 T632;

/* ARRAY [DS_BILINKABLE [INTEGER_32]] */
typedef struct S633 T633;

/* LX_ACTION */
typedef struct S635 T635;

/* TO_SPECIAL [LX_NFA] */
typedef struct S636 T636;

/* DS_BUBBLE_SORTER [LX_NFA_STATE] */
typedef struct S637 T637;

/* DS_BUBBLE_SORTER [LX_RULE] */
typedef struct S639 T639;

/* SPECIAL [LX_NFA_STATE] */
typedef struct S641 T641;

/* KL_SPECIAL_ROUTINES [LX_NFA_STATE] */
typedef struct S643 T643;

/* DS_ARRAYED_LIST_CURSOR [LX_NFA_STATE] */
typedef struct S644 T644;

/* SPECIAL [LX_DFA_STATE] */
typedef struct S646 T646;

/* KL_SPECIAL_ROUTINES [LX_DFA_STATE] */
typedef struct S647 T647;

/* DS_ARRAYED_LIST_CURSOR [LX_DFA_STATE] */
typedef struct S648 T648;

/* ARRAY [LX_DFA_STATE] */
typedef struct S649 T649;

/* KL_ARRAY_ROUTINES [LX_DFA_STATE] */
typedef struct S650 T650;

/* DS_ARRAYED_LIST_CURSOR [LX_NFA] */
typedef struct S651 T651;

/* DS_SPARSE_TABLE_KEYS [LX_NFA, INTEGER_32] */
typedef struct S653 T653;

/* DS_HASH_TABLE_CURSOR [LX_NFA, INTEGER_32] */
typedef struct S655 T655;

/* KL_BINARY_INPUT_FILE */
typedef struct S656 T656;

/* KL_BINARY_OUTPUT_FILE */
typedef struct S657 T657;

/* FILE_NAME */
typedef struct S659 T659;

/* RAW_FILE */
typedef struct S660 T660;

/* DIRECTORY */
typedef struct S661 T661;

/* ARRAYED_LIST [STRING_8] */
typedef struct S662 T662;

/* KL_COMPARABLE_COMPARATOR [LX_RULE] */
typedef struct S665 T665;

/* KL_COMPARABLE_COMPARATOR [LX_NFA_STATE] */
typedef struct S668 T668;

/* TO_SPECIAL [LX_RULE] */
typedef struct S671 T671;

/* TO_SPECIAL [LX_START_CONDITION] */
typedef struct S672 T672;

/* DS_SPARSE_TABLE_KEYS_CURSOR [LX_SYMBOL_CLASS, STRING_8] */
typedef struct S673 T673;

/* TO_SPECIAL [LX_NFA_STATE] */
typedef struct S674 T674;

/* TO_SPECIAL [LX_DFA_STATE] */
typedef struct S675 T675;

/* DS_SPARSE_TABLE_KEYS_CURSOR [LX_NFA, INTEGER_32] */
typedef struct S676 T676;

/* STRING_SEARCHER */
typedef struct S677 T677;

/* HASH_TABLE [C_STRING, STRING_8] */
typedef struct S678 T678;

/* DS_SHELL_SORTER [INTEGER_32] */
typedef struct S679 T679;

/* TYPED_POINTER [FILE_NAME] */
typedef struct S681 T681;

/* KL_COMPARABLE_COMPARATOR [INTEGER_32] */
typedef struct S684 T684;

/* PRIMES */
typedef struct S687 T687;

/* SPECIAL [C_STRING] */
typedef struct S688 T688;

/* Struct for boxed version of type BOOLEAN */
struct Sb1 {
	int id;
	T1 z1; /* item */
};

/* Struct for boxed version of type CHARACTER_8 */
struct Sb2 {
	int id;
	T2 z1; /* item */
};

/* Struct for boxed version of type CHARACTER_32 */
struct Sb3 {
	int id;
	T3 z1; /* item */
};

/* Struct for boxed version of type INTEGER_8 */
struct Sb4 {
	int id;
	T4 z1; /* item */
};

/* Struct for boxed version of type INTEGER_16 */
struct Sb5 {
	int id;
	T5 z1; /* item */
};

/* Struct for boxed version of type INTEGER_32 */
struct Sb6 {
	int id;
	T6 z1; /* item */
};

/* Struct for boxed version of type INTEGER_64 */
struct Sb7 {
	int id;
	T7 z1; /* item */
};

/* Struct for boxed version of type NATURAL_8 */
struct Sb8 {
	int id;
	T8 z1; /* item */
};

/* Struct for boxed version of type NATURAL_16 */
struct Sb9 {
	int id;
	T9 z1; /* item */
};

/* Struct for boxed version of type NATURAL_32 */
struct Sb10 {
	int id;
	T10 z1; /* item */
};

/* Struct for boxed version of type NATURAL_64 */
struct Sb11 {
	int id;
	T11 z1; /* item */
};

/* Struct for boxed version of type REAL_32 */
struct Sb12 {
	int id;
	T12 z1; /* item */
};

/* Struct for boxed version of type REAL_64 */
struct Sb13 {
	int id;
	T13 z1; /* item */
};

/* Struct for boxed version of type POINTER */
struct Sb14 {
	int id;
	T14 z1; /* item */
};

/* Struct for type TYPED_POINTER [ANY] */
struct S77 {
	int id;
	T14 a1; /* to_pointer */
};

/* Struct for type TYPED_POINTER [SPECIAL [CHARACTER_8]] */
struct S131 {
	int id;
	T14 a1; /* to_pointer */
};

/* Struct for type TYPED_POINTER [NATURAL_8] */
struct S370 {
	int id;
	T14 a1; /* to_pointer */
};

/* Struct for type TYPED_POINTER [FILE_NAME] */
struct S681 {
	int id;
	T14 a1; /* to_pointer */
};

/* Struct for type SPECIAL [CHARACTER_8] */
struct S15 {
	int id;
	T6 z1; /* count */
	T2 z2[1]; /* item */
};

/* Struct for type STRING_8 */
struct S17 {
	int id;
	T0* a1; /* area */
	T6 a2; /* count */
	T6 a3; /* internal_hash_code */
};

/* Struct for type GEANT */
struct S21 {
	int id;
	T0* a1; /* error_handler */
	T1 a2; /* verbose */
	T1 a3; /* debug_mode */
	T1 a4; /* no_exec */
	T0* a5; /* build_filename */
	T0* a6; /* start_target_name */
	T1 a7; /* show_target_info */
};

/* Struct for type GEANT_PROJECT */
struct S22 {
	int id;
	T0* a1; /* targets */
	T0* a2; /* name */
	T1 a3; /* build_successful */
	T0* a4; /* start_target_name */
	T0* a5; /* default_target_name */
	T0* a6; /* output_file */
	T0* a7; /* variables */
	T0* a8; /* selected_targets */
	T0* a9; /* targets_stack */
	T0* a10; /* task_factory */
	T0* a11; /* options */
	T0* a12; /* inherit_clause */
	T0* a13; /* position_table */
	T0* a14; /* description */
	T1 a15; /* old_inherit */
};

/* Struct for type GEANT_PROJECT_LOADER */
struct S23 {
	int id;
	T0* a1; /* project_element */
	T0* a2; /* build_filename */
};

/* Struct for type GEANT_PROJECT_OPTIONS */
struct S24 {
	int id;
	T1 a1; /* verbose */
	T1 a2; /* debug_mode */
	T1 a3; /* no_exec */
	T1 a4; /* variable_local_by_default */
};

/* Struct for type GEANT_PROJECT_VARIABLES */
struct S25 {
	int id;
	T0* a1; /* key_equality_tester */
	T0* a2; /* internal_keys */
	T6 a3; /* position */
	T6 a4; /* count */
	T6 a5; /* capacity */
	T6 a6; /* slots_position */
	T6 a7; /* free_slot */
	T6 a8; /* last_position */
	T0* a9; /* equality_tester */
	T6 a10; /* found_position */
	T6 a11; /* modulus */
	T6 a12; /* clashes_previous_position */
	T0* a13; /* item_storage */
	T0* a14; /* clashes */
	T0* a15; /* slots */
	T0* a16; /* key_storage */
	T0* a17; /* internal_cursor */
	T0* a18; /* special_item_routines */
	T0* a19; /* special_key_routines */
	T0* a20; /* hash_function */
};

/* Struct for type GEANT_TARGET */
struct S26 {
	int id;
	T0* a1; /* name */
	T0* a2; /* project */
	T0* a3; /* xml_element */
	T0* a4; /* position */
	T0* a5; /* formal_arguments */
	T0* a6; /* formal_locals */
	T0* a7; /* formal_globals */
	T0* a8; /* obsolete_message */
	T0* a9; /* exports */
	T1 a10; /* execute_once */
	T0* a11; /* description */
	T1 a12; /* is_executed */
	T0* a13; /* precursor_target */
	T0* a14; /* redefining_target */
};

/* Struct for type KL_ARGUMENTS */
struct S27 {
	int id;
	T0* a1; /* program_name */
};

/* Struct for type UT_ERROR_HANDLER */
struct S28 {
	int id;
	T0* a1; /* error_file */
	T0* a2; /* warning_file */
	T0* a3; /* info_file */
};

/* Struct for type GEANT_VARIABLES */
struct S29 {
	int id;
	T6 a1; /* position */
	T6 a2; /* count */
	T6 a3; /* capacity */
	T6 a4; /* slots_position */
	T6 a5; /* free_slot */
	T6 a6; /* last_position */
	T0* a7; /* key_equality_tester */
	T0* a8; /* internal_keys */
	T6 a9; /* found_position */
	T6 a10; /* modulus */
	T6 a11; /* clashes_previous_position */
	T0* a12; /* item_storage */
	T0* a13; /* clashes */
	T0* a14; /* slots */
	T0* a15; /* key_storage */
	T0* a16; /* equality_tester */
	T0* a17; /* special_item_routines */
	T0* a18; /* special_key_routines */
	T0* a19; /* internal_cursor */
	T0* a20; /* hash_function */
};

/* Struct for type GEANT_PROJECT_ELEMENT */
struct S30 {
	int id;
	T0* a1; /* project */
	T0* a2; /* xml_element */
};

/* Struct for type DS_HASH_TABLE [GEANT_TARGET, STRING_8] */
struct S31 {
	int id;
	T6 a1; /* found_position */
	T0* a2; /* item_storage */
	T0* a3; /* key_equality_tester */
	T0* a4; /* internal_keys */
	T6 a5; /* position */
	T6 a6; /* last_position */
	T6 a7; /* capacity */
	T6 a8; /* slots_position */
	T6 a9; /* count */
	T0* a10; /* equality_tester */
	T6 a11; /* modulus */
	T6 a12; /* clashes_previous_position */
	T0* a13; /* clashes */
	T0* a14; /* slots */
	T0* a15; /* key_storage */
	T6 a16; /* free_slot */
	T0* a17; /* internal_cursor */
	T0* a18; /* special_item_routines */
	T0* a19; /* special_key_routines */
	T0* a20; /* hash_function */
};

/* Struct for type SPECIAL [STRING_8] */
struct S32 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type ARRAY [STRING_8] */
struct S33 {
	int id;
	T0* a1; /* area */
	T6 a2; /* lower */
	T6 a3; /* upper */
};

/* Struct for type GEANT_ARGUMENT_VARIABLES */
struct S34 {
	int id;
	T6 a1; /* position */
	T6 a2; /* count */
	T6 a3; /* capacity */
	T6 a4; /* slots_position */
	T6 a5; /* free_slot */
	T6 a6; /* last_position */
	T0* a7; /* key_equality_tester */
	T0* a8; /* internal_keys */
	T6 a9; /* found_position */
	T6 a10; /* modulus */
	T6 a11; /* clashes_previous_position */
	T0* a12; /* item_storage */
	T0* a13; /* clashes */
	T0* a14; /* slots */
	T0* a15; /* key_storage */
	T0* a16; /* equality_tester */
	T0* a17; /* special_item_routines */
	T0* a18; /* special_key_routines */
	T0* a19; /* internal_cursor */
	T0* a20; /* hash_function */
};

/* Struct for type AP_FLAG */
struct S35 {
	int id;
	T6 a1; /* occurrences */
	T0* a2; /* description */
	T0* a3; /* long_form */
	T2 a4; /* short_form */
	T1 a5; /* has_short_form */
	T1 a6; /* is_mandatory */
	T6 a7; /* maximum_occurrences */
	T1 a8; /* is_hidden */
};

/* Struct for type AP_ALTERNATIVE_OPTIONS_LIST */
struct S36 {
	int id;
	T0* a1; /* introduction_option */
	T0* a2; /* parameters_description */
	T0* a3; /* internal_cursor */
	T0* a4; /* first_cell */
};

/* Struct for type AP_STRING_OPTION */
struct S37 {
	int id;
	T0* a1; /* parameters */
	T0* a2; /* description */
	T0* a3; /* parameter_description */
	T1 a4; /* needs_parameter */
	T2 a5; /* short_form */
	T1 a6; /* has_short_form */
	T0* a7; /* long_form */
	T1 a8; /* is_mandatory */
	T6 a9; /* maximum_occurrences */
	T1 a10; /* is_hidden */
};

/* Struct for type AP_PARSER */
struct S38 {
	int id;
	T0* a1; /* options */
	T0* a2; /* alternative_options_lists */
	T0* a3; /* error_handler */
	T0* a4; /* parameters */
	T0* a5; /* help_option */
	T0* a6; /* application_description */
	T0* a7; /* parameters_description */
	T0* a8; /* argument_list */
	T0* a9; /* current_options */
	T1 a10; /* is_first_option */
	T0* a11; /* last_option_parameter */
};

/* Struct for type AP_ERROR */
struct S40 {
	int id;
	T0* a1; /* parameters */
	T0* a2; /* default_template */
	T0* a3; /* code */
};

/* Struct for type AP_ERROR_HANDLER */
struct S45 {
	int id;
	T1 a1; /* has_error */
	T0* a2; /* error_file */
	T0* a3; /* warning_file */
	T0* a4; /* info_file */
};

/* Struct for type KL_STANDARD_FILES */
struct S46 {
	int id;
};

/* Struct for type KL_STDERR_FILE */
struct S47 {
	int id;
	T14 a1; /* file_pointer */
	T0* a2; /* name */
	T6 a3; /* mode */
};

/* Struct for type KL_EXCEPTIONS */
struct S48 {
	int id;
};

/* Struct for type UT_VERSION_NUMBER */
struct S49 {
	int id;
	T0* a1; /* parameters */
};

/* Struct for type KL_OPERATING_SYSTEM */
struct S51 {
	int id;
};

/* Struct for type KL_WINDOWS_FILE_SYSTEM */
struct S53 {
	int id;
	T2 a1; /* secondary_directory_separator */
};

/* Struct for type KL_UNIX_FILE_SYSTEM */
struct S54 {
	int id;
};

/* Struct for type KL_TEXT_INPUT_FILE */
struct S55 {
	int id;
	T0* a1; /* string_name */
	T6 a2; /* mode */
	T0* a3; /* last_string */
	T0* a4; /* name */
	T0* a5; /* character_buffer */
	T1 a6; /* end_of_file */
	T14 a7; /* file_pointer */
	T1 a8; /* descriptor_available */
	T2 a9; /* last_character */
};

/* Struct for type GEANT_PROJECT_PARSER */
struct S56 {
	int id;
	T0* a1; /* last_project_element */
	T0* a2; /* variables */
	T0* a3; /* options */
	T0* a4; /* build_filename */
	T0* a5; /* xml_parser */
	T0* a6; /* tree_pipe */
};

/* Struct for type GEANT_PROJECT_VARIABLE_RESOLVER */
struct S58 {
	int id;
	T0* a1; /* variables */
};

/* Struct for type UC_STRING_EQUALITY_TESTER */
struct S59 {
	int id;
};

/* Struct for type DS_SPARSE_TABLE_KEYS [STRING_8, STRING_8] */
struct S61 {
	int id;
	T0* a1; /* table */
	T0* a2; /* equality_tester */
	T0* a3; /* internal_cursor */
};

/* Struct for type SPECIAL [INTEGER_32] */
struct S63 {
	int id;
	T6 z1; /* count */
	T6 z2[1]; /* item */
};

/* Struct for type DS_HASH_TABLE_CURSOR [STRING_8, STRING_8] */
struct S64 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
	T0* a3; /* next_cursor */
};

/* Struct for type KL_SPECIAL_ROUTINES [INTEGER_32] */
struct S65 {
	int id;
};

/* Struct for type KL_SPECIAL_ROUTINES [STRING_8] */
struct S66 {
	int id;
};

/* Struct for type KL_STDOUT_FILE */
struct S68 {
	int id;
	T14 a1; /* file_pointer */
	T0* a2; /* name */
	T6 a3; /* mode */
};

/* Struct for type DS_LINKED_LIST_CURSOR [AP_OPTION] */
struct S69 {
	int id;
	T0* a1; /* container */
	T1 a2; /* before */
	T1 a3; /* after */
	T0* a4; /* current_cell */
	T0* a5; /* next_cursor */
};

/* Struct for type DS_ARRAYED_LIST [STRING_8] */
struct S71 {
	int id;
	T6 a1; /* count */
	T0* a2; /* storage */
	T0* a3; /* internal_cursor */
	T0* a4; /* special_routines */
	T6 a5; /* capacity */
	T0* a6; /* equality_tester */
};

/* Struct for type DS_ARRAYED_LIST_CURSOR [STRING_8] */
struct S72 {
	int id;
	T6 a1; /* position */
	T0* a2; /* next_cursor */
	T0* a3; /* container */
};

/* Struct for type AP_DISPLAY_HELP_FLAG */
struct S73 {
	int id;
	T0* a1; /* description */
	T2 a2; /* short_form */
	T1 a3; /* has_short_form */
	T0* a4; /* long_form */
	T6 a5; /* occurrences */
	T1 a6; /* is_mandatory */
	T6 a7; /* maximum_occurrences */
	T1 a8; /* is_hidden */
};

/* Struct for type DS_ARRAYED_LIST [AP_OPTION] */
struct S74 {
	int id;
	T0* a1; /* internal_cursor */
	T6 a2; /* count */
	T0* a3; /* equality_tester */
	T0* a4; /* storage */
	T0* a5; /* special_routines */
	T6 a6; /* capacity */
};

/* Struct for type DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST] */
struct S75 {
	int id;
	T0* a1; /* internal_cursor */
	T0* a2; /* storage */
	T0* a3; /* special_routines */
	T6 a4; /* capacity */
	T6 a5; /* count */
};

/* Struct for type KL_STRING_ROUTINES */
struct S76 {
	int id;
};

/* Struct for type DS_HASH_TABLE [STRING_8, STRING_8] */
struct S81 {
	int id;
	T0* a1; /* key_equality_tester */
	T0* a2; /* internal_keys */
	T0* a3; /* equality_tester */
	T6 a4; /* capacity */
	T6 a5; /* modulus */
	T6 a6; /* last_position */
	T6 a7; /* free_slot */
	T6 a8; /* position */
	T0* a9; /* internal_cursor */
	T0* a10; /* special_item_routines */
	T0* a11; /* item_storage */
	T0* a12; /* special_key_routines */
	T0* a13; /* key_storage */
	T0* a14; /* clashes */
	T0* a15; /* slots */
	T6 a16; /* found_position */
	T6 a17; /* slots_position */
	T6 a18; /* count */
	T6 a19; /* clashes_previous_position */
	T0* a20; /* hash_function */
};

/* Struct for type EXECUTION_ENVIRONMENT */
struct S83 {
	int id;
	T6 a1; /* return_code */
};

/* Struct for type KL_ANY_ROUTINES */
struct S84 {
	int id;
};

/* Struct for type KL_PATHNAME */
struct S86 {
	int id;
	T6 a1; /* count */
	T0* a2; /* drive */
	T0* a3; /* hostname */
	T0* a4; /* sharename */
	T1 a5; /* is_relative */
	T0* a6; /* components */
};

/* Struct for type UNIX_FILE_INFO */
struct S87 {
	int id;
	T0* a1; /* buffered_file_info */
	T0* a2; /* file_name */
};

/* Struct for type ? KL_LINKABLE [CHARACTER_8] */
struct S89 {
	int id;
	T2 a1; /* item */
	T0* a2; /* right */
};

/* Struct for type XM_EXPAT_PARSER_FACTORY */
struct S91 {
	int id;
};

/* Struct for type XM_EIFFEL_PARSER */
struct S93 {
	int id;
	T0* a1; /* internal_last_error_description */
	T0* a2; /* scanner */
	T0* a3; /* error_positions */
	T0* a4; /* scanners */
	T1 a5; /* in_external_dtd */
	T0* a6; /* callbacks */
	T0* a7; /* entities */
	T0* a8; /* pe_entities */
	T0* a9; /* dtd_resolver */
	T0* a10; /* entity_resolver */
	T1 a11; /* use_namespaces */
	T6 a12; /* string_mode */
	T0* a13; /* yyss */
	T0* a14; /* yytranslate */
	T0* a15; /* yyr1 */
	T0* a16; /* yytypes1 */
	T0* a17; /* yytypes2 */
	T0* a18; /* yydefact */
	T0* a19; /* yydefgoto */
	T0* a20; /* yypact */
	T0* a21; /* yypgoto */
	T0* a22; /* yytable */
	T0* a23; /* yycheck */
	T6 a24; /* yy_parsing_status */
	T6 a25; /* yy_suspended_yystacksize */
	T6 a26; /* yy_suspended_yystate */
	T6 a27; /* yy_suspended_yyn */
	T6 a28; /* yy_suspended_yychar1 */
	T6 a29; /* yy_suspended_index */
	T6 a30; /* yy_suspended_yyss_top */
	T6 a31; /* yy_suspended_yy_goto */
	T6 a32; /* yyssp */
	T6 a33; /* error_count */
	T1 a34; /* yy_lookahead_needed */
	T6 a35; /* yyerrstatus */
	T6 a36; /* last_token */
	T6 a37; /* yyvsp1 */
	T6 a38; /* yyvsp2 */
	T6 a39; /* yyvsp3 */
	T6 a40; /* yyvsp4 */
	T6 a41; /* yyvsp5 */
	T6 a42; /* yyvsp6 */
	T6 a43; /* yyvsp7 */
	T6 a44; /* yyvsp8 */
	T6 a45; /* yyvsp9 */
	T6 a46; /* yyvsp10 */
	T6 a47; /* yyvsp11 */
	T0* a48; /* last_string_value */
	T6 a49; /* yyvsc1 */
	T0* a50; /* yyvs1 */
	T0* a51; /* yyspecial_routines1 */
	T0* a52; /* last_any_value */
	T6 a53; /* yyvsc4 */
	T0* a54; /* yyvs4 */
	T0* a55; /* yyspecial_routines4 */
	T6 a56; /* yyvsc2 */
	T0* a57; /* yyvs2 */
	T0* a58; /* yyspecial_routines2 */
	T0* a59; /* yyvs11 */
	T6 a60; /* yyvsc11 */
	T0* a61; /* yyspecial_routines11 */
	T0* a62; /* yyvs10 */
	T0* a63; /* yyvs5 */
	T6 a64; /* yyvsc10 */
	T0* a65; /* yyspecial_routines10 */
	T6 a66; /* yyvsc3 */
	T0* a67; /* yyvs3 */
	T0* a68; /* yyspecial_routines3 */
	T0* a69; /* yyvs6 */
	T6 a70; /* yyvsc6 */
	T0* a71; /* yyspecial_routines6 */
	T0* a72; /* yyvs8 */
	T0* a73; /* yyvs7 */
	T6 a74; /* yyvsc8 */
	T0* a75; /* yyspecial_routines8 */
	T6 a76; /* yyvsc7 */
	T0* a77; /* yyspecial_routines7 */
	T0* a78; /* yyvs9 */
	T6 a79; /* yyvsc9 */
	T0* a80; /* yyspecial_routines9 */
	T6 a81; /* yyvsc5 */
	T0* a82; /* yyspecial_routines5 */
	T0* a83; /* dtd_callbacks */
};

/* Struct for type XM_TREE_CALLBACKS_PIPE */
struct S94 {
	int id;
	T0* a1; /* start */
	T0* a2; /* tree */
	T0* a3; /* error */
	T0* a4; /* last */
};

/* Struct for type XM_CALLBACKS_TO_TREE_FILTER */
struct S97 {
	int id;
	T0* a1; /* last_position_table */
	T0* a2; /* document */
	T0* a3; /* next */
	T0* a4; /* source_parser */
	T0* a5; /* current_element */
	T0* a6; /* namespace_cache */
};

/* Struct for type XM_DOCUMENT */
struct S98 {
	int id;
	T0* a1; /* root_element */
	T0* a2; /* internal_cursor */
	T0* a3; /* first_cell */
	T0* a4; /* last_cell */
	T6 a5; /* count */
	T0* a6; /* parent */
};

/* Struct for type XM_ELEMENT */
struct S99 {
	int id;
	T0* a1; /* parent */
	T0* a2; /* name */
	T0* a3; /* namespace */
	T0* a4; /* internal_cursor */
	T0* a5; /* first_cell */
	T0* a6; /* last_cell */
	T6 a7; /* count */
};

/* Struct for type XM_STOP_ON_ERROR_FILTER */
struct S100 {
	int id;
	T1 a1; /* has_error */
	T0* a2; /* last_error */
	T0* a3; /* next */
};

/* Struct for type XM_POSITION_TABLE */
struct S101 {
	int id;
	T0* a1; /* table */
};

/* Struct for type KL_EXECUTION_ENVIRONMENT */
struct S104 {
	int id;
};

/* Struct for type DS_ARRAYED_STACK [GEANT_ARGUMENT_VARIABLES] */
struct S105 {
	int id;
	T6 a1; /* count */
	T0* a2; /* storage */
	T0* a3; /* special_routines */
	T6 a4; /* capacity */
};

/* Struct for type DS_ARRAYED_STACK [GEANT_VARIABLES] */
struct S106 {
	int id;
	T6 a1; /* count */
	T0* a2; /* storage */
	T0* a3; /* special_routines */
	T6 a4; /* capacity */
};

/* Struct for type DS_SPARSE_TABLE_KEYS_CURSOR [STRING_8, STRING_8] */
struct S107 {
	int id;
	T0* a1; /* container */
	T0* a2; /* table_cursor */
};

/* Struct for type TO_SPECIAL [INTEGER_32] */
struct S108 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [STRING_8] */
struct S109 {
	int id;
	T0* a1; /* area */
};

/* Struct for type DS_ARRAYED_LIST_CURSOR [AP_OPTION] */
struct S110 {
	int id;
	T6 a1; /* position */
	T0* a2; /* next_cursor */
	T0* a3; /* container */
};

/* Struct for type SPECIAL [AP_OPTION] */
struct S112 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [AP_OPTION] */
struct S113 {
	int id;
};

/* Struct for type DS_ARRAYED_LIST_CURSOR [AP_ALTERNATIVE_OPTIONS_LIST] */
struct S114 {
	int id;
	T6 a1; /* position */
	T0* a2; /* next_cursor */
	T0* a3; /* container */
};

/* Struct for type SPECIAL [AP_ALTERNATIVE_OPTIONS_LIST] */
struct S115 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [AP_ALTERNATIVE_OPTIONS_LIST] */
struct S116 {
	int id;
};

/* Struct for type UC_STRING */
struct S117 {
	int id;
	T6 a1; /* count */
	T6 a2; /* byte_count */
	T6 a3; /* internal_hash_code */
	T0* a4; /* area */
	T6 a5; /* last_byte_index_input */
	T6 a6; /* last_byte_index_result */
};

/* Struct for type STRING_TO_INTEGER_CONVERTOR */
struct S119 {
	int id;
	T6 a1; /* sign */
	T11 a2; /* part1 */
	T11 a3; /* part2 */
	T6 a4; /* last_state */
	T1 a5; /* internal_overflowed */
	T0* a6; /* leading_separators */
	T0* a7; /* trailing_separators */
	T6 a8; /* conversion_type */
	T1 a9; /* leading_separators_acceptable */
	T1 a10; /* trailing_separators_acceptable */
};

/* Struct for type DS_LINKED_LIST [XM_ELEMENT] */
struct S121 {
	int id;
	T6 a1; /* count */
	T0* a2; /* internal_cursor */
	T0* a3; /* first_cell */
	T0* a4; /* last_cell */
};

/* Struct for type DS_LINKED_LIST_CURSOR [XM_ELEMENT] */
struct S122 {
	int id;
	T1 a1; /* after */
	T0* a2; /* current_cell */
	T0* a3; /* container */
	T1 a4; /* before */
	T0* a5; /* next_cursor */
};

/* Struct for type GEANT_INHERIT_ELEMENT */
struct S123 {
	int id;
	T0* a1; /* geant_inherit */
	T0* a2; /* project */
	T0* a3; /* xml_element */
	T0* a4; /* position */
};

/* Struct for type GEANT_INHERIT */
struct S124 {
	int id;
	T0* a1; /* parents */
	T0* a2; /* project */
};

/* Struct for type SPECIAL [GEANT_TARGET] */
struct S125 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type DS_SPARSE_TABLE_KEYS [GEANT_TARGET, STRING_8] */
struct S127 {
	int id;
	T0* a1; /* table */
	T0* a2; /* equality_tester */
	T0* a3; /* internal_cursor */
};

/* Struct for type DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8] */
struct S129 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
	T0* a3; /* next_cursor */
};

/* Struct for type KL_SPECIAL_ROUTINES [GEANT_TARGET] */
struct S130 {
	int id;
};

/* Struct for type XM_EIFFEL_SCANNER */
struct S133 {
	int id;
	T6 a1; /* last_token */
	T0* a2; /* last_value */
	T0* a3; /* input_name */
	T6 a4; /* position */
	T6 a5; /* column */
	T6 a6; /* line */
	T0* a7; /* input_filter */
	T6 a8; /* yy_start_state */
	T0* a9; /* character_entity */
	T0* a10; /* input_stream */
	T0* a11; /* input_resolver */
	T1 a12; /* yy_more_flag */
	T6 a13; /* yy_more_len */
	T6 a14; /* yy_end */
	T6 a15; /* yy_start */
	T6 a16; /* yy_line */
	T6 a17; /* yy_column */
	T6 a18; /* yy_position */
	T0* a19; /* input_buffer */
	T0* a20; /* yy_state_stack */
	T6 a21; /* yy_state_count */
	T0* a22; /* yy_ec */
	T0* a23; /* yy_content_area */
	T0* a24; /* yy_accept */
	T6 a25; /* yy_last_accepting_state */
	T6 a26; /* yy_last_accepting_cpos */
	T0* a27; /* yy_chk */
	T0* a28; /* yy_base */
	T0* a29; /* yy_def */
	T0* a30; /* yy_meta */
	T0* a31; /* yy_nxt */
	T6 a32; /* yy_lp */
	T0* a33; /* yy_acclist */
	T6 a34; /* yy_looking_for_trail_begin */
	T6 a35; /* yy_full_match */
	T6 a36; /* yy_full_state */
	T6 a37; /* yy_full_lp */
	T1 a38; /* yy_rejected */
	T0* a39; /* last_error */
	T0* a40; /* start_conditions */
	T0* a41; /* yy_content */
};

/* Struct for type XM_DEFAULT_POSITION */
struct S134 {
	int id;
	T0* a1; /* source_name */
	T6 a2; /* row */
	T6 a3; /* column */
	T6 a4; /* byte_index */
};

/* Struct for type DS_BILINKED_LIST [XM_POSITION] */
struct S136 {
	int id;
	T0* a1; /* first_cell */
	T0* a2; /* internal_cursor */
	T0* a3; /* last_cell */
	T6 a4; /* count */
};

/* Struct for type DS_LINKED_STACK [XM_EIFFEL_SCANNER] */
struct S137 {
	int id;
	T6 a1; /* count */
	T0* a2; /* first_cell */
};

/* Struct for type XM_CALLBACKS_NULL */
struct S138 {
	int id;
};

/* Struct for type DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8] */
struct S139 {
	int id;
	T6 a1; /* position */
	T0* a2; /* item_storage */
	T6 a3; /* count */
	T6 a4; /* last_position */
	T6 a5; /* free_slot */
	T6 a6; /* capacity */
	T0* a7; /* key_equality_tester */
	T0* a8; /* internal_keys */
	T6 a9; /* modulus */
	T6 a10; /* slots_position */
	T6 a11; /* clashes_previous_position */
	T0* a12; /* internal_cursor */
	T6 a13; /* found_position */
	T0* a14; /* key_storage */
	T0* a15; /* clashes */
	T0* a16; /* slots */
	T0* a17; /* equality_tester */
	T0* a18; /* special_item_routines */
	T0* a19; /* special_key_routines */
	T0* a20; /* hash_function */
};

/* Struct for type XM_NULL_EXTERNAL_RESOLVER */
struct S141 {
	int id;
};

/* Struct for type SPECIAL [ANY] */
struct S142 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [ANY] */
struct S143 {
	int id;
};

/* Struct for type XM_EIFFEL_PARSER_NAME */
struct S144 {
	int id;
	T1 a1; /* use_namespaces */
	T6 a2; /* count */
	T0* a3; /* first */
	T0* a4; /* second */
	T0* a5; /* tail */
};

/* Struct for type XM_EIFFEL_DECLARATION */
struct S145 {
	int id;
	T0* a1; /* version */
	T0* a2; /* encoding */
	T1 a3; /* stand_alone */
};

/* Struct for type XM_DTD_EXTERNAL_ID */
struct S146 {
	int id;
	T0* a1; /* system_id */
	T0* a2; /* public_id */
};

/* Struct for type DS_HASH_SET [XM_EIFFEL_PARSER_NAME] */
struct S147 {
	int id;
	T6 a1; /* position */
	T0* a2; /* equality_tester */
	T6 a3; /* count */
	T6 a4; /* capacity */
	T6 a5; /* free_slot */
	T6 a6; /* last_position */
	T6 a7; /* modulus */
	T6 a8; /* slots_position */
	T6 a9; /* clashes_previous_position */
	T0* a10; /* internal_cursor */
	T6 a11; /* found_position */
	T0* a12; /* clashes */
	T0* a13; /* slots */
	T0* a14; /* item_storage */
	T0* a15; /* special_item_routines */
	T0* a16; /* hash_function */
};

/* Struct for type XM_DTD_ELEMENT_CONTENT */
struct S148 {
	int id;
	T0* a1; /* items */
	T2 a2; /* repetition */
	T0* a3; /* name */
	T2 a4; /* type */
	T1 a5; /* is_character_data_allowed */
};

/* Struct for type DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT] */
struct S149 {
	int id;
	T0* a1; /* internal_cursor */
	T0* a2; /* first_cell */
	T0* a3; /* last_cell */
	T6 a4; /* count */
};

/* Struct for type XM_DTD_ATTRIBUTE_CONTENT */
struct S150 {
	int id;
	T0* a1; /* name */
	T2 a2; /* type */
	T1 a3; /* is_list_type */
	T0* a4; /* enumeration_list */
	T2 a5; /* value */
	T0* a6; /* default_value */
};

/* Struct for type DS_BILINKED_LIST [STRING_8] */
struct S151 {
	int id;
	T0* a1; /* internal_cursor */
	T0* a2; /* first_cell */
	T0* a3; /* last_cell */
	T6 a4; /* count */
	T0* a5; /* equality_tester */
};

/* Struct for type SPECIAL [XM_EIFFEL_PARSER_NAME] */
struct S152 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [XM_EIFFEL_PARSER_NAME] */
struct S153 {
	int id;
};

/* Struct for type SPECIAL [XM_EIFFEL_DECLARATION] */
struct S154 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [XM_EIFFEL_DECLARATION] */
struct S155 {
	int id;
};

/* Struct for type SPECIAL [BOOLEAN] */
struct S156 {
	int id;
	T6 z1; /* count */
	T1 z2[1]; /* item */
};

/* Struct for type SPECIAL [XM_DTD_EXTERNAL_ID] */
struct S157 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [BOOLEAN] */
struct S158 {
	int id;
};

/* Struct for type SPECIAL [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]] */
struct S159 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]] */
struct S160 {
	int id;
};

/* Struct for type SPECIAL [XM_DTD_ELEMENT_CONTENT] */
struct S161 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [XM_DTD_ELEMENT_CONTENT] */
struct S162 {
	int id;
};

/* Struct for type SPECIAL [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]] */
struct S164 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type SPECIAL [XM_DTD_ATTRIBUTE_CONTENT] */
struct S166 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]] */
struct S167 {
	int id;
};

/* Struct for type KL_SPECIAL_ROUTINES [XM_DTD_ATTRIBUTE_CONTENT] */
struct S168 {
	int id;
};

/* Struct for type SPECIAL [DS_BILINKED_LIST [STRING_8]] */
struct S169 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [STRING_8]] */
struct S170 {
	int id;
};

/* Struct for type XM_EIFFEL_ENTITY_DEF */
struct S171 {
	int id;
	T0* a1; /* literal_name */
	T0* a2; /* value */
	T0* a3; /* resolver */
	T0* a4; /* external_id */
	T0* a5; /* character_entity */
	T0* a6; /* input_buffer */
	T1 a7; /* in_use */
	T0* a8; /* input_name */
	T0* a9; /* last_error */
	T0* a10; /* start_conditions */
	T6 a11; /* yy_start_state */
	T6 a12; /* yy_line */
	T6 a13; /* yy_column */
	T6 a14; /* yy_position */
	T6 a15; /* line */
	T6 a16; /* column */
	T6 a17; /* position */
	T1 a18; /* yy_more_flag */
	T6 a19; /* yy_more_len */
	T6 a20; /* yy_last_accepting_state */
	T6 a21; /* yy_last_accepting_cpos */
	T1 a22; /* yy_rejected */
	T6 a23; /* yy_state_count */
	T6 a24; /* yy_full_match */
	T6 a25; /* yy_lp */
	T6 a26; /* yy_looking_for_trail_begin */
	T6 a27; /* yy_full_lp */
	T6 a28; /* yy_full_state */
	T0* a29; /* yy_state_stack */
	T6 a30; /* yy_end */
	T6 a31; /* yy_start */
	T0* a32; /* yy_nxt */
	T0* a33; /* yy_chk */
	T0* a34; /* yy_base */
	T0* a35; /* yy_def */
	T0* a36; /* yy_ec */
	T0* a37; /* yy_meta */
	T0* a38; /* yy_accept */
	T0* a39; /* yy_content */
	T0* a40; /* yy_content_area */
	T6 a41; /* last_token */
	T0* a42; /* last_value */
	T0* a43; /* input_filter */
	T0* a44; /* input_stream */
	T0* a45; /* input_resolver */
	T0* a46; /* yy_acclist */
};

/* Struct for type KL_SPECIAL_ROUTINES [XM_DTD_EXTERNAL_ID] */
struct S172 {
	int id;
};

/* Struct for type XM_DTD_CALLBACKS_NULL */
struct S174 {
	int id;
};

/* Struct for type XM_EIFFEL_SCANNER_DTD */
struct S175 {
	int id;
	T6 a1; /* last_token */
	T0* a2; /* last_value */
	T0* a3; /* input_name */
	T6 a4; /* position */
	T6 a5; /* column */
	T6 a6; /* line */
	T0* a7; /* input_filter */
	T6 a8; /* yy_start_state */
	T0* a9; /* character_entity */
	T0* a10; /* input_stream */
	T0* a11; /* input_resolver */
	T1 a12; /* decl_start_sent */
	T1 a13; /* decl_end_sent */
	T1 a14; /* yy_more_flag */
	T6 a15; /* yy_more_len */
	T6 a16; /* yy_end */
	T6 a17; /* yy_start */
	T6 a18; /* yy_line */
	T6 a19; /* yy_column */
	T6 a20; /* yy_position */
	T0* a21; /* input_buffer */
	T0* a22; /* yy_state_stack */
	T6 a23; /* yy_state_count */
	T0* a24; /* yy_ec */
	T0* a25; /* yy_content_area */
	T0* a26; /* yy_accept */
	T6 a27; /* yy_last_accepting_state */
	T6 a28; /* yy_last_accepting_cpos */
	T0* a29; /* yy_chk */
	T0* a30; /* yy_base */
	T0* a31; /* yy_def */
	T0* a32; /* yy_meta */
	T0* a33; /* yy_nxt */
	T6 a34; /* yy_lp */
	T0* a35; /* yy_acclist */
	T6 a36; /* yy_looking_for_trail_begin */
	T6 a37; /* yy_full_match */
	T6 a38; /* yy_full_state */
	T6 a39; /* yy_full_lp */
	T1 a40; /* yy_rejected */
	T0* a41; /* last_error */
	T0* a42; /* start_conditions */
	T0* a43; /* yy_content */
};

/* Struct for type XM_EIFFEL_PE_ENTITY_DEF */
struct S177 {
	int id;
	T0* a1; /* resolver */
	T0* a2; /* external_id */
	T0* a3; /* literal_name */
	T0* a4; /* value */
	T0* a5; /* character_entity */
	T0* a6; /* input_buffer */
	T1 a7; /* in_use */
	T0* a8; /* input_name */
	T0* a9; /* last_error */
	T0* a10; /* start_conditions */
	T6 a11; /* yy_start_state */
	T6 a12; /* yy_line */
	T6 a13; /* yy_column */
	T6 a14; /* yy_position */
	T6 a15; /* line */
	T6 a16; /* column */
	T6 a17; /* position */
	T1 a18; /* yy_more_flag */
	T6 a19; /* yy_more_len */
	T6 a20; /* yy_last_accepting_state */
	T6 a21; /* yy_last_accepting_cpos */
	T1 a22; /* yy_rejected */
	T6 a23; /* yy_state_count */
	T6 a24; /* yy_full_match */
	T6 a25; /* yy_lp */
	T6 a26; /* yy_looking_for_trail_begin */
	T6 a27; /* yy_full_lp */
	T6 a28; /* yy_full_state */
	T0* a29; /* yy_state_stack */
	T6 a30; /* yy_end */
	T6 a31; /* yy_start */
	T1 a32; /* pre_sent */
	T1 a33; /* post_sent */
	T0* a34; /* yy_nxt */
	T0* a35; /* yy_chk */
	T0* a36; /* yy_base */
	T0* a37; /* yy_def */
	T0* a38; /* yy_ec */
	T0* a39; /* yy_meta */
	T0* a40; /* yy_accept */
	T0* a41; /* yy_content */
	T0* a42; /* yy_content_area */
	T6 a43; /* last_token */
	T0* a44; /* last_value */
	T0* a45; /* input_filter */
	T0* a46; /* input_stream */
	T0* a47; /* input_resolver */
	T0* a48; /* yy_acclist */
};

/* Struct for type XM_NAMESPACE_RESOLVER */
struct S178 {
	int id;
	T0* a1; /* next */
	T0* a2; /* context */
	T0* a3; /* element_prefix */
	T0* a4; /* element_local_part */
	T1 a5; /* forward_xmlns */
	T0* a6; /* attributes_prefix */
	T0* a7; /* attributes_local_part */
	T0* a8; /* attributes_value */
};

/* Struct for type SPECIAL [XM_CALLBACKS_FILTER] */
struct S179 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type ARRAY [XM_CALLBACKS_FILTER] */
struct S180 {
	int id;
	T0* a1; /* area */
	T6 a2; /* lower */
	T6 a3; /* upper */
};

/* Struct for type DS_LINKED_LIST [DS_PAIR [XM_POSITION, XM_NODE]] */
struct S181 {
	int id;
	T0* a1; /* internal_cursor */
	T0* a2; /* first_cell */
	T0* a3; /* last_cell */
	T6 a4; /* count */
};

/* Struct for type SPECIAL [GEANT_ARGUMENT_VARIABLES] */
struct S182 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [GEANT_ARGUMENT_VARIABLES] */
struct S183 {
	int id;
};

/* Struct for type SPECIAL [GEANT_VARIABLES] */
struct S184 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [GEANT_VARIABLES] */
struct S185 {
	int id;
};

/* Struct for type TO_SPECIAL [AP_OPTION] */
struct S187 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [AP_ALTERNATIVE_OPTIONS_LIST] */
struct S188 {
	int id;
	T0* a1; /* area */
};

/* Struct for type C_STRING */
struct S189 {
	int id;
	T6 a1; /* count */
	T0* a2; /* managed_data */
};

/* Struct for type DS_ARRAYED_STACK [GEANT_TARGET] */
struct S191 {
	int id;
	T6 a1; /* count */
	T0* a2; /* storage */
	T0* a3; /* special_routines */
	T6 a4; /* capacity */
};

/* Struct for type GEANT_TASK_FACTORY */
struct S192 {
	int id;
	T0* a1; /* project */
	T0* a2; /* builders */
};

/* Struct for type GEANT_PARENT */
struct S193 {
	int id;
	T0* a1; /* renames */
	T0* a2; /* parent_project */
	T0* a3; /* redefines */
	T0* a4; /* selects */
	T0* a5; /* project */
	T0* a6; /* unchanged_targets */
	T0* a7; /* renamed_targets */
	T0* a8; /* redefined_targets */
};

/* Struct for type DS_ARRAYED_LIST [GEANT_PARENT] */
struct S195 {
	int id;
	T0* a1; /* special_routines */
	T0* a2; /* storage */
	T6 a3; /* capacity */
	T0* a4; /* internal_cursor */
	T6 a5; /* count */
};

/* Struct for type DS_ARRAYED_LIST_CURSOR [GEANT_PARENT] */
struct S196 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
	T0* a3; /* next_cursor */
};

/* Struct for type GEANT_INTERPRETING_ELEMENT */
struct S197 {
	int id;
	T0* a1; /* project */
	T0* a2; /* xml_element */
	T0* a3; /* position */
};

/* Struct for type GEANT_ARGUMENT_ELEMENT */
struct S198 {
	int id;
	T0* a1; /* xml_element */
};

/* Struct for type GEANT_LOCAL_ELEMENT */
struct S199 {
	int id;
	T0* a1; /* xml_element */
};

/* Struct for type GEANT_GLOBAL_ELEMENT */
struct S200 {
	int id;
	T0* a1; /* xml_element */
};

/* Struct for type XM_ATTRIBUTE */
struct S201 {
	int id;
	T0* a1; /* name */
	T0* a2; /* namespace */
	T0* a3; /* value */
	T0* a4; /* parent */
};

/* Struct for type GEANT_GROUP */
struct S202 {
	int id;
	T0* a1; /* project */
	T0* a2; /* xml_element */
	T0* a3; /* position */
	T0* a4; /* parent */
	T0* a5; /* description */
};

/* Struct for type DS_LINKED_LIST_CURSOR [XM_NODE] */
struct S204 {
	int id;
	T1 a1; /* after */
	T0* a2; /* current_cell */
	T0* a3; /* container */
	T1 a4; /* before */
	T0* a5; /* next_cursor */
};

/* Struct for type ARRAY [INTEGER_32] */
struct S205 {
	int id;
	T0* a1; /* area */
	T6 a2; /* lower */
	T6 a3; /* upper */
};

/* Struct for type UC_UTF8_ROUTINES */
struct S206 {
	int id;
};

/* Struct for type UC_UTF8_STRING */
struct S207 {
	int id;
	T6 a1; /* count */
	T0* a2; /* area */
	T6 a3; /* byte_count */
	T6 a4; /* internal_hash_code */
	T6 a5; /* last_byte_index_input */
	T6 a6; /* last_byte_index_result */
};

/* Struct for type XM_EIFFEL_INPUT_STREAM */
struct S209 {
	int id;
	T0* a1; /* last_string */
	T6 a2; /* encoding */
	T0* a3; /* impl */
	T0* a4; /* utf_queue */
};

/* Struct for type KL_INTEGER_ROUTINES */
struct S210 {
	int id;
};

/* Struct for type KL_PLATFORM */
struct S211 {
	int id;
};

/* Struct for type DS_LINKED_LIST_CURSOR [DS_PAIR [XM_POSITION, XM_NODE]] */
struct S212 {
	int id;
	T1 a1; /* after */
	T0* a2; /* current_cell */
	T0* a3; /* container */
	T1 a4; /* before */
	T0* a5; /* next_cursor */
};

/* Struct for type DS_PAIR [XM_POSITION, XM_NODE] */
struct S213 {
	int id;
	T0* a1; /* first */
	T0* a2; /* second */
};

/* Struct for type INTEGER_OVERFLOW_CHECKER */
struct S214 {
	int id;
	T0* a1; /* integer_overflow_state1 */
	T0* a2; /* integer_overflow_state2 */
	T0* a3; /* natural_overflow_state1 */
	T0* a4; /* natural_overflow_state2 */
};

/* Struct for type DS_LINKABLE [XM_ELEMENT] */
struct S215 {
	int id;
	T0* a1; /* item */
	T0* a2; /* right */
};

/* Struct for type GEANT_PARENT_ELEMENT */
struct S216 {
	int id;
	T0* a1; /* parent */
	T0* a2; /* project */
	T0* a3; /* xml_element */
	T0* a4; /* position */
};

/* Struct for type DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_TARGET, STRING_8] */
struct S218 {
	int id;
	T0* a1; /* container */
	T0* a2; /* table_cursor */
};

/* Struct for type TO_SPECIAL [GEANT_TARGET] */
struct S219 {
	int id;
	T0* a1; /* area */
};

/* Struct for type XM_EIFFEL_CHARACTER_ENTITY */
struct S220 {
	int id;
	T6 a1; /* code */
};

/* Struct for type YY_BUFFER */
struct S221 {
	int id;
	T1 a1; /* beginning_of_line */
	T6 a2; /* count */
	T1 a3; /* filled */
	T0* a4; /* content */
	T6 a5; /* index */
	T6 a6; /* line */
	T6 a7; /* column */
	T6 a8; /* position */
	T6 a9; /* capacity */
};

/* Struct for type YY_FILE_BUFFER */
struct S222 {
	int id;
	T1 a1; /* beginning_of_line */
	T6 a2; /* count */
	T1 a3; /* filled */
	T0* a4; /* content */
	T6 a5; /* index */
	T6 a6; /* line */
	T6 a7; /* column */
	T6 a8; /* position */
	T0* a9; /* file */
	T1 a10; /* end_of_file */
	T6 a11; /* capacity */
	T1 a12; /* interactive */
};

/* Struct for type DS_LINKED_STACK [INTEGER_32] */
struct S224 {
	int id;
	T6 a1; /* count */
	T0* a2; /* first_cell */
};

/* Struct for type DS_BILINKABLE [XM_POSITION] */
struct S226 {
	int id;
	T0* a1; /* item */
	T0* a2; /* right */
	T0* a3; /* left */
};

/* Struct for type DS_BILINKED_LIST_CURSOR [XM_POSITION] */
struct S227 {
	int id;
	T0* a1; /* container */
	T1 a2; /* before */
};

/* Struct for type DS_LINKABLE [XM_EIFFEL_SCANNER] */
struct S228 {
	int id;
	T0* a1; /* item */
	T0* a2; /* right */
};

/* Struct for type SPECIAL [XM_EIFFEL_ENTITY_DEF] */
struct S229 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type DS_SPARSE_TABLE_KEYS [XM_EIFFEL_ENTITY_DEF, STRING_8] */
struct S230 {
	int id;
	T0* a1; /* table */
	T0* a2; /* equality_tester */
	T0* a3; /* internal_cursor */
};

/* Struct for type DS_HASH_TABLE_CURSOR [XM_EIFFEL_ENTITY_DEF, STRING_8] */
struct S232 {
	int id;
	T0* a1; /* next_cursor */
	T0* a2; /* container */
	T6 a3; /* position */
};

/* Struct for type KL_SPECIAL_ROUTINES [XM_EIFFEL_ENTITY_DEF] */
struct S234 {
	int id;
};

/* Struct for type TO_SPECIAL [ANY] */
struct S235 {
	int id;
	T0* a1; /* area */
};

/* Struct for type KL_EQUALITY_TESTER [XM_EIFFEL_PARSER_NAME] */
struct S236 {
	int id;
};

/* Struct for type DS_HASH_SET_CURSOR [XM_EIFFEL_PARSER_NAME] */
struct S237 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
};

/* Struct for type DS_BILINKED_LIST [XM_DTD_ELEMENT_CONTENT] */
struct S238 {
	int id;
	T0* a1; /* internal_cursor */
	T0* a2; /* first_cell */
	T0* a3; /* last_cell */
	T6 a4; /* count */
};

/* Struct for type DS_BILINKED_LIST_CURSOR [XM_DTD_ATTRIBUTE_CONTENT] */
struct S239 {
	int id;
	T0* a1; /* container */
	T1 a2; /* before */
	T1 a3; /* after */
	T0* a4; /* current_cell */
	T0* a5; /* next_cursor */
};

/* Struct for type DS_BILINKABLE [XM_DTD_ATTRIBUTE_CONTENT] */
struct S240 {
	int id;
	T0* a1; /* item */
	T0* a2; /* right */
	T0* a3; /* left */
};

/* Struct for type DS_LINKED_LIST [STRING_8] */
struct S241 {
	int id;
	T0* a1; /* internal_cursor */
	T6 a2; /* count */
	T0* a3; /* first_cell */
	T0* a4; /* last_cell */
	T0* a5; /* equality_tester */
};

/* Struct for type DS_BILINKED_LIST_CURSOR [STRING_8] */
struct S242 {
	int id;
	T0* a1; /* container */
	T1 a2; /* before */
	T1 a3; /* after */
	T0* a4; /* current_cell */
	T0* a5; /* next_cursor */
};

/* Struct for type DS_BILINKABLE [STRING_8] */
struct S243 {
	int id;
	T0* a1; /* item */
	T0* a2; /* right */
	T0* a3; /* left */
};

/* Struct for type TO_SPECIAL [XM_EIFFEL_PARSER_NAME] */
struct S244 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [XM_EIFFEL_DECLARATION] */
struct S245 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [BOOLEAN] */
struct S246 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]] */
struct S247 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [XM_DTD_ELEMENT_CONTENT] */
struct S248 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]] */
struct S249 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [XM_DTD_ATTRIBUTE_CONTENT] */
struct S250 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [DS_BILINKED_LIST [STRING_8]] */
struct S251 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [XM_DTD_EXTERNAL_ID] */
struct S252 {
	int id;
	T0* a1; /* area */
};

/* Struct for type XM_NAMESPACE_RESOLVER_CONTEXT */
struct S253 {
	int id;
	T0* a1; /* context */
};

/* Struct for type DS_LINKED_QUEUE [STRING_8] */
struct S255 {
	int id;
	T0* a1; /* first_cell */
	T6 a2; /* count */
	T0* a3; /* last_cell */
};

/* Struct for type TO_SPECIAL [GEANT_ARGUMENT_VARIABLES] */
struct S256 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [GEANT_VARIABLES] */
struct S257 {
	int id;
	T0* a1; /* area */
};

/* Struct for type SPECIAL [NATURAL_8] */
struct S258 {
	int id;
	T6 z1; /* count */
	T8 z2[1]; /* item */
};

/* Struct for type GEANT_STRING_INTERPRETER */
struct S259 {
	int id;
	T0* a1; /* variable_resolver */
};

/* Struct for type KL_ARRAY_ROUTINES [INTEGER_32] */
struct S262 {
	int id;
};

/* Struct for type MANAGED_POINTER */
struct S264 {
	int id;
	T1 a1; /* is_shared */
	T14 a2; /* item */
	T6 a3; /* count */
};

/* Struct for type DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8] */
struct S265 {
	int id;
	T0* a1; /* key_equality_tester */
	T0* a2; /* internal_keys */
	T6 a3; /* count */
	T6 a4; /* capacity */
	T6 a5; /* free_slot */
	T6 a6; /* last_position */
	T0* a7; /* equality_tester */
	T6 a8; /* found_position */
	T6 a9; /* modulus */
	T6 a10; /* position */
	T0* a11; /* clashes */
	T0* a12; /* slots */
	T0* a13; /* item_storage */
	T0* a14; /* key_storage */
	T0* a15; /* internal_cursor */
	T0* a16; /* special_item_routines */
	T0* a17; /* special_key_routines */
	T0* a18; /* hash_function */
	T6 a19; /* slots_position */
	T6 a20; /* clashes_previous_position */
};

/* Struct for type GEANT_GEC_TASK */
struct S266 {
	int id;
	T0* a1; /* command */
	T0* a2; /* position */
	T0* a3; /* project */
	T0* a4; /* xml_element */
};

/* Struct for type TUPLE [XM_ELEMENT] */
struct S267 {
	int id;
	T0* z1;
};

/* Struct for type TUPLE */
struct S268 {
	int id;
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEC_TASK] */
struct S269 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type TUPLE [GEANT_TASK_FACTORY] */
struct S270 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_ISE_TASK */
struct S273 {
	int id;
	T0* a1; /* command */
	T0* a2; /* position */
	T0* a3; /* project */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_ISE_TASK] */
struct S274 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_EXEC_TASK */
struct S275 {
	int id;
	T0* a1; /* command */
	T0* a2; /* xml_element */
	T0* a3; /* project */
	T0* a4; /* position */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_EXEC_TASK] */
struct S276 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_LCC_TASK */
struct S277 {
	int id;
	T0* a1; /* command */
	T0* a2; /* position */
	T0* a3; /* project */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_LCC_TASK] */
struct S278 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_SET_TASK */
struct S279 {
	int id;
	T0* a1; /* command */
	T0* a2; /* position */
	T0* a3; /* project */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_SET_TASK] */
struct S280 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_UNSET_TASK */
struct S281 {
	int id;
	T0* a1; /* command */
	T0* a2; /* position */
	T0* a3; /* project */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_UNSET_TASK] */
struct S282 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_GEXACE_TASK */
struct S283 {
	int id;
	T0* a1; /* command */
	T0* a2; /* project */
	T0* a3; /* position */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEXACE_TASK] */
struct S284 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_GELEX_TASK */
struct S285 {
	int id;
	T0* a1; /* command */
	T0* a2; /* position */
	T0* a3; /* project */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GELEX_TASK] */
struct S286 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_GEYACC_TASK */
struct S287 {
	int id;
	T0* a1; /* command */
	T0* a2; /* position */
	T0* a3; /* project */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEYACC_TASK] */
struct S288 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_GEPP_TASK */
struct S289 {
	int id;
	T0* a1; /* command */
	T0* a2; /* project */
	T0* a3; /* xml_element */
	T0* a4; /* position */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEPP_TASK] */
struct S290 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_GETEST_TASK */
struct S291 {
	int id;
	T0* a1; /* command */
	T0* a2; /* project */
	T0* a3; /* position */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GETEST_TASK] */
struct S292 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_GEANT_TASK */
struct S293 {
	int id;
	T0* a1; /* command */
	T0* a2; /* xml_element */
	T0* a3; /* project */
	T0* a4; /* position */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEANT_TASK] */
struct S294 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_ECHO_TASK */
struct S295 {
	int id;
	T0* a1; /* command */
	T0* a2; /* position */
	T0* a3; /* project */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_ECHO_TASK] */
struct S296 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_MKDIR_TASK */
struct S297 {
	int id;
	T0* a1; /* command */
	T0* a2; /* position */
	T0* a3; /* project */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_MKDIR_TASK] */
struct S298 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_DELETE_TASK */
struct S299 {
	int id;
	T0* a1; /* command */
	T0* a2; /* xml_element */
	T0* a3; /* project */
	T0* a4; /* position */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_DELETE_TASK] */
struct S300 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_COPY_TASK */
struct S301 {
	int id;
	T0* a1; /* command */
	T0* a2; /* xml_element */
	T0* a3; /* project */
	T0* a4; /* position */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_COPY_TASK] */
struct S302 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_MOVE_TASK */
struct S303 {
	int id;
	T0* a1; /* command */
	T0* a2; /* xml_element */
	T0* a3; /* project */
	T0* a4; /* position */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_MOVE_TASK] */
struct S304 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_SETENV_TASK */
struct S305 {
	int id;
	T0* a1; /* command */
	T0* a2; /* position */
	T0* a3; /* project */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_SETENV_TASK] */
struct S306 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_XSLT_TASK */
struct S307 {
	int id;
	T0* a1; /* command */
	T0* a2; /* project */
	T0* a3; /* position */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_XSLT_TASK] */
struct S308 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_OUTOFDATE_TASK */
struct S309 {
	int id;
	T0* a1; /* command */
	T0* a2; /* xml_element */
	T0* a3; /* project */
	T0* a4; /* position */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_OUTOFDATE_TASK] */
struct S310 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_EXIT_TASK */
struct S311 {
	int id;
	T0* a1; /* command */
	T0* a2; /* position */
	T0* a3; /* project */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_EXIT_TASK] */
struct S312 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_PRECURSOR_TASK */
struct S313 {
	int id;
	T0* a1; /* command */
	T0* a2; /* project */
	T0* a3; /* position */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_PRECURSOR_TASK] */
struct S314 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_AVAILABLE_TASK */
struct S315 {
	int id;
	T0* a1; /* command */
	T0* a2; /* position */
	T0* a3; /* project */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_AVAILABLE_TASK] */
struct S316 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_INPUT_TASK */
struct S317 {
	int id;
	T0* a1; /* command */
	T0* a2; /* position */
	T0* a3; /* project */
	T0* a4; /* xml_element */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_INPUT_TASK] */
struct S318 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type GEANT_REPLACE_TASK */
struct S319 {
	int id;
	T0* a1; /* command */
	T0* a2; /* xml_element */
	T0* a3; /* project */
	T0* a4; /* position */
};

/* Struct for type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_REPLACE_TASK] */
struct S320 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*, T0*);
};

/* Struct for type KL_SPECIAL_ROUTINES [GEANT_PARENT] */
struct S321 {
	int id;
};

/* Struct for type SPECIAL [GEANT_PARENT] */
struct S322 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type UC_UNICODE_ROUTINES */
struct S324 {
	int id;
};

/* Struct for type DS_LINKED_QUEUE [CHARACTER_8] */
struct S326 {
	int id;
	T6 a1; /* count */
	T0* a2; /* first_cell */
	T0* a3; /* last_cell */
};

/* Struct for type UC_UTF16_ROUTINES */
struct S327 {
	int id;
};

/* Struct for type DS_LINKABLE [DS_PAIR [XM_POSITION, XM_NODE]] */
struct S328 {
	int id;
	T0* a1; /* item */
	T0* a2; /* right */
};

/* Struct for type SPECIAL [NATURAL_64] */
struct S329 {
	int id;
	T6 z1; /* count */
	T11 z2[1]; /* item */
};

/* Struct for type GEANT_RENAME_ELEMENT */
struct S330 {
	int id;
	T0* a1; /* rename_clause */
	T0* a2; /* project */
	T0* a3; /* xml_element */
	T0* a4; /* position */
};

/* Struct for type GEANT_REDEFINE_ELEMENT */
struct S331 {
	int id;
	T0* a1; /* redefine_clause */
	T0* a2; /* project */
	T0* a3; /* xml_element */
	T0* a4; /* position */
};

/* Struct for type GEANT_SELECT_ELEMENT */
struct S332 {
	int id;
	T0* a1; /* select_clause */
	T0* a2; /* project */
	T0* a3; /* xml_element */
	T0* a4; /* position */
};

/* Struct for type GEANT_RENAME */
struct S333 {
	int id;
	T0* a1; /* original_name */
	T0* a2; /* new_name */
};

/* Struct for type DS_HASH_TABLE [GEANT_RENAME, STRING_8] */
struct S334 {
	int id;
	T6 a1; /* position */
	T0* a2; /* equality_tester */
	T6 a3; /* last_position */
	T6 a4; /* capacity */
	T6 a5; /* slots_position */
	T6 a6; /* count */
	T0* a7; /* key_equality_tester */
	T0* a8; /* internal_keys */
	T6 a9; /* modulus */
	T6 a10; /* clashes_previous_position */
	T6 a11; /* found_position */
	T0* a12; /* item_storage */
	T0* a13; /* clashes */
	T0* a14; /* slots */
	T0* a15; /* key_storage */
	T6 a16; /* free_slot */
	T0* a17; /* internal_cursor */
	T0* a18; /* special_item_routines */
	T0* a19; /* special_key_routines */
	T0* a20; /* hash_function */
};

/* Struct for type GEANT_REDEFINE */
struct S335 {
	int id;
	T0* a1; /* name */
};

/* Struct for type DS_HASH_TABLE [GEANT_REDEFINE, STRING_8] */
struct S336 {
	int id;
	T0* a1; /* equality_tester */
	T6 a2; /* position */
	T6 a3; /* last_position */
	T6 a4; /* capacity */
	T6 a5; /* slots_position */
	T6 a6; /* count */
	T0* a7; /* key_equality_tester */
	T0* a8; /* internal_keys */
	T6 a9; /* found_position */
	T6 a10; /* modulus */
	T6 a11; /* clashes_previous_position */
	T0* a12; /* item_storage */
	T0* a13; /* clashes */
	T0* a14; /* slots */
	T0* a15; /* key_storage */
	T6 a16; /* free_slot */
	T0* a17; /* internal_cursor */
	T0* a18; /* special_item_routines */
	T0* a19; /* special_key_routines */
	T0* a20; /* hash_function */
};

/* Struct for type GEANT_SELECT */
struct S337 {
	int id;
	T0* a1; /* name */
};

/* Struct for type DS_HASH_TABLE [GEANT_SELECT, STRING_8] */
struct S338 {
	int id;
	T0* a1; /* equality_tester */
	T6 a2; /* position */
	T6 a3; /* last_position */
	T6 a4; /* capacity */
	T6 a5; /* slots_position */
	T6 a6; /* count */
	T0* a7; /* key_equality_tester */
	T0* a8; /* internal_keys */
	T6 a9; /* found_position */
	T6 a10; /* modulus */
	T6 a11; /* clashes_previous_position */
	T0* a12; /* item_storage */
	T0* a13; /* clashes */
	T0* a14; /* slots */
	T0* a15; /* key_storage */
	T6 a16; /* free_slot */
	T0* a17; /* internal_cursor */
	T0* a18; /* special_item_routines */
	T0* a19; /* special_key_routines */
	T0* a20; /* hash_function */
};

/* Struct for type DS_LINKABLE [INTEGER_32] */
struct S340 {
	int id;
	T6 a1; /* item */
	T0* a2; /* right */
};

/* Struct for type DS_SPARSE_TABLE_KEYS_CURSOR [XM_EIFFEL_ENTITY_DEF, STRING_8] */
struct S341 {
	int id;
	T0* a1; /* container */
	T0* a2; /* table_cursor */
};

/* Struct for type TO_SPECIAL [XM_EIFFEL_ENTITY_DEF] */
struct S342 {
	int id;
	T0* a1; /* area */
};

/* Struct for type DS_BILINKED_LIST_CURSOR [XM_DTD_ELEMENT_CONTENT] */
struct S343 {
	int id;
	T0* a1; /* container */
	T1 a2; /* before */
};

/* Struct for type DS_BILINKABLE [XM_DTD_ELEMENT_CONTENT] */
struct S344 {
	int id;
	T0* a1; /* item */
	T0* a2; /* right */
	T0* a3; /* left */
};

/* Struct for type DS_LINKED_LIST_CURSOR [STRING_8] */
struct S345 {
	int id;
	T0* a1; /* container */
	T1 a2; /* before */
	T1 a3; /* after */
	T0* a4; /* current_cell */
	T0* a5; /* next_cursor */
};

/* Struct for type DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]] */
struct S347 {
	int id;
	T6 a1; /* count */
	T0* a2; /* last_cell */
	T0* a3; /* internal_cursor */
	T0* a4; /* first_cell */
};

/* Struct for type DS_BILINKED_LIST_CURSOR [DS_HASH_TABLE [STRING_8, STRING_8]] */
struct S348 {
	int id;
	T1 a1; /* before */
	T0* a2; /* current_cell */
	T0* a3; /* next_cursor */
	T0* a4; /* container */
	T1 a5; /* after */
};

/* Struct for type DS_LINKABLE [STRING_8] */
struct S349 {
	int id;
	T0* a1; /* item */
	T0* a2; /* right */
};

/* Struct for type GEANT_NAME_VALUE_ELEMENT */
struct S350 {
	int id;
	T0* a1; /* xml_element */
};

/* Struct for type AP_OPTION_COMPARATOR */
struct S351 {
	int id;
};

/* Struct for type DS_QUICK_SORTER [AP_OPTION] */
struct S352 {
	int id;
	T0* a1; /* comparator */
};

/* Struct for type ST_WORD_WRAPPER */
struct S354 {
	int id;
	T6 a1; /* new_line_indentation */
	T6 a2; /* broken_words */
	T6 a3; /* maximum_text_width */
};

/* Struct for type DS_HASH_SET [XM_NAMESPACE] */
struct S356 {
	int id;
	T6 a1; /* position */
	T0* a2; /* item_storage */
	T0* a3; /* equality_tester */
	T6 a4; /* last_position */
	T6 a5; /* capacity */
	T6 a6; /* slots_position */
	T6 a7; /* count */
	T6 a8; /* modulus */
	T6 a9; /* clashes_previous_position */
	T6 a10; /* free_slot */
	T0* a11; /* internal_cursor */
	T6 a12; /* found_position */
	T0* a13; /* clashes */
	T0* a14; /* slots */
	T0* a15; /* special_item_routines */
	T0* a16; /* hash_function */
};

/* Struct for type XM_COMMENT */
struct S357 {
	int id;
	T0* a1; /* data */
	T0* a2; /* parent */
};

/* Struct for type XM_PROCESSING_INSTRUCTION */
struct S358 {
	int id;
	T0* a1; /* target */
	T0* a2; /* data */
	T0* a3; /* parent */
};

/* Struct for type XM_CHARACTER_DATA */
struct S359 {
	int id;
	T0* a1; /* content */
	T0* a2; /* parent */
};

/* Struct for type XM_NAMESPACE */
struct S360 {
	int id;
	T0* a1; /* uri */
	T0* a2; /* ns_prefix */
};

/* Struct for type DS_LINKABLE [XM_NODE] */
struct S363 {
	int id;
	T0* a1; /* right */
	T0* a2; /* item */
};

/* Struct for type XM_NODE_TYPER */
struct S365 {
	int id;
	T0* a1; /* element */
	T0* a2; /* xml_attribute */
	T0* a3; /* composite */
	T0* a4; /* document */
	T0* a5; /* character_data */
	T0* a6; /* processing_instruction */
	T0* a7; /* comment */
};

/* Struct for type KL_CHARACTER_BUFFER */
struct S369 {
	int id;
	T0* a1; /* as_special */
	T0* a2; /* area */
};

/* Struct for type EXCEPTIONS */
struct S371 {
	int id;
};

/* Struct for type DS_SPARSE_TABLE_KEYS [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8] */
struct S373 {
	int id;
	T0* a1; /* table */
	T0* a2; /* equality_tester */
	T0* a3; /* internal_cursor */
};

/* Struct for type SPECIAL [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]] */
struct S375 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type DS_HASH_TABLE_CURSOR [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8] */
struct S376 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
};

/* Struct for type KL_SPECIAL_ROUTINES [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]] */
struct S377 {
	int id;
};

/* Struct for type GEANT_GEC_COMMAND */
struct S378 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T1 a3; /* c_compile */
	T1 a4; /* split_mode */
	T0* a5; /* ace_filename */
	T0* a6; /* clean */
	T1 a7; /* finalize */
	T1 a8; /* gelint */
	T0* a9; /* catcall_mode */
	T6 a10; /* split_size */
	T0* a11; /* garbage_collector */
	T0* a12; /* exit_code_variable_name */
	T6 a13; /* exit_code */
};

/* Struct for type DS_CELL [PROCEDURE [ANY, TUPLE]] */
struct S379 {
	int id;
	T0* a1; /* item */
};

/* Struct for type PROCEDURE [GEANT_GEC_TASK, TUPLE] */
struct S380 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_GEC_TASK] */
struct S381 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_ISE_COMMAND */
struct S382 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T0* a3; /* ace_filename */
	T0* a4; /* system_name */
	T0* a5; /* clean */
	T1 a6; /* finalize_mode */
	T1 a7; /* finish_freezing */
	T0* a8; /* exit_code_variable_name */
	T6 a9; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_ISE_TASK, TUPLE] */
struct S383 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_ISE_TASK] */
struct S384 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_FILESET_ELEMENT */
struct S385 {
	int id;
	T0* a1; /* fileset */
	T0* a2; /* project */
	T0* a3; /* xml_element */
	T0* a4; /* position */
};

/* Struct for type GEANT_EXEC_COMMAND */
struct S386 {
	int id;
	T0* a1; /* command_line */
	T0* a2; /* exit_code_variable_name */
	T0* a3; /* accept_errors */
	T0* a4; /* log_validation_messages_agent_cell */
	T0* a5; /* project */
	T0* a6; /* fileset */
	T6 a7; /* exit_code */
	T1 a8; /* single_execution_mode */
};

/* Struct for type GEANT_STRING_PROPERTY */
struct S387 {
	int id;
	T0* a1; /* string_value_agent */
	T1 a2; /* has_been_retrieved */
	T0* a3; /* retrieved_string_value */
};

/* Struct for type FUNCTION [GEANT_INTERPRETING_ELEMENT, TUPLE, STRING_8] */
struct S388 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T0* (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_INTERPRETING_ELEMENT, STRING_8] */
struct S389 {
	int id;
	T0* z1;
	T0* z2;
};

/* Struct for type GEANT_BOOLEAN_PROPERTY */
struct S390 {
	int id;
	T0* a1; /* string_value_agent */
	T1 a2; /* has_been_retrieved */
	T0* a3; /* retrieved_string_value */
};

/* Struct for type GEANT_FILESET */
struct S391 {
	int id;
	T0* a1; /* project */
	T0* a2; /* filenames */
	T0* a3; /* single_includes */
	T0* a4; /* single_excludes */
	T1 a5; /* force */
	T0* a6; /* dir_name */
	T0* a7; /* directory_name */
	T0* a8; /* include_wc_string */
	T0* a9; /* include_wildcard */
	T0* a10; /* exclude_wc_string */
	T0* a11; /* exclude_wildcard */
	T1 a12; /* concat */
	T0* a13; /* filename_variable_name */
	T0* a14; /* mapped_filename_variable_name */
	T0* a15; /* filename_directory_name */
	T0* a16; /* mapped_filename_directory_name */
	T1 a17; /* convert_to_filesystem */
	T0* a18; /* map */
};

/* Struct for type PROCEDURE [GEANT_EXEC_TASK, TUPLE] */
struct S392 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_EXEC_TASK] */
struct S393 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_LCC_COMMAND */
struct S394 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T0* a3; /* executable */
	T0* a4; /* source_filename */
	T6 a5; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_LCC_TASK, TUPLE] */
struct S395 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_LCC_TASK] */
struct S396 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_SET_COMMAND */
struct S397 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T0* a3; /* name */
	T0* a4; /* value */
	T6 a5; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_SET_TASK, TUPLE] */
struct S398 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_SET_TASK] */
struct S399 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_UNSET_COMMAND */
struct S400 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T0* a3; /* name */
	T6 a4; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_UNSET_TASK, TUPLE] */
struct S401 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_UNSET_TASK] */
struct S402 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_DEFINE_ELEMENT */
struct S403 {
	int id;
	T0* a1; /* project */
	T0* a2; /* xml_element */
	T0* a3; /* position */
};

/* Struct for type GEANT_GEXACE_COMMAND */
struct S404 {
	int id;
	T0* a1; /* defines */
	T0* a2; /* log_validation_messages_agent_cell */
	T0* a3; /* project */
	T1 a4; /* verbose */
	T1 a5; /* validate_command */
	T0* a6; /* system_command */
	T0* a7; /* library_command */
	T0* a8; /* format */
	T0* a9; /* xace_filename */
	T0* a10; /* output_filename */
	T6 a11; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_GEXACE_TASK, TUPLE] */
struct S405 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_GEXACE_TASK] */
struct S406 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_GELEX_COMMAND */
struct S407 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T0* a3; /* output_filename */
	T0* a4; /* input_filename */
	T0* a5; /* size */
	T1 a6; /* ecs */
	T1 a7; /* meta_ecs */
	T1 a8; /* backup */
	T1 a9; /* full */
	T1 a10; /* case_insensitive */
	T1 a11; /* no_default */
	T1 a12; /* no_warn */
	T1 a13; /* separate_actions */
	T6 a14; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_GELEX_TASK, TUPLE] */
struct S408 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_GELEX_TASK] */
struct S409 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_GEYACC_COMMAND */
struct S410 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T0* a3; /* output_filename */
	T0* a4; /* input_filename */
	T1 a5; /* separate_actions */
	T0* a6; /* verbose_filename */
	T1 a7; /* old_typing */
	T1 a8; /* new_typing */
	T0* a9; /* tokens_classname */
	T0* a10; /* tokens_filename */
	T6 a11; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_GEYACC_TASK, TUPLE] */
struct S411 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_GEYACC_TASK] */
struct S412 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_GEPP_COMMAND */
struct S413 {
	int id;
	T0* a1; /* defines */
	T0* a2; /* log_validation_messages_agent_cell */
	T0* a3; /* project */
	T0* a4; /* input_filename */
	T0* a5; /* output_filename */
	T1 a6; /* empty_lines */
	T0* a7; /* to_directory */
	T1 a8; /* force */
	T0* a9; /* fileset */
	T6 a10; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_GEPP_TASK, TUPLE] */
struct S414 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_GEPP_TASK] */
struct S415 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_GETEST_COMMAND */
struct S416 {
	int id;
	T0* a1; /* defines */
	T0* a2; /* log_validation_messages_agent_cell */
	T0* a3; /* project */
	T1 a4; /* generation */
	T1 a5; /* compilation */
	T1 a6; /* execution */
	T1 a7; /* verbose */
	T0* a8; /* config_filename */
	T0* a9; /* compile */
	T0* a10; /* class_regexp */
	T0* a11; /* feature_regexp */
	T1 a12; /* default_test_included */
	T1 a13; /* abort */
	T6 a14; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_GETEST_TASK, TUPLE] */
struct S417 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_GETEST_TASK] */
struct S418 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_GEANT_COMMAND */
struct S419 {
	int id;
	T0* a1; /* arguments */
	T0* a2; /* log_validation_messages_agent_cell */
	T0* a3; /* project */
	T0* a4; /* start_target_name */
	T1 a5; /* reuse_variables */
	T0* a6; /* filename */
	T1 a7; /* fork */
	T1 a8; /* has_fork_been_set */
	T0* a9; /* fileset */
	T0* a10; /* exit_code_variable_name */
	T6 a11; /* exit_code */
};

/* Struct for type ST_SPLITTER */
struct S420 {
	int id;
	T1 a1; /* has_escape_character */
	T2 a2; /* escape_character */
	T0* a3; /* separator_codes */
	T0* a4; /* separators */
};

/* Struct for type PROCEDURE [GEANT_GEANT_TASK, TUPLE] */
struct S421 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_GEANT_TASK] */
struct S422 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_ECHO_COMMAND */
struct S423 {
	int id;
	T0* a1; /* message_property */
	T0* a2; /* to_file_property */
	T0* a3; /* append_property */
	T0* a4; /* log_validation_messages_agent_cell */
	T0* a5; /* project */
	T0* a6; /* message_only_agent_cell */
	T0* a7; /* message_with_file_agent_cell */
	T6 a8; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_ECHO_TASK, TUPLE] */
struct S424 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_ECHO_TASK] */
struct S425 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_MKDIR_COMMAND */
struct S426 {
	int id;
	T0* a1; /* directory */
	T0* a2; /* log_validation_messages_agent_cell */
	T0* a3; /* project */
	T0* a4; /* mkdir_agent_cell */
	T6 a5; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_MKDIR_TASK, TUPLE] */
struct S427 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_MKDIR_TASK] */
struct S428 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_DIRECTORYSET_ELEMENT */
struct S429 {
	int id;
	T0* a1; /* directoryset */
	T0* a2; /* project */
	T0* a3; /* xml_element */
	T0* a4; /* position */
};

/* Struct for type GEANT_DELETE_COMMAND */
struct S430 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T0* a3; /* directory */
	T0* a4; /* file */
	T0* a5; /* fileset */
	T0* a6; /* directoryset */
	T6 a7; /* exit_code */
};

/* Struct for type GEANT_DIRECTORYSET */
struct S431 {
	int id;
	T0* a1; /* project */
	T0* a2; /* directory_names */
	T0* a3; /* single_includes */
	T0* a4; /* single_excludes */
	T0* a5; /* directory_name */
	T0* a6; /* include_wc_string */
	T0* a7; /* include_wildcard */
	T0* a8; /* exclude_wc_string */
	T0* a9; /* exclude_wildcard */
	T1 a10; /* concat */
	T0* a11; /* directory_name_variable_name */
	T1 a12; /* convert_to_filesystem */
};

/* Struct for type PROCEDURE [GEANT_DELETE_TASK, TUPLE] */
struct S432 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_DELETE_TASK] */
struct S433 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_COPY_COMMAND */
struct S434 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T0* a3; /* file */
	T0* a4; /* to_file */
	T0* a5; /* to_directory */
	T1 a6; /* force */
	T0* a7; /* fileset */
	T6 a8; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_COPY_TASK, TUPLE] */
struct S435 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_COPY_TASK] */
struct S436 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_MOVE_COMMAND */
struct S437 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T0* a3; /* file */
	T0* a4; /* to_file */
	T0* a5; /* to_directory */
	T0* a6; /* fileset */
	T6 a7; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_MOVE_TASK, TUPLE] */
struct S438 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_MOVE_TASK] */
struct S439 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_SETENV_COMMAND */
struct S440 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T0* a3; /* name */
	T0* a4; /* value */
	T6 a5; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_SETENV_TASK, TUPLE] */
struct S441 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_SETENV_TASK] */
struct S442 {
	int id;
	T0* z1;
};

/* Struct for type DS_PAIR [STRING_8, STRING_8] */
struct S443 {
	int id;
	T0* a1; /* first */
	T0* a2; /* second */
};

/* Struct for type GEANT_XSLT_COMMAND */
struct S444 {
	int id;
	T0* a1; /* parameters */
	T0* a2; /* log_validation_messages_agent_cell */
	T0* a3; /* project */
	T0* a4; /* input_filename */
	T0* a5; /* output_filename */
	T6 a6; /* processor */
	T0* a7; /* stylesheet_filename */
	T1 a8; /* force */
	T0* a9; /* indent */
	T0* a10; /* format */
	T0* a11; /* extdirs */
	T0* a12; /* classpath */
	T6 a13; /* exit_code */
};

/* Struct for type DS_ARRAYED_LIST [DS_PAIR [STRING_8, STRING_8]] */
struct S445 {
	int id;
	T0* a1; /* special_routines */
	T0* a2; /* storage */
	T6 a3; /* capacity */
	T0* a4; /* internal_cursor */
	T6 a5; /* count */
};

/* Struct for type PROCEDURE [GEANT_XSLT_TASK, TUPLE] */
struct S446 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_XSLT_TASK] */
struct S447 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_OUTOFDATE_COMMAND */
struct S448 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T0* a3; /* source_filename */
	T0* a4; /* target_filename */
	T0* a5; /* true_value */
	T0* a6; /* false_value */
	T0* a7; /* variable_name */
	T0* a8; /* fileset */
	T6 a9; /* exit_code */
	T1 a10; /* is_out_of_date */
};

/* Struct for type PROCEDURE [GEANT_OUTOFDATE_TASK, TUPLE] */
struct S449 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_OUTOFDATE_TASK] */
struct S450 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_EXIT_COMMAND */
struct S451 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T6 a3; /* code */
	T6 a4; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_EXIT_TASK, TUPLE] */
struct S452 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_EXIT_TASK] */
struct S453 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_PRECURSOR_COMMAND */
struct S454 {
	int id;
	T0* a1; /* arguments */
	T0* a2; /* log_validation_messages_agent_cell */
	T0* a3; /* project */
	T0* a4; /* parent */
	T6 a5; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_PRECURSOR_TASK, TUPLE] */
struct S455 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_PRECURSOR_TASK] */
struct S456 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_AVAILABLE_COMMAND */
struct S457 {
	int id;
	T0* a1; /* resource_name */
	T0* a2; /* variable_name */
	T0* a3; /* true_value */
	T0* a4; /* false_value */
	T0* a5; /* log_validation_messages_agent_cell */
	T0* a6; /* project */
	T0* a7; /* available_agent_cell */
	T6 a8; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_AVAILABLE_TASK, TUPLE] */
struct S458 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_AVAILABLE_TASK] */
struct S459 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_INPUT_COMMAND */
struct S460 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T0* a3; /* variable */
	T0* a4; /* message */
	T0* a5; /* default_value */
	T0* a6; /* validargs */
	T0* a7; /* validregexp */
	T1 a8; /* answer_required */
	T6 a9; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_INPUT_TASK, TUPLE] */
struct S461 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_INPUT_TASK] */
struct S462 {
	int id;
	T0* z1;
};

/* Struct for type GEANT_REPLACE_COMMAND */
struct S463 {
	int id;
	T0* a1; /* log_validation_messages_agent_cell */
	T0* a2; /* project */
	T0* a3; /* file */
	T0* a4; /* to_file */
	T0* a5; /* to_directory */
	T0* a6; /* match */
	T0* a7; /* token */
	T0* a8; /* variable_pattern */
	T0* a9; /* replace */
	T0* a10; /* flags */
	T0* a11; /* fileset */
	T6 a12; /* exit_code */
};

/* Struct for type PROCEDURE [GEANT_REPLACE_TASK, TUPLE] */
struct S464 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*);
};

/* Struct for type TUPLE [GEANT_REPLACE_TASK] */
struct S465 {
	int id;
	T0* z1;
};

/* Struct for type TO_SPECIAL [GEANT_PARENT] */
struct S466 {
	int id;
	T0* a1; /* area */
};

/* Struct for type SPECIAL [ARRAY [INTEGER_32]] */
struct S467 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type SPECIAL [SPECIAL [ARRAY [INTEGER_32]]] */
struct S468 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type DS_LINKABLE [CHARACTER_8] */
struct S469 {
	int id;
	T2 a1; /* item */
	T0* a2; /* right */
};

/* Struct for type KL_EQUALITY_TESTER [GEANT_RENAME] */
struct S470 {
	int id;
};

/* Struct for type DS_SPARSE_TABLE_KEYS [GEANT_RENAME, STRING_8] */
struct S471 {
	int id;
	T0* a1; /* table */
	T0* a2; /* equality_tester */
	T0* a3; /* internal_cursor */
};

/* Struct for type SPECIAL [GEANT_RENAME] */
struct S473 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type DS_HASH_TABLE_CURSOR [GEANT_RENAME, STRING_8] */
struct S474 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
	T0* a3; /* next_cursor */
};

/* Struct for type KL_SPECIAL_ROUTINES [GEANT_RENAME] */
struct S475 {
	int id;
};

/* Struct for type KL_EQUALITY_TESTER [GEANT_REDEFINE] */
struct S476 {
	int id;
};

/* Struct for type DS_SPARSE_TABLE_KEYS [GEANT_REDEFINE, STRING_8] */
struct S477 {
	int id;
	T0* a1; /* table */
	T0* a2; /* equality_tester */
	T0* a3; /* internal_cursor */
};

/* Struct for type SPECIAL [GEANT_REDEFINE] */
struct S479 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type DS_HASH_TABLE_CURSOR [GEANT_REDEFINE, STRING_8] */
struct S480 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
	T0* a3; /* next_cursor */
};

/* Struct for type KL_SPECIAL_ROUTINES [GEANT_REDEFINE] */
struct S481 {
	int id;
};

/* Struct for type KL_EQUALITY_TESTER [GEANT_SELECT] */
struct S482 {
	int id;
};

/* Struct for type DS_SPARSE_TABLE_KEYS [GEANT_SELECT, STRING_8] */
struct S483 {
	int id;
	T0* a1; /* table */
	T0* a2; /* equality_tester */
	T0* a3; /* internal_cursor */
};

/* Struct for type SPECIAL [GEANT_SELECT] */
struct S485 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type DS_HASH_TABLE_CURSOR [GEANT_SELECT, STRING_8] */
struct S486 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
	T0* a3; /* next_cursor */
};

/* Struct for type KL_SPECIAL_ROUTINES [GEANT_SELECT] */
struct S487 {
	int id;
};

/* Struct for type DS_BILINKABLE [DS_HASH_TABLE [STRING_8, STRING_8]] */
struct S489 {
	int id;
	T0* a1; /* item */
	T0* a2; /* left */
	T0* a3; /* right */
};

/* Struct for type KL_DIRECTORY */
struct S490 {
	int id;
	T0* a1; /* string_name */
	T0* a2; /* name */
	T0* a3; /* last_entry */
	T6 a4; /* mode */
	T14 a5; /* directory_pointer */
	T1 a6; /* end_of_input */
	T0* a7; /* entry_buffer */
	T0* a8; /* lastentry */
};

/* Struct for type KL_STRING_INPUT_STREAM */
struct S491 {
	int id;
	T1 a1; /* end_of_input */
	T2 a2; /* last_character */
	T0* a3; /* last_string */
	T0* a4; /* string */
	T6 a5; /* location */
};

/* Struct for type SPECIAL [XM_NAMESPACE] */
struct S492 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_EQUALITY_TESTER [XM_NAMESPACE] */
struct S493 {
	int id;
};

/* Struct for type DS_HASH_SET_CURSOR [XM_NAMESPACE] */
struct S494 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
};

/* Struct for type KL_SPECIAL_ROUTINES [XM_NAMESPACE] */
struct S495 {
	int id;
};

/* Struct for type DS_SPARSE_TABLE_KEYS_CURSOR [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8] */
struct S496 {
	int id;
	T0* a1; /* container */
	T0* a2; /* table_cursor */
};

/* Struct for type TO_SPECIAL [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]] */
struct S497 {
	int id;
	T0* a1; /* area */
};

/* Struct for type GEANT_MAP_ELEMENT */
struct S500 {
	int id;
	T0* a1; /* map */
	T0* a2; /* project */
	T0* a3; /* xml_element */
	T0* a4; /* position */
};

/* Struct for type GEANT_MAP */
struct S501 {
	int id;
	T0* a1; /* project */
	T0* a2; /* type */
	T0* a3; /* source_pattern */
	T0* a4; /* target_pattern */
	T0* a5; /* map */
};

/* Struct for type DS_HASH_SET [GEANT_FILESET_ENTRY] */
struct S504 {
	int id;
	T0* a1; /* equality_tester */
	T6 a2; /* capacity */
	T6 a3; /* modulus */
	T6 a4; /* last_position */
	T6 a5; /* free_slot */
	T6 a6; /* position */
	T0* a7; /* internal_cursor */
	T0* a8; /* special_item_routines */
	T0* a9; /* item_storage */
	T0* a10; /* clashes */
	T0* a11; /* slots */
	T6 a12; /* found_position */
	T6 a13; /* slots_position */
	T6 a14; /* count */
	T6 a15; /* clashes_previous_position */
	T0* a16; /* hash_function */
};

/* Struct for type DS_HASH_SET [STRING_8] */
struct S506 {
	int id;
	T6 a1; /* capacity */
	T6 a2; /* modulus */
	T6 a3; /* last_position */
	T6 a4; /* free_slot */
	T6 a5; /* position */
	T0* a6; /* internal_cursor */
	T0* a7; /* equality_tester */
	T6 a8; /* slots_position */
	T6 a9; /* count */
	T0* a10; /* special_item_routines */
	T0* a11; /* item_storage */
	T0* a12; /* clashes */
	T0* a13; /* slots */
	T6 a14; /* found_position */
	T6 a15; /* clashes_previous_position */
	T0* a16; /* hash_function */
};

/* Struct for type LX_DFA_WILDCARD */
struct S508 {
	int id;
	T0* a1; /* yy_nxt */
	T0* a2; /* yy_accept */
	T6 a3; /* yyNb_rows */
	T6 a4; /* match_count */
	T6 a5; /* subject_start */
	T6 a6; /* subject_end */
	T0* a7; /* subject */
	T6 a8; /* matched_start */
	T6 a9; /* matched_end */
};

/* Struct for type DS_HASH_SET [INTEGER_32] */
struct S510 {
	int id;
	T6 a1; /* position */
	T6 a2; /* capacity */
	T6 a3; /* modulus */
	T6 a4; /* last_position */
	T6 a5; /* free_slot */
	T0* a6; /* internal_cursor */
	T6 a7; /* slots_position */
	T6 a8; /* count */
	T6 a9; /* clashes_previous_position */
	T0* a10; /* special_item_routines */
	T0* a11; /* item_storage */
	T0* a12; /* clashes */
	T0* a13; /* slots */
	T6 a14; /* found_position */
	T0* a15; /* equality_tester */
	T0* a16; /* hash_function */
};

/* Struct for type DS_CELL [PROCEDURE [ANY, TUPLE [STRING_8]]] */
struct S511 {
	int id;
	T0* a1; /* item */
};

/* Struct for type TUPLE [STRING_8] */
struct S512 {
	int id;
	T0* z1;
};

/* Struct for type PROCEDURE [GEANT_ECHO_COMMAND, TUPLE [STRING_8]] */
struct S513 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*, T0*);
};

/* Struct for type TUPLE [GEANT_ECHO_COMMAND] */
struct S514 {
	int id;
	T0* z1;
};

/* Struct for type DS_CELL [PROCEDURE [ANY, TUPLE [STRING_8, KL_TEXT_OUTPUT_FILE, BOOLEAN]]] */
struct S516 {
	int id;
	T0* a1; /* item */
};

/* Struct for type KL_TEXT_OUTPUT_FILE */
struct S517 {
	int id;
	T0* a1; /* name */
	T6 a2; /* mode */
	T0* a3; /* string_name */
	T14 a4; /* file_pointer */
	T1 a5; /* descriptor_available */
};

/* Struct for type TUPLE [STRING_8, KL_TEXT_OUTPUT_FILE, BOOLEAN] */
struct S518 {
	int id;
	T0* z1;
	T0* z2;
	T1 z3;
};

/* Struct for type PROCEDURE [GEANT_ECHO_COMMAND, TUPLE [STRING_8, KL_TEXT_OUTPUT_FILE, BOOLEAN]] */
struct S519 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*, T0*, T0*, T1);
};

/* Struct for type PROCEDURE [GEANT_MKDIR_COMMAND, TUPLE [STRING_8]] */
struct S521 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	void (*f)(T0*, T0*);
};

/* Struct for type TUPLE [GEANT_MKDIR_COMMAND] */
struct S522 {
	int id;
	T0* z1;
};

/* Struct for type KL_SPECIAL_ROUTINES [DS_PAIR [STRING_8, STRING_8]] */
struct S523 {
	int id;
};

/* Struct for type SPECIAL [DS_PAIR [STRING_8, STRING_8]] */
struct S524 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type DS_ARRAYED_LIST_CURSOR [DS_PAIR [STRING_8, STRING_8]] */
struct S525 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
};

/* Struct for type DS_CELL [FUNCTION [ANY, TUPLE [STRING_8], BOOLEAN]] */
struct S526 {
	int id;
	T0* a1; /* item */
};

/* Struct for type PREDICATE [GEANT_AVAILABLE_COMMAND, TUPLE [STRING_8]] */
struct S527 {
	int id;
	T0* a1; /* closed_operands */
	T1 a2; /* is_target_closed */
	T1 (*f)(T0*, T0*);
};

/* Struct for type TUPLE [GEANT_AVAILABLE_COMMAND] */
struct S528 {
	int id;
	T0* z1;
};

/* Struct for type DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_RENAME, STRING_8] */
struct S530 {
	int id;
	T0* a1; /* container */
	T0* a2; /* table_cursor */
};

/* Struct for type TO_SPECIAL [GEANT_RENAME] */
struct S531 {
	int id;
	T0* a1; /* area */
};

/* Struct for type DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_REDEFINE, STRING_8] */
struct S532 {
	int id;
	T0* a1; /* container */
	T0* a2; /* table_cursor */
};

/* Struct for type TO_SPECIAL [GEANT_REDEFINE] */
struct S533 {
	int id;
	T0* a1; /* area */
};

/* Struct for type DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_SELECT, STRING_8] */
struct S534 {
	int id;
	T0* a1; /* container */
	T0* a2; /* table_cursor */
};

/* Struct for type TO_SPECIAL [GEANT_SELECT] */
struct S535 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [XM_NAMESPACE] */
struct S540 {
	int id;
	T0* a1; /* area */
};

/* Struct for type KL_EQUALITY_TESTER [GEANT_FILESET_ENTRY] */
struct S542 {
	int id;
};

/* Struct for type DS_HASH_SET_CURSOR [GEANT_FILESET_ENTRY] */
struct S543 {
	int id;
	T6 a1; /* position */
	T0* a2; /* next_cursor */
	T0* a3; /* container */
};

/* Struct for type KL_SPECIAL_ROUTINES [GEANT_FILESET_ENTRY] */
struct S544 {
	int id;
};

/* Struct for type GEANT_FILESET_ENTRY */
struct S545 {
	int id;
	T0* a1; /* filename */
	T0* a2; /* mapped_filename */
};

/* Struct for type SPECIAL [GEANT_FILESET_ENTRY] */
struct S546 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type DS_HASH_SET_CURSOR [STRING_8] */
struct S547 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
	T0* a3; /* next_cursor */
};

/* Struct for type LX_WILDCARD_PARSER */
struct S548 {
	int id;
	T1 a1; /* successful */
	T0* a2; /* pending_rules */
	T0* a3; /* start_condition_stack */
	T0* a4; /* action_factory */
	T0* a5; /* old_singleton_lines */
	T0* a6; /* old_singleton_columns */
	T0* a7; /* old_singleton_counts */
	T0* a8; /* old_regexp_lines */
	T0* a9; /* old_regexp_columns */
	T0* a10; /* old_regexp_counts */
	T0* a11; /* description */
	T0* a12; /* error_handler */
	T0* a13; /* name_definitions */
	T0* a14; /* character_classes */
	T6 a15; /* line_nb */
	T0* a16; /* yyss */
	T0* a17; /* input_buffer */
	T6 a18; /* yy_end */
	T6 a19; /* yy_position */
	T6 a20; /* yy_line */
	T6 a21; /* yy_column */
	T6 a22; /* yy_parsing_status */
	T6 a23; /* yy_suspended_yystacksize */
	T6 a24; /* yy_suspended_yystate */
	T6 a25; /* yy_suspended_yyn */
	T6 a26; /* yy_suspended_yychar1 */
	T6 a27; /* yy_suspended_index */
	T6 a28; /* yy_suspended_yyss_top */
	T6 a29; /* yy_suspended_yy_goto */
	T0* a30; /* yyr1 */
	T6 a31; /* yyssp */
	T0* a32; /* yypgoto */
	T0* a33; /* yycheck */
	T0* a34; /* yytable */
	T0* a35; /* yydefgoto */
	T6 a36; /* error_count */
	T1 a37; /* yy_lookahead_needed */
	T6 a38; /* yyerrstatus */
	T0* a39; /* yypact */
	T6 a40; /* last_token */
	T0* a41; /* yytranslate */
	T0* a42; /* yydefact */
	T0* a43; /* yytypes1 */
	T0* a44; /* yytypes2 */
	T6 a45; /* yy_start */
	T6 a46; /* yyvsp1 */
	T6 a47; /* yyvsp2 */
	T6 a48; /* yyvsp3 */
	T6 a49; /* yyvsp4 */
	T6 a50; /* yyvsp5 */
	T1 a51; /* yy_more_flag */
	T6 a52; /* yy_more_len */
	T6 a53; /* line */
	T6 a54; /* column */
	T6 a55; /* position */
	T6 a56; /* yy_start_state */
	T0* a57; /* yy_state_stack */
	T6 a58; /* yy_state_count */
	T0* a59; /* yy_ec */
	T0* a60; /* yy_content_area */
	T0* a61; /* yy_accept */
	T6 a62; /* yy_last_accepting_state */
	T6 a63; /* yy_last_accepting_cpos */
	T0* a64; /* yy_chk */
	T0* a65; /* yy_base */
	T0* a66; /* yy_def */
	T0* a67; /* yy_meta */
	T0* a68; /* yy_nxt */
	T6 a69; /* yy_lp */
	T0* a70; /* yy_acclist */
	T6 a71; /* yy_looking_for_trail_begin */
	T6 a72; /* yy_full_match */
	T6 a73; /* yy_full_state */
	T6 a74; /* yy_full_lp */
	T1 a75; /* yy_rejected */
	T6 a76; /* yyvsc1 */
	T0* a77; /* yyvs1 */
	T0* a78; /* yyspecial_routines1 */
	T0* a79; /* last_any_value */
	T6 a80; /* yyvsc2 */
	T0* a81; /* yyvs2 */
	T0* a82; /* yyspecial_routines2 */
	T6 a83; /* last_integer_value */
	T6 a84; /* yyvsc3 */
	T0* a85; /* yyvs3 */
	T0* a86; /* yyspecial_routines3 */
	T0* a87; /* last_lx_symbol_class_value */
	T6 a88; /* yyvsc4 */
	T0* a89; /* yyvs4 */
	T0* a90; /* yyspecial_routines4 */
	T0* a91; /* last_string_value */
	T1 a92; /* in_trail_context */
	T0* a93; /* rule */
	T0* a94; /* yyvs5 */
	T1 a95; /* has_trail_context */
	T6 a96; /* head_count */
	T6 a97; /* head_line */
	T6 a98; /* head_column */
	T6 a99; /* trail_count */
	T6 a100; /* yyvsc5 */
	T0* a101; /* yyspecial_routines5 */
	T0* a102; /* yy_content */
	T0* a103; /* last_string */
	T6 a104; /* rule_line_nb */
};

/* Struct for type LX_DESCRIPTION */
struct S549 {
	int id;
	T0* a1; /* equiv_classes */
	T1 a2; /* equiv_classes_used */
	T1 a3; /* full_table */
	T1 a4; /* meta_equiv_classes_used */
	T1 a5; /* reject_used */
	T1 a6; /* variable_trail_context */
	T0* a7; /* rules */
	T0* a8; /* start_conditions */
	T6 a9; /* characters_count */
	T6 a10; /* array_size */
	T1 a11; /* line_pragma */
	T0* a12; /* eof_rules */
	T0* a13; /* eiffel_header */
	T1 a14; /* case_insensitive */
	T0* a15; /* input_filename */
	T1 a16; /* inspect_used */
	T1 a17; /* actions_separated */
	T0* a18; /* eiffel_code */
	T1 a19; /* bol_needed */
	T1 a20; /* pre_action_used */
	T1 a21; /* post_action_used */
	T1 a22; /* pre_eof_action_used */
	T1 a23; /* post_eof_action_used */
	T1 a24; /* line_used */
	T1 a25; /* position_used */
};

/* Struct for type LX_FULL_DFA */
struct S550 {
	int id;
	T0* a1; /* yy_nxt */
	T0* a2; /* yy_accept */
	T6 a3; /* yyNb_rows */
	T0* a4; /* input_filename */
	T6 a5; /* characters_count */
	T6 a6; /* array_size */
	T1 a7; /* inspect_used */
	T1 a8; /* actions_separated */
	T0* a9; /* eiffel_code */
	T0* a10; /* eiffel_header */
	T1 a11; /* bol_needed */
	T1 a12; /* pre_action_used */
	T1 a13; /* post_action_used */
	T1 a14; /* pre_eof_action_used */
	T1 a15; /* post_eof_action_used */
	T1 a16; /* line_pragma */
	T0* a17; /* yy_start_conditions */
	T0* a18; /* yy_ec */
	T6 a19; /* yyNull_equiv_class */
	T6 a20; /* yyNb_rules */
	T0* a21; /* yy_rules */
	T6 a22; /* yyEnd_of_buffer */
	T1 a23; /* yyLine_used */
	T1 a24; /* yyPosition_used */
	T6 a25; /* minimum_symbol */
	T6 a26; /* maximum_symbol */
	T0* a27; /* states */
	T6 a28; /* backing_up_count */
	T0* a29; /* partitions */
	T6 a30; /* start_states_count */
	T1 a31; /* yyBacking_up */
	T0* a32; /* yy_eof_rules */
};

/* Struct for type DS_HASH_SET_CURSOR [INTEGER_32] */
struct S552 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
};

/* Struct for type KL_EQUALITY_TESTER [INTEGER_32] */
struct S553 {
	int id;
};

/* Struct for type TO_SPECIAL [DS_PAIR [STRING_8, STRING_8]] */
struct S554 {
	int id;
	T0* a1; /* area */
};

/* Struct for type KL_NULL_TEXT_OUTPUT_STREAM */
struct S558 {
	int id;
	T0* a1; /* name */
};

/* Struct for type DP_SHELL_COMMAND */
struct S560 {
	int id;
	T6 a1; /* exit_code */
	T0* a2; /* string_command */
	T0* a3; /* command */
	T6 a4; /* return_code */
	T1 a5; /* is_system_code */
};

/* Struct for type DS_CELL [BOOLEAN] */
struct S561 {
	int id;
	T1 a1; /* item */
};

/* Struct for type KL_BOOLEAN_ROUTINES */
struct S563 {
	int id;
};

/* Struct for type ARRAY [BOOLEAN] */
struct S564 {
	int id;
	T0* a1; /* area */
	T6 a2; /* lower */
	T6 a3; /* upper */
};

/* Struct for type GEANT_VARIABLES_VARIABLE_RESOLVER */
struct S565 {
	int id;
	T0* a1; /* variables */
};

/* Struct for type RX_PCRE_REGULAR_EXPRESSION */
struct S566 {
	int id;
	T6 a1; /* match_count */
	T0* a2; /* error_message */
	T0* a3; /* subject */
	T6 a4; /* subject_end */
	T6 a5; /* subject_start */
	T0* a6; /* offset_vector */
	T6 a7; /* offset_vector_count */
	T6 a8; /* brastart_capacity */
	T0* a9; /* brastart_vector */
	T6 a10; /* brastart_lower */
	T6 a11; /* brastart_count */
	T6 a12; /* eptr_capacity */
	T0* a13; /* eptr_vector */
	T6 a14; /* eptr_lower */
	T6 a15; /* eptr_upper */
	T0* a16; /* byte_code */
	T0* a17; /* pattern */
	T6 a18; /* subexpression_count */
	T6 a19; /* pattern_count */
	T6 a20; /* pattern_position */
	T6 a21; /* code_index */
	T6 a22; /* maxbackrefs */
	T6 a23; /* optchanged */
	T6 a24; /* first_character */
	T6 a25; /* required_character */
	T6 a26; /* regexp_countlits */
	T0* a27; /* start_bits */
	T1 a28; /* is_anchored */
	T1 a29; /* is_caseless */
	T1 a30; /* is_multiline */
	T0* a31; /* character_case_mapping */
	T0* a32; /* word_set */
	T6 a33; /* subject_next_start */
	T6 a34; /* error_code */
	T6 a35; /* error_position */
	T1 a36; /* is_startline */
	T1 a37; /* is_dotall */
	T1 a38; /* is_extended */
	T1 a39; /* is_empty_allowed */
	T1 a40; /* is_dollar_endonly */
	T1 a41; /* is_bol */
	T1 a42; /* is_eol */
	T1 a43; /* is_greedy */
	T1 a44; /* is_strict */
	T1 a45; /* is_ichanged */
	T6 a46; /* first_matched_index */
	T6 a47; /* eptr */
	T6 a48; /* offset_top */
	T1 a49; /* is_matching_caseless */
	T1 a50; /* is_matching_multiline */
	T1 a51; /* is_matching_dotall */
};

/* Struct for type KL_STRING_EQUALITY_TESTER */
struct S567 {
	int id;
};

/* Struct for type KL_STDIN_FILE */
struct S568 {
	int id;
	T0* a1; /* last_string */
	T1 a2; /* end_of_file */
	T2 a3; /* last_character */
	T14 a4; /* file_pointer */
	T0* a5; /* character_buffer */
	T0* a6; /* name */
	T6 a7; /* mode */
};

/* Struct for type ARRAY [GEANT_VARIABLES] */
struct S569 {
	int id;
	T0* a1; /* area */
	T6 a2; /* lower */
	T6 a3; /* upper */
};

/* Struct for type TO_SPECIAL [GEANT_FILESET_ENTRY] */
struct S572 {
	int id;
	T0* a1; /* area */
};

/* Struct for type DS_ARRAYED_LIST [LX_RULE] */
struct S573 {
	int id;
	T6 a1; /* count */
	T0* a2; /* storage */
	T0* a3; /* special_routines */
	T6 a4; /* capacity */
	T0* a5; /* internal_cursor */
};

/* Struct for type LX_START_CONDITIONS */
struct S574 {
	int id;
	T6 a1; /* count */
	T0* a2; /* storage */
	T0* a3; /* special_routines */
	T6 a4; /* capacity */
	T0* a5; /* internal_cursor */
};

/* Struct for type LX_ACTION_FACTORY */
struct S575 {
	int id;
};

/* Struct for type DS_ARRAYED_STACK [INTEGER_32] */
struct S576 {
	int id;
	T0* a1; /* special_routines */
	T0* a2; /* storage */
	T6 a3; /* capacity */
};

/* Struct for type DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8] */
struct S577 {
	int id;
	T6 a1; /* position */
	T6 a2; /* found_position */
	T0* a3; /* item_storage */
	T0* a4; /* key_equality_tester */
	T0* a5; /* internal_keys */
	T6 a6; /* count */
	T6 a7; /* capacity */
	T6 a8; /* slots_position */
	T6 a9; /* free_slot */
	T6 a10; /* last_position */
	T6 a11; /* modulus */
	T6 a12; /* clashes_previous_position */
	T0* a13; /* equality_tester */
	T0* a14; /* clashes */
	T0* a15; /* slots */
	T0* a16; /* key_storage */
	T0* a17; /* internal_cursor */
	T0* a18; /* special_item_routines */
	T0* a19; /* special_key_routines */
	T0* a20; /* hash_function */
};

/* Struct for type LX_SYMBOL_CLASS */
struct S578 {
	int id;
	T0* a1; /* special_routines */
	T0* a2; /* storage */
	T6 a3; /* capacity */
	T0* a4; /* internal_cursor */
	T1 a5; /* sort_needed */
	T1 a6; /* negated */
	T6 a7; /* count */
	T0* a8; /* equality_tester */
};

/* Struct for type SPECIAL [LX_SYMBOL_CLASS] */
struct S579 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [LX_SYMBOL_CLASS] */
struct S580 {
	int id;
};

/* Struct for type LX_NFA */
struct S581 {
	int id;
	T1 a1; /* in_trail_context */
	T0* a2; /* states */
};

/* Struct for type LX_EQUIVALENCE_CLASSES */
struct S582 {
	int id;
	T6 a1; /* count */
	T0* a2; /* storage */
};

/* Struct for type LX_RULE */
struct S583 {
	int id;
	T6 a1; /* id */
	T0* a2; /* pattern */
	T0* a3; /* action */
	T6 a4; /* head_count */
	T6 a5; /* trail_count */
	T6 a6; /* line_count */
	T6 a7; /* column_count */
	T6 a8; /* line_nb */
	T1 a9; /* has_trail_context */
	T1 a10; /* is_useful */
};

/* Struct for type SPECIAL [LX_NFA] */
struct S584 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [LX_NFA] */
struct S585 {
	int id;
};

/* Struct for type UT_SYNTAX_ERROR */
struct S586 {
	int id;
	T0* a1; /* parameters */
};

/* Struct for type DS_HASH_TABLE_CURSOR [LX_SYMBOL_CLASS, STRING_8] */
struct S587 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
	T0* a3; /* next_cursor */
};

/* Struct for type LX_UNRECOGNIZED_RULE_ERROR */
struct S588 {
	int id;
	T0* a1; /* parameters */
};

/* Struct for type LX_MISSING_QUOTE_ERROR */
struct S589 {
	int id;
	T0* a1; /* parameters */
};

/* Struct for type LX_BAD_CHARACTER_CLASS_ERROR */
struct S590 {
	int id;
	T0* a1; /* parameters */
};

/* Struct for type LX_BAD_CHARACTER_ERROR */
struct S591 {
	int id;
	T0* a1; /* parameters */
};

/* Struct for type LX_FULL_AND_META_ERROR */
struct S592 {
	int id;
	T0* a1; /* parameters */
};

/* Struct for type LX_FULL_AND_REJECT_ERROR */
struct S593 {
	int id;
	T0* a1; /* parameters */
};

/* Struct for type LX_FULL_AND_VARIABLE_TRAILING_CONTEXT_ERROR */
struct S594 {
	int id;
	T0* a1; /* parameters */
};

/* Struct for type LX_CHARACTER_OUT_OF_RANGE_ERROR */
struct S595 {
	int id;
	T0* a1; /* parameters */
};

/* Struct for type SPECIAL [LX_RULE] */
struct S596 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type ARRAY [LX_RULE] */
struct S597 {
	int id;
	T0* a1; /* area */
	T6 a2; /* lower */
	T6 a3; /* upper */
};

/* Struct for type LX_DFA_STATE */
struct S598 {
	int id;
	T0* a1; /* accepted_rules */
	T0* a2; /* states */
	T0* a3; /* transitions */
	T0* a4; /* accepted_head_rules */
	T6 a5; /* code */
	T6 a6; /* id */
};

/* Struct for type DS_ARRAYED_LIST [LX_NFA_STATE] */
struct S599 {
	int id;
	T6 a1; /* count */
	T0* a2; /* storage */
	T0* a3; /* equality_tester */
	T0* a4; /* special_routines */
	T6 a5; /* capacity */
	T0* a6; /* internal_cursor */
};

/* Struct for type DS_ARRAYED_LIST [LX_DFA_STATE] */
struct S600 {
	int id;
	T6 a1; /* count */
	T6 a2; /* capacity */
	T0* a3; /* storage */
	T0* a4; /* special_routines */
	T0* a5; /* internal_cursor */
};

/* Struct for type LX_SYMBOL_PARTITIONS */
struct S601 {
	int id;
	T0* a1; /* symbols */
	T0* a2; /* storage */
	T6 a3; /* count */
};

/* Struct for type LX_START_CONDITION */
struct S602 {
	int id;
	T0* a1; /* name */
	T6 a2; /* id */
	T1 a3; /* is_exclusive */
	T0* a4; /* patterns */
	T0* a5; /* bol_patterns */
};

/* Struct for type LX_TRANSITION_TABLE [LX_DFA_STATE] */
struct S603 {
	int id;
	T0* a1; /* storage */
	T0* a2; /* array_routines */
	T6 a3; /* count */
};

/* Struct for type DS_ARRAYED_LIST [LX_NFA] */
struct S604 {
	int id;
	T0* a1; /* special_routines */
	T0* a2; /* storage */
	T6 a3; /* capacity */
	T0* a4; /* internal_cursor */
	T6 a5; /* count */
};

/* Struct for type DS_HASH_TABLE [LX_NFA, INTEGER_32] */
struct S605 {
	int id;
	T6 a1; /* position */
	T0* a2; /* item_storage */
	T0* a3; /* key_equality_tester */
	T6 a4; /* count */
	T6 a5; /* capacity */
	T6 a6; /* slots_position */
	T6 a7; /* free_slot */
	T6 a8; /* last_position */
	T6 a9; /* modulus */
	T6 a10; /* clashes_previous_position */
	T0* a11; /* equality_tester */
	T0* a12; /* internal_keys */
	T6 a13; /* found_position */
	T0* a14; /* clashes */
	T0* a15; /* slots */
	T0* a16; /* key_storage */
	T0* a17; /* internal_cursor */
	T0* a18; /* special_item_routines */
	T0* a19; /* special_key_routines */
	T0* a20; /* hash_function */
};

/* Struct for type LX_NFA_STATE */
struct S606 {
	int id;
	T1 a1; /* in_trail_context */
	T0* a2; /* transition */
	T0* a3; /* epsilon_transition */
	T6 a4; /* id */
	T0* a5; /* accepted_rule */
};

/* Struct for type LX_NEGATIVE_RANGE_IN_CHARACTER_CLASS_ERROR */
struct S608 {
	int id;
	T0* a1; /* parameters */
};

/* Struct for type RX_BYTE_CODE */
struct S610 {
	int id;
	T6 a1; /* count */
	T0* a2; /* byte_code */
	T0* a3; /* character_sets */
	T6 a4; /* capacity */
	T6 a5; /* character_sets_count */
	T6 a6; /* character_sets_capacity */
};

/* Struct for type RX_CASE_MAPPING */
struct S611 {
	int id;
	T0* a1; /* lower_table */
	T0* a2; /* flip_table */
};

/* Struct for type RX_CHARACTER_SET */
struct S612 {
	int id;
	T0* a1; /* set */
};

/* Struct for type SPECIAL [RX_CHARACTER_SET] */
struct S614 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type ARRAY [RX_CHARACTER_SET] */
struct S615 {
	int id;
	T0* a1; /* area */
	T6 a2; /* lower */
	T6 a3; /* upper */
};

/* Struct for type KL_SPECIAL_ROUTINES [LX_RULE] */
struct S616 {
	int id;
};

/* Struct for type DS_ARRAYED_LIST_CURSOR [LX_RULE] */
struct S617 {
	int id;
	T6 a1; /* position */
	T0* a2; /* next_cursor */
	T0* a3; /* container */
};

/* Struct for type SPECIAL [LX_START_CONDITION] */
struct S618 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [LX_START_CONDITION] */
struct S619 {
	int id;
};

/* Struct for type DS_ARRAYED_LIST_CURSOR [LX_START_CONDITION] */
struct S620 {
	int id;
	T6 a1; /* position */
	T0* a2; /* next_cursor */
	T0* a3; /* container */
};

/* Struct for type DS_SPARSE_TABLE_KEYS [LX_SYMBOL_CLASS, STRING_8] */
struct S622 {
	int id;
	T0* a1; /* table */
	T0* a2; /* equality_tester */
	T0* a3; /* internal_cursor */
};

/* Struct for type DS_ARRAYED_LIST_CURSOR [INTEGER_32] */
struct S624 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
};

/* Struct for type TO_SPECIAL [LX_SYMBOL_CLASS] */
struct S625 {
	int id;
	T0* a1; /* area */
};

/* Struct for type LX_SYMBOL_CLASS_TRANSITION [LX_NFA_STATE] */
struct S626 {
	int id;
	T0* a1; /* label */
	T0* a2; /* target */
};

/* Struct for type LX_EPSILON_TRANSITION [LX_NFA_STATE] */
struct S628 {
	int id;
	T0* a1; /* target */
};

/* Struct for type LX_SYMBOL_TRANSITION [LX_NFA_STATE] */
struct S630 {
	int id;
	T6 a1; /* label */
	T0* a2; /* target */
};

/* Struct for type DS_BILINKABLE [INTEGER_32] */
struct S631 {
	int id;
	T6 a1; /* item */
	T0* a2; /* left */
	T0* a3; /* right */
};

/* Struct for type SPECIAL [DS_BILINKABLE [INTEGER_32]] */
struct S632 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type ARRAY [DS_BILINKABLE [INTEGER_32]] */
struct S633 {
	int id;
	T0* a1; /* area */
	T6 a2; /* lower */
	T6 a3; /* upper */
};

/* Struct for type LX_ACTION */
struct S635 {
	int id;
	T0* a1; /* text */
};

/* Struct for type TO_SPECIAL [LX_NFA] */
struct S636 {
	int id;
	T0* a1; /* area */
};

/* Struct for type DS_BUBBLE_SORTER [LX_NFA_STATE] */
struct S637 {
	int id;
	T0* a1; /* comparator */
};

/* Struct for type DS_BUBBLE_SORTER [LX_RULE] */
struct S639 {
	int id;
	T0* a1; /* comparator */
};

/* Struct for type SPECIAL [LX_NFA_STATE] */
struct S641 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [LX_NFA_STATE] */
struct S643 {
	int id;
};

/* Struct for type DS_ARRAYED_LIST_CURSOR [LX_NFA_STATE] */
struct S644 {
	int id;
	T6 a1; /* position */
	T0* a2; /* next_cursor */
	T0* a3; /* container */
};

/* Struct for type SPECIAL [LX_DFA_STATE] */
struct S646 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

/* Struct for type KL_SPECIAL_ROUTINES [LX_DFA_STATE] */
struct S647 {
	int id;
};

/* Struct for type DS_ARRAYED_LIST_CURSOR [LX_DFA_STATE] */
struct S648 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
};

/* Struct for type ARRAY [LX_DFA_STATE] */
struct S649 {
	int id;
	T0* a1; /* area */
	T6 a2; /* lower */
	T6 a3; /* upper */
};

/* Struct for type KL_ARRAY_ROUTINES [LX_DFA_STATE] */
struct S650 {
	int id;
};

/* Struct for type DS_ARRAYED_LIST_CURSOR [LX_NFA] */
struct S651 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
};

/* Struct for type DS_SPARSE_TABLE_KEYS [LX_NFA, INTEGER_32] */
struct S653 {
	int id;
	T0* a1; /* table */
	T0* a2; /* equality_tester */
	T0* a3; /* internal_cursor */
};

/* Struct for type DS_HASH_TABLE_CURSOR [LX_NFA, INTEGER_32] */
struct S655 {
	int id;
	T0* a1; /* container */
	T6 a2; /* position */
};

/* Struct for type KL_BINARY_INPUT_FILE */
struct S656 {
	int id;
	T1 a1; /* end_of_file */
	T0* a2; /* last_string */
	T6 a3; /* mode */
	T0* a4; /* name */
	T0* a5; /* string_name */
	T0* a6; /* character_buffer */
	T14 a7; /* file_pointer */
	T1 a8; /* descriptor_available */
};

/* Struct for type KL_BINARY_OUTPUT_FILE */
struct S657 {
	int id;
	T6 a1; /* mode */
	T0* a2; /* name */
	T0* a3; /* string_name */
	T14 a4; /* file_pointer */
	T1 a5; /* descriptor_available */
};

/* Struct for type FILE_NAME */
struct S659 {
	int id;
	T6 a1; /* count */
	T6 a2; /* internal_hash_code */
	T0* a3; /* area */
};

/* Struct for type RAW_FILE */
struct S660 {
	int id;
	T0* a1; /* name */
	T6 a2; /* mode */
	T14 a3; /* file_pointer */
	T1 a4; /* descriptor_available */
};

/* Struct for type DIRECTORY */
struct S661 {
	int id;
	T0* a1; /* lastentry */
	T0* a2; /* name */
	T6 a3; /* mode */
	T14 a4; /* directory_pointer */
};

/* Struct for type ARRAYED_LIST [STRING_8] */
struct S662 {
	int id;
	T6 a1; /* index */
	T6 a2; /* count */
	T0* a3; /* area */
	T6 a4; /* lower */
	T6 a5; /* upper */
};

/* Struct for type KL_COMPARABLE_COMPARATOR [LX_RULE] */
struct S665 {
	int id;
};

/* Struct for type KL_COMPARABLE_COMPARATOR [LX_NFA_STATE] */
struct S668 {
	int id;
};

/* Struct for type TO_SPECIAL [LX_RULE] */
struct S671 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [LX_START_CONDITION] */
struct S672 {
	int id;
	T0* a1; /* area */
};

/* Struct for type DS_SPARSE_TABLE_KEYS_CURSOR [LX_SYMBOL_CLASS, STRING_8] */
struct S673 {
	int id;
	T0* a1; /* container */
	T0* a2; /* table_cursor */
};

/* Struct for type TO_SPECIAL [LX_NFA_STATE] */
struct S674 {
	int id;
	T0* a1; /* area */
};

/* Struct for type TO_SPECIAL [LX_DFA_STATE] */
struct S675 {
	int id;
	T0* a1; /* area */
};

/* Struct for type DS_SPARSE_TABLE_KEYS_CURSOR [LX_NFA, INTEGER_32] */
struct S676 {
	int id;
	T0* a1; /* container */
	T0* a2; /* table_cursor */
};

/* Struct for type STRING_SEARCHER */
struct S677 {
	int id;
	T0* a1; /* deltas */
};

/* Struct for type HASH_TABLE [C_STRING, STRING_8] */
struct S678 {
	int id;
	T6 a1; /* capacity */
	T0* a2; /* content */
	T0* a3; /* keys */
	T0* a4; /* deleted_marks */
	T6 a5; /* iteration_position */
	T6 a6; /* count */
	T6 a7; /* deleted_position */
	T6 a8; /* control */
	T0* a9; /* found_item */
	T1 a10; /* has_default */
	T6 a11; /* position */
	T6 a12; /* used_slot_count */
};

/* Struct for type DS_SHELL_SORTER [INTEGER_32] */
struct S679 {
	int id;
	T0* a1; /* comparator */
};

/* Struct for type KL_COMPARABLE_COMPARATOR [INTEGER_32] */
struct S684 {
	int id;
};

/* Struct for type PRIMES */
struct S687 {
	int id;
};

/* Struct for type SPECIAL [C_STRING] */
struct S688 {
	int id;
	T6 z1; /* count */
	T0* z2[1]; /* item */
};

typedef struct {
	int id;
	EIF_INTEGER type_id;
	EIF_BOOLEAN is_special;
	void (*dispose) (EIF_REFERENCE);
} EIF_TYPE;


extern T1 GE_default1;
extern T2 GE_default2;
extern T3 GE_default3;
extern T4 GE_default4;
extern T5 GE_default5;
extern T6 GE_default6;
extern T7 GE_default7;
extern T8 GE_default8;
extern T9 GE_default9;
extern T10 GE_default10;
extern T11 GE_default11;
extern T12 GE_default12;
extern T13 GE_default13;
extern T14 GE_default14;
extern T15 GE_default15;
extern T17 GE_default17;
extern T21 GE_default21;
extern T22 GE_default22;
extern T23 GE_default23;
extern T24 GE_default24;
extern T25 GE_default25;
extern T26 GE_default26;
extern T27 GE_default27;
extern T28 GE_default28;
extern T29 GE_default29;
extern T30 GE_default30;
extern T31 GE_default31;
extern T32 GE_default32;
extern T33 GE_default33;
extern T34 GE_default34;
extern T35 GE_default35;
extern T36 GE_default36;
extern T37 GE_default37;
extern T38 GE_default38;
extern T40 GE_default40;
extern T45 GE_default45;
extern T46 GE_default46;
extern T47 GE_default47;
extern T48 GE_default48;
extern T49 GE_default49;
extern T51 GE_default51;
extern T53 GE_default53;
extern T54 GE_default54;
extern T55 GE_default55;
extern T56 GE_default56;
extern T58 GE_default58;
extern T59 GE_default59;
extern T61 GE_default61;
extern T63 GE_default63;
extern T64 GE_default64;
extern T65 GE_default65;
extern T66 GE_default66;
extern T68 GE_default68;
extern T69 GE_default69;
extern T71 GE_default71;
extern T72 GE_default72;
extern T73 GE_default73;
extern T74 GE_default74;
extern T75 GE_default75;
extern T76 GE_default76;
extern T77 GE_default77;
extern T81 GE_default81;
extern T83 GE_default83;
extern T84 GE_default84;
extern T86 GE_default86;
extern T87 GE_default87;
extern T89 GE_default89;
extern T91 GE_default91;
extern T93 GE_default93;
extern T94 GE_default94;
extern T97 GE_default97;
extern T98 GE_default98;
extern T99 GE_default99;
extern T100 GE_default100;
extern T101 GE_default101;
extern T104 GE_default104;
extern T105 GE_default105;
extern T106 GE_default106;
extern T107 GE_default107;
extern T108 GE_default108;
extern T109 GE_default109;
extern T110 GE_default110;
extern T112 GE_default112;
extern T113 GE_default113;
extern T114 GE_default114;
extern T115 GE_default115;
extern T116 GE_default116;
extern T117 GE_default117;
extern T119 GE_default119;
extern T121 GE_default121;
extern T122 GE_default122;
extern T123 GE_default123;
extern T124 GE_default124;
extern T125 GE_default125;
extern T127 GE_default127;
extern T129 GE_default129;
extern T130 GE_default130;
extern T131 GE_default131;
extern T133 GE_default133;
extern T134 GE_default134;
extern T136 GE_default136;
extern T137 GE_default137;
extern T138 GE_default138;
extern T139 GE_default139;
extern T141 GE_default141;
extern T142 GE_default142;
extern T143 GE_default143;
extern T144 GE_default144;
extern T145 GE_default145;
extern T146 GE_default146;
extern T147 GE_default147;
extern T148 GE_default148;
extern T149 GE_default149;
extern T150 GE_default150;
extern T151 GE_default151;
extern T152 GE_default152;
extern T153 GE_default153;
extern T154 GE_default154;
extern T155 GE_default155;
extern T156 GE_default156;
extern T157 GE_default157;
extern T158 GE_default158;
extern T159 GE_default159;
extern T160 GE_default160;
extern T161 GE_default161;
extern T162 GE_default162;
extern T164 GE_default164;
extern T166 GE_default166;
extern T167 GE_default167;
extern T168 GE_default168;
extern T169 GE_default169;
extern T170 GE_default170;
extern T171 GE_default171;
extern T172 GE_default172;
extern T174 GE_default174;
extern T175 GE_default175;
extern T177 GE_default177;
extern T178 GE_default178;
extern T179 GE_default179;
extern T180 GE_default180;
extern T181 GE_default181;
extern T182 GE_default182;
extern T183 GE_default183;
extern T184 GE_default184;
extern T185 GE_default185;
extern T187 GE_default187;
extern T188 GE_default188;
extern T189 GE_default189;
extern T191 GE_default191;
extern T192 GE_default192;
extern T193 GE_default193;
extern T195 GE_default195;
extern T196 GE_default196;
extern T197 GE_default197;
extern T198 GE_default198;
extern T199 GE_default199;
extern T200 GE_default200;
extern T201 GE_default201;
extern T202 GE_default202;
extern T204 GE_default204;
extern T205 GE_default205;
extern T206 GE_default206;
extern T207 GE_default207;
extern T209 GE_default209;
extern T210 GE_default210;
extern T211 GE_default211;
extern T212 GE_default212;
extern T213 GE_default213;
extern T214 GE_default214;
extern T215 GE_default215;
extern T216 GE_default216;
extern T218 GE_default218;
extern T219 GE_default219;
extern T220 GE_default220;
extern T221 GE_default221;
extern T222 GE_default222;
extern T224 GE_default224;
extern T226 GE_default226;
extern T227 GE_default227;
extern T228 GE_default228;
extern T229 GE_default229;
extern T230 GE_default230;
extern T232 GE_default232;
extern T234 GE_default234;
extern T235 GE_default235;
extern T236 GE_default236;
extern T237 GE_default237;
extern T238 GE_default238;
extern T239 GE_default239;
extern T240 GE_default240;
extern T241 GE_default241;
extern T242 GE_default242;
extern T243 GE_default243;
extern T244 GE_default244;
extern T245 GE_default245;
extern T246 GE_default246;
extern T247 GE_default247;
extern T248 GE_default248;
extern T249 GE_default249;
extern T250 GE_default250;
extern T251 GE_default251;
extern T252 GE_default252;
extern T253 GE_default253;
extern T255 GE_default255;
extern T256 GE_default256;
extern T257 GE_default257;
extern T258 GE_default258;
extern T259 GE_default259;
extern T262 GE_default262;
extern T264 GE_default264;
extern T265 GE_default265;
extern T266 GE_default266;
extern T267 GE_default267;
extern T268 GE_default268;
extern T269 GE_default269;
extern T270 GE_default270;
extern T273 GE_default273;
extern T274 GE_default274;
extern T275 GE_default275;
extern T276 GE_default276;
extern T277 GE_default277;
extern T278 GE_default278;
extern T279 GE_default279;
extern T280 GE_default280;
extern T281 GE_default281;
extern T282 GE_default282;
extern T283 GE_default283;
extern T284 GE_default284;
extern T285 GE_default285;
extern T286 GE_default286;
extern T287 GE_default287;
extern T288 GE_default288;
extern T289 GE_default289;
extern T290 GE_default290;
extern T291 GE_default291;
extern T292 GE_default292;
extern T293 GE_default293;
extern T294 GE_default294;
extern T295 GE_default295;
extern T296 GE_default296;
extern T297 GE_default297;
extern T298 GE_default298;
extern T299 GE_default299;
extern T300 GE_default300;
extern T301 GE_default301;
extern T302 GE_default302;
extern T303 GE_default303;
extern T304 GE_default304;
extern T305 GE_default305;
extern T306 GE_default306;
extern T307 GE_default307;
extern T308 GE_default308;
extern T309 GE_default309;
extern T310 GE_default310;
extern T311 GE_default311;
extern T312 GE_default312;
extern T313 GE_default313;
extern T314 GE_default314;
extern T315 GE_default315;
extern T316 GE_default316;
extern T317 GE_default317;
extern T318 GE_default318;
extern T319 GE_default319;
extern T320 GE_default320;
extern T321 GE_default321;
extern T322 GE_default322;
extern T324 GE_default324;
extern T326 GE_default326;
extern T327 GE_default327;
extern T328 GE_default328;
extern T329 GE_default329;
extern T330 GE_default330;
extern T331 GE_default331;
extern T332 GE_default332;
extern T333 GE_default333;
extern T334 GE_default334;
extern T335 GE_default335;
extern T336 GE_default336;
extern T337 GE_default337;
extern T338 GE_default338;
extern T340 GE_default340;
extern T341 GE_default341;
extern T342 GE_default342;
extern T343 GE_default343;
extern T344 GE_default344;
extern T345 GE_default345;
extern T347 GE_default347;
extern T348 GE_default348;
extern T349 GE_default349;
extern T350 GE_default350;
extern T351 GE_default351;
extern T352 GE_default352;
extern T354 GE_default354;
extern T356 GE_default356;
extern T357 GE_default357;
extern T358 GE_default358;
extern T359 GE_default359;
extern T360 GE_default360;
extern T363 GE_default363;
extern T365 GE_default365;
extern T369 GE_default369;
extern T370 GE_default370;
extern T371 GE_default371;
extern T373 GE_default373;
extern T375 GE_default375;
extern T376 GE_default376;
extern T377 GE_default377;
extern T378 GE_default378;
extern T379 GE_default379;
extern T380 GE_default380;
extern T381 GE_default381;
extern T382 GE_default382;
extern T383 GE_default383;
extern T384 GE_default384;
extern T385 GE_default385;
extern T386 GE_default386;
extern T387 GE_default387;
extern T388 GE_default388;
extern T389 GE_default389;
extern T390 GE_default390;
extern T391 GE_default391;
extern T392 GE_default392;
extern T393 GE_default393;
extern T394 GE_default394;
extern T395 GE_default395;
extern T396 GE_default396;
extern T397 GE_default397;
extern T398 GE_default398;
extern T399 GE_default399;
extern T400 GE_default400;
extern T401 GE_default401;
extern T402 GE_default402;
extern T403 GE_default403;
extern T404 GE_default404;
extern T405 GE_default405;
extern T406 GE_default406;
extern T407 GE_default407;
extern T408 GE_default408;
extern T409 GE_default409;
extern T410 GE_default410;
extern T411 GE_default411;
extern T412 GE_default412;
extern T413 GE_default413;
extern T414 GE_default414;
extern T415 GE_default415;
extern T416 GE_default416;
extern T417 GE_default417;
extern T418 GE_default418;
extern T419 GE_default419;
extern T420 GE_default420;
extern T421 GE_default421;
extern T422 GE_default422;
extern T423 GE_default423;
extern T424 GE_default424;
extern T425 GE_default425;
extern T426 GE_default426;
extern T427 GE_default427;
extern T428 GE_default428;
extern T429 GE_default429;
extern T430 GE_default430;
extern T431 GE_default431;
extern T432 GE_default432;
extern T433 GE_default433;
extern T434 GE_default434;
extern T435 GE_default435;
extern T436 GE_default436;
extern T437 GE_default437;
extern T438 GE_default438;
extern T439 GE_default439;
extern T440 GE_default440;
extern T441 GE_default441;
extern T442 GE_default442;
extern T443 GE_default443;
extern T444 GE_default444;
extern T445 GE_default445;
extern T446 GE_default446;
extern T447 GE_default447;
extern T448 GE_default448;
extern T449 GE_default449;
extern T450 GE_default450;
extern T451 GE_default451;
extern T452 GE_default452;
extern T453 GE_default453;
extern T454 GE_default454;
extern T455 GE_default455;
extern T456 GE_default456;
extern T457 GE_default457;
extern T458 GE_default458;
extern T459 GE_default459;
extern T460 GE_default460;
extern T461 GE_default461;
extern T462 GE_default462;
extern T463 GE_default463;
extern T464 GE_default464;
extern T465 GE_default465;
extern T466 GE_default466;
extern T467 GE_default467;
extern T468 GE_default468;
extern T469 GE_default469;
extern T470 GE_default470;
extern T471 GE_default471;
extern T473 GE_default473;
extern T474 GE_default474;
extern T475 GE_default475;
extern T476 GE_default476;
extern T477 GE_default477;
extern T479 GE_default479;
extern T480 GE_default480;
extern T481 GE_default481;
extern T482 GE_default482;
extern T483 GE_default483;
extern T485 GE_default485;
extern T486 GE_default486;
extern T487 GE_default487;
extern T489 GE_default489;
extern T490 GE_default490;
extern T491 GE_default491;
extern T492 GE_default492;
extern T493 GE_default493;
extern T494 GE_default494;
extern T495 GE_default495;
extern T496 GE_default496;
extern T497 GE_default497;
extern T500 GE_default500;
extern T501 GE_default501;
extern T504 GE_default504;
extern T506 GE_default506;
extern T508 GE_default508;
extern T510 GE_default510;
extern T511 GE_default511;
extern T512 GE_default512;
extern T513 GE_default513;
extern T514 GE_default514;
extern T516 GE_default516;
extern T517 GE_default517;
extern T518 GE_default518;
extern T519 GE_default519;
extern T521 GE_default521;
extern T522 GE_default522;
extern T523 GE_default523;
extern T524 GE_default524;
extern T525 GE_default525;
extern T526 GE_default526;
extern T527 GE_default527;
extern T528 GE_default528;
extern T530 GE_default530;
extern T531 GE_default531;
extern T532 GE_default532;
extern T533 GE_default533;
extern T534 GE_default534;
extern T535 GE_default535;
extern T540 GE_default540;
extern T542 GE_default542;
extern T543 GE_default543;
extern T544 GE_default544;
extern T545 GE_default545;
extern T546 GE_default546;
extern T547 GE_default547;
extern T548 GE_default548;
extern T549 GE_default549;
extern T550 GE_default550;
extern T552 GE_default552;
extern T553 GE_default553;
extern T554 GE_default554;
extern T558 GE_default558;
extern T560 GE_default560;
extern T561 GE_default561;
extern T563 GE_default563;
extern T564 GE_default564;
extern T565 GE_default565;
extern T566 GE_default566;
extern T567 GE_default567;
extern T568 GE_default568;
extern T569 GE_default569;
extern T572 GE_default572;
extern T573 GE_default573;
extern T574 GE_default574;
extern T575 GE_default575;
extern T576 GE_default576;
extern T577 GE_default577;
extern T578 GE_default578;
extern T579 GE_default579;
extern T580 GE_default580;
extern T581 GE_default581;
extern T582 GE_default582;
extern T583 GE_default583;
extern T584 GE_default584;
extern T585 GE_default585;
extern T586 GE_default586;
extern T587 GE_default587;
extern T588 GE_default588;
extern T589 GE_default589;
extern T590 GE_default590;
extern T591 GE_default591;
extern T592 GE_default592;
extern T593 GE_default593;
extern T594 GE_default594;
extern T595 GE_default595;
extern T596 GE_default596;
extern T597 GE_default597;
extern T598 GE_default598;
extern T599 GE_default599;
extern T600 GE_default600;
extern T601 GE_default601;
extern T602 GE_default602;
extern T603 GE_default603;
extern T604 GE_default604;
extern T605 GE_default605;
extern T606 GE_default606;
extern T608 GE_default608;
extern T610 GE_default610;
extern T611 GE_default611;
extern T612 GE_default612;
extern T614 GE_default614;
extern T615 GE_default615;
extern T616 GE_default616;
extern T617 GE_default617;
extern T618 GE_default618;
extern T619 GE_default619;
extern T620 GE_default620;
extern T622 GE_default622;
extern T624 GE_default624;
extern T625 GE_default625;
extern T626 GE_default626;
extern T628 GE_default628;
extern T630 GE_default630;
extern T631 GE_default631;
extern T632 GE_default632;
extern T633 GE_default633;
extern T635 GE_default635;
extern T636 GE_default636;
extern T637 GE_default637;
extern T639 GE_default639;
extern T641 GE_default641;
extern T643 GE_default643;
extern T644 GE_default644;
extern T646 GE_default646;
extern T647 GE_default647;
extern T648 GE_default648;
extern T649 GE_default649;
extern T650 GE_default650;
extern T651 GE_default651;
extern T653 GE_default653;
extern T655 GE_default655;
extern T656 GE_default656;
extern T657 GE_default657;
extern T659 GE_default659;
extern T660 GE_default660;
extern T661 GE_default661;
extern T662 GE_default662;
extern T665 GE_default665;
extern T668 GE_default668;
extern T671 GE_default671;
extern T672 GE_default672;
extern T673 GE_default673;
extern T674 GE_default674;
extern T675 GE_default675;
extern T676 GE_default676;
extern T677 GE_default677;
extern T678 GE_default678;
extern T679 GE_default679;
extern T681 GE_default681;
extern T684 GE_default684;
extern T687 GE_default687;
extern T688 GE_default688;

extern T0* GE_ms8(char* s, T6 c);
extern T0* GE_ms32(char* s, T6 c);
/* Call to STRING_8.to_c */
extern T0* T17x1121(T0* C);
/* Call to STRING_8.count */
extern T6 T17x1218(T0* C);
/* Call to ANY.same_type */
extern T1 T19x27T0(T0* C, T0* a1);
/* Call to GEANT_VARIABLES.has */
extern T1 T29x1979T0(T0* C, T0* a1);
/* Call to GEANT_VARIABLES.item_for_iteration */
extern T0* T29x2038(T0* C);
/* Call to GEANT_VARIABLES.key_for_iteration */
extern T0* T29x1972(T0* C);
/* Call to GEANT_VARIABLES.after */
extern T1 T29x2019(T0* C);
/* Call to GEANT_VARIABLES.found_item */
extern T0* T29x2061(T0* C);
/* Call to GEANT_VARIABLES.found */
extern T1 T29x2069(T0* C);
/* Call to AP_OPTION.short_form */
extern T2 T42x2575(T0* C);
/* Call to AP_OPTION.long_form */
extern T0* T42x2570(T0* C);
/* Call to AP_OPTION.has_long_form */
extern T1 T42x2577(T0* C);
/* Call to AP_OPTION.example */
extern T0* T42x2569(T0* C);
/* Call to AP_OPTION.is_hidden */
extern T1 T42x2579(T0* C);
/* Call to AP_OPTION.description */
extern T0* T42x2568(T0* C);
/* Call to AP_OPTION.names */
extern T0* T42x2572(T0* C);
/* Call to AP_OPTION.name */
extern T0* T42x2571(T0* C);
/* Call to AP_OPTION.needs_parameter */
extern T1 T42x2581(T0* C);
/* Call to AP_OPTION.has_short_form */
extern T1 T42x2578(T0* C);
/* Call to AP_OPTION.allows_parameter */
extern T1 T42x2576(T0* C);
/* Call to AP_OPTION.maximum_occurrences */
extern T6 T42x2574(T0* C);
/* Call to AP_OPTION.occurrences */
extern T6 T42x2573(T0* C);
/* Call to AP_OPTION.was_found */
extern T1 T42x2583(T0* C);
/* Call to AP_OPTION.is_mandatory */
extern T1 T42x2580(T0* C);
/* Call to UT_ERROR.default_message */
extern T0* T50x2956(T0* C);
/* Call to DS_SPARSE_TABLE [STRING_8, STRING_8].new_cursor */
extern T0* T62x2039(T0* C);
/* Call to DS_SPARSE_TABLE [STRING_8, STRING_8].key_equality_tester */
extern T0* T62x2091(T0* C);
/* Call to READABLE_STRING_8.area_lower */
extern T6 T78x1213(T0* C);
/* Call to READABLE_STRING_8.area */
extern T0* T78x1212(T0* C);
/* Call to READABLE_STRING_8.count */
extern T6 T78x1218(T0* C);
/* Call to DS_HASH_TABLE [STRING_8, STRING_8].cursor_key */
extern T0* T81x1974T0(T0* C, T0* a1);
/* Call to DS_HASH_TABLE [STRING_8, STRING_8].cursor_item */
extern T0* T81x2045T0(T0* C, T0* a1);
/* Call to DS_HASH_TABLE [STRING_8, STRING_8].cursor_after */
extern T1 T81x2033T0(T0* C, T0* a1);
/* Call to DS_HASH_TABLE [STRING_8, STRING_8].before_position */
extern T6 T81x2146(T0* C);
/* Call to XM_EIFFEL_SCANNER.start_condition */
extern T6 T133x6331(T0* C);
/* Call to XM_EIFFEL_SCANNER.is_applicable_encoding */
extern T1 T133x6206T0(T0* C, T0* a1);
/* Call to XM_EIFFEL_SCANNER.end_of_file */
extern T1 T133x6336(T0* C);
/* Call to XM_EIFFEL_SCANNER.last_value */
extern T0* T133x6217(T0* C);
/* Call to XM_EIFFEL_SCANNER.last_token */
extern T6 T133x6327(T0* C);
/* Call to XM_EIFFEL_SCANNER.error_position */
extern T0* T133x6215(T0* C);
/* Call to XM_NODE.parent */
extern T0* T203x5666(T0* C);
/* Call to GEANT_TASK.exit_code */
extern T6 T271x7797(T0* C);
/* Call to GEANT_TASK.is_exit_command */
extern T1 T271x7798(T0* C);
/* Call to GEANT_TASK.is_enabled */
extern T1 T271x2402(T0* C);
/* Call to GEANT_TASK.is_executable */
extern T1 T271x7796(T0* C);
/* Call to FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK].item with a manifest tuple argument of type TUPLE [XM_ELEMENT] */
extern T0* T272xmt7841T267(T0* C, T0* a1);
/* Call to LX_TRANSITION [LX_NFA_STATE].target */
extern T0* T627x11464(T0* C);
/* Call to LX_TRANSITION [LX_NFA_STATE].labeled */
extern T1 T627x11467T6(T0* C, T6 a1);
/* Call to GEANT_VARIABLES.replace */
extern void T29x1980T0T0(T0* C, T0* a1, T0* a2);
/* Call to GEANT_VARIABLES.set_variable_value */
extern void T29x1896T0T0(T0* C, T0* a1, T0* a2);
/* Call to GEANT_VARIABLES.forth */
extern void T29x2023(T0* C);
/* Call to GEANT_VARIABLES.start */
extern void T29x2022(T0* C);
/* Call to GEANT_VARIABLES.search */
extern void T29x2076T0(T0* C, T0* a1);
/* Call to GEANT_VARIABLES.force_last */
extern void T29x1961T0T0(T0* C, T0* a1, T0* a2);
/* Call to AP_OPTION.record_occurrence */
extern void T42x2594T0(T0* C, T0* a1);
/* Call to AP_OPTION.reset */
extern void T42x2595(T0* C);
/* Call to DS_HASH_TABLE [STRING_8, STRING_8].cursor_forth */
extern void T81x2035T0(T0* C, T0* a1);
/* Call to DS_HASH_TABLE [STRING_8, STRING_8].cursor_start */
extern void T81x2034T0(T0* C, T0* a1);
/* Call to XM_CALLBACKS_FILTER.set_next */
extern void T95x4921T0(T0* C, T0* a1);
/* Call to XM_CALLBACKS.on_xml_declaration */
extern void T96x5084T0T0T1(T0* C, T0* a1, T0* a2, T1 a3);
/* Call to XM_CALLBACKS.on_attribute */
extern void T96x5089T0T0T0T0(T0* C, T0* a1, T0* a2, T0* a3, T0* a4);
/* Call to XM_CALLBACKS.on_error */
extern void T96x5085T0(T0* C, T0* a1);
/* Call to XM_CALLBACKS.on_end_tag */
extern void T96x5091T0T0T0(T0* C, T0* a1, T0* a2, T0* a3);
/* Call to XM_CALLBACKS.on_start_tag_finish */
extern void T96x5090(T0* C);
/* Call to XM_CALLBACKS.on_start_tag */
extern void T96x5088T0T0T0(T0* C, T0* a1, T0* a2, T0* a3);
/* Call to XM_CALLBACKS.on_content */
extern void T96x5092T0(T0* C, T0* a1);
/* Call to XM_CALLBACKS.on_processing_instruction */
extern void T96x5086T0T0(T0* C, T0* a1, T0* a2);
/* Call to XM_CALLBACKS.on_comment */
extern void T96x5087T0(T0* C, T0* a1);
/* Call to XM_CALLBACKS.on_finish */
extern void T96x5083(T0* C);
/* Call to XM_CALLBACKS.on_start */
extern void T96x5082(T0* C);
/* Call to XM_EIFFEL_SCANNER.close_input */
extern void T133x6202(T0* C);
/* Call to XM_EIFFEL_SCANNER.set_input_from_resolver */
extern void T133x6201T0(T0* C, T0* a1);
/* Call to XM_EIFFEL_SCANNER.set_encoding */
extern void T133x6207T0(T0* C, T0* a1);
/* Call to XM_EIFFEL_SCANNER.push_start_condition_dtd_ignore */
extern void T133x6198(T0* C);
/* Call to XM_EIFFEL_SCANNER.read_token */
extern void T133x6342(T0* C);
/* Call to XM_EIFFEL_SCANNER.set_input_stream */
extern void T133x6200T0(T0* C, T0* a1);
/* Call to XM_NODE.process */
extern void T203x5676T0(T0* C, T0* a1);
/* Call to XM_NODE.node_set_parent */
extern void T203x5674T0(T0* C, T0* a1);
/* Call to GEANT_TASK.execute */
extern void T271x7800(T0* C);
/* Call to GEANT_TASK.log_validation_messages */
extern void T271x7801(T0* C);
/* Call to LX_TRANSITION [LX_NFA_STATE].record */
extern void T627x11468T0(T0* C, T0* a1);
/* New instance of type SPECIAL [CHARACTER_8] */
extern T0* GE_new15(T6 a1, T1 initialize);
/* New instance of type STRING_8 */
extern T0* GE_new17(T1 initialize);
/* New instance of type GEANT */
extern T0* GE_new21(T1 initialize);
/* New instance of type GEANT_PROJECT */
extern T0* GE_new22(T1 initialize);
/* New instance of type GEANT_PROJECT_LOADER */
extern T0* GE_new23(T1 initialize);
/* New instance of type GEANT_PROJECT_OPTIONS */
extern T0* GE_new24(T1 initialize);
/* New instance of type GEANT_PROJECT_VARIABLES */
extern T0* GE_new25(T1 initialize);
/* New instance of type GEANT_TARGET */
extern T0* GE_new26(T1 initialize);
/* New instance of type KL_ARGUMENTS */
extern T0* GE_new27(T1 initialize);
/* New instance of type UT_ERROR_HANDLER */
extern T0* GE_new28(T1 initialize);
/* New instance of type GEANT_VARIABLES */
extern T0* GE_new29(T1 initialize);
/* New instance of type GEANT_PROJECT_ELEMENT */
extern T0* GE_new30(T1 initialize);
/* New instance of type DS_HASH_TABLE [GEANT_TARGET, STRING_8] */
extern T0* GE_new31(T1 initialize);
/* New instance of type SPECIAL [STRING_8] */
extern T0* GE_new32(T6 a1, T1 initialize);
/* New instance of type ARRAY [STRING_8] */
extern T0* GE_new33(T1 initialize);
/* New instance of type GEANT_ARGUMENT_VARIABLES */
extern T0* GE_new34(T1 initialize);
/* New instance of type AP_FLAG */
extern T0* GE_new35(T1 initialize);
/* New instance of type AP_ALTERNATIVE_OPTIONS_LIST */
extern T0* GE_new36(T1 initialize);
/* New instance of type AP_STRING_OPTION */
extern T0* GE_new37(T1 initialize);
/* New instance of type AP_PARSER */
extern T0* GE_new38(T1 initialize);
/* New instance of type AP_ERROR */
extern T0* GE_new40(T1 initialize);
/* New instance of type AP_ERROR_HANDLER */
extern T0* GE_new45(T1 initialize);
/* New instance of type KL_STANDARD_FILES */
extern T0* GE_new46(T1 initialize);
/* New instance of type KL_STDERR_FILE */
extern T0* GE_new47(T1 initialize);
/* New instance of type KL_EXCEPTIONS */
extern T0* GE_new48(T1 initialize);
/* New instance of type UT_VERSION_NUMBER */
extern T0* GE_new49(T1 initialize);
/* New instance of type KL_OPERATING_SYSTEM */
extern T0* GE_new51(T1 initialize);
/* New instance of type KL_WINDOWS_FILE_SYSTEM */
extern T0* GE_new53(T1 initialize);
/* New instance of type KL_UNIX_FILE_SYSTEM */
extern T0* GE_new54(T1 initialize);
/* New instance of type KL_TEXT_INPUT_FILE */
extern T0* GE_new55(T1 initialize);
/* New instance of type GEANT_PROJECT_PARSER */
extern T0* GE_new56(T1 initialize);
/* New instance of type GEANT_PROJECT_VARIABLE_RESOLVER */
extern T0* GE_new58(T1 initialize);
/* New instance of type UC_STRING_EQUALITY_TESTER */
extern T0* GE_new59(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS [STRING_8, STRING_8] */
extern T0* GE_new61(T1 initialize);
/* New instance of type SPECIAL [INTEGER_32] */
extern T0* GE_new63(T6 a1, T1 initialize);
/* New instance of type DS_HASH_TABLE_CURSOR [STRING_8, STRING_8] */
extern T0* GE_new64(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [INTEGER_32] */
extern T0* GE_new65(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [STRING_8] */
extern T0* GE_new66(T1 initialize);
/* New instance of type KL_STDOUT_FILE */
extern T0* GE_new68(T1 initialize);
/* New instance of type DS_LINKED_LIST_CURSOR [AP_OPTION] */
extern T0* GE_new69(T1 initialize);
/* New instance of type DS_ARRAYED_LIST [STRING_8] */
extern T0* GE_new71(T1 initialize);
/* New instance of type DS_ARRAYED_LIST_CURSOR [STRING_8] */
extern T0* GE_new72(T1 initialize);
/* New instance of type AP_DISPLAY_HELP_FLAG */
extern T0* GE_new73(T1 initialize);
/* New instance of type DS_ARRAYED_LIST [AP_OPTION] */
extern T0* GE_new74(T1 initialize);
/* New instance of type DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST] */
extern T0* GE_new75(T1 initialize);
/* New instance of type KL_STRING_ROUTINES */
extern T0* GE_new76(T1 initialize);
/* New instance of type DS_HASH_TABLE [STRING_8, STRING_8] */
extern T0* GE_new81(T1 initialize);
/* New instance of type EXECUTION_ENVIRONMENT */
extern T0* GE_new83(T1 initialize);
/* New instance of type KL_ANY_ROUTINES */
extern T0* GE_new84(T1 initialize);
/* New instance of type KL_PATHNAME */
extern T0* GE_new86(T1 initialize);
/* New instance of type UNIX_FILE_INFO */
extern T0* GE_new87(T1 initialize);
/* New instance of type ? KL_LINKABLE [CHARACTER_8] */
extern T0* GE_new89(T1 initialize);
/* New instance of type XM_EXPAT_PARSER_FACTORY */
extern T0* GE_new91(T1 initialize);
/* New instance of type XM_EIFFEL_PARSER */
extern T0* GE_new93(T1 initialize);
/* New instance of type XM_TREE_CALLBACKS_PIPE */
extern T0* GE_new94(T1 initialize);
/* New instance of type XM_CALLBACKS_TO_TREE_FILTER */
extern T0* GE_new97(T1 initialize);
/* New instance of type XM_DOCUMENT */
extern T0* GE_new98(T1 initialize);
/* New instance of type XM_ELEMENT */
extern T0* GE_new99(T1 initialize);
/* New instance of type XM_STOP_ON_ERROR_FILTER */
extern T0* GE_new100(T1 initialize);
/* New instance of type XM_POSITION_TABLE */
extern T0* GE_new101(T1 initialize);
/* New instance of type KL_EXECUTION_ENVIRONMENT */
extern T0* GE_new104(T1 initialize);
/* New instance of type DS_ARRAYED_STACK [GEANT_ARGUMENT_VARIABLES] */
extern T0* GE_new105(T1 initialize);
/* New instance of type DS_ARRAYED_STACK [GEANT_VARIABLES] */
extern T0* GE_new106(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS_CURSOR [STRING_8, STRING_8] */
extern T0* GE_new107(T1 initialize);
/* New instance of type TO_SPECIAL [INTEGER_32] */
extern T0* GE_new108(T1 initialize);
/* New instance of type TO_SPECIAL [STRING_8] */
extern T0* GE_new109(T1 initialize);
/* New instance of type DS_ARRAYED_LIST_CURSOR [AP_OPTION] */
extern T0* GE_new110(T1 initialize);
/* New instance of type SPECIAL [AP_OPTION] */
extern T0* GE_new112(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [AP_OPTION] */
extern T0* GE_new113(T1 initialize);
/* New instance of type DS_ARRAYED_LIST_CURSOR [AP_ALTERNATIVE_OPTIONS_LIST] */
extern T0* GE_new114(T1 initialize);
/* New instance of type SPECIAL [AP_ALTERNATIVE_OPTIONS_LIST] */
extern T0* GE_new115(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [AP_ALTERNATIVE_OPTIONS_LIST] */
extern T0* GE_new116(T1 initialize);
/* New instance of type UC_STRING */
extern T0* GE_new117(T1 initialize);
/* New instance of type STRING_TO_INTEGER_CONVERTOR */
extern T0* GE_new119(T1 initialize);
/* New instance of type DS_LINKED_LIST [XM_ELEMENT] */
extern T0* GE_new121(T1 initialize);
/* New instance of type DS_LINKED_LIST_CURSOR [XM_ELEMENT] */
extern T0* GE_new122(T1 initialize);
/* New instance of type GEANT_INHERIT_ELEMENT */
extern T0* GE_new123(T1 initialize);
/* New instance of type GEANT_INHERIT */
extern T0* GE_new124(T1 initialize);
/* New instance of type SPECIAL [GEANT_TARGET] */
extern T0* GE_new125(T6 a1, T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS [GEANT_TARGET, STRING_8] */
extern T0* GE_new127(T1 initialize);
/* New instance of type DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8] */
extern T0* GE_new129(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [GEANT_TARGET] */
extern T0* GE_new130(T1 initialize);
/* New instance of type XM_EIFFEL_SCANNER */
extern T0* GE_new133(T1 initialize);
/* New instance of type XM_DEFAULT_POSITION */
extern T0* GE_new134(T1 initialize);
/* New instance of type DS_BILINKED_LIST [XM_POSITION] */
extern T0* GE_new136(T1 initialize);
/* New instance of type DS_LINKED_STACK [XM_EIFFEL_SCANNER] */
extern T0* GE_new137(T1 initialize);
/* New instance of type XM_CALLBACKS_NULL */
extern T0* GE_new138(T1 initialize);
/* New instance of type DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8] */
extern T0* GE_new139(T1 initialize);
/* New instance of type XM_NULL_EXTERNAL_RESOLVER */
extern T0* GE_new141(T1 initialize);
/* New instance of type SPECIAL [ANY] */
extern T0* GE_new142(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [ANY] */
extern T0* GE_new143(T1 initialize);
/* New instance of type XM_EIFFEL_PARSER_NAME */
extern T0* GE_new144(T1 initialize);
/* New instance of type XM_EIFFEL_DECLARATION */
extern T0* GE_new145(T1 initialize);
/* New instance of type XM_DTD_EXTERNAL_ID */
extern T0* GE_new146(T1 initialize);
/* New instance of type DS_HASH_SET [XM_EIFFEL_PARSER_NAME] */
extern T0* GE_new147(T1 initialize);
/* New instance of type XM_DTD_ELEMENT_CONTENT */
extern T0* GE_new148(T1 initialize);
/* New instance of type DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT] */
extern T0* GE_new149(T1 initialize);
/* New instance of type XM_DTD_ATTRIBUTE_CONTENT */
extern T0* GE_new150(T1 initialize);
/* New instance of type DS_BILINKED_LIST [STRING_8] */
extern T0* GE_new151(T1 initialize);
/* New instance of type SPECIAL [XM_EIFFEL_PARSER_NAME] */
extern T0* GE_new152(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [XM_EIFFEL_PARSER_NAME] */
extern T0* GE_new153(T1 initialize);
/* New instance of type SPECIAL [XM_EIFFEL_DECLARATION] */
extern T0* GE_new154(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [XM_EIFFEL_DECLARATION] */
extern T0* GE_new155(T1 initialize);
/* New instance of type SPECIAL [BOOLEAN] */
extern T0* GE_new156(T6 a1, T1 initialize);
/* New instance of type SPECIAL [XM_DTD_EXTERNAL_ID] */
extern T0* GE_new157(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [BOOLEAN] */
extern T0* GE_new158(T1 initialize);
/* New instance of type SPECIAL [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]] */
extern T0* GE_new159(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]] */
extern T0* GE_new160(T1 initialize);
/* New instance of type SPECIAL [XM_DTD_ELEMENT_CONTENT] */
extern T0* GE_new161(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [XM_DTD_ELEMENT_CONTENT] */
extern T0* GE_new162(T1 initialize);
/* New instance of type SPECIAL [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]] */
extern T0* GE_new164(T6 a1, T1 initialize);
/* New instance of type SPECIAL [XM_DTD_ATTRIBUTE_CONTENT] */
extern T0* GE_new166(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]] */
extern T0* GE_new167(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [XM_DTD_ATTRIBUTE_CONTENT] */
extern T0* GE_new168(T1 initialize);
/* New instance of type SPECIAL [DS_BILINKED_LIST [STRING_8]] */
extern T0* GE_new169(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [STRING_8]] */
extern T0* GE_new170(T1 initialize);
/* New instance of type XM_EIFFEL_ENTITY_DEF */
extern T0* GE_new171(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [XM_DTD_EXTERNAL_ID] */
extern T0* GE_new172(T1 initialize);
/* New instance of type XM_DTD_CALLBACKS_NULL */
extern T0* GE_new174(T1 initialize);
/* New instance of type XM_EIFFEL_SCANNER_DTD */
extern T0* GE_new175(T1 initialize);
/* New instance of type XM_EIFFEL_PE_ENTITY_DEF */
extern T0* GE_new177(T1 initialize);
/* New instance of type XM_NAMESPACE_RESOLVER */
extern T0* GE_new178(T1 initialize);
/* New instance of type SPECIAL [XM_CALLBACKS_FILTER] */
extern T0* GE_new179(T6 a1, T1 initialize);
/* New instance of type ARRAY [XM_CALLBACKS_FILTER] */
extern T0* GE_new180(T1 initialize);
/* New instance of type DS_LINKED_LIST [DS_PAIR [XM_POSITION, XM_NODE]] */
extern T0* GE_new181(T1 initialize);
/* New instance of type SPECIAL [GEANT_ARGUMENT_VARIABLES] */
extern T0* GE_new182(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [GEANT_ARGUMENT_VARIABLES] */
extern T0* GE_new183(T1 initialize);
/* New instance of type SPECIAL [GEANT_VARIABLES] */
extern T0* GE_new184(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [GEANT_VARIABLES] */
extern T0* GE_new185(T1 initialize);
/* New instance of type TO_SPECIAL [AP_OPTION] */
extern T0* GE_new187(T1 initialize);
/* New instance of type TO_SPECIAL [AP_ALTERNATIVE_OPTIONS_LIST] */
extern T0* GE_new188(T1 initialize);
/* New instance of type C_STRING */
extern T0* GE_new189(T1 initialize);
/* New instance of type DS_ARRAYED_STACK [GEANT_TARGET] */
extern T0* GE_new191(T1 initialize);
/* New instance of type GEANT_TASK_FACTORY */
extern T0* GE_new192(T1 initialize);
/* New instance of type GEANT_PARENT */
extern T0* GE_new193(T1 initialize);
/* New instance of type DS_ARRAYED_LIST [GEANT_PARENT] */
extern T0* GE_new195(T1 initialize);
/* New instance of type DS_ARRAYED_LIST_CURSOR [GEANT_PARENT] */
extern T0* GE_new196(T1 initialize);
/* New instance of type GEANT_INTERPRETING_ELEMENT */
extern T0* GE_new197(T1 initialize);
/* New instance of type GEANT_ARGUMENT_ELEMENT */
extern T0* GE_new198(T1 initialize);
/* New instance of type GEANT_LOCAL_ELEMENT */
extern T0* GE_new199(T1 initialize);
/* New instance of type GEANT_GLOBAL_ELEMENT */
extern T0* GE_new200(T1 initialize);
/* New instance of type XM_ATTRIBUTE */
extern T0* GE_new201(T1 initialize);
/* New instance of type GEANT_GROUP */
extern T0* GE_new202(T1 initialize);
/* New instance of type DS_LINKED_LIST_CURSOR [XM_NODE] */
extern T0* GE_new204(T1 initialize);
/* New instance of type ARRAY [INTEGER_32] */
extern T0* GE_new205(T1 initialize);
/* New instance of type UC_UTF8_ROUTINES */
extern T0* GE_new206(T1 initialize);
/* New instance of type UC_UTF8_STRING */
extern T0* GE_new207(T1 initialize);
/* New instance of type XM_EIFFEL_INPUT_STREAM */
extern T0* GE_new209(T1 initialize);
/* New instance of type KL_INTEGER_ROUTINES */
extern T0* GE_new210(T1 initialize);
/* New instance of type KL_PLATFORM */
extern T0* GE_new211(T1 initialize);
/* New instance of type DS_LINKED_LIST_CURSOR [DS_PAIR [XM_POSITION, XM_NODE]] */
extern T0* GE_new212(T1 initialize);
/* New instance of type DS_PAIR [XM_POSITION, XM_NODE] */
extern T0* GE_new213(T1 initialize);
/* New instance of type INTEGER_OVERFLOW_CHECKER */
extern T0* GE_new214(T1 initialize);
/* New instance of type DS_LINKABLE [XM_ELEMENT] */
extern T0* GE_new215(T1 initialize);
/* New instance of type GEANT_PARENT_ELEMENT */
extern T0* GE_new216(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_TARGET, STRING_8] */
extern T0* GE_new218(T1 initialize);
/* New instance of type TO_SPECIAL [GEANT_TARGET] */
extern T0* GE_new219(T1 initialize);
/* New instance of type XM_EIFFEL_CHARACTER_ENTITY */
extern T0* GE_new220(T1 initialize);
/* New instance of type YY_BUFFER */
extern T0* GE_new221(T1 initialize);
/* New instance of type YY_FILE_BUFFER */
extern T0* GE_new222(T1 initialize);
/* New instance of type DS_LINKED_STACK [INTEGER_32] */
extern T0* GE_new224(T1 initialize);
/* New instance of type DS_BILINKABLE [XM_POSITION] */
extern T0* GE_new226(T1 initialize);
/* New instance of type DS_BILINKED_LIST_CURSOR [XM_POSITION] */
extern T0* GE_new227(T1 initialize);
/* New instance of type DS_LINKABLE [XM_EIFFEL_SCANNER] */
extern T0* GE_new228(T1 initialize);
/* New instance of type SPECIAL [XM_EIFFEL_ENTITY_DEF] */
extern T0* GE_new229(T6 a1, T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS [XM_EIFFEL_ENTITY_DEF, STRING_8] */
extern T0* GE_new230(T1 initialize);
/* New instance of type DS_HASH_TABLE_CURSOR [XM_EIFFEL_ENTITY_DEF, STRING_8] */
extern T0* GE_new232(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [XM_EIFFEL_ENTITY_DEF] */
extern T0* GE_new234(T1 initialize);
/* New instance of type TO_SPECIAL [ANY] */
extern T0* GE_new235(T1 initialize);
/* New instance of type KL_EQUALITY_TESTER [XM_EIFFEL_PARSER_NAME] */
extern T0* GE_new236(T1 initialize);
/* New instance of type DS_HASH_SET_CURSOR [XM_EIFFEL_PARSER_NAME] */
extern T0* GE_new237(T1 initialize);
/* New instance of type DS_BILINKED_LIST [XM_DTD_ELEMENT_CONTENT] */
extern T0* GE_new238(T1 initialize);
/* New instance of type DS_BILINKED_LIST_CURSOR [XM_DTD_ATTRIBUTE_CONTENT] */
extern T0* GE_new239(T1 initialize);
/* New instance of type DS_BILINKABLE [XM_DTD_ATTRIBUTE_CONTENT] */
extern T0* GE_new240(T1 initialize);
/* New instance of type DS_LINKED_LIST [STRING_8] */
extern T0* GE_new241(T1 initialize);
/* New instance of type DS_BILINKED_LIST_CURSOR [STRING_8] */
extern T0* GE_new242(T1 initialize);
/* New instance of type DS_BILINKABLE [STRING_8] */
extern T0* GE_new243(T1 initialize);
/* New instance of type TO_SPECIAL [XM_EIFFEL_PARSER_NAME] */
extern T0* GE_new244(T1 initialize);
/* New instance of type TO_SPECIAL [XM_EIFFEL_DECLARATION] */
extern T0* GE_new245(T1 initialize);
/* New instance of type TO_SPECIAL [BOOLEAN] */
extern T0* GE_new246(T1 initialize);
/* New instance of type TO_SPECIAL [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]] */
extern T0* GE_new247(T1 initialize);
/* New instance of type TO_SPECIAL [XM_DTD_ELEMENT_CONTENT] */
extern T0* GE_new248(T1 initialize);
/* New instance of type TO_SPECIAL [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]] */
extern T0* GE_new249(T1 initialize);
/* New instance of type TO_SPECIAL [XM_DTD_ATTRIBUTE_CONTENT] */
extern T0* GE_new250(T1 initialize);
/* New instance of type TO_SPECIAL [DS_BILINKED_LIST [STRING_8]] */
extern T0* GE_new251(T1 initialize);
/* New instance of type TO_SPECIAL [XM_DTD_EXTERNAL_ID] */
extern T0* GE_new252(T1 initialize);
/* New instance of type XM_NAMESPACE_RESOLVER_CONTEXT */
extern T0* GE_new253(T1 initialize);
/* New instance of type DS_LINKED_QUEUE [STRING_8] */
extern T0* GE_new255(T1 initialize);
/* New instance of type TO_SPECIAL [GEANT_ARGUMENT_VARIABLES] */
extern T0* GE_new256(T1 initialize);
/* New instance of type TO_SPECIAL [GEANT_VARIABLES] */
extern T0* GE_new257(T1 initialize);
/* New instance of type SPECIAL [NATURAL_8] */
extern T0* GE_new258(T6 a1, T1 initialize);
/* New instance of type GEANT_STRING_INTERPRETER */
extern T0* GE_new259(T1 initialize);
/* New instance of type KL_ARRAY_ROUTINES [INTEGER_32] */
extern T0* GE_new262(T1 initialize);
/* New instance of type MANAGED_POINTER */
extern T0* GE_new264(T1 initialize);
/* New instance of type DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8] */
extern T0* GE_new265(T1 initialize);
/* New instance of type GEANT_GEC_TASK */
extern T0* GE_new266(T1 initialize);
/* New instance of type TUPLE [XM_ELEMENT] */
extern T0* GE_new267(T1 initialize);
/* New instance of type TUPLE */
extern T0* GE_new268(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEC_TASK] */
extern T0* GE_new269(T1 initialize);
/* New instance of type TUPLE [GEANT_TASK_FACTORY] */
extern T0* GE_new270(T1 initialize);
/* New instance of type GEANT_ISE_TASK */
extern T0* GE_new273(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_ISE_TASK] */
extern T0* GE_new274(T1 initialize);
/* New instance of type GEANT_EXEC_TASK */
extern T0* GE_new275(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_EXEC_TASK] */
extern T0* GE_new276(T1 initialize);
/* New instance of type GEANT_LCC_TASK */
extern T0* GE_new277(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_LCC_TASK] */
extern T0* GE_new278(T1 initialize);
/* New instance of type GEANT_SET_TASK */
extern T0* GE_new279(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_SET_TASK] */
extern T0* GE_new280(T1 initialize);
/* New instance of type GEANT_UNSET_TASK */
extern T0* GE_new281(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_UNSET_TASK] */
extern T0* GE_new282(T1 initialize);
/* New instance of type GEANT_GEXACE_TASK */
extern T0* GE_new283(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEXACE_TASK] */
extern T0* GE_new284(T1 initialize);
/* New instance of type GEANT_GELEX_TASK */
extern T0* GE_new285(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GELEX_TASK] */
extern T0* GE_new286(T1 initialize);
/* New instance of type GEANT_GEYACC_TASK */
extern T0* GE_new287(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEYACC_TASK] */
extern T0* GE_new288(T1 initialize);
/* New instance of type GEANT_GEPP_TASK */
extern T0* GE_new289(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEPP_TASK] */
extern T0* GE_new290(T1 initialize);
/* New instance of type GEANT_GETEST_TASK */
extern T0* GE_new291(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GETEST_TASK] */
extern T0* GE_new292(T1 initialize);
/* New instance of type GEANT_GEANT_TASK */
extern T0* GE_new293(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_GEANT_TASK] */
extern T0* GE_new294(T1 initialize);
/* New instance of type GEANT_ECHO_TASK */
extern T0* GE_new295(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_ECHO_TASK] */
extern T0* GE_new296(T1 initialize);
/* New instance of type GEANT_MKDIR_TASK */
extern T0* GE_new297(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_MKDIR_TASK] */
extern T0* GE_new298(T1 initialize);
/* New instance of type GEANT_DELETE_TASK */
extern T0* GE_new299(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_DELETE_TASK] */
extern T0* GE_new300(T1 initialize);
/* New instance of type GEANT_COPY_TASK */
extern T0* GE_new301(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_COPY_TASK] */
extern T0* GE_new302(T1 initialize);
/* New instance of type GEANT_MOVE_TASK */
extern T0* GE_new303(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_MOVE_TASK] */
extern T0* GE_new304(T1 initialize);
/* New instance of type GEANT_SETENV_TASK */
extern T0* GE_new305(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_SETENV_TASK] */
extern T0* GE_new306(T1 initialize);
/* New instance of type GEANT_XSLT_TASK */
extern T0* GE_new307(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_XSLT_TASK] */
extern T0* GE_new308(T1 initialize);
/* New instance of type GEANT_OUTOFDATE_TASK */
extern T0* GE_new309(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_OUTOFDATE_TASK] */
extern T0* GE_new310(T1 initialize);
/* New instance of type GEANT_EXIT_TASK */
extern T0* GE_new311(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_EXIT_TASK] */
extern T0* GE_new312(T1 initialize);
/* New instance of type GEANT_PRECURSOR_TASK */
extern T0* GE_new313(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_PRECURSOR_TASK] */
extern T0* GE_new314(T1 initialize);
/* New instance of type GEANT_AVAILABLE_TASK */
extern T0* GE_new315(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_AVAILABLE_TASK] */
extern T0* GE_new316(T1 initialize);
/* New instance of type GEANT_INPUT_TASK */
extern T0* GE_new317(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_INPUT_TASK] */
extern T0* GE_new318(T1 initialize);
/* New instance of type GEANT_REPLACE_TASK */
extern T0* GE_new319(T1 initialize);
/* New instance of type FUNCTION [GEANT_TASK_FACTORY, TUPLE [XM_ELEMENT], GEANT_REPLACE_TASK] */
extern T0* GE_new320(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [GEANT_PARENT] */
extern T0* GE_new321(T1 initialize);
/* New instance of type SPECIAL [GEANT_PARENT] */
extern T0* GE_new322(T6 a1, T1 initialize);
/* New instance of type UC_UNICODE_ROUTINES */
extern T0* GE_new324(T1 initialize);
/* New instance of type DS_LINKED_QUEUE [CHARACTER_8] */
extern T0* GE_new326(T1 initialize);
/* New instance of type UC_UTF16_ROUTINES */
extern T0* GE_new327(T1 initialize);
/* New instance of type DS_LINKABLE [DS_PAIR [XM_POSITION, XM_NODE]] */
extern T0* GE_new328(T1 initialize);
/* New instance of type SPECIAL [NATURAL_64] */
extern T0* GE_new329(T6 a1, T1 initialize);
/* New instance of type GEANT_RENAME_ELEMENT */
extern T0* GE_new330(T1 initialize);
/* New instance of type GEANT_REDEFINE_ELEMENT */
extern T0* GE_new331(T1 initialize);
/* New instance of type GEANT_SELECT_ELEMENT */
extern T0* GE_new332(T1 initialize);
/* New instance of type GEANT_RENAME */
extern T0* GE_new333(T1 initialize);
/* New instance of type DS_HASH_TABLE [GEANT_RENAME, STRING_8] */
extern T0* GE_new334(T1 initialize);
/* New instance of type GEANT_REDEFINE */
extern T0* GE_new335(T1 initialize);
/* New instance of type DS_HASH_TABLE [GEANT_REDEFINE, STRING_8] */
extern T0* GE_new336(T1 initialize);
/* New instance of type GEANT_SELECT */
extern T0* GE_new337(T1 initialize);
/* New instance of type DS_HASH_TABLE [GEANT_SELECT, STRING_8] */
extern T0* GE_new338(T1 initialize);
/* New instance of type DS_LINKABLE [INTEGER_32] */
extern T0* GE_new340(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS_CURSOR [XM_EIFFEL_ENTITY_DEF, STRING_8] */
extern T0* GE_new341(T1 initialize);
/* New instance of type TO_SPECIAL [XM_EIFFEL_ENTITY_DEF] */
extern T0* GE_new342(T1 initialize);
/* New instance of type DS_BILINKED_LIST_CURSOR [XM_DTD_ELEMENT_CONTENT] */
extern T0* GE_new343(T1 initialize);
/* New instance of type DS_BILINKABLE [XM_DTD_ELEMENT_CONTENT] */
extern T0* GE_new344(T1 initialize);
/* New instance of type DS_LINKED_LIST_CURSOR [STRING_8] */
extern T0* GE_new345(T1 initialize);
/* New instance of type DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]] */
extern T0* GE_new347(T1 initialize);
/* New instance of type DS_BILINKED_LIST_CURSOR [DS_HASH_TABLE [STRING_8, STRING_8]] */
extern T0* GE_new348(T1 initialize);
/* New instance of type DS_LINKABLE [STRING_8] */
extern T0* GE_new349(T1 initialize);
/* New instance of type GEANT_NAME_VALUE_ELEMENT */
extern T0* GE_new350(T1 initialize);
/* New instance of type AP_OPTION_COMPARATOR */
extern T0* GE_new351(T1 initialize);
/* New instance of type DS_QUICK_SORTER [AP_OPTION] */
extern T0* GE_new352(T1 initialize);
/* New instance of type ST_WORD_WRAPPER */
extern T0* GE_new354(T1 initialize);
/* New instance of type DS_HASH_SET [XM_NAMESPACE] */
extern T0* GE_new356(T1 initialize);
/* New instance of type XM_COMMENT */
extern T0* GE_new357(T1 initialize);
/* New instance of type XM_PROCESSING_INSTRUCTION */
extern T0* GE_new358(T1 initialize);
/* New instance of type XM_CHARACTER_DATA */
extern T0* GE_new359(T1 initialize);
/* New instance of type XM_NAMESPACE */
extern T0* GE_new360(T1 initialize);
/* New instance of type DS_LINKABLE [XM_NODE] */
extern T0* GE_new363(T1 initialize);
/* New instance of type XM_NODE_TYPER */
extern T0* GE_new365(T1 initialize);
/* New instance of type KL_CHARACTER_BUFFER */
extern T0* GE_new369(T1 initialize);
/* New instance of type EXCEPTIONS */
extern T0* GE_new371(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8] */
extern T0* GE_new373(T1 initialize);
/* New instance of type SPECIAL [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]] */
extern T0* GE_new375(T6 a1, T1 initialize);
/* New instance of type DS_HASH_TABLE_CURSOR [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8] */
extern T0* GE_new376(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]] */
extern T0* GE_new377(T1 initialize);
/* New instance of type GEANT_GEC_COMMAND */
extern T0* GE_new378(T1 initialize);
/* New instance of type DS_CELL [PROCEDURE [ANY, TUPLE]] */
extern T0* GE_new379(T1 initialize);
/* New instance of type PROCEDURE [GEANT_GEC_TASK, TUPLE] */
extern T0* GE_new380(T1 initialize);
/* New instance of type TUPLE [GEANT_GEC_TASK] */
extern T0* GE_new381(T1 initialize);
/* New instance of type GEANT_ISE_COMMAND */
extern T0* GE_new382(T1 initialize);
/* New instance of type PROCEDURE [GEANT_ISE_TASK, TUPLE] */
extern T0* GE_new383(T1 initialize);
/* New instance of type TUPLE [GEANT_ISE_TASK] */
extern T0* GE_new384(T1 initialize);
/* New instance of type GEANT_FILESET_ELEMENT */
extern T0* GE_new385(T1 initialize);
/* New instance of type GEANT_EXEC_COMMAND */
extern T0* GE_new386(T1 initialize);
/* New instance of type GEANT_STRING_PROPERTY */
extern T0* GE_new387(T1 initialize);
/* New instance of type FUNCTION [GEANT_INTERPRETING_ELEMENT, TUPLE, STRING_8] */
extern T0* GE_new388(T1 initialize);
/* New instance of type TUPLE [GEANT_INTERPRETING_ELEMENT, STRING_8] */
extern T0* GE_new389(T1 initialize);
/* New instance of type GEANT_BOOLEAN_PROPERTY */
extern T0* GE_new390(T1 initialize);
/* New instance of type GEANT_FILESET */
extern T0* GE_new391(T1 initialize);
/* New instance of type PROCEDURE [GEANT_EXEC_TASK, TUPLE] */
extern T0* GE_new392(T1 initialize);
/* New instance of type TUPLE [GEANT_EXEC_TASK] */
extern T0* GE_new393(T1 initialize);
/* New instance of type GEANT_LCC_COMMAND */
extern T0* GE_new394(T1 initialize);
/* New instance of type PROCEDURE [GEANT_LCC_TASK, TUPLE] */
extern T0* GE_new395(T1 initialize);
/* New instance of type TUPLE [GEANT_LCC_TASK] */
extern T0* GE_new396(T1 initialize);
/* New instance of type GEANT_SET_COMMAND */
extern T0* GE_new397(T1 initialize);
/* New instance of type PROCEDURE [GEANT_SET_TASK, TUPLE] */
extern T0* GE_new398(T1 initialize);
/* New instance of type TUPLE [GEANT_SET_TASK] */
extern T0* GE_new399(T1 initialize);
/* New instance of type GEANT_UNSET_COMMAND */
extern T0* GE_new400(T1 initialize);
/* New instance of type PROCEDURE [GEANT_UNSET_TASK, TUPLE] */
extern T0* GE_new401(T1 initialize);
/* New instance of type TUPLE [GEANT_UNSET_TASK] */
extern T0* GE_new402(T1 initialize);
/* New instance of type GEANT_DEFINE_ELEMENT */
extern T0* GE_new403(T1 initialize);
/* New instance of type GEANT_GEXACE_COMMAND */
extern T0* GE_new404(T1 initialize);
/* New instance of type PROCEDURE [GEANT_GEXACE_TASK, TUPLE] */
extern T0* GE_new405(T1 initialize);
/* New instance of type TUPLE [GEANT_GEXACE_TASK] */
extern T0* GE_new406(T1 initialize);
/* New instance of type GEANT_GELEX_COMMAND */
extern T0* GE_new407(T1 initialize);
/* New instance of type PROCEDURE [GEANT_GELEX_TASK, TUPLE] */
extern T0* GE_new408(T1 initialize);
/* New instance of type TUPLE [GEANT_GELEX_TASK] */
extern T0* GE_new409(T1 initialize);
/* New instance of type GEANT_GEYACC_COMMAND */
extern T0* GE_new410(T1 initialize);
/* New instance of type PROCEDURE [GEANT_GEYACC_TASK, TUPLE] */
extern T0* GE_new411(T1 initialize);
/* New instance of type TUPLE [GEANT_GEYACC_TASK] */
extern T0* GE_new412(T1 initialize);
/* New instance of type GEANT_GEPP_COMMAND */
extern T0* GE_new413(T1 initialize);
/* New instance of type PROCEDURE [GEANT_GEPP_TASK, TUPLE] */
extern T0* GE_new414(T1 initialize);
/* New instance of type TUPLE [GEANT_GEPP_TASK] */
extern T0* GE_new415(T1 initialize);
/* New instance of type GEANT_GETEST_COMMAND */
extern T0* GE_new416(T1 initialize);
/* New instance of type PROCEDURE [GEANT_GETEST_TASK, TUPLE] */
extern T0* GE_new417(T1 initialize);
/* New instance of type TUPLE [GEANT_GETEST_TASK] */
extern T0* GE_new418(T1 initialize);
/* New instance of type GEANT_GEANT_COMMAND */
extern T0* GE_new419(T1 initialize);
/* New instance of type ST_SPLITTER */
extern T0* GE_new420(T1 initialize);
/* New instance of type PROCEDURE [GEANT_GEANT_TASK, TUPLE] */
extern T0* GE_new421(T1 initialize);
/* New instance of type TUPLE [GEANT_GEANT_TASK] */
extern T0* GE_new422(T1 initialize);
/* New instance of type GEANT_ECHO_COMMAND */
extern T0* GE_new423(T1 initialize);
/* New instance of type PROCEDURE [GEANT_ECHO_TASK, TUPLE] */
extern T0* GE_new424(T1 initialize);
/* New instance of type TUPLE [GEANT_ECHO_TASK] */
extern T0* GE_new425(T1 initialize);
/* New instance of type GEANT_MKDIR_COMMAND */
extern T0* GE_new426(T1 initialize);
/* New instance of type PROCEDURE [GEANT_MKDIR_TASK, TUPLE] */
extern T0* GE_new427(T1 initialize);
/* New instance of type TUPLE [GEANT_MKDIR_TASK] */
extern T0* GE_new428(T1 initialize);
/* New instance of type GEANT_DIRECTORYSET_ELEMENT */
extern T0* GE_new429(T1 initialize);
/* New instance of type GEANT_DELETE_COMMAND */
extern T0* GE_new430(T1 initialize);
/* New instance of type GEANT_DIRECTORYSET */
extern T0* GE_new431(T1 initialize);
/* New instance of type PROCEDURE [GEANT_DELETE_TASK, TUPLE] */
extern T0* GE_new432(T1 initialize);
/* New instance of type TUPLE [GEANT_DELETE_TASK] */
extern T0* GE_new433(T1 initialize);
/* New instance of type GEANT_COPY_COMMAND */
extern T0* GE_new434(T1 initialize);
/* New instance of type PROCEDURE [GEANT_COPY_TASK, TUPLE] */
extern T0* GE_new435(T1 initialize);
/* New instance of type TUPLE [GEANT_COPY_TASK] */
extern T0* GE_new436(T1 initialize);
/* New instance of type GEANT_MOVE_COMMAND */
extern T0* GE_new437(T1 initialize);
/* New instance of type PROCEDURE [GEANT_MOVE_TASK, TUPLE] */
extern T0* GE_new438(T1 initialize);
/* New instance of type TUPLE [GEANT_MOVE_TASK] */
extern T0* GE_new439(T1 initialize);
/* New instance of type GEANT_SETENV_COMMAND */
extern T0* GE_new440(T1 initialize);
/* New instance of type PROCEDURE [GEANT_SETENV_TASK, TUPLE] */
extern T0* GE_new441(T1 initialize);
/* New instance of type TUPLE [GEANT_SETENV_TASK] */
extern T0* GE_new442(T1 initialize);
/* New instance of type DS_PAIR [STRING_8, STRING_8] */
extern T0* GE_new443(T1 initialize);
/* New instance of type GEANT_XSLT_COMMAND */
extern T0* GE_new444(T1 initialize);
/* New instance of type DS_ARRAYED_LIST [DS_PAIR [STRING_8, STRING_8]] */
extern T0* GE_new445(T1 initialize);
/* New instance of type PROCEDURE [GEANT_XSLT_TASK, TUPLE] */
extern T0* GE_new446(T1 initialize);
/* New instance of type TUPLE [GEANT_XSLT_TASK] */
extern T0* GE_new447(T1 initialize);
/* New instance of type GEANT_OUTOFDATE_COMMAND */
extern T0* GE_new448(T1 initialize);
/* New instance of type PROCEDURE [GEANT_OUTOFDATE_TASK, TUPLE] */
extern T0* GE_new449(T1 initialize);
/* New instance of type TUPLE [GEANT_OUTOFDATE_TASK] */
extern T0* GE_new450(T1 initialize);
/* New instance of type GEANT_EXIT_COMMAND */
extern T0* GE_new451(T1 initialize);
/* New instance of type PROCEDURE [GEANT_EXIT_TASK, TUPLE] */
extern T0* GE_new452(T1 initialize);
/* New instance of type TUPLE [GEANT_EXIT_TASK] */
extern T0* GE_new453(T1 initialize);
/* New instance of type GEANT_PRECURSOR_COMMAND */
extern T0* GE_new454(T1 initialize);
/* New instance of type PROCEDURE [GEANT_PRECURSOR_TASK, TUPLE] */
extern T0* GE_new455(T1 initialize);
/* New instance of type TUPLE [GEANT_PRECURSOR_TASK] */
extern T0* GE_new456(T1 initialize);
/* New instance of type GEANT_AVAILABLE_COMMAND */
extern T0* GE_new457(T1 initialize);
/* New instance of type PROCEDURE [GEANT_AVAILABLE_TASK, TUPLE] */
extern T0* GE_new458(T1 initialize);
/* New instance of type TUPLE [GEANT_AVAILABLE_TASK] */
extern T0* GE_new459(T1 initialize);
/* New instance of type GEANT_INPUT_COMMAND */
extern T0* GE_new460(T1 initialize);
/* New instance of type PROCEDURE [GEANT_INPUT_TASK, TUPLE] */
extern T0* GE_new461(T1 initialize);
/* New instance of type TUPLE [GEANT_INPUT_TASK] */
extern T0* GE_new462(T1 initialize);
/* New instance of type GEANT_REPLACE_COMMAND */
extern T0* GE_new463(T1 initialize);
/* New instance of type PROCEDURE [GEANT_REPLACE_TASK, TUPLE] */
extern T0* GE_new464(T1 initialize);
/* New instance of type TUPLE [GEANT_REPLACE_TASK] */
extern T0* GE_new465(T1 initialize);
/* New instance of type TO_SPECIAL [GEANT_PARENT] */
extern T0* GE_new466(T1 initialize);
/* New instance of type SPECIAL [ARRAY [INTEGER_32]] */
extern T0* GE_new467(T6 a1, T1 initialize);
/* New instance of type SPECIAL [SPECIAL [ARRAY [INTEGER_32]]] */
extern T0* GE_new468(T6 a1, T1 initialize);
/* New instance of type DS_LINKABLE [CHARACTER_8] */
extern T0* GE_new469(T1 initialize);
/* New instance of type KL_EQUALITY_TESTER [GEANT_RENAME] */
extern T0* GE_new470(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS [GEANT_RENAME, STRING_8] */
extern T0* GE_new471(T1 initialize);
/* New instance of type SPECIAL [GEANT_RENAME] */
extern T0* GE_new473(T6 a1, T1 initialize);
/* New instance of type DS_HASH_TABLE_CURSOR [GEANT_RENAME, STRING_8] */
extern T0* GE_new474(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [GEANT_RENAME] */
extern T0* GE_new475(T1 initialize);
/* New instance of type KL_EQUALITY_TESTER [GEANT_REDEFINE] */
extern T0* GE_new476(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS [GEANT_REDEFINE, STRING_8] */
extern T0* GE_new477(T1 initialize);
/* New instance of type SPECIAL [GEANT_REDEFINE] */
extern T0* GE_new479(T6 a1, T1 initialize);
/* New instance of type DS_HASH_TABLE_CURSOR [GEANT_REDEFINE, STRING_8] */
extern T0* GE_new480(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [GEANT_REDEFINE] */
extern T0* GE_new481(T1 initialize);
/* New instance of type KL_EQUALITY_TESTER [GEANT_SELECT] */
extern T0* GE_new482(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS [GEANT_SELECT, STRING_8] */
extern T0* GE_new483(T1 initialize);
/* New instance of type SPECIAL [GEANT_SELECT] */
extern T0* GE_new485(T6 a1, T1 initialize);
/* New instance of type DS_HASH_TABLE_CURSOR [GEANT_SELECT, STRING_8] */
extern T0* GE_new486(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [GEANT_SELECT] */
extern T0* GE_new487(T1 initialize);
/* New instance of type DS_BILINKABLE [DS_HASH_TABLE [STRING_8, STRING_8]] */
extern T0* GE_new489(T1 initialize);
/* New instance of type KL_DIRECTORY */
extern T0* GE_new490(T1 initialize);
/* New instance of type KL_STRING_INPUT_STREAM */
extern T0* GE_new491(T1 initialize);
/* New instance of type SPECIAL [XM_NAMESPACE] */
extern T0* GE_new492(T6 a1, T1 initialize);
/* New instance of type KL_EQUALITY_TESTER [XM_NAMESPACE] */
extern T0* GE_new493(T1 initialize);
/* New instance of type DS_HASH_SET_CURSOR [XM_NAMESPACE] */
extern T0* GE_new494(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [XM_NAMESPACE] */
extern T0* GE_new495(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS_CURSOR [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8] */
extern T0* GE_new496(T1 initialize);
/* New instance of type TO_SPECIAL [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]] */
extern T0* GE_new497(T1 initialize);
/* New instance of type GEANT_MAP_ELEMENT */
extern T0* GE_new500(T1 initialize);
/* New instance of type GEANT_MAP */
extern T0* GE_new501(T1 initialize);
/* New instance of type DS_HASH_SET [GEANT_FILESET_ENTRY] */
extern T0* GE_new504(T1 initialize);
/* New instance of type DS_HASH_SET [STRING_8] */
extern T0* GE_new506(T1 initialize);
/* New instance of type LX_DFA_WILDCARD */
extern T0* GE_new508(T1 initialize);
/* New instance of type DS_HASH_SET [INTEGER_32] */
extern T0* GE_new510(T1 initialize);
/* New instance of type DS_CELL [PROCEDURE [ANY, TUPLE [STRING_8]]] */
extern T0* GE_new511(T1 initialize);
/* New instance of type TUPLE [STRING_8] */
extern T0* GE_new512(T1 initialize);
/* New instance of type PROCEDURE [GEANT_ECHO_COMMAND, TUPLE [STRING_8]] */
extern T0* GE_new513(T1 initialize);
/* New instance of type TUPLE [GEANT_ECHO_COMMAND] */
extern T0* GE_new514(T1 initialize);
/* New instance of type DS_CELL [PROCEDURE [ANY, TUPLE [STRING_8, KL_TEXT_OUTPUT_FILE, BOOLEAN]]] */
extern T0* GE_new516(T1 initialize);
/* New instance of type KL_TEXT_OUTPUT_FILE */
extern T0* GE_new517(T1 initialize);
/* New instance of type TUPLE [STRING_8, KL_TEXT_OUTPUT_FILE, BOOLEAN] */
extern T0* GE_new518(T1 initialize);
/* New instance of type PROCEDURE [GEANT_ECHO_COMMAND, TUPLE [STRING_8, KL_TEXT_OUTPUT_FILE, BOOLEAN]] */
extern T0* GE_new519(T1 initialize);
/* New instance of type PROCEDURE [GEANT_MKDIR_COMMAND, TUPLE [STRING_8]] */
extern T0* GE_new521(T1 initialize);
/* New instance of type TUPLE [GEANT_MKDIR_COMMAND] */
extern T0* GE_new522(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [DS_PAIR [STRING_8, STRING_8]] */
extern T0* GE_new523(T1 initialize);
/* New instance of type SPECIAL [DS_PAIR [STRING_8, STRING_8]] */
extern T0* GE_new524(T6 a1, T1 initialize);
/* New instance of type DS_ARRAYED_LIST_CURSOR [DS_PAIR [STRING_8, STRING_8]] */
extern T0* GE_new525(T1 initialize);
/* New instance of type DS_CELL [FUNCTION [ANY, TUPLE [STRING_8], BOOLEAN]] */
extern T0* GE_new526(T1 initialize);
/* New instance of type PREDICATE [GEANT_AVAILABLE_COMMAND, TUPLE [STRING_8]] */
extern T0* GE_new527(T1 initialize);
/* New instance of type TUPLE [GEANT_AVAILABLE_COMMAND] */
extern T0* GE_new528(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_RENAME, STRING_8] */
extern T0* GE_new530(T1 initialize);
/* New instance of type TO_SPECIAL [GEANT_RENAME] */
extern T0* GE_new531(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_REDEFINE, STRING_8] */
extern T0* GE_new532(T1 initialize);
/* New instance of type TO_SPECIAL [GEANT_REDEFINE] */
extern T0* GE_new533(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_SELECT, STRING_8] */
extern T0* GE_new534(T1 initialize);
/* New instance of type TO_SPECIAL [GEANT_SELECT] */
extern T0* GE_new535(T1 initialize);
/* New instance of type TO_SPECIAL [XM_NAMESPACE] */
extern T0* GE_new540(T1 initialize);
/* New instance of type KL_EQUALITY_TESTER [GEANT_FILESET_ENTRY] */
extern T0* GE_new542(T1 initialize);
/* New instance of type DS_HASH_SET_CURSOR [GEANT_FILESET_ENTRY] */
extern T0* GE_new543(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [GEANT_FILESET_ENTRY] */
extern T0* GE_new544(T1 initialize);
/* New instance of type GEANT_FILESET_ENTRY */
extern T0* GE_new545(T1 initialize);
/* New instance of type SPECIAL [GEANT_FILESET_ENTRY] */
extern T0* GE_new546(T6 a1, T1 initialize);
/* New instance of type DS_HASH_SET_CURSOR [STRING_8] */
extern T0* GE_new547(T1 initialize);
/* New instance of type LX_WILDCARD_PARSER */
extern T0* GE_new548(T1 initialize);
/* New instance of type LX_DESCRIPTION */
extern T0* GE_new549(T1 initialize);
/* New instance of type LX_FULL_DFA */
extern T0* GE_new550(T1 initialize);
/* New instance of type DS_HASH_SET_CURSOR [INTEGER_32] */
extern T0* GE_new552(T1 initialize);
/* New instance of type KL_EQUALITY_TESTER [INTEGER_32] */
extern T0* GE_new553(T1 initialize);
/* New instance of type TO_SPECIAL [DS_PAIR [STRING_8, STRING_8]] */
extern T0* GE_new554(T1 initialize);
/* New instance of type KL_NULL_TEXT_OUTPUT_STREAM */
extern T0* GE_new558(T1 initialize);
/* New instance of type DP_SHELL_COMMAND */
extern T0* GE_new560(T1 initialize);
/* New instance of type DS_CELL [BOOLEAN] */
extern T0* GE_new561(T1 initialize);
/* New instance of type KL_BOOLEAN_ROUTINES */
extern T0* GE_new563(T1 initialize);
/* New instance of type ARRAY [BOOLEAN] */
extern T0* GE_new564(T1 initialize);
/* New instance of type GEANT_VARIABLES_VARIABLE_RESOLVER */
extern T0* GE_new565(T1 initialize);
/* New instance of type RX_PCRE_REGULAR_EXPRESSION */
extern T0* GE_new566(T1 initialize);
/* New instance of type KL_STRING_EQUALITY_TESTER */
extern T0* GE_new567(T1 initialize);
/* New instance of type KL_STDIN_FILE */
extern T0* GE_new568(T1 initialize);
/* New instance of type ARRAY [GEANT_VARIABLES] */
extern T0* GE_new569(T1 initialize);
/* New instance of type TO_SPECIAL [GEANT_FILESET_ENTRY] */
extern T0* GE_new572(T1 initialize);
/* New instance of type DS_ARRAYED_LIST [LX_RULE] */
extern T0* GE_new573(T1 initialize);
/* New instance of type LX_START_CONDITIONS */
extern T0* GE_new574(T1 initialize);
/* New instance of type LX_ACTION_FACTORY */
extern T0* GE_new575(T1 initialize);
/* New instance of type DS_ARRAYED_STACK [INTEGER_32] */
extern T0* GE_new576(T1 initialize);
/* New instance of type DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8] */
extern T0* GE_new577(T1 initialize);
/* New instance of type LX_SYMBOL_CLASS */
extern T0* GE_new578(T1 initialize);
/* New instance of type SPECIAL [LX_SYMBOL_CLASS] */
extern T0* GE_new579(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [LX_SYMBOL_CLASS] */
extern T0* GE_new580(T1 initialize);
/* New instance of type LX_NFA */
extern T0* GE_new581(T1 initialize);
/* New instance of type LX_EQUIVALENCE_CLASSES */
extern T0* GE_new582(T1 initialize);
/* New instance of type LX_RULE */
extern T0* GE_new583(T1 initialize);
/* New instance of type SPECIAL [LX_NFA] */
extern T0* GE_new584(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [LX_NFA] */
extern T0* GE_new585(T1 initialize);
/* New instance of type UT_SYNTAX_ERROR */
extern T0* GE_new586(T1 initialize);
/* New instance of type DS_HASH_TABLE_CURSOR [LX_SYMBOL_CLASS, STRING_8] */
extern T0* GE_new587(T1 initialize);
/* New instance of type LX_UNRECOGNIZED_RULE_ERROR */
extern T0* GE_new588(T1 initialize);
/* New instance of type LX_MISSING_QUOTE_ERROR */
extern T0* GE_new589(T1 initialize);
/* New instance of type LX_BAD_CHARACTER_CLASS_ERROR */
extern T0* GE_new590(T1 initialize);
/* New instance of type LX_BAD_CHARACTER_ERROR */
extern T0* GE_new591(T1 initialize);
/* New instance of type LX_FULL_AND_META_ERROR */
extern T0* GE_new592(T1 initialize);
/* New instance of type LX_FULL_AND_REJECT_ERROR */
extern T0* GE_new593(T1 initialize);
/* New instance of type LX_FULL_AND_VARIABLE_TRAILING_CONTEXT_ERROR */
extern T0* GE_new594(T1 initialize);
/* New instance of type LX_CHARACTER_OUT_OF_RANGE_ERROR */
extern T0* GE_new595(T1 initialize);
/* New instance of type SPECIAL [LX_RULE] */
extern T0* GE_new596(T6 a1, T1 initialize);
/* New instance of type ARRAY [LX_RULE] */
extern T0* GE_new597(T1 initialize);
/* New instance of type LX_DFA_STATE */
extern T0* GE_new598(T1 initialize);
/* New instance of type DS_ARRAYED_LIST [LX_NFA_STATE] */
extern T0* GE_new599(T1 initialize);
/* New instance of type DS_ARRAYED_LIST [LX_DFA_STATE] */
extern T0* GE_new600(T1 initialize);
/* New instance of type LX_SYMBOL_PARTITIONS */
extern T0* GE_new601(T1 initialize);
/* New instance of type LX_START_CONDITION */
extern T0* GE_new602(T1 initialize);
/* New instance of type LX_TRANSITION_TABLE [LX_DFA_STATE] */
extern T0* GE_new603(T1 initialize);
/* New instance of type DS_ARRAYED_LIST [LX_NFA] */
extern T0* GE_new604(T1 initialize);
/* New instance of type DS_HASH_TABLE [LX_NFA, INTEGER_32] */
extern T0* GE_new605(T1 initialize);
/* New instance of type LX_NFA_STATE */
extern T0* GE_new606(T1 initialize);
/* New instance of type LX_NEGATIVE_RANGE_IN_CHARACTER_CLASS_ERROR */
extern T0* GE_new608(T1 initialize);
/* New instance of type RX_BYTE_CODE */
extern T0* GE_new610(T1 initialize);
/* New instance of type RX_CASE_MAPPING */
extern T0* GE_new611(T1 initialize);
/* New instance of type RX_CHARACTER_SET */
extern T0* GE_new612(T1 initialize);
/* New instance of type SPECIAL [RX_CHARACTER_SET] */
extern T0* GE_new614(T6 a1, T1 initialize);
/* New instance of type ARRAY [RX_CHARACTER_SET] */
extern T0* GE_new615(T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [LX_RULE] */
extern T0* GE_new616(T1 initialize);
/* New instance of type DS_ARRAYED_LIST_CURSOR [LX_RULE] */
extern T0* GE_new617(T1 initialize);
/* New instance of type SPECIAL [LX_START_CONDITION] */
extern T0* GE_new618(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [LX_START_CONDITION] */
extern T0* GE_new619(T1 initialize);
/* New instance of type DS_ARRAYED_LIST_CURSOR [LX_START_CONDITION] */
extern T0* GE_new620(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS [LX_SYMBOL_CLASS, STRING_8] */
extern T0* GE_new622(T1 initialize);
/* New instance of type DS_ARRAYED_LIST_CURSOR [INTEGER_32] */
extern T0* GE_new624(T1 initialize);
/* New instance of type TO_SPECIAL [LX_SYMBOL_CLASS] */
extern T0* GE_new625(T1 initialize);
/* New instance of type LX_SYMBOL_CLASS_TRANSITION [LX_NFA_STATE] */
extern T0* GE_new626(T1 initialize);
/* New instance of type LX_EPSILON_TRANSITION [LX_NFA_STATE] */
extern T0* GE_new628(T1 initialize);
/* New instance of type LX_SYMBOL_TRANSITION [LX_NFA_STATE] */
extern T0* GE_new630(T1 initialize);
/* New instance of type DS_BILINKABLE [INTEGER_32] */
extern T0* GE_new631(T1 initialize);
/* New instance of type SPECIAL [DS_BILINKABLE [INTEGER_32]] */
extern T0* GE_new632(T6 a1, T1 initialize);
/* New instance of type ARRAY [DS_BILINKABLE [INTEGER_32]] */
extern T0* GE_new633(T1 initialize);
/* New instance of type LX_ACTION */
extern T0* GE_new635(T1 initialize);
/* New instance of type TO_SPECIAL [LX_NFA] */
extern T0* GE_new636(T1 initialize);
/* New instance of type DS_BUBBLE_SORTER [LX_NFA_STATE] */
extern T0* GE_new637(T1 initialize);
/* New instance of type DS_BUBBLE_SORTER [LX_RULE] */
extern T0* GE_new639(T1 initialize);
/* New instance of type SPECIAL [LX_NFA_STATE] */
extern T0* GE_new641(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [LX_NFA_STATE] */
extern T0* GE_new643(T1 initialize);
/* New instance of type DS_ARRAYED_LIST_CURSOR [LX_NFA_STATE] */
extern T0* GE_new644(T1 initialize);
/* New instance of type SPECIAL [LX_DFA_STATE] */
extern T0* GE_new646(T6 a1, T1 initialize);
/* New instance of type KL_SPECIAL_ROUTINES [LX_DFA_STATE] */
extern T0* GE_new647(T1 initialize);
/* New instance of type DS_ARRAYED_LIST_CURSOR [LX_DFA_STATE] */
extern T0* GE_new648(T1 initialize);
/* New instance of type ARRAY [LX_DFA_STATE] */
extern T0* GE_new649(T1 initialize);
/* New instance of type KL_ARRAY_ROUTINES [LX_DFA_STATE] */
extern T0* GE_new650(T1 initialize);
/* New instance of type DS_ARRAYED_LIST_CURSOR [LX_NFA] */
extern T0* GE_new651(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS [LX_NFA, INTEGER_32] */
extern T0* GE_new653(T1 initialize);
/* New instance of type DS_HASH_TABLE_CURSOR [LX_NFA, INTEGER_32] */
extern T0* GE_new655(T1 initialize);
/* New instance of type KL_BINARY_INPUT_FILE */
extern T0* GE_new656(T1 initialize);
/* New instance of type KL_BINARY_OUTPUT_FILE */
extern T0* GE_new657(T1 initialize);
/* New instance of type FILE_NAME */
extern T0* GE_new659(T1 initialize);
/* New instance of type RAW_FILE */
extern T0* GE_new660(T1 initialize);
/* New instance of type DIRECTORY */
extern T0* GE_new661(T1 initialize);
/* New instance of type ARRAYED_LIST [STRING_8] */
extern T0* GE_new662(T1 initialize);
/* New instance of type KL_COMPARABLE_COMPARATOR [LX_RULE] */
extern T0* GE_new665(T1 initialize);
/* New instance of type KL_COMPARABLE_COMPARATOR [LX_NFA_STATE] */
extern T0* GE_new668(T1 initialize);
/* New instance of type TO_SPECIAL [LX_RULE] */
extern T0* GE_new671(T1 initialize);
/* New instance of type TO_SPECIAL [LX_START_CONDITION] */
extern T0* GE_new672(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS_CURSOR [LX_SYMBOL_CLASS, STRING_8] */
extern T0* GE_new673(T1 initialize);
/* New instance of type TO_SPECIAL [LX_NFA_STATE] */
extern T0* GE_new674(T1 initialize);
/* New instance of type TO_SPECIAL [LX_DFA_STATE] */
extern T0* GE_new675(T1 initialize);
/* New instance of type DS_SPARSE_TABLE_KEYS_CURSOR [LX_NFA, INTEGER_32] */
extern T0* GE_new676(T1 initialize);
/* New instance of type STRING_SEARCHER */
extern T0* GE_new677(T1 initialize);
/* New instance of type HASH_TABLE [C_STRING, STRING_8] */
extern T0* GE_new678(T1 initialize);
/* New instance of type DS_SHELL_SORTER [INTEGER_32] */
extern T0* GE_new679(T1 initialize);
/* New instance of type KL_COMPARABLE_COMPARATOR [INTEGER_32] */
extern T0* GE_new684(T1 initialize);
/* New instance of type PRIMES */
extern T0* GE_new687(T1 initialize);
/* New instance of type SPECIAL [C_STRING] */
extern T0* GE_new688(T6 a1, T1 initialize);
/* GEANT.make */
extern T0* T21c20(void);
/* GEANT_PROJECT.build */
extern void T22f35(T0* C, T0* a1);
/* GEANT_PROJECT.build_target */
extern void T22f46(T0* C, T0* a1, T0* a2);
/* DS_ARRAYED_STACK [GEANT_ARGUMENT_VARIABLES].remove */
extern void T105f10(T0* C);
/* DS_ARRAYED_STACK [GEANT_TARGET].remove */
extern void T191f11(T0* C);
/* GEANT_PROJECT.execute_target */
extern void T22f49(T0* C, T0* a1, T0* a2, T1 a3, T1 a4);
/* DS_ARRAYED_STACK [GEANT_VARIABLES].remove */
extern void T106f10(T0* C);
/* GEANT_TARGET.execute */
extern void T26f75(T0* C);
/* GEANT_TARGET.set_executed */
extern void T26f79(T0* C, T1 a1);
/* GEANT_TARGET.execute */
extern void T26f75p1(T0* C);
/* GEANT_TARGET.has_attribute */
extern T1 T26f28(T0* C, T0* a1);
/* GEANT_TARGET.execute_nested_tasks */
extern void T26f81(T0* C);
/* DS_LINKED_LIST_CURSOR [XM_NODE].forth */
extern void T204f11(T0* C);
/* XM_DOCUMENT.cursor_forth */
extern void T98f24(T0* C, T0* a1);
/* XM_DOCUMENT.add_traversing_cursor */
extern void T98f28(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [XM_NODE].set_next_cursor */
extern void T204f16(T0* C, T0* a1);
/* XM_DOCUMENT.remove_traversing_cursor */
extern void T98f29(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [XM_NODE].set */
extern void T204f14(T0* C, T0* a1, T1 a2, T1 a3);
/* XM_ELEMENT.cursor_forth */
extern void T99f41(T0* C, T0* a1);
/* XM_ELEMENT.add_traversing_cursor */
extern void T99f44(T0* C, T0* a1);
/* XM_ELEMENT.remove_traversing_cursor */
extern void T99f45(T0* C, T0* a1);
/* GEANT_TARGET.execute_element */
extern void T26f83(T0* C, T0* a1);
/* GEANT_TARGET.obsolete_element_name */
extern unsigned char ge61os2375;
extern T0* ge61ov2375;
extern T0* T26f17(T0* C);
/* GEANT_TARGET.argument_element_name */
extern unsigned char ge61os2376;
extern T0* ge61ov2376;
extern T0* T26f15(T0* C);
/* GEANT_TARGET.description_element_name */
extern unsigned char ge127os2425;
extern T0* ge127ov2425;
extern T0* T26f22(T0* C);
/* GEANT_TARGET.execute_task */
extern void T26f84(T0* C, T0* a1);
/* GEANT_PROJECT.new_task */
extern T0* T22f25(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_task */
extern T0* T192f54(T0* C, T0* a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].item */
extern T0* T265f30(T0* C, T0* a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].item_storage_item */
extern T0* T265f32(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].search_position */
extern void T265f55(T0* C, T0* a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].clashes_item */
extern T6 T265f33(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].hash_position */
extern T6 T265f34(T0* C, T0* a1);
/* UC_UTF8_STRING.hash_code */
extern T6 T207f17(T0* C);
/* UC_UTF8_STRING.string */
extern T0* T207f36(T0* C);
/* KL_INTEGER_ROUTINES.to_character */
extern T2 T210f2(T0* C, T6 a1);
/* UC_UTF8_STRING.integer_ */
extern unsigned char ge175os4779;
extern T0* ge175ov4779;
extern T0* T207f25(T0* C);
/* KL_INTEGER_ROUTINES.default_create */
extern T0* T210c4(void);
/* INTEGER_32.is_less_equal */
extern T1 T6f9(T6* C, T6 a1);
/* STRING_8.append_character */
extern void T17f35(T0* C, T2 a1);
/* STRING_8.resize */
extern void T17f37(T0* C, T6 a1);
/* SPECIAL [CHARACTER_8].aliased_resized_area */
extern T0* T15f2(T0* C, T6 a1);
/* INTEGER_32.is_greater_equal */
extern T1 T6f5(T6* C, T6 a1);
/* STRING_8.additional_space */
extern T6 T17f6(T0* C);
/* INTEGER_32.max */
extern T6 T6f10(T6* C, T6 a1);
/* STRING_8.capacity */
extern T6 T17f5(T0* C);
/* UC_UTF8_STRING.byte_item */
extern T2 T207f22(T0* C, T6 a1);
/* UC_UTF8_STRING.old_item */
extern T2 T207f35(T0* C, T6 a1);
/* UC_UTF8_STRING.set_count */
extern void T207f63(T0* C, T6 a1);
/* UC_UTF8_STRING.reset_byte_index_cache */
extern void T207f70(T0* C);
/* STRING_8.make */
extern void T17f34(T0* C, T6 a1);
/* STRING_8.make */
extern T0* T17c34(T6 a1);
/* SPECIAL [CHARACTER_8].make */
extern T0* T15c9(T6 a1);
/* UC_UTF8_STRING.next_byte_index */
extern T6 T207f26(T0* C, T6 a1);
/* UC_UTF8_ROUTINES.encoded_byte_count */
extern T6 T206f3(T0* C, T2 a1);
/* CHARACTER_8.is_less_equal */
extern T1 T2f17(T2* C, T2 a1);
/* CHARACTER_8.is_less */
extern T1 T2f5(T2* C, T2 a1);
/* UC_UTF8_STRING.utf8 */
extern unsigned char ge266os5364;
extern T0* ge266ov5364;
extern T0* T207f27(T0* C);
/* UC_UTF8_ROUTINES.default_create */
extern T0* T206c36(void);
/* KL_PLATFORM.maximum_character_code */
extern unsigned char ge247os7424;
extern T6 ge247ov7424;
extern T6 T211f1(T0* C);
/* UC_UTF8_STRING.platform */
extern unsigned char ge254os3995;
extern T0* ge254ov3995;
extern T0* T207f24(T0* C);
/* KL_PLATFORM.default_create */
extern T0* T211c3(void);
/* UC_UTF8_STRING.item_code_at_byte_index */
extern T6 T207f23(T0* C, T6 a1);
/* UC_UTF8_ROUTINES.encoded_next_value */
extern T6 T206f6(T0* C, T2 a1);
/* UC_UTF8_ROUTINES.encoded_first_value */
extern T6 T206f4(T0* C, T2 a1);
/* UC_UTF8_STRING.hash_code */
extern T6 T207f17p1(T0* C);
/* STRING_8.hash_code */
extern T6 T17f8(T0* C);
/* UC_STRING_EQUALITY_TESTER.test */
extern T1 T59f1(T0* C, T0* a1, T0* a2);
/* UC_STRING_EQUALITY_TESTER.string_ */
extern unsigned char ge177os1759;
extern T0* ge177ov1759;
extern T0* T59f2(T0* C);
/* KL_STRING_ROUTINES.default_create */
extern T0* T76c19(void);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].key_storage_item */
extern T0* T265f31(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].slots_item */
extern T6 T265f21(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].has */
extern T1 T265f29(T0* C, T0* a1);
/* XM_ELEMENT.set_name */
extern void T99f54(T0* C, T0* a1);
/* GEANT_TARGET.set_attribute_name */
extern unsigned char ge61os2378;
extern T0* ge61ov2378;
extern T0* T26f55(T0* C);
/* XM_ELEMENT.cloned_object */
extern T0* T99f26(T0* C);
/* XM_ELEMENT.twin */
extern T0* T99f28(T0* C);
/* XM_ELEMENT.copy */
extern void T99f55(T0* C, T0* a1);
/* DS_LINKABLE [XM_NODE].put_right */
extern void T363f4(T0* C, T0* a1);
/* DS_LINKABLE [XM_NODE].make */
extern T0* T363c3(T0* a1);
/* XM_ELEMENT.is_empty */
extern T1 T99f17(T0* C);
/* XM_ELEMENT.valid_cursor */
extern T1 T99f30(T0* C, T0* a1);
/* XM_ELEMENT.move_all_cursors_after */
extern void T99f53(T0* C);
/* DS_LINKED_LIST_CURSOR [XM_NODE].set_after */
extern void T204f15(T0* C);
/* GEANT_NAME_VALUE_ELEMENT.has_value */
extern T1 T350f4(T0* C);
/* GEANT_NAME_VALUE_ELEMENT.has_attribute */
extern T1 T350f3(T0* C, T0* a1);
/* GEANT_NAME_VALUE_ELEMENT.value_attribute_name */
extern unsigned char ge139os7233;
extern T0* ge139ov7233;
extern T0* T350f2(T0* C);
/* GEANT_NAME_VALUE_ELEMENT.make */
extern T0* T350c5(T0* a1);
/* GEANT_NAME_VALUE_ELEMENT.set_xml_element */
extern void T350f6(T0* C, T0* a1);
/* GEANT_TARGET.global_element_name */
extern unsigned char ge53os2398;
extern T0* ge53ov2398;
extern T0* T26f21(T0* C);
/* GEANT_TARGET.local_element_name */
extern unsigned char ge53os2399;
extern T0* ge53ov2399;
extern T0* T26f19(T0* C);
/* GEANT_TARGET.execute_group_element */
extern void T26f82(T0* C, T0* a1);
/* GEANT_GROUP.execute */
extern void T202f26(T0* C);
/* GEANT_GROUP.has_attribute */
extern T1 T202f18(T0* C, T0* a1);
/* GEANT_GROUP.execute_nested_tasks */
extern void T202f32(T0* C);
/* GEANT_GROUP.execute_element */
extern void T202f37(T0* C, T0* a1);
/* GEANT_GROUP.execute_task */
extern void T202f38(T0* C, T0* a1);
/* GEANT_GROUP.description_element_name */
extern T0* T202f13(T0* C);
/* GEANT_GROUP.global_element_name */
extern T0* T202f20(T0* C);
/* GEANT_GROUP.local_element_name */
extern T0* T202f19(T0* C);
/* GEANT_GROUP.execute_group_element */
extern void T202f36(T0* C, T0* a1);
/* GEANT_GROUP.group_element_name */
extern unsigned char ge53os2397;
extern T0* ge53ov2397;
extern T0* T202f17(T0* C);
/* GEANT_GROUP.string_ */
extern T0* T202f16(T0* C);
/* GEANT_GROUP.prepare_variables_before_execution */
extern void T202f31(T0* C);
/* GEANT_GROUP.exit_application */
extern void T202f30(T0* C, T6 a1, T0* a2);
/* KL_EXCEPTIONS.die */
extern void T48f2(T0* C, T6 a1);
/* GEANT_GROUP.exceptions */
extern unsigned char ge250os1761;
extern T0* ge250ov1761;
extern T0* T202f15(T0* C);
/* KL_EXCEPTIONS.default_create */
extern T0* T48c1(void);
/* KL_STDERR_FILE.put_line */
extern void T47f12(T0* C, T0* a1);
/* KL_STDERR_FILE.put_string */
extern void T47f13(T0* C, T0* a1);
/* KL_STDERR_FILE.old_put_string */
extern void T47f15(T0* C, T0* a1);
/* KL_STDERR_FILE.console_ps */
extern void T47f18(T0* C, T14 a1, T14 a2, T6 a3);
/* KL_STRING_ROUTINES.as_string */
extern T0* T76f2(T0* C, T0* a1);
/* STRING_8.string */
extern T0* T17f14(T0* C);
/* STRING_8.make_from_string */
extern T0* T17c41(T0* a1);
/* SPECIAL [CHARACTER_8].copy_data */
extern void T15f11(T0* C, T0* a1, T6 a2, T6 a3, T6 a4);
/* SPECIAL [CHARACTER_8].move_data */
extern void T15f12(T0* C, T6 a1, T6 a2, T6 a3);
/* SPECIAL [CHARACTER_8].overlapping_move */
extern void T15f14(T0* C, T6 a1, T6 a2, T6 a3);
/* SPECIAL [CHARACTER_8].non_overlapping_move */
extern void T15f13(T0* C, T6 a1, T6 a2, T6 a3);
/* UC_UTF8_STRING.as_string */
extern T0* T207f32(T0* C);
/* UC_UTF8_STRING.to_utf8 */
extern T0* T207f20(T0* C);
/* KL_ANY_ROUTINES.same_types */
extern T1 T84f1(T0* C, T0* a1, T0* a2);
/* KL_STRING_ROUTINES.any_ */
extern unsigned char ge170os1999;
extern T0* ge170ov1999;
extern T0* T76f8(T0* C);
/* KL_ANY_ROUTINES.default_create */
extern T0* T84c2(void);
/* KL_STDERR_FILE.string_ */
extern T0* T47f5(T0* C);
/* KL_STDERR_FILE.put_new_line */
extern void T47f11(T0* C);
/* KL_STANDARD_FILES.error */
extern unsigned char ge217os2964;
extern T0* ge217ov2964;
extern T0* T46f1(T0* C);
/* KL_STDERR_FILE.make */
extern T0* T47c9(void);
/* KL_STDERR_FILE.make_open_stderr */
extern void T47f14(T0* C, T0* a1);
/* KL_STDERR_FILE.set_write_mode */
extern void T47f17(T0* C);
/* KL_STDERR_FILE.console_def */
extern T14 T47f4(T0* C, T6 a1);
/* KL_STDERR_FILE.old_make */
extern void T47f16(T0* C, T0* a1);
/* GEANT_GROUP.std */
extern unsigned char ge215os1762;
extern T0* ge215ov1762;
extern T0* T202f14(T0* C);
/* KL_STANDARD_FILES.default_create */
extern T0* T46c3(void);
/* GEANT_GROUP.log_messages */
extern void T202f35(T0* C, T0* a1);
/* ARRAY [STRING_8].item */
extern T0* T33f4(T0* C, T6 a1);
/* GEANT_GROUP.associated_target */
extern T0* T202f12(T0* C);
/* GEANT_GROUP.file_system */
extern unsigned char ge214os1763;
extern T0* ge214ov1763;
extern T0* T202f11(T0* C);
/* GEANT_GROUP.unix_file_system */
extern unsigned char ge214os1766;
extern T0* ge214ov1766;
extern T0* T202f23(T0* C);
/* KL_UNIX_FILE_SYSTEM.make */
extern T0* T54c32(void);
/* KL_OPERATING_SYSTEM.is_unix */
extern unsigned char ge245os2997;
extern T1 ge245ov2997;
extern T1 T51f2(T0* C);
/* STRING_8.item */
extern T2 T17f10(T0* C, T6 a1);
/* KL_OPERATING_SYSTEM.current_working_directory */
extern T0* T51f4(T0* C);
/* EXECUTION_ENVIRONMENT.current_working_directory */
extern T0* T83f2(T0* C);
/* KL_OPERATING_SYSTEM.execution_environment */
extern unsigned char ge245os3001;
extern T0* ge245ov3001;
extern T0* T51f5(T0* C);
/* EXECUTION_ENVIRONMENT.default_create */
extern T0* T83c8(void);
/* STRING_8.is_equal */
extern T1 T17f26(T0* C, T0* a1);
/* SPECIAL [CHARACTER_8].same_items */
extern T1 T15f4(T0* C, T0* a1, T6 a2, T6 a3, T6 a4);
/* KL_OPERATING_SYSTEM.variable_value */
extern T0* T51f3(T0* C, T0* a1);
/* EXECUTION_ENVIRONMENT.get */
extern T0* T83f4(T0* C, T0* a1);
/* STRING_8.make_from_c */
extern T0* T17c45(T14 a1);
/* C_STRING.read_substring_into_character_8_area */
extern void T189f7(T0* C, T0* a1, T6 a2, T6 a3);
/* MANAGED_POINTER.read_natural_8 */
extern T8 T264f6(T0* C, T6 a1);
/* TYPED_POINTER [NATURAL_8].memory_copy */
extern void T370f2(T370* C, T14 a1, T6 a2);
/* TYPED_POINTER [NATURAL_8].c_memcpy */
extern void T370f3(T370* C, T14 a1, T14 a2, T6 a3);
/* C_STRING.set_shared_from_pointer */
extern void T189f6(T0* C, T14 a1);
/* C_STRING.set_shared_from_pointer_and_count */
extern void T189f8(T0* C, T14 a1, T6 a2);
/* MANAGED_POINTER.set_from_pointer */
extern void T264f10(T0* C, T14 a1, T6 a2);
/* MANAGED_POINTER.share_from_pointer */
extern T0* T264c9(T14 a1, T6 a2);
/* C_STRING.c_strlen */
extern T6 T189f3(T0* C, T14 a1);
/* STRING_8.c_string_provider */
extern unsigned char ge2345os1236;
extern T0* ge2345ov1236;
extern T0* T17f28(T0* C);
/* C_STRING.make_empty */
extern void T189f5(T0* C, T6 a1);
/* C_STRING.make_empty */
extern T0* T189c5(T6 a1);
/* MANAGED_POINTER.make */
extern T0* T264c7(T6 a1);
/* EXCEPTIONS.raise */
extern void T371f3(T0* C, T0* a1);
/* EXCEPTIONS.eraise */
extern void T371f4(T0* C, T14 a1, T6 a2);
/* EXCEPTIONS.default_create */
extern T0* T371c2(void);
/* MANAGED_POINTER.default_pointer */
extern T14 T264f5(T0* C);
/* POINTER.memory_calloc */
extern T14 T14f2(T14* C, T6 a1, T6 a2);
/* POINTER.c_calloc */
extern T14 T14f3(T14* C, T6 a1, T6 a2);
/* EXECUTION_ENVIRONMENT.eif_getenv */
extern T14 T83f3(T0* C, T14 a1);
/* GEANT_GROUP.windows_file_system */
extern unsigned char ge214os1764;
extern T0* ge214ov1764;
extern T0* T202f22(T0* C);
/* KL_WINDOWS_FILE_SYSTEM.make */
extern T0* T53c36(void);
/* KL_OPERATING_SYSTEM.is_windows */
extern unsigned char ge245os2996;
extern T1 ge245ov2996;
extern T1 T51f1(T0* C);
/* GEANT_GROUP.operating_system */
extern unsigned char ge253os1767;
extern T0* ge253ov1767;
extern T0* T202f21(T0* C);
/* KL_OPERATING_SYSTEM.default_create */
extern T0* T51c6(void);
/* GEANT_GROUP.project_variables_resolver */
extern unsigned char ge59os1750;
extern T0* ge59ov1750;
extern T0* T202f6(T0* C);
/* GEANT_PROJECT_VARIABLE_RESOLVER.make */
extern T0* T58c18(void);
/* GEANT_GROUP.dir_attribute_name */
extern unsigned char ge135os2407;
extern T0* ge135ov2407;
extern T0* T202f10(T0* C);
/* GEANT_GROUP.is_enabled */
extern T1 T202f8(T0* C);
/* GEANT_GROUP.unless_attribute_name */
extern unsigned char ge135os2409;
extern T0* ge135ov2409;
extern T0* T202f7(T0* C);
/* BOOLEAN.out */
extern T0* T1f6(T1* C);
/* GEANT_PROJECT_VARIABLE_RESOLVER.boolean_condition_value */
extern T1 T58f8(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLE_RESOLVER.exit_application */
extern void T58f20(T0* C, T6 a1, T0* a2);
/* GEANT_PROJECT_VARIABLE_RESOLVER.exceptions */
extern T0* T58f17(T0* C);
/* GEANT_PROJECT_VARIABLE_RESOLVER.std */
extern T0* T58f16(T0* C);
/* GEANT_PROJECT_VARIABLE_RESOLVER.log_messages */
extern void T58f21(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLE_RESOLVER.has */
extern T1 T58f6(T0* C, T0* a1);
/* KL_EXECUTION_ENVIRONMENT.variable_value */
extern T0* T104f1(T0* C, T0* a1);
/* KL_EXECUTION_ENVIRONMENT.string_ */
extern T0* T104f3(T0* C);
/* KL_EXECUTION_ENVIRONMENT.environment_impl */
extern unsigned char ge239os5853;
extern T0* ge239ov5853;
extern T0* T104f2(T0* C);
/* GEANT_PROJECT_VARIABLE_RESOLVER.execution_environment */
extern unsigned char ge251os1760;
extern T0* ge251ov1760;
extern T0* T58f7(T0* C);
/* KL_EXECUTION_ENVIRONMENT.default_create */
extern T0* T104c4(void);
/* DS_ARRAYED_STACK [GEANT_VARIABLES].item */
extern T0* T106f5(T0* C);
/* GEANT_PROJECT_VARIABLE_RESOLVER.target_locals_stack */
extern unsigned char ge59os1753;
extern T0* ge59ov1753;
extern T0* T58f5(T0* C);
/* DS_ARRAYED_STACK [GEANT_VARIABLES].make */
extern T0* T106c8(T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_VARIABLES].make */
extern T0* T185f1(T0* C, T6 a1);
/* TO_SPECIAL [GEANT_VARIABLES].make_area */
extern T0* T257c2(T6 a1);
/* SPECIAL [GEANT_VARIABLES].make */
extern T0* T184c4(T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_VARIABLES].default_create */
extern T0* T185c3(void);
/* GEANT_PROJECT_VARIABLE_RESOLVER.commandline_variables */
extern unsigned char ge59os1743;
extern T0* ge59ov1743;
extern T0* T58f4(T0* C);
/* DS_ARRAYED_STACK [GEANT_ARGUMENT_VARIABLES].item */
extern T0* T105f5(T0* C);
/* GEANT_PROJECT_VARIABLE_RESOLVER.target_arguments_stack */
extern unsigned char ge59os1752;
extern T0* ge59ov1752;
extern T0* T58f3(T0* C);
/* DS_ARRAYED_STACK [GEANT_ARGUMENT_VARIABLES].make */
extern T0* T105c8(T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_ARGUMENT_VARIABLES].make */
extern T0* T183f1(T0* C, T6 a1);
/* TO_SPECIAL [GEANT_ARGUMENT_VARIABLES].make_area */
extern T0* T256c2(T6 a1);
/* SPECIAL [GEANT_ARGUMENT_VARIABLES].make */
extern T0* T182c4(T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_ARGUMENT_VARIABLES].default_create */
extern T0* T183c3(void);
/* UC_UTF8_STRING.substring */
extern T0* T207f11(T0* C, T6 a1, T6 a2);
/* UC_UTF8_STRING.make_from_substring */
extern T0* T207c62(T0* a1, T6 a2, T6 a3);
/* UC_UTF8_STRING.make_from_substring_general */
extern void T207f72(T0* C, T0* a1, T6 a2, T6 a3);
/* UC_UTF8_STRING.put_substring_at_byte_index */
extern void T207f69(T0* C, T0* a1, T6 a2, T6 a3, T6 a4, T6 a5);
/* NATURAL_32.to_integer_32 */
extern T6 T10f2(T10* C);
/* UC_UTF8_STRING.code */
extern T10 T207f14(T0* C, T6 a1);
/* UC_UTF8_STRING.item_code */
extern T6 T207f16(T0* C, T6 a1);
/* STRING_8.code */
extern T10 T17f25(T0* C, T6 a1);
/* INTEGER_32.to_natural_32 */
extern T10 T6f12(T6* C);
/* UC_UTF8_STRING.put_code_at_byte_index */
extern void T207f75(T0* C, T6 a1, T6 a2, T6 a3);
/* UC_UTF8_ROUTINES.code_byte_count */
extern T6 T206f24(T0* C, T6 a1);
/* UC_UTF8_STRING.byte_index */
extern T6 T207f28(T0* C, T6 a1);
/* UC_UTF8_STRING.put_character_at_byte_index */
extern void T207f68(T0* C, T2 a1, T6 a2, T6 a3);
/* UC_UTF8_ROUTINES.character_byte_count */
extern T6 T206f23(T0* C, T2 a1);
/* UC_UTF8_STRING.put_byte */
extern void T207f73(T0* C, T2 a1, T6 a2);
/* UC_UTF8_STRING.old_put */
extern void T207f67(T0* C, T2 a1, T6 a2);
/* UC_UTF8_STRING.any_ */
extern T0* T207f40(T0* C);
/* UC_UTF8_ROUTINES.substring_byte_count */
extern T6 T206f22(T0* C, T0* a1, T6 a2, T6 a3);
/* UC_UTF8_STRING.shifted_byte_index */
extern T6 T207f45(T0* C, T6 a1, T6 a2);
/* UC_UTF8_ROUTINES.dummy_uc_string */
extern unsigned char ge279os7329;
extern T0* ge279ov7329;
extern T0* T206f27(T0* C);
/* UC_STRING.make_empty */
extern T0* T117c8(void);
/* UC_STRING.make */
extern void T117f9(T0* C, T6 a1);
/* UC_STRING.old_set_count */
extern void T117f12(T0* C, T6 a1);
/* UC_STRING.set_count */
extern void T117f11(T0* C, T6 a1);
/* UC_STRING.byte_capacity */
extern T6 T117f7(T0* C);
/* UC_STRING.capacity */
extern T6 T117f7p1(T0* C);
/* UC_STRING.make */
extern void T117f9p1(T0* C, T6 a1);
/* UC_STRING.reset_byte_index_cache */
extern void T117f10(T0* C);
/* UC_UTF8_ROUTINES.any_ */
extern T0* T206f25(T0* C);
/* UC_UTF8_STRING.cloned_string */
extern T0* T207f39(T0* C);
/* UC_UTF8_STRING.twin */
extern T0* T207f44(T0* C);
/* UC_UTF8_STRING.copy */
extern void T207f79(T0* C, T0* a1);
/* UC_UTF8_STRING.copy */
extern void T207f79p1(T0* C, T0* a1);
/* SPECIAL [CHARACTER_8].twin */
extern T0* T15f5(T0* C);
/* UC_UTF8_STRING.make */
extern void T207f61(T0* C, T6 a1);
/* UC_UTF8_STRING.make */
extern T0* T207c61(T6 a1);
/* UC_UTF8_STRING.old_set_count */
extern void T207f71(T0* C, T6 a1);
/* UC_UTF8_STRING.byte_capacity */
extern T6 T207f38(T0* C);
/* UC_UTF8_STRING.capacity */
extern T6 T207f38p1(T0* C);
/* UC_UTF8_STRING.make */
extern void T207f61p1(T0* C, T6 a1);
/* STRING_8.substring */
extern T0* T17f11(T0* C, T6 a1, T6 a2);
/* STRING_8.set_count */
extern void T17f43(T0* C, T6 a1);
/* STRING_8.new_string */
extern T0* T17f20(T0* C, T6 a1);
/* UC_UTF8_STRING.item */
extern T2 T207f10(T0* C, T6 a1);
/* UC_UTF8_STRING.character_item_at_byte_index */
extern T2 T207f29(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLE_RESOLVER.true_attribute_value */
extern unsigned char ge58os4459;
extern T0* ge58ov4459;
extern T0* T58f11(T0* C);
/* KL_STRING_ROUTINES.same_case_insensitive */
extern T1 T76f11(T0* C, T0* a1, T0* a2);
/* CHARACTER_8.lower */
extern T2 T2f19(T2* C);
/* CHARACTER_8.is_upper */
extern T1 T2f20(T2* C);
/* NATURAL_8.is_greater */
extern T1 T8f2(T8* C, T8 a1);
/* CHARACTER_8.character_types */
extern T8 T2f7(T2* C, T6 a1);
/* CHARACTER_8.internal_character_types */
extern unsigned char ge8os92;
extern T0* ge8ov92;
extern T0* T2f9(T2* C);
/* SPECIAL [NATURAL_8].make */
extern T0* T258c2(T6 a1);
/* UC_UNICODE_ROUTINES.lower_code */
extern T6 T324f4(T0* C, T6 a1);
/* ARRAY [INTEGER_32].item */
extern T6 T205f4(T0* C, T6 a1);
/* UC_UNICODE_ROUTINES.lower_codes */
extern unsigned char ge290os8433;
extern T0* ge290ov8433;
extern T0* T324f9(T0* C);
/* UC_UNICODE_ROUTINES.empty_lower_code_plane */
extern unsigned char ge290os8432;
extern T0* ge290ov8432;
extern T0* T324f12(T0* C);
/* UC_UNICODE_ROUTINES.empty_lower_code_segment */
extern unsigned char ge290os8419;
extern T0* ge290ov8419;
extern T0* T324f19(T0* C);
/* KL_INTEGER_ROUTINES.to_integer */
extern T6 T210f3(T0* C, T6 a1);
/* UC_UNICODE_ROUTINES.integer_ */
extern T0* T324f30(T0* C);
/* SPECIAL [ARRAY [INTEGER_32]].make */
extern T0* T467c2(T6 a1);
/* UC_UNICODE_ROUTINES.lower_code_plane_1 */
extern unsigned char ge290os8431;
extern T0* ge290ov8431;
extern T0* T324f11(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_1_segment_4 */
extern unsigned char ge290os8430;
extern T0* ge290ov8430;
extern T0* T324f29(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0 */
extern unsigned char ge290os8429;
extern T0* ge290ov8429;
extern T0* T324f10(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_255 */
extern unsigned char ge290os8428;
extern T0* ge290ov8428;
extern T0* T324f28(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_167 */
extern unsigned char ge290os8427;
extern T0* ge290ov8427;
extern T0* T324f27(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_166 */
extern unsigned char ge290os8426;
extern T0* ge290ov8426;
extern T0* T324f26(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_44 */
extern unsigned char ge290os8425;
extern T0* ge290ov8425;
extern T0* T324f25(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_36 */
extern unsigned char ge290os8424;
extern T0* ge290ov8424;
extern T0* T324f24(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_33 */
extern unsigned char ge290os8423;
extern T0* ge290ov8423;
extern T0* T324f23(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_31 */
extern unsigned char ge290os8422;
extern T0* ge290ov8422;
extern T0* T324f22(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_30 */
extern unsigned char ge290os8421;
extern T0* ge290ov8421;
extern T0* T324f21(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_16 */
extern unsigned char ge290os8420;
extern T0* ge290ov8420;
extern T0* T324f20(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_5 */
extern unsigned char ge290os8418;
extern T0* ge290ov8418;
extern T0* T324f18(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_4 */
extern unsigned char ge290os8417;
extern T0* ge290ov8417;
extern T0* T324f17(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_3 */
extern unsigned char ge290os8416;
extern T0* ge290ov8416;
extern T0* T324f16(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_2 */
extern unsigned char ge290os8415;
extern T0* ge290ov8415;
extern T0* T324f15(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_1 */
extern unsigned char ge290os8414;
extern T0* ge290ov8414;
extern T0* T324f14(T0* C);
/* UC_UNICODE_ROUTINES.lower_code_plane_0_segment_0 */
extern unsigned char ge290os8413;
extern T0* ge290ov8413;
extern T0* T324f13(T0* C);
/* SPECIAL [SPECIAL [ARRAY [INTEGER_32]]].make */
extern T0* T468c2(T6 a1);
/* KL_STRING_ROUTINES.unicode */
extern unsigned char ge263os4780;
extern T0* ge263ov4780;
extern T0* T76f12(T0* C);
/* UC_UNICODE_ROUTINES.default_create */
extern T0* T324c31(void);
/* STRING_8.item_code */
extern T6 T17f13(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLE_RESOLVER.false_attribute_value */
extern unsigned char ge58os4460;
extern T0* ge58ov4460;
extern T0* T58f10(T0* C);
/* GEANT_PROJECT_VARIABLE_RESOLVER.string_ */
extern T0* T58f2(T0* C);
/* DS_LINKED_LIST [STRING_8].item */
extern T0* T241f7(T0* C, T6 a1);
/* ST_SPLITTER.split_greedy */
extern T0* T420f9(T0* C, T0* a1);
/* ST_SPLITTER.do_split */
extern T0* T420f7(T0* C, T0* a1, T1 a2);
/* DS_LINKED_LIST [STRING_8].force_last */
extern void T241f12(T0* C, T0* a1);
/* DS_LINKABLE [STRING_8].put_right */
extern void T349f4(T0* C, T0* a1);
/* DS_LINKABLE [STRING_8].make */
extern T0* T349c3(T0* a1);
/* DS_LINKED_LIST [STRING_8].is_empty */
extern T1 T241f6(T0* C);
/* DS_HASH_SET [INTEGER_32].has */
extern T1 T510f24(T0* C, T6 a1);
/* DS_HASH_SET [INTEGER_32].search_position */
extern void T510f32(T0* C, T6 a1);
/* DS_HASH_SET [INTEGER_32].clashes_item */
extern T6 T510f22(T0* C, T6 a1);
/* DS_HASH_SET [INTEGER_32].hash_position */
extern T6 T510f19(T0* C, T6 a1);
/* INTEGER_32.hash_code */
extern T6 T6f23(T6* C);
/* DS_HASH_SET [INTEGER_32].key_storage_item */
extern T6 T510f18(T0* C, T6 a1);
/* DS_HASH_SET [INTEGER_32].item_storage_item */
extern T6 T510f27(T0* C, T6 a1);
/* DS_HASH_SET [INTEGER_32].key_equality_tester */
extern T0* T510f17(T0* C);
/* DS_HASH_SET [INTEGER_32].slots_item */
extern T6 T510f25(T0* C, T6 a1);
/* KL_STRING_ROUTINES.appended_substring */
extern T0* T76f4(T0* C, T0* a1, T0* a2, T6 a3, T6 a4);
/* UC_UTF8_STRING.append_character */
extern void T207f58(T0* C, T2 a1);
/* UC_UTF8_STRING.resize_byte_storage */
extern void T207f66(T0* C, T6 a1);
/* UC_UTF8_STRING.resize */
extern void T207f74(T0* C, T6 a1);
/* UC_UTF8_STRING.append_string */
extern void T207f57(T0* C, T0* a1);
/* UC_UTF8_STRING.append */
extern void T207f65(T0* C, T0* a1);
/* UC_UTF8_STRING.dummy_uc_string */
extern unsigned char ge269os6010;
extern T0* ge269ov6010;
extern T0* T207f42(T0* C);
/* UC_UTF8_STRING.append */
extern void T207f65p1(T0* C, T0* a1);
/* UC_UTF8_STRING.additional_space */
extern T6 T207f43(T0* C);
/* ISE_RUNTIME.check_assert */
extern T1 T325s1(T1 a1);
/* UC_UTF8_STRING.new_empty_string */
extern T0* T207f9(T0* C, T6 a1);
/* UC_UTF8_STRING.append_substring */
extern void T207f59(T0* C, T0* a1, T6 a2, T6 a3);
/* ST_SPLITTER.string_ */
extern T0* T420f6(T0* C);
/* DS_LINKED_LIST [STRING_8].make */
extern T0* T241c11(void);
/* DS_LINKED_LIST [STRING_8].new_cursor */
extern T0* T241f10(T0* C);
/* DS_LINKED_LIST_CURSOR [STRING_8].make */
extern T0* T345c7(T0* a1);
/* ST_SPLITTER.make_with_separators */
extern T0* T420c10(T0* a1);
/* ST_SPLITTER.set_separators */
extern void T420f12(T0* C, T0* a1);
/* DS_HASH_SET [INTEGER_32].put */
extern void T510f31(T0* C, T6 a1);
/* DS_HASH_SET [INTEGER_32].slots_put */
extern void T510f40(T0* C, T6 a1, T6 a2);
/* DS_HASH_SET [INTEGER_32].clashes_put */
extern void T510f39(T0* C, T6 a1, T6 a2);
/* DS_HASH_SET [INTEGER_32].item_storage_put */
extern void T510f38(T0* C, T6 a1, T6 a2);
/* DS_HASH_SET [INTEGER_32].unset_found_item */
extern void T510f37(T0* C);
/* DS_HASH_SET [INTEGER_32].make */
extern T0* T510c30(T6 a1);
/* DS_HASH_SET [INTEGER_32].new_cursor */
extern T0* T510f20(T0* C);
/* DS_HASH_SET_CURSOR [INTEGER_32].make */
extern T0* T552c3(T0* a1);
/* DS_HASH_SET [INTEGER_32].make_slots */
extern void T510f36(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [INTEGER_32].make */
extern T0* T65f2(T0* C, T6 a1);
/* TO_SPECIAL [INTEGER_32].make_area */
extern T0* T108c2(T6 a1);
/* SPECIAL [INTEGER_32].make */
extern T0* T63c4(T6 a1);
/* DS_HASH_SET [INTEGER_32].special_integer_ */
extern unsigned char ge176os2159;
extern T0* ge176ov2159;
extern T0* T510f23(T0* C);
/* KL_SPECIAL_ROUTINES [INTEGER_32].default_create */
extern T0* T65c4(void);
/* DS_HASH_SET [INTEGER_32].new_modulus */
extern T6 T510f28(T0* C, T6 a1);
/* DS_HASH_SET [INTEGER_32].make_clashes */
extern void T510f35(T0* C, T6 a1);
/* DS_HASH_SET [INTEGER_32].make_key_storage */
extern void T510f34(T0* C, T6 a1);
/* DS_HASH_SET [INTEGER_32].make_item_storage */
extern void T510f33(T0* C, T6 a1);
/* GEANT_GROUP.if_attribute_name */
extern unsigned char ge135os2408;
extern T0* ge135ov2408;
extern T0* T202f9(T0* C);
/* GEANT_GROUP.set_parent */
extern void T202f25(T0* C, T0* a1);
/* GEANT_GROUP.make */
extern T0* T202c24(T0* a1, T0* a2);
/* GEANT_GROUP.initialize */
extern void T202f27(T0* C);
/* GEANT_GROUP.set_description */
extern void T202f33(T0* C, T0* a1);
/* XM_ELEMENT.text */
extern T0* T99f27(T0* C);
/* KL_STRING_ROUTINES.appended_string */
extern T0* T76f5(T0* C, T0* a1, T0* a2);
/* STRING_8.append_string */
extern void T17f40(T0* C, T0* a1);
/* STRING_8.append */
extern void T17f36(T0* C, T0* a1);
/* KL_STRING_ROUTINES.concat */
extern T0* T76f6(T0* C, T0* a1, T0* a2);
/* UC_UTF8_STRING.prefixed_string */
extern T0* T207f8(T0* C, T0* a1);
/* KL_STRING_ROUTINES.cloned_string */
extern T0* T76f7(T0* C, T0* a1);
/* STRING_8.twin */
extern T0* T17f17(T0* C);
/* STRING_8.copy */
extern void T17f42(T0* C, T0* a1);
/* XM_ELEMENT.string_ */
extern T0* T99f29(T0* C);
/* XM_NODE_TYPER.is_character_data */
extern T1 T365f10(T0* C);
/* XM_NODE_TYPER.default_create */
extern T0* T365c11(void);
/* XM_ELEMENT.element_by_name */
extern T0* T99f16(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [XM_NODE].go_after */
extern void T204f12(T0* C);
/* XM_DOCUMENT.cursor_go_after */
extern void T98f25(T0* C, T0* a1);
/* XM_DOCUMENT.cursor_off */
extern T1 T98f12(T0* C, T0* a1);
/* XM_ELEMENT.cursor_go_after */
extern void T99f42(T0* C, T0* a1);
/* XM_ELEMENT.cursor_off */
extern T1 T99f23(T0* C, T0* a1);
/* XM_ELEMENT.named_same_name */
extern T1 T99f9(T0* C, T0* a1, T0* a2);
/* XM_ELEMENT.same_namespace */
extern T1 T99f12(T0* C, T0* a1);
/* XM_NAMESPACE.is_equal */
extern T1 T360f4(T0* C, T0* a1);
/* XM_NAMESPACE.string_ */
extern T0* T360f3(T0* C);
/* XM_ELEMENT.has_namespace */
extern T1 T99f14(T0* C);
/* XM_ELEMENT.same_string */
extern T1 T99f11(T0* C, T0* a1, T0* a2);
/* XM_ELEMENT.string_equality_tester */
extern unsigned char ge268os2161;
extern T0* ge268ov2161;
extern T0* T99f13(T0* C);
/* UC_STRING_EQUALITY_TESTER.default_create */
extern T0* T59c3(void);
/* XM_NODE_TYPER.is_element */
extern T1 T365f8(T0* C);
/* GEANT_GROUP.make */
extern void T202f24p1(T0* C, T0* a1, T0* a2);
/* XM_POSITION_TABLE.item */
extern T0* T101f3(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [DS_PAIR [XM_POSITION, XM_NODE]].forth */
extern void T212f10(T0* C);
/* DS_LINKED_LIST [DS_PAIR [XM_POSITION, XM_NODE]].cursor_forth */
extern void T181f11(T0* C, T0* a1);
/* DS_LINKED_LIST [DS_PAIR [XM_POSITION, XM_NODE]].add_traversing_cursor */
extern void T181f13(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [DS_PAIR [XM_POSITION, XM_NODE]].set_next_cursor */
extern void T212f13(T0* C, T0* a1);
/* DS_LINKED_LIST [DS_PAIR [XM_POSITION, XM_NODE]].remove_traversing_cursor */
extern void T181f14(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [DS_PAIR [XM_POSITION, XM_NODE]].set */
extern void T212f11(T0* C, T0* a1, T1 a2, T1 a3);
/* DS_LINKED_LIST_CURSOR [DS_PAIR [XM_POSITION, XM_NODE]].go_after */
extern void T212f9(T0* C);
/* DS_LINKED_LIST [DS_PAIR [XM_POSITION, XM_NODE]].cursor_go_after */
extern void T181f10(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [DS_PAIR [XM_POSITION, XM_NODE]].set_after */
extern void T212f12(T0* C);
/* DS_LINKED_LIST [DS_PAIR [XM_POSITION, XM_NODE]].cursor_off */
extern T1 T181f6(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [DS_PAIR [XM_POSITION, XM_NODE]].item */
extern T0* T212f6(T0* C);
/* DS_LINKED_LIST_CURSOR [DS_PAIR [XM_POSITION, XM_NODE]].start */
extern void T212f8(T0* C);
/* DS_LINKED_LIST [DS_PAIR [XM_POSITION, XM_NODE]].cursor_start */
extern void T181f9(T0* C, T0* a1);
/* DS_LINKED_LIST [DS_PAIR [XM_POSITION, XM_NODE]].new_cursor */
extern T0* T181f7(T0* C);
/* DS_LINKED_LIST_CURSOR [DS_PAIR [XM_POSITION, XM_NODE]].make */
extern T0* T212c7(T0* a1);
/* XM_POSITION_TABLE.has */
extern T1 T101f2(T0* C, T0* a1);
/* GEANT_GROUP.set_project */
extern void T202f29(T0* C, T0* a1);
/* GEANT_GROUP.element_make */
extern void T202f28(T0* C, T0* a1);
/* GEANT_GROUP.set_xml_element */
extern void T202f34(T0* C, T0* a1);
/* KL_STRING_ROUTINES.same_string */
extern T1 T76f1(T0* C, T0* a1, T0* a2);
/* KL_STRING_ROUTINES.elks_same_string */
extern T1 T76f10(T0* C, T0* a1, T0* a2);
/* UC_UTF8_STRING.same_string */
extern T1 T207f15(T0* C, T0* a1);
/* UC_UTF8_STRING.substring_index */
extern T6 T207f31(T0* C, T0* a1, T6 a2);
/* STRING_8.same_string */
extern T1 T17f18(T0* C, T0* a1);
/* STRING_8.same_string_general */
extern T1 T17f24(T0* C, T0* a1);
/* UC_UTF8_STRING.same_unicode_string */
extern T1 T207f13(T0* C, T0* a1);
/* UC_UTF8_STRING.unicode_substring_index */
extern T6 T207f30(T0* C, T0* a1, T6 a2);
/* GEANT_TARGET.group_element_name */
extern T0* T26f54(T0* C);
/* GEANT_TARGET.string_ */
extern T0* T26f30(T0* C);
/* DS_LINKED_LIST_CURSOR [XM_NODE].item */
extern T0* T204f8(T0* C);
/* DS_LINKED_LIST_CURSOR [XM_NODE].start */
extern void T204f10(T0* C);
/* XM_DOCUMENT.cursor_start */
extern void T98f23(T0* C, T0* a1);
/* XM_ELEMENT.cursor_start */
extern void T99f40(T0* C, T0* a1);
/* XM_ELEMENT.new_cursor */
extern T0* T99f20(T0* C);
/* DS_LINKED_LIST_CURSOR [XM_NODE].make */
extern T0* T204c9(T0* a1);
/* GEANT_TARGET.prepare_variables_before_execution */
extern void T26f80(T0* C);
/* GEANT_TARGET.prepare_variables_before_execution */
extern void T26f80p1(T0* C);
/* DS_HASH_TABLE_CURSOR [STRING_8, STRING_8].forth */
extern void T64f9(T0* C);
/* DS_HASH_TABLE_CURSOR [STRING_8, STRING_8].key */
extern T0* T64f5(T0* C);
/* STRING_8.make_empty */
extern T0* T17c38(void);
/* DS_HASH_TABLE_CURSOR [STRING_8, STRING_8].item */
extern T0* T64f4(T0* C);
/* DS_HASH_TABLE_CURSOR [STRING_8, STRING_8].after */
extern T1 T64f6(T0* C);
/* DS_HASH_TABLE_CURSOR [STRING_8, STRING_8].start */
extern void T64f8(T0* C);
/* GEANT_TARGET.target_locals_stack */
extern T0* T26f53(T0* C);
/* GEANT_TARGET.prepared_arguments_from_formal_arguments */
extern T0* T26f52(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.has_same_keys */
extern T1 T34f35(T0* C, T0* a1);
/* GEANT_TARGET.named_from_numbered_arguments */
extern T0* T26f61(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.has_numbered_keys */
extern T1 T34f39(T0* C);
/* INTEGER_32.out */
extern T0* T6f13(T6* C);
/* STRING_8.append_integer */
extern void T17f46(T0* C, T6 a1);
/* GEANT_TARGET.target_arguments_stack */
extern T0* T26f51(T0* C);
/* KL_UNIX_FILE_SYSTEM.set_current_working_directory */
extern void T54f33(T0* C, T0* a1);
/* EXECUTION_ENVIRONMENT.change_working_directory */
extern void T83f9(T0* C, T0* a1);
/* EXECUTION_ENVIRONMENT.eif_chdir */
extern T6 T83f5(T0* C, T14 a1);
/* KL_UNIX_FILE_SYSTEM.execution_environment */
extern unsigned char ge205os3844;
extern T0* ge205ov3844;
extern T0* T54f18(T0* C);
/* KL_UNIX_FILE_SYSTEM.string_ */
extern T0* T54f13(T0* C);
/* KL_WINDOWS_FILE_SYSTEM.set_current_working_directory */
extern void T53f37(T0* C, T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.execution_environment */
extern T0* T53f20(T0* C);
/* KL_WINDOWS_FILE_SYSTEM.string_ */
extern T0* T53f12(T0* C);
/* GEANT_TARGET.exit_application */
extern void T26f67(T0* C, T6 a1, T0* a2);
/* GEANT_TARGET.exceptions */
extern T0* T26f24(T0* C);
/* GEANT_TARGET.std */
extern T0* T26f23(T0* C);
/* GEANT_TARGET.log_messages */
extern void T26f74(T0* C, T0* a1);
/* GEANT_TARGET.associated_target */
extern T0* T26f50(T0* C);
/* KL_UNIX_FILE_SYSTEM.directory_exists */
extern T1 T54f24(T0* C, T0* a1);
/* KL_DIRECTORY.exists */
extern T1 T490f12(T0* C);
/* KL_DIRECTORY.old_exists */
extern T1 T490f15(T0* C);
/* KL_DIRECTORY.eif_dir_exists */
extern T1 T490f10(T0* C, T14 a1);
/* KL_DIRECTORY.reset */
extern void T490f37(T0* C, T0* a1);
/* KL_DIRECTORY.make */
extern void T490f35(T0* C, T0* a1);
/* KL_DIRECTORY.make */
extern T0* T490c35(T0* a1);
/* KL_DIRECTORY.old_make */
extern void T490f38(T0* C, T0* a1);
/* KL_DIRECTORY.string_ */
extern T0* T490f19(T0* C);
/* KL_UNIX_FILE_SYSTEM.tmp_directory */
extern unsigned char ge205os3842;
extern T0* ge205ov3842;
extern T0* T54f25(T0* C);
/* KL_WINDOWS_FILE_SYSTEM.directory_exists */
extern T1 T53f27(T0* C, T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.tmp_directory */
extern T0* T53f28(T0* C);
/* KL_UNIX_FILE_SYSTEM.current_working_directory */
extern T0* T54f23(T0* C);
/* KL_WINDOWS_FILE_SYSTEM.current_working_directory */
extern T0* T53f26(T0* C);
/* GEANT_TARGET.file_system */
extern T0* T26f49(T0* C);
/* GEANT_TARGET.unix_file_system */
extern T0* T26f60(T0* C);
/* GEANT_TARGET.windows_file_system */
extern T0* T26f59(T0* C);
/* GEANT_TARGET.operating_system */
extern T0* T26f58(T0* C);
/* GEANT_STRING_INTERPRETER.interpreted_string */
extern T0* T259f5(T0* C, T0* a1);
/* GEANT_STRING_INTERPRETER.variable_value */
extern T0* T259f3(T0* C, T0* a1);
/* GEANT_STRING_INTERPRETER.expanded_variable_value */
extern T0* T259f6(T0* C, T0* a1);
/* GEANT_VARIABLES_VARIABLE_RESOLVER.value */
extern T0* T565f2(T0* C, T0* a1);
/* GEANT_VARIABLES.item */
extern T0* T29f34(T0* C, T0* a1);
/* GEANT_VARIABLES.item_storage_item */
extern T0* T29f35(T0* C, T6 a1);
/* GEANT_VARIABLES.search_position */
extern void T29f54(T0* C, T0* a1);
/* GEANT_VARIABLES.clashes_item */
extern T6 T29f27(T0* C, T6 a1);
/* GEANT_VARIABLES.hash_position */
extern T6 T29f24(T0* C, T0* a1);
/* GEANT_VARIABLES.key_storage_item */
extern T0* T29f28(T0* C, T6 a1);
/* GEANT_VARIABLES.slots_item */
extern T6 T29f29(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLE_RESOLVER.value */
extern T0* T58f9(T0* C, T0* a1);
/* KL_UNIX_FILE_SYSTEM.cwd */
extern T0* T54f10(T0* C);
/* KL_WINDOWS_FILE_SYSTEM.cwd */
extern T0* T53f10(T0* C);
/* GEANT_PROJECT_VARIABLE_RESOLVER.file_system */
extern T0* T58f12(T0* C);
/* GEANT_PROJECT_VARIABLE_RESOLVER.unix_file_system */
extern T0* T58f15(T0* C);
/* GEANT_PROJECT_VARIABLE_RESOLVER.windows_file_system */
extern T0* T58f14(T0* C);
/* GEANT_PROJECT_VARIABLE_RESOLVER.operating_system */
extern T0* T58f13(T0* C);
/* GEANT_VARIABLES_VARIABLE_RESOLVER.has */
extern T1 T565f3(T0* C, T0* a1);
/* GEANT_STRING_INTERPRETER.default_variable_value */
extern T0* T259f4(T0* C, T0* a1);
/* UC_UTF8_STRING.old_is_empty */
extern T1 T207f51(T0* C);
/* STRING_8.is_empty */
extern T1 T17f30(T0* C);
/* KL_STRING_ROUTINES.append_substring_to_string */
extern void T76f20(T0* C, T0* a1, T0* a2, T6 a3, T6 a4);
/* KL_STRING_ROUTINES.new_empty_string */
extern T0* T76f3(T0* C, T0* a1, T6 a2);
/* UC_UTF8_STRING.old_wipe_out */
extern void T207f77(T0* C);
/* UC_UTF8_STRING.wipe_out */
extern void T207f80(T0* C);
/* UC_UTF8_STRING.wipe_out */
extern void T207f77p1(T0* C);
/* STRING_8.wipe_out */
extern void T17f39(T0* C);
/* GEANT_STRING_INTERPRETER.string_ */
extern T0* T259f2(T0* C);
/* UC_UTF8_STRING.out */
extern T0* T207f18(T0* C);
/* UC_UTF8_STRING.unicode */
extern T0* T207f33(T0* C);
/* STRING_8.out */
extern T0* T17f4(T0* C);
/* XM_ELEMENT.attribute_by_name */
extern T0* T99f8(T0* C, T0* a1);
/* XM_ELEMENT.attribute_same_name */
extern T1 T99f10(T0* C, T0* a1, T0* a2);
/* XM_NODE_TYPER.is_attribute */
extern T1 T365f9(T0* C);
/* GEANT_STRING_INTERPRETER.set_variable_resolver */
extern void T259f8(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLE_RESOLVER.set_variables */
extern void T58f19(T0* C, T0* a1);
/* GEANT_TARGET.project_variables_resolver */
extern T0* T26f33(T0* C);
/* GEANT_STRING_INTERPRETER.make */
extern T0* T259c7(void);
/* XM_ELEMENT.has_attribute_by_name */
extern T1 T99f21(T0* C, T0* a1);
/* GEANT_TARGET.dir_attribute_name */
extern T0* T26f48(T0* C);
/* GEANT_PROJECT.log */
extern void T22f50(T0* C, T0* a1);
/* KL_STDOUT_FILE.flush */
extern void T68f19(T0* C);
/* KL_STDOUT_FILE.old_flush */
extern void T68f20(T0* C);
/* KL_STDOUT_FILE.file_flush */
extern void T68f21(T0* C, T14 a1);
/* KL_STDOUT_FILE.put_new_line */
extern void T68f14(T0* C);
/* KL_STDOUT_FILE.put_string */
extern void T68f13(T0* C, T0* a1);
/* KL_STDOUT_FILE.old_put_string */
extern void T68f17(T0* C, T0* a1);
/* KL_STDOUT_FILE.console_ps */
extern void T68f18(T0* C, T14 a1, T14 a2, T6 a3);
/* KL_STDOUT_FILE.string_ */
extern T0* T68f6(T0* C);
/* GEANT_PROJECT.target_name */
extern T0* T22f24(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8].forth */
extern void T129f10(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].cursor_forth */
extern void T31f69(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].add_traversing_cursor */
extern void T31f74(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8].set_next_cursor */
extern void T129f15(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].remove_traversing_cursor */
extern void T31f73(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8].set_position */
extern void T129f14(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].clashes_item */
extern T6 T31f21(T0* C, T6 a1);
/* DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8].go_after */
extern void T129f13(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].cursor_go_after */
extern void T31f79(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].cursor_off */
extern T1 T31f43(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8].key */
extern T0* T129f7(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].cursor_key */
extern T0* T31f38(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].key_storage_item */
extern T0* T31f35(T0* C, T6 a1);
/* DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8].item */
extern T0* T129f6(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].cursor_item */
extern T0* T31f37(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].item_storage_item */
extern T0* T31f27(T0* C, T6 a1);
/* DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8].after */
extern T1 T129f5(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].cursor_after */
extern T1 T31f36(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8].start */
extern void T129f9(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].cursor_start */
extern void T31f68(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].is_empty */
extern T1 T31f42(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].new_cursor */
extern T0* T31f29(T0* C);
/* DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8].make */
extern T0* T129c8(T0* a1);
/* GEANT_TARGET.is_enabled */
extern T1 T26f47(T0* C);
/* GEANT_TARGET.unless_attribute_name */
extern T0* T26f57(T0* C);
/* GEANT_TARGET.if_attribute_name */
extern T0* T26f56(T0* C);
/* DS_ARRAYED_STACK [GEANT_VARIABLES].force */
extern void T106f9(T0* C, T0* a1);
/* DS_ARRAYED_STACK [GEANT_VARIABLES].resize */
extern void T106f11(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_VARIABLES].resize */
extern T0* T185f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [GEANT_VARIABLES].aliased_resized_area */
extern T0* T184f3(T0* C, T6 a1);
/* DS_ARRAYED_STACK [GEANT_VARIABLES].new_capacity */
extern T6 T106f7(T0* C, T6 a1);
/* DS_ARRAYED_STACK [GEANT_VARIABLES].extendible */
extern T1 T106f6(T0* C, T6 a1);
/* GEANT_VARIABLES.make */
extern T0* T29c48(void);
/* GEANT_VARIABLES.set_key_equality_tester */
extern void T29f52(T0* C, T0* a1);
/* DS_SPARSE_TABLE_KEYS [STRING_8, STRING_8].internal_set_equality_tester */
extern void T61f6(T0* C, T0* a1);
/* GEANT_VARIABLES.make_map */
extern void T29f51(T0* C, T6 a1);
/* GEANT_VARIABLES.make_with_equality_testers */
extern void T29f60(T0* C, T6 a1, T0* a2, T0* a3);
/* DS_SPARSE_TABLE_KEYS [STRING_8, STRING_8].make */
extern T0* T61c5(T0* a1);
/* DS_SPARSE_TABLE_KEYS [STRING_8, STRING_8].new_cursor */
extern T0* T61f4(T0* C);
/* DS_SPARSE_TABLE_KEYS_CURSOR [STRING_8, STRING_8].make */
extern T0* T107c3(T0* a1);
/* GEANT_VARIABLES.make_sparse_container */
extern void T29f65(T0* C, T6 a1);
/* GEANT_VARIABLES.unset_found_item */
extern void T29f53(T0* C);
/* GEANT_VARIABLES.make_slots */
extern void T29f69(T0* C, T6 a1);
/* GEANT_VARIABLES.special_integer_ */
extern T0* T29f26(T0* C);
/* GEANT_VARIABLES.new_modulus */
extern T6 T29f33(T0* C, T6 a1);
/* GEANT_VARIABLES.make_clashes */
extern void T29f68(T0* C, T6 a1);
/* GEANT_VARIABLES.make_key_storage */
extern void T29f67(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [STRING_8].make */
extern T0* T66f2(T0* C, T6 a1);
/* TO_SPECIAL [STRING_8].make_area */
extern T0* T109c2(T6 a1);
/* SPECIAL [STRING_8].make */
extern T0* T32c6(T6 a1);
/* KL_SPECIAL_ROUTINES [STRING_8].default_create */
extern T0* T66c3(void);
/* GEANT_VARIABLES.make_item_storage */
extern void T29f66(T0* C, T6 a1);
/* GEANT_PROJECT.target_locals_stack */
extern T0* T22f23(T0* C);
/* GEANT_TARGET.final_target */
extern T0* T26f37(T0* C);
/* GEANT_PROJECT.current_target */
extern T0* T22f22(T0* C);
/* DS_ARRAYED_STACK [GEANT_TARGET].is_empty */
extern T1 T191f5(T0* C);
/* GEANT_PROJECT.trace_debug */
extern void T22f39(T0* C, T0* a1);
/* DS_ARRAYED_STACK [GEANT_TARGET].item */
extern T0* T191f6(T0* C);
/* GEANT_ARGUMENT_VARIABLES.make */
extern T0* T34c48(void);
/* GEANT_ARGUMENT_VARIABLES.set_key_equality_tester */
extern void T34f51(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.make_map */
extern void T34f50(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.make_with_equality_testers */
extern void T34f59(T0* C, T6 a1, T0* a2, T0* a3);
/* GEANT_ARGUMENT_VARIABLES.make_sparse_container */
extern void T34f64(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.unset_found_item */
extern void T34f52(T0* C);
/* GEANT_ARGUMENT_VARIABLES.make_slots */
extern void T34f68(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.special_integer_ */
extern T0* T34f26(T0* C);
/* GEANT_ARGUMENT_VARIABLES.new_modulus */
extern T6 T34f31(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.make_clashes */
extern void T34f67(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.make_key_storage */
extern void T34f66(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.make_item_storage */
extern void T34f65(T0* C, T6 a1);
/* GEANT_PROJECT.calculate_depend_order */
extern void T22f48(T0* C, T0* a1);
/* GEANT_TARGET.dependent_targets */
extern T0* T26f41(T0* C);
/* DS_ARRAYED_LIST [STRING_8].item */
extern T0* T71f14(T0* C, T6 a1);
/* GEANT_TARGET.show_dependent_targets */
extern void T26f78(T0* C, T0* a1);
/* KL_STDOUT_FILE.put_line */
extern void T68f11(T0* C, T0* a1);
/* KL_STANDARD_FILES.output */
extern unsigned char ge217os2963;
extern T0* ge217ov2963;
extern T0* T46f2(T0* C);
/* KL_STDOUT_FILE.make */
extern T0* T68c9(void);
/* KL_STDOUT_FILE.make_open_stdout */
extern void T68f12(T0* C, T0* a1);
/* KL_STDOUT_FILE.set_write_mode */
extern void T68f16(T0* C);
/* KL_STDOUT_FILE.console_def */
extern T14 T68f5(T0* C, T6 a1);
/* KL_STDOUT_FILE.old_make */
extern void T68f15(T0* C, T0* a1);
/* GEANT_TARGET.string_tokens */
extern T0* T26f25(T0* C, T0* a1, T2 a2);
/* DS_ARRAYED_LIST [STRING_8].force_last */
extern void T71f27(T0* C, T0* a1);
/* DS_ARRAYED_LIST [STRING_8].resize */
extern void T71f28(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [STRING_8].resize */
extern T0* T66f1(T0* C, T0* a1, T6 a2);
/* SPECIAL [STRING_8].aliased_resized_area */
extern T0* T32f3(T0* C, T6 a1);
/* DS_ARRAYED_LIST [STRING_8].new_capacity */
extern T6 T71f19(T0* C, T6 a1);
/* DS_ARRAYED_LIST [STRING_8].extendible */
extern T1 T71f18(T0* C, T6 a1);
/* UC_UTF8_STRING.index_of */
extern T6 T207f19(T0* C, T2 a1, T6 a2);
/* UC_UTF8_STRING.index_of_item_code */
extern T6 T207f34(T0* C, T6 a1, T6 a2);
/* STRING_8.index_of */
extern T6 T17f27(T0* C, T2 a1, T6 a2);
/* UC_UTF8_STRING.keep_head */
extern void T207f76(T0* C, T6 a1);
/* STRING_8.keep_head */
extern void T17f48(T0* C, T6 a1);
/* UC_UTF8_STRING.keep_tail */
extern void T207f78(T0* C, T6 a1);
/* UC_UTF8_STRING.move_bytes_left */
extern void T207f81(T0* C, T6 a1, T6 a2);
/* STRING_8.keep_tail */
extern void T17f47(T0* C, T6 a1);
/* DS_ARRAYED_LIST [STRING_8].make */
extern T0* T71c23(T6 a1);
/* DS_ARRAYED_LIST [STRING_8].new_cursor */
extern T0* T71f9(T0* C);
/* DS_ARRAYED_LIST_CURSOR [STRING_8].make */
extern T0* T72c7(T0* a1);
/* GEANT_TARGET.dependencies */
extern T0* T26f45(T0* C);
/* GEANT_TARGET.depend_attribute_name */
extern unsigned char ge61os2379;
extern T0* ge61ov2379;
extern T0* T26f46(T0* C);
/* GEANT_TARGET.has_dependencies */
extern T1 T26f44(T0* C);
/* DS_ARRAYED_STACK [GEANT_TARGET].force */
extern void T191f10(T0* C, T0* a1);
/* DS_ARRAYED_STACK [GEANT_TARGET].resize */
extern void T191f12(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_TARGET].resize */
extern T0* T130f1(T0* C, T0* a1, T6 a2);
/* SPECIAL [GEANT_TARGET].aliased_resized_area */
extern T0* T125f3(T0* C, T6 a1);
/* DS_ARRAYED_STACK [GEANT_TARGET].new_capacity */
extern T6 T191f8(T0* C, T6 a1);
/* DS_ARRAYED_STACK [GEANT_TARGET].extendible */
extern T1 T191f7(T0* C, T6 a1);
/* DS_ARRAYED_STACK [GEANT_TARGET].make */
extern T0* T191c9(T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_TARGET].make */
extern T0* T130f2(T0* C, T6 a1);
/* TO_SPECIAL [GEANT_TARGET].make_area */
extern T0* T219c2(T6 a1);
/* SPECIAL [GEANT_TARGET].make */
extern T0* T125c4(T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_TARGET].default_create */
extern T0* T130c3(void);
/* DS_ARRAYED_STACK [GEANT_ARGUMENT_VARIABLES].force */
extern void T105f9(T0* C, T0* a1);
/* DS_ARRAYED_STACK [GEANT_ARGUMENT_VARIABLES].resize */
extern void T105f11(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_ARGUMENT_VARIABLES].resize */
extern T0* T183f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [GEANT_ARGUMENT_VARIABLES].aliased_resized_area */
extern T0* T182f3(T0* C, T6 a1);
/* DS_ARRAYED_STACK [GEANT_ARGUMENT_VARIABLES].new_capacity */
extern T6 T105f7(T0* C, T6 a1);
/* DS_ARRAYED_STACK [GEANT_ARGUMENT_VARIABLES].extendible */
extern T1 T105f6(T0* C, T6 a1);
/* GEANT_PROJECT.target_arguments_stack */
extern T0* T22f21(T0* C);
/* GEANT_PROJECT.trace */
extern void T22f31(T0* C, T0* a1);
/* GEANT.commandline_arguments */
extern unsigned char ge59os1744;
extern T0* ge59ov1744;
extern T0* T21f11(T0* C);
/* GEANT_PROJECT.start_target */
extern T0* T22f17(T0* C);
/* GEANT_PROJECT.exit_application */
extern void T22f43(T0* C, T6 a1, T0* a2);
/* GEANT_PROJECT.exceptions */
extern T0* T22f20(T0* C);
/* GEANT_PROJECT.std */
extern T0* T22f18(T0* C);
/* GEANT_PROJECT.log_messages */
extern void T22f47(T0* C, T0* a1);
/* GEANT_PROJECT.preferred_start_target */
extern T0* T22f19(T0* C);
/* GEANT_PROJECT.default_target */
extern T0* T22f16(T0* C);
/* GEANT_PROJECT.show_target_info */
extern void T22f34(T0* C);
/* GEANT_PROJECT.set_start_target_name */
extern void T22f33(T0* C, T0* a1);
/* GEANT_TARGET.full_name */
extern T0* T26f34(T0* C);
/* GEANT_TARGET.is_exported_to_any */
extern T1 T26f35(T0* C);
/* DS_ARRAYED_LIST [STRING_8].has */
extern T1 T71f22(T0* C, T0* a1);
/* GEANT_TARGET.project_name_any */
extern unsigned char ge61os2382;
extern T0* ge61ov2382;
extern T0* T26f26(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].item */
extern T0* T31f34(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].search_position */
extern void T31f51(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].hash_position */
extern T6 T31f24(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].slots_item */
extern T6 T31f26(T0* C, T6 a1);
/* GEANT.exit_application */
extern void T21f22(T0* C, T6 a1, T0* a2);
/* GEANT.exceptions */
extern T0* T21f14(T0* C);
/* GEANT.std */
extern T0* T21f13(T0* C);
/* GEANT.log_messages */
extern void T21f28(T0* C, T0* a1);
/* UC_UTF8_STRING.plus */
extern T0* T207f7(T0* C, T0* a1);
/* STRING_8.plus */
extern T0* T17f9(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].has */
extern T1 T31f33(T0* C, T0* a1);
/* INTEGER_32.is_greater */
extern T1 T6f1(T6* C, T6 a1);
/* GEANT_PROJECT.merge_in_parent_projects */
extern void T22f32(T0* C);
/* GEANT_TARGET.show_precursors */
extern void T26f77(T0* C);
/* ARRAY [STRING_8].force */
extern void T33f14(T0* C, T0* a1, T6 a2);
/* ARRAY [STRING_8].auto_resize */
extern void T33f15(T0* C, T6 a1, T6 a2);
/* SPECIAL [STRING_8].fill_with_default */
extern void T32f10(T0* C, T6 a1, T6 a2);
/* SPECIAL [STRING_8].move_data */
extern void T32f9(T0* C, T6 a1, T6 a2, T6 a3);
/* SPECIAL [STRING_8].overlapping_move */
extern void T32f12(T0* C, T6 a1, T6 a2, T6 a3);
/* SPECIAL [STRING_8].non_overlapping_move */
extern void T32f11(T0* C, T6 a1, T6 a2, T6 a3);
/* ARRAY [STRING_8].capacity */
extern T6 T33f8(T0* C);
/* ARRAY [STRING_8].make_area */
extern void T33f13(T0* C, T6 a1);
/* ARRAY [STRING_8].additional_space */
extern T6 T33f7(T0* C);
/* INTEGER_32.min */
extern T6 T6f19(T6* C, T6 a1);
/* ARRAY [STRING_8].empty_area */
extern T1 T33f6(T0* C);
/* ARRAY [STRING_8].count */
extern T6 T33f10(T0* C);
/* ARRAY [STRING_8].put */
extern void T33f12(T0* C, T0* a1, T6 a2);
/* ARRAY [STRING_8].make */
extern T0* T33c11(T6 a1, T6 a2);
/* GEANT_INHERIT.apply_selects */
extern void T124f8(T0* C);
/* GEANT_INHERIT.check_targets_for_conflicts */
extern void T124f14(T0* C);
/* DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8].back */
extern void T129f12(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].cursor_back */
extern void T31f71(T0* C, T0* a1);
/* GEANT_INHERIT.exit_application */
extern void T124f15(T0* C, T6 a1, T0* a2);
/* GEANT_INHERIT.exceptions */
extern T0* T124f5(T0* C);
/* GEANT_INHERIT.std */
extern T0* T124f4(T0* C);
/* GEANT_INHERIT.log_messages */
extern void T124f16(T0* C, T0* a1);
/* GEANT_TARGET.conflicts_with */
extern T1 T26f39(T0* C, T0* a1);
/* GEANT_TARGET.seed */
extern T0* T26f43(T0* C);
/* DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8].before */
extern T1 T129f4(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].cursor_before */
extern T1 T31f39(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_TARGET, STRING_8].finish */
extern void T129f11(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].cursor_finish */
extern void T31f70(T0* C, T0* a1);
/* GEANT_INHERIT.sort_out_selected_targets */
extern void T124f13(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].remove */
extern void T31f67(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].remove_position */
extern void T31f72(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].key_storage_put */
extern void T31f57(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].item_storage_put */
extern void T31f56(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].clashes_put */
extern void T31f54(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].slots_put */
extern void T31f55(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].move_cursors_forth */
extern void T31f76(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].move_all_cursors */
extern void T31f78(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].move_cursors_after */
extern void T31f77(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].internal_set_key_equality_tester */
extern void T31f75(T0* C, T0* a1);
/* DS_SPARSE_TABLE_KEYS [GEANT_TARGET, STRING_8].internal_set_equality_tester */
extern void T127f6(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].unset_found_item */
extern void T31f52(T0* C);
/* GEANT_TARGET.set_redefining_target */
extern void T26f85(T0* C, T0* a1);
/* GEANT_INHERIT.validate_parent_selects */
extern void T124f12(T0* C);
/* GEANT_INHERIT.merge_in_parent_project */
extern void T124f7(T0* C, T0* a1);
/* GEANT_INHERIT.merge_in_unchanged_targets */
extern void T124f11(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].force_last_new */
extern void T31f49(T0* C, T0* a1, T0* a2);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].resize */
extern void T31f53(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].clashes_resize */
extern void T31f62(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [INTEGER_32].resize */
extern T0* T65f1(T0* C, T0* a1, T6 a2);
/* SPECIAL [INTEGER_32].aliased_resized_area */
extern T0* T63f3(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].special_integer_ */
extern T0* T31f30(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].key_storage_resize */
extern void T31f61(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].item_storage_resize */
extern void T31f60(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].slots_resize */
extern void T31f59(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].new_modulus */
extern T6 T31f22(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].new_capacity */
extern T6 T31f32(T0* C, T6 a1);
/* GEANT_INHERIT.string_ */
extern T0* T124f3(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].found_item */
extern T0* T31f28(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].found */
extern T1 T31f31(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].search */
extern void T31f48(T0* C, T0* a1);
/* GEANT_INHERIT.merge_in_renamed_targets */
extern void T124f10(T0* C, T0* a1);
/* GEANT_INHERIT.merge_in_redefined_targets */
extern void T124f9(T0* C, T0* a1);
/* GEANT_TARGET.set_precursor_target */
extern void T26f76(T0* C, T0* a1);
/* GEANT_TARGET.formal_arguments_match */
extern T1 T26f38(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [GEANT_PARENT].forth */
extern void T196f9(T0* C);
/* DS_ARRAYED_LIST [GEANT_PARENT].cursor_forth */
extern void T195f20(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [GEANT_PARENT].set_position */
extern void T196f10(T0* C, T6 a1);
/* DS_ARRAYED_LIST [GEANT_PARENT].add_traversing_cursor */
extern void T195f21(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [GEANT_PARENT].set_next_cursor */
extern void T196f11(T0* C, T0* a1);
/* DS_ARRAYED_LIST [GEANT_PARENT].remove_traversing_cursor */
extern void T195f22(T0* C, T0* a1);
/* GEANT_PARENT.prepare_project */
extern void T193f14(T0* C);
/* GEANT_PARENT.apply_selects */
extern void T193f19(T0* C);
/* DS_HASH_TABLE_CURSOR [GEANT_SELECT, STRING_8].forth */
extern void T486f8(T0* C);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].cursor_forth */
extern void T338f59(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].add_traversing_cursor */
extern void T338f61(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_SELECT, STRING_8].set_next_cursor */
extern void T486f10(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].remove_traversing_cursor */
extern void T338f60(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_SELECT, STRING_8].set_position */
extern void T486f9(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].clashes_item */
extern T6 T338f25(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].force_last */
extern void T31f80(T0* C, T0* a1, T0* a2);
/* GEANT_PARENT.exit_application */
extern void T193f20(T0* C, T6 a1, T0* a2);
/* GEANT_PARENT.exceptions */
extern T0* T193f11(T0* C);
/* GEANT_PARENT.std */
extern T0* T193f10(T0* C);
/* GEANT_PARENT.log_messages */
extern void T193f21(T0* C, T0* a1);
/* GEANT_SELECT.is_executable */
extern T1 T337f2(T0* C);
/* DS_HASH_TABLE_CURSOR [GEANT_SELECT, STRING_8].item */
extern T0* T486f4(T0* C);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].cursor_item */
extern T0* T338f33(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].item_storage_item */
extern T0* T338f35(T0* C, T6 a1);
/* DS_HASH_TABLE_CURSOR [GEANT_SELECT, STRING_8].after */
extern T1 T486f5(T0* C);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].cursor_after */
extern T1 T338f32(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_SELECT, STRING_8].start */
extern void T486f7(T0* C);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].cursor_start */
extern void T338f58(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].cursor_off */
extern T1 T338f37(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].is_empty */
extern T1 T338f36(T0* C);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].new_cursor */
extern T0* T338f26(T0* C);
/* DS_HASH_TABLE_CURSOR [GEANT_SELECT, STRING_8].make */
extern T0* T486c6(T0* a1);
/* GEANT_PARENT.apply_undeclared_redefines */
extern void T193f18(T0* C);
/* GEANT_PARENT.apply_unchangeds */
extern void T193f17(T0* C);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].has_item */
extern T1 T31f45(T0* C, T0* a1);
/* GEANT_PARENT.apply_redefines */
extern void T193f16(T0* C);
/* DS_HASH_TABLE_CURSOR [GEANT_REDEFINE, STRING_8].forth */
extern void T480f8(T0* C);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].cursor_forth */
extern void T336f59(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].add_traversing_cursor */
extern void T336f61(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_REDEFINE, STRING_8].set_next_cursor */
extern void T480f10(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].remove_traversing_cursor */
extern void T336f60(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_REDEFINE, STRING_8].set_position */
extern void T480f9(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].clashes_item */
extern T6 T336f25(T0* C, T6 a1);
/* GEANT_REDEFINE.is_executable */
extern T1 T335f2(T0* C);
/* DS_HASH_TABLE_CURSOR [GEANT_REDEFINE, STRING_8].item */
extern T0* T480f4(T0* C);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].cursor_item */
extern T0* T336f33(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].item_storage_item */
extern T0* T336f35(T0* C, T6 a1);
/* DS_HASH_TABLE_CURSOR [GEANT_REDEFINE, STRING_8].after */
extern T1 T480f5(T0* C);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].cursor_after */
extern T1 T336f32(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_REDEFINE, STRING_8].start */
extern void T480f7(T0* C);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].cursor_start */
extern void T336f58(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].cursor_off */
extern T1 T336f37(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].is_empty */
extern T1 T336f36(T0* C);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].new_cursor */
extern T0* T336f26(T0* C);
/* DS_HASH_TABLE_CURSOR [GEANT_REDEFINE, STRING_8].make */
extern T0* T480c6(T0* a1);
/* GEANT_PARENT.apply_renames */
extern void T193f15(T0* C);
/* DS_HASH_TABLE_CURSOR [GEANT_RENAME, STRING_8].back */
extern void T474f8(T0* C);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].cursor_back */
extern void T334f60(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].add_traversing_cursor */
extern void T334f62(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_RENAME, STRING_8].set_next_cursor */
extern void T474f10(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].remove_traversing_cursor */
extern void T334f61(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_RENAME, STRING_8].set_position */
extern void T474f9(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].clashes_item */
extern T6 T334f26(T0* C, T6 a1);
/* GEANT_RENAME.is_executable */
extern T1 T333f3(T0* C);
/* GEANT_RENAME.string_ */
extern T0* T333f4(T0* C);
/* DS_HASH_TABLE_CURSOR [GEANT_RENAME, STRING_8].item */
extern T0* T474f4(T0* C);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].cursor_item */
extern T0* T334f34(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].item_storage_item */
extern T0* T334f35(T0* C, T6 a1);
/* DS_HASH_TABLE_CURSOR [GEANT_RENAME, STRING_8].before */
extern T1 T474f5(T0* C);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].cursor_before */
extern T1 T334f33(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [GEANT_RENAME, STRING_8].finish */
extern void T474f7(T0* C);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].cursor_finish */
extern void T334f59(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].cursor_off */
extern T1 T334f37(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].is_empty */
extern T1 T334f36(T0* C);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].new_cursor */
extern T0* T334f27(T0* C);
/* DS_HASH_TABLE_CURSOR [GEANT_RENAME, STRING_8].make */
extern T0* T474c6(T0* a1);
/* DS_ARRAYED_LIST_CURSOR [GEANT_PARENT].item */
extern T0* T196f4(T0* C);
/* DS_ARRAYED_LIST [GEANT_PARENT].cursor_item */
extern T0* T195f10(T0* C, T0* a1);
/* DS_ARRAYED_LIST [GEANT_PARENT].item */
extern T0* T195f12(T0* C, T6 a1);
/* DS_ARRAYED_LIST_CURSOR [GEANT_PARENT].after */
extern T1 T196f6(T0* C);
/* DS_ARRAYED_LIST [GEANT_PARENT].cursor_after */
extern T1 T195f9(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [GEANT_PARENT].start */
extern void T196f8(T0* C);
/* DS_ARRAYED_LIST [GEANT_PARENT].cursor_start */
extern void T195f19(T0* C, T0* a1);
/* DS_ARRAYED_LIST [GEANT_PARENT].is_empty */
extern T1 T195f13(T0* C);
/* DS_ARRAYED_LIST_CURSOR [GEANT_PARENT].off */
extern T1 T196f5(T0* C);
/* DS_ARRAYED_LIST [GEANT_PARENT].cursor_off */
extern T1 T195f14(T0* C, T0* a1);
/* DS_ARRAYED_LIST [GEANT_PARENT].cursor_before */
extern T1 T195f15(T0* C, T0* a1);
/* DS_ARRAYED_LIST [GEANT_PARENT].new_cursor */
extern T0* T195f7(T0* C);
/* DS_ARRAYED_LIST_CURSOR [GEANT_PARENT].make */
extern T0* T196c7(T0* a1);
/* GEANT_PROJECT_LOADER.load */
extern void T23f10(T0* C, T0* a1, T0* a2);
/* GEANT_PROJECT_LOADER.exit_application */
extern void T23f11(T0* C, T6 a1, T0* a2);
/* GEANT_PROJECT_LOADER.exceptions */
extern T0* T23f6(T0* C);
/* GEANT_PROJECT_LOADER.log_messages */
extern void T23f12(T0* C, T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.absolute_pathname */
extern T0* T53f4(T0* C, T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.current_drive */
extern T0* T53f13(T0* C);
/* KL_WINDOWS_FILE_SYSTEM.is_directory_separator */
extern T1 T53f19(T0* C, T2 a1);
/* KL_WINDOWS_FILE_SYSTEM.pathname */
extern T0* T53f11(T0* C, T0* a1, T0* a2);
/* KL_WINDOWS_FILE_SYSTEM.is_relative_pathname */
extern T1 T53f9(T0* C, T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.is_absolute_pathname */
extern T1 T53f8(T0* C, T0* a1);
/* KL_UNIX_FILE_SYSTEM.absolute_pathname */
extern T0* T54f4(T0* C, T0* a1);
/* KL_UNIX_FILE_SYSTEM.pathname */
extern T0* T54f11(T0* C, T0* a1, T0* a2);
/* KL_UNIX_FILE_SYSTEM.is_absolute_pathname */
extern T1 T54f9(T0* C, T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.pathname_from_file_system */
extern T0* T53f3(T0* C, T0* a1, T0* a2);
/* KL_WINDOWS_FILE_SYSTEM.pathname_to_string */
extern T0* T53f7(T0* C, T0* a1);
/* KL_PATHNAME.item */
extern T0* T86f8(T0* C, T6 a1);
/* KL_PATHNAME.is_parent */
extern T1 T86f7(T0* C, T6 a1);
/* KL_PATHNAME.is_current */
extern T1 T86f11(T0* C, T6 a1);
/* KL_WINDOWS_FILE_SYSTEM.root_directory */
extern unsigned char ge226os3886;
extern T0* ge226ov3886;
extern T0* T53f16(T0* C);
/* KL_UNIX_FILE_SYSTEM.string_to_pathname */
extern T0* T54f5(T0* C, T0* a1);
/* KL_PATHNAME.append_name */
extern void T86f17(T0* C, T0* a1);
/* KL_PATHNAME.append_parent */
extern void T86f16(T0* C);
/* KL_PATHNAME.append_current */
extern void T86f15(T0* C);
/* KL_PATHNAME.set_relative */
extern void T86f14(T0* C, T1 a1);
/* KL_PATHNAME.make */
extern T0* T86c13(void);
/* KL_WINDOWS_FILE_SYSTEM.any_ */
extern T0* T53f6(T0* C);
/* KL_UNIX_FILE_SYSTEM.pathname_from_file_system */
extern T0* T54f3(T0* C, T0* a1, T0* a2);
/* KL_UNIX_FILE_SYSTEM.pathname_to_string */
extern T0* T54f8(T0* C, T0* a1);
/* KL_UNIX_FILE_SYSTEM.root_directory */
extern unsigned char ge223os3886;
extern T0* ge223ov3886;
extern T0* T54f17(T0* C);
/* KL_UNIX_FILE_SYSTEM.any_ */
extern T0* T54f7(T0* C);
/* GEANT_PROJECT_LOADER.unix_file_system */
extern T0* T23f4(T0* C);
/* GEANT_PROJECT_LOADER.file_system */
extern T0* T23f3(T0* C);
/* GEANT_PROJECT_LOADER.windows_file_system */
extern T0* T23f8(T0* C);
/* GEANT_PROJECT_LOADER.operating_system */
extern T0* T23f7(T0* C);
/* KL_STDERR_FILE.put_character */
extern void T47f19(T0* C, T2 a1);
/* KL_STDERR_FILE.old_put_character */
extern void T47f20(T0* C, T2 a1);
/* KL_STDERR_FILE.console_pc */
extern void T47f21(T0* C, T14 a1, T2 a2);
/* GEANT_PROJECT_LOADER.std */
extern T0* T23f5(T0* C);
/* KL_TEXT_INPUT_FILE.close */
extern void T55f59(T0* C);
/* KL_TEXT_INPUT_FILE.old_close */
extern void T55f63(T0* C);
/* KL_TEXT_INPUT_FILE.file_close */
extern void T55f65(T0* C, T14 a1);
/* GEANT_PROJECT_PARSER.parse_file */
extern void T56f9(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.last_error_extended_description */
extern T0* T93f89(T0* C);
/* XM_EIFFEL_PARSER.string_ */
extern T0* T93f85(T0* C);
/* XM_EIFFEL_PARSER.last_error_description */
extern T0* T93f177(T0* C);
/* XM_EIFFEL_PARSER.safe_error_component */
extern T0* T93f170(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.is_safe_error_character */
extern T1 T93f109(T0* C, T2 a1);
/* CHARACTER_8.is_greater_equal */
extern T1 T2f4(T2* C, T2 a1);
/* XM_EIFFEL_PARSER.position */
extern T0* T93f137(T0* C);
/* DS_BILINKED_LIST [XM_POSITION].first */
extern T0* T136f6(T0* C);
/* XM_EIFFEL_PARSER.positions */
extern T0* T93f91(T0* C);
/* XM_EIFFEL_PARSER.new_positions */
extern T0* T93f135(T0* C);
/* DS_LINKED_STACK [XM_EIFFEL_SCANNER].remove */
extern void T137f7(T0* C);
/* DS_LINKED_STACK [XM_EIFFEL_SCANNER].item */
extern T0* T137f4(T0* C);
/* DS_LINKED_STACK [XM_EIFFEL_SCANNER].is_empty */
extern T1 T137f3(T0* C);
/* DS_BILINKED_LIST [XM_POSITION].force_last */
extern void T136f9(T0* C, T0* a1);
/* DS_BILINKABLE [XM_POSITION].put_right */
extern void T226f5(T0* C, T0* a1);
/* DS_BILINKABLE [XM_POSITION].attach_left */
extern void T226f6(T0* C, T0* a1);
/* DS_BILINKABLE [XM_POSITION].make */
extern T0* T226c4(T0* a1);
/* DS_BILINKED_LIST [XM_POSITION].is_empty */
extern T1 T136f5(T0* C);
/* DS_BILINKED_LIST [XM_POSITION].make */
extern T0* T136c8(void);
/* DS_BILINKED_LIST [XM_POSITION].new_cursor */
extern T0* T136f7(T0* C);
/* DS_BILINKED_LIST_CURSOR [XM_POSITION].make */
extern T0* T227c3(T0* a1);
/* DS_LINKED_STACK [XM_EIFFEL_SCANNER].copy */
extern void T137f6(T0* C, T0* a1);
/* DS_LINKABLE [XM_EIFFEL_SCANNER].put_right */
extern void T228f4(T0* C, T0* a1);
/* DS_LINKABLE [XM_EIFFEL_SCANNER].make */
extern T0* T228c3(T0* a1);
/* DS_LINKED_STACK [XM_EIFFEL_SCANNER].make */
extern T0* T137c5(void);
/* KL_STDERR_FILE.flush */
extern void T47f22(T0* C);
/* KL_STDERR_FILE.old_flush */
extern void T47f23(T0* C);
/* KL_STDERR_FILE.file_flush */
extern void T47f24(T0* C, T14 a1);
/* XM_TREE_CALLBACKS_PIPE.last_error */
extern T0* T94f5(T0* C);
/* GEANT_PROJECT_PARSER.std */
extern T0* T56f7(T0* C);
/* GEANT_PROJECT.set_position_table */
extern void T22f36(T0* C, T0* a1);
/* GEANT_PROJECT_ELEMENT.make */
extern T0* T30c20(T0* a1, T0* a2, T0* a3, T0* a4);
/* GEANT_PROJECT_ELEMENT.load_parent_projects */
extern void T30f23(T0* C);
/* GEANT_INHERIT_ELEMENT.make */
extern T0* T123c11(T0* a1, T0* a2);
/* GEANT_INHERIT_ELEMENT.exit_application */
extern void T123f13(T0* C, T6 a1, T0* a2);
/* GEANT_INHERIT_ELEMENT.exceptions */
extern T0* T123f8(T0* C);
/* GEANT_INHERIT_ELEMENT.std */
extern T0* T123f7(T0* C);
/* GEANT_INHERIT_ELEMENT.log_messages */
extern void T123f16(T0* C, T0* a1);
/* DS_ARRAYED_LIST [GEANT_PARENT].force_last */
extern void T195f17(T0* C, T0* a1);
/* DS_ARRAYED_LIST [GEANT_PARENT].resize */
extern void T195f18(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_PARENT].resize */
extern T0* T321f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [GEANT_PARENT].aliased_resized_area */
extern T0* T322f2(T0* C, T6 a1);
/* DS_ARRAYED_LIST [GEANT_PARENT].new_capacity */
extern T6 T195f8(T0* C, T6 a1);
/* DS_ARRAYED_LIST [GEANT_PARENT].extendible */
extern T1 T195f6(T0* C, T6 a1);
/* GEANT_PARENT.is_executable */
extern T1 T193f9(T0* C);
/* GEANT_PARENT_ELEMENT.make */
extern T0* T216c18(T0* a1, T0* a2);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].force_last */
extern void T338f39(T0* C, T0* a1, T0* a2);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].key_storage_put */
extern void T338f48(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].slots_put */
extern void T338f47(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].clashes_put */
extern void T338f46(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].slots_item */
extern T6 T338f21(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].hash_position */
extern T6 T338f23(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].resize */
extern void T338f45(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].clashes_resize */
extern void T338f53(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].special_integer_ */
extern T0* T338f27(T0* C);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].key_storage_resize */
extern void T338f52(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].item_storage_resize */
extern void T338f51(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_SELECT].resize */
extern T0* T487f1(T0* C, T0* a1, T6 a2);
/* SPECIAL [GEANT_SELECT].aliased_resized_area */
extern T0* T485f2(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].key_storage_item */
extern T0* T338f24(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].slots_resize */
extern void T338f50(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].new_modulus */
extern T6 T338f29(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].new_capacity */
extern T6 T338f22(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].item_storage_put */
extern void T338f44(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].search_position */
extern void T338f43(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].unset_found_item */
extern void T338f42(T0* C);
/* GEANT_SELECT_ELEMENT.make */
extern T0* T332c9(T0* a1, T0* a2);
/* GEANT_SELECT.set_name */
extern void T337f4(T0* C, T0* a1);
/* GEANT_SELECT_ELEMENT.attribute_value */
extern T0* T332f7(T0* C, T0* a1);
/* GEANT_SELECT_ELEMENT.project_variables_resolver */
extern T0* T332f8(T0* C);
/* GEANT_SELECT_ELEMENT.has_attribute */
extern T1 T332f6(T0* C, T0* a1);
/* GEANT_SELECT_ELEMENT.target_attribute_name */
extern unsigned char ge149os8586;
extern T0* ge149ov8586;
extern T0* T332f5(T0* C);
/* GEANT_SELECT.make */
extern T0* T337c3(void);
/* GEANT_SELECT_ELEMENT.interpreting_element_make */
extern void T332f10(T0* C, T0* a1, T0* a2);
/* GEANT_SELECT_ELEMENT.set_project */
extern void T332f12(T0* C, T0* a1);
/* GEANT_SELECT_ELEMENT.element_make */
extern void T332f11(T0* C, T0* a1);
/* GEANT_SELECT_ELEMENT.set_xml_element */
extern void T332f13(T0* C, T0* a1);
/* GEANT_PARENT_ELEMENT.select_element_name */
extern unsigned char ge141os7542;
extern T0* ge141ov7542;
extern T0* T216f10(T0* C);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].force_last */
extern void T336f39(T0* C, T0* a1, T0* a2);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].key_storage_put */
extern void T336f48(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].slots_put */
extern void T336f47(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].clashes_put */
extern void T336f46(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].slots_item */
extern T6 T336f21(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].hash_position */
extern T6 T336f23(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].resize */
extern void T336f45(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].clashes_resize */
extern void T336f53(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].special_integer_ */
extern T0* T336f27(T0* C);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].key_storage_resize */
extern void T336f52(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].item_storage_resize */
extern void T336f51(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_REDEFINE].resize */
extern T0* T481f1(T0* C, T0* a1, T6 a2);
/* SPECIAL [GEANT_REDEFINE].aliased_resized_area */
extern T0* T479f2(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].key_storage_item */
extern T0* T336f24(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].slots_resize */
extern void T336f50(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].new_modulus */
extern T6 T336f29(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].new_capacity */
extern T6 T336f22(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].item_storage_put */
extern void T336f44(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].search_position */
extern void T336f43(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].unset_found_item */
extern void T336f42(T0* C);
/* GEANT_REDEFINE_ELEMENT.make */
extern T0* T331c9(T0* a1, T0* a2);
/* GEANT_REDEFINE.set_name */
extern void T335f4(T0* C, T0* a1);
/* GEANT_REDEFINE_ELEMENT.attribute_value */
extern T0* T331f7(T0* C, T0* a1);
/* GEANT_REDEFINE_ELEMENT.project_variables_resolver */
extern T0* T331f8(T0* C);
/* GEANT_REDEFINE_ELEMENT.has_attribute */
extern T1 T331f6(T0* C, T0* a1);
/* GEANT_REDEFINE_ELEMENT.target_attribute_name */
extern unsigned char ge145os8582;
extern T0* ge145ov8582;
extern T0* T331f5(T0* C);
/* GEANT_REDEFINE.make */
extern T0* T335c3(void);
/* GEANT_REDEFINE_ELEMENT.interpreting_element_make */
extern void T331f10(T0* C, T0* a1, T0* a2);
/* GEANT_REDEFINE_ELEMENT.set_project */
extern void T331f12(T0* C, T0* a1);
/* GEANT_REDEFINE_ELEMENT.element_make */
extern void T331f11(T0* C, T0* a1);
/* GEANT_REDEFINE_ELEMENT.set_xml_element */
extern void T331f13(T0* C, T0* a1);
/* GEANT_PARENT_ELEMENT.redefine_element_name */
extern unsigned char ge141os7541;
extern T0* ge141ov7541;
extern T0* T216f9(T0* C);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].force_last */
extern void T334f40(T0* C, T0* a1, T0* a2);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].key_storage_put */
extern void T334f49(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].slots_put */
extern void T334f48(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].clashes_put */
extern void T334f47(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].slots_item */
extern T6 T334f24(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].hash_position */
extern T6 T334f22(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].resize */
extern void T334f46(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].clashes_resize */
extern void T334f54(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].special_integer_ */
extern T0* T334f28(T0* C);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].key_storage_resize */
extern void T334f53(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].item_storage_resize */
extern void T334f52(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_RENAME].resize */
extern T0* T475f1(T0* C, T0* a1, T6 a2);
/* SPECIAL [GEANT_RENAME].aliased_resized_area */
extern T0* T473f2(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].key_storage_item */
extern T0* T334f25(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].slots_resize */
extern void T334f51(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].new_modulus */
extern T6 T334f31(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].new_capacity */
extern T6 T334f30(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].item_storage_put */
extern void T334f45(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].search_position */
extern void T334f42(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].unset_found_item */
extern void T334f44(T0* C);
/* GEANT_PARENT_ELEMENT.exit_application */
extern void T216f20(T0* C, T6 a1, T0* a2);
/* GEANT_PARENT_ELEMENT.exceptions */
extern T0* T216f14(T0* C);
/* GEANT_PARENT_ELEMENT.std */
extern T0* T216f13(T0* C);
/* GEANT_PARENT_ELEMENT.log_messages */
extern void T216f23(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].has */
extern T1 T334f29(T0* C, T0* a1);
/* GEANT_RENAME_ELEMENT.make */
extern T0* T330c10(T0* a1, T0* a2);
/* GEANT_RENAME.set_new_name */
extern void T333f7(T0* C, T0* a1);
/* GEANT_RENAME_ELEMENT.as_attribute_name */
extern unsigned char ge147os8578;
extern T0* ge147ov8578;
extern T0* T330f5(T0* C);
/* GEANT_RENAME.set_original_name */
extern void T333f6(T0* C, T0* a1);
/* GEANT_RENAME_ELEMENT.attribute_value */
extern T0* T330f8(T0* C, T0* a1);
/* GEANT_RENAME_ELEMENT.project_variables_resolver */
extern T0* T330f9(T0* C);
/* GEANT_RENAME_ELEMENT.has_attribute */
extern T1 T330f7(T0* C, T0* a1);
/* GEANT_RENAME_ELEMENT.target_attribute_name */
extern unsigned char ge147os8577;
extern T0* ge147ov8577;
extern T0* T330f6(T0* C);
/* GEANT_RENAME.make */
extern T0* T333c5(void);
/* GEANT_RENAME_ELEMENT.interpreting_element_make */
extern void T330f11(T0* C, T0* a1, T0* a2);
/* GEANT_RENAME_ELEMENT.set_project */
extern void T330f13(T0* C, T0* a1);
/* GEANT_RENAME_ELEMENT.element_make */
extern void T330f12(T0* C, T0* a1);
/* GEANT_RENAME_ELEMENT.set_xml_element */
extern void T330f14(T0* C, T0* a1);
/* GEANT_PARENT_ELEMENT.elements_by_name */
extern T0* T216f8(T0* C, T0* a1);
/* DS_LINKED_LIST [XM_ELEMENT].force_last */
extern void T121f9(T0* C, T0* a1);
/* DS_LINKABLE [XM_ELEMENT].put_right */
extern void T215f4(T0* C, T0* a1);
/* DS_LINKABLE [XM_ELEMENT].make */
extern T0* T215c3(T0* a1);
/* DS_LINKED_LIST [XM_ELEMENT].is_empty */
extern T1 T121f6(T0* C);
/* GEANT_PARENT_ELEMENT.string_ */
extern T0* T216f15(T0* C);
/* DS_LINKED_LIST [XM_ELEMENT].make */
extern T0* T121c8(void);
/* GEANT_PARENT_ELEMENT.rename_element_name */
extern unsigned char ge141os7540;
extern T0* ge141ov7540;
extern T0* T216f7(T0* C);
/* GEANT_PARENT.set_parent_project */
extern void T193f13(T0* C, T0* a1);
/* GEANT_PARENT_ELEMENT.attribute_value */
extern T0* T216f11(T0* C, T0* a1);
/* GEANT_PARENT_ELEMENT.project_variables_resolver */
extern T0* T216f16(T0* C);
/* GEANT_PARENT_ELEMENT.has_attribute */
extern T1 T216f6(T0* C, T0* a1);
/* GEANT_PARENT_ELEMENT.location_attribute_name */
extern unsigned char ge141os7538;
extern T0* ge141ov7538;
extern T0* T216f5(T0* C);
/* GEANT_PARENT.make */
extern T0* T193c12(T0* a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].set_key_equality_tester */
extern void T338f40(T0* C, T0* a1);
/* DS_SPARSE_TABLE_KEYS [GEANT_SELECT, STRING_8].internal_set_equality_tester */
extern void T483f6(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].make_map_equal */
extern T0* T338c38(T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].make_with_equality_testers */
extern void T338f41(T0* C, T6 a1, T0* a2, T0* a3);
/* DS_SPARSE_TABLE_KEYS [GEANT_SELECT, STRING_8].make */
extern T0* T483c5(T0* a1);
/* DS_SPARSE_TABLE_KEYS [GEANT_SELECT, STRING_8].new_cursor */
extern T0* T483f4(T0* C);
/* DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_SELECT, STRING_8].make */
extern T0* T534c3(T0* a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].make_sparse_container */
extern void T338f49(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].make_slots */
extern void T338f57(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].make_clashes */
extern void T338f56(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].make_key_storage */
extern void T338f55(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_SELECT, STRING_8].make_item_storage */
extern void T338f54(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_SELECT].make */
extern T0* T487f2(T0* C, T6 a1);
/* TO_SPECIAL [GEANT_SELECT].make_area */
extern T0* T535c2(T6 a1);
/* SPECIAL [GEANT_SELECT].make */
extern T0* T485c4(T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_SELECT].default_create */
extern T0* T487c3(void);
/* KL_EQUALITY_TESTER [GEANT_SELECT].default_create */
extern T0* T482c1(void);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].set_key_equality_tester */
extern void T336f40(T0* C, T0* a1);
/* DS_SPARSE_TABLE_KEYS [GEANT_REDEFINE, STRING_8].internal_set_equality_tester */
extern void T477f6(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].make_map_equal */
extern T0* T336c38(T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].make_with_equality_testers */
extern void T336f41(T0* C, T6 a1, T0* a2, T0* a3);
/* DS_SPARSE_TABLE_KEYS [GEANT_REDEFINE, STRING_8].make */
extern T0* T477c5(T0* a1);
/* DS_SPARSE_TABLE_KEYS [GEANT_REDEFINE, STRING_8].new_cursor */
extern T0* T477f4(T0* C);
/* DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_REDEFINE, STRING_8].make */
extern T0* T532c3(T0* a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].make_sparse_container */
extern void T336f49(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].make_slots */
extern void T336f57(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].make_clashes */
extern void T336f56(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].make_key_storage */
extern void T336f55(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_REDEFINE, STRING_8].make_item_storage */
extern void T336f54(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_REDEFINE].make */
extern T0* T481f2(T0* C, T6 a1);
/* TO_SPECIAL [GEANT_REDEFINE].make_area */
extern T0* T533c2(T6 a1);
/* SPECIAL [GEANT_REDEFINE].make */
extern T0* T479c4(T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_REDEFINE].default_create */
extern T0* T481c3(void);
/* KL_EQUALITY_TESTER [GEANT_REDEFINE].default_create */
extern T0* T476c1(void);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].set_key_equality_tester */
extern void T334f41(T0* C, T0* a1);
/* DS_SPARSE_TABLE_KEYS [GEANT_RENAME, STRING_8].internal_set_equality_tester */
extern void T471f6(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].make_map_equal */
extern T0* T334c39(T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].make_with_equality_testers */
extern void T334f43(T0* C, T6 a1, T0* a2, T0* a3);
/* DS_SPARSE_TABLE_KEYS [GEANT_RENAME, STRING_8].make */
extern T0* T471c5(T0* a1);
/* DS_SPARSE_TABLE_KEYS [GEANT_RENAME, STRING_8].new_cursor */
extern T0* T471f4(T0* C);
/* DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_RENAME, STRING_8].make */
extern T0* T530c3(T0* a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].make_sparse_container */
extern void T334f50(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].make_slots */
extern void T334f58(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].make_clashes */
extern void T334f57(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].make_key_storage */
extern void T334f56(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_RENAME, STRING_8].make_item_storage */
extern void T334f55(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_RENAME].make */
extern T0* T475f2(T0* C, T6 a1);
/* TO_SPECIAL [GEANT_RENAME].make_area */
extern T0* T531c2(T6 a1);
/* SPECIAL [GEANT_RENAME].make */
extern T0* T473c4(T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_RENAME].default_create */
extern T0* T475c3(void);
/* KL_EQUALITY_TESTER [GEANT_RENAME].default_create */
extern T0* T470c1(void);
/* GEANT_PARENT_ELEMENT.interpreting_element_make */
extern void T216f19(T0* C, T0* a1, T0* a2);
/* GEANT_PARENT_ELEMENT.set_project */
extern void T216f22(T0* C, T0* a1);
/* GEANT_PARENT_ELEMENT.element_make */
extern void T216f21(T0* C, T0* a1);
/* GEANT_PARENT_ELEMENT.set_xml_element */
extern void T216f24(T0* C, T0* a1);
/* GEANT_INHERIT_ELEMENT.elements_by_name */
extern T0* T123f6(T0* C, T0* a1);
/* GEANT_INHERIT_ELEMENT.string_ */
extern T0* T123f9(T0* C);
/* GEANT_INHERIT_ELEMENT.parent_element_name */
extern unsigned char ge134os6107;
extern T0* ge134ov6107;
extern T0* T123f5(T0* C);
/* GEANT_INHERIT.make */
extern T0* T124c6(T0* a1);
/* DS_ARRAYED_LIST [GEANT_PARENT].make */
extern T0* T195c16(T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_PARENT].make */
extern T0* T321f1(T0* C, T6 a1);
/* TO_SPECIAL [GEANT_PARENT].make_area */
extern T0* T466c2(T6 a1);
/* SPECIAL [GEANT_PARENT].make */
extern T0* T322c4(T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_PARENT].default_create */
extern T0* T321c3(void);
/* GEANT_INHERIT_ELEMENT.interpreting_element_make */
extern void T123f12(T0* C, T0* a1, T0* a2);
/* GEANT_INHERIT_ELEMENT.set_project */
extern void T123f15(T0* C, T0* a1);
/* GEANT_INHERIT_ELEMENT.element_make */
extern void T123f14(T0* C, T0* a1);
/* GEANT_INHERIT_ELEMENT.set_xml_element */
extern void T123f17(T0* C, T0* a1);
/* GEANT_PROJECT_ELEMENT.inherit_element_name */
extern unsigned char ge142os2554;
extern T0* ge142ov2554;
extern T0* T30f16(T0* C);
/* GEANT_PROJECT.set_inherit_clause */
extern void T22f42(T0* C, T0* a1);
/* GEANT_INHERIT_ELEMENT.make_old */
extern T0* T123c10(T0* a1, T0* a2);
/* GEANT_PARENT_ELEMENT.make_old */
extern T0* T216c17(T0* a1, T0* a2);
/* GEANT_PARENT_ELEMENT.inherit_attribute_name */
extern unsigned char ge141os7539;
extern T0* ge141ov7539;
extern T0* T216f12(T0* C);
/* GEANT_PROJECT.set_old_inherit */
extern void T22f41(T0* C, T1 a1);
/* GEANT_PROJECT_ELEMENT.has_inherit_element */
extern T1 T30f15(T0* C);
/* GEANT_PROJECT_ELEMENT.inherit_attribute_name */
extern unsigned char ge142os2553;
extern T0* ge142ov2553;
extern T0* T30f14(T0* C);
/* GEANT_PROJECT.set_targets */
extern void T22f40(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [XM_ELEMENT].forth */
extern void T122f9(T0* C);
/* DS_LINKED_LIST [XM_ELEMENT].cursor_forth */
extern void T121f11(T0* C, T0* a1);
/* DS_LINKED_LIST [XM_ELEMENT].add_traversing_cursor */
extern void T121f12(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [XM_ELEMENT].set_next_cursor */
extern void T122f11(T0* C, T0* a1);
/* DS_LINKED_LIST [XM_ELEMENT].remove_traversing_cursor */
extern void T121f13(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [XM_ELEMENT].set */
extern void T122f10(T0* C, T0* a1, T1 a2, T1 a3);
/* GEANT_TARGET.make */
extern T0* T26c63(T0* a1, T0* a2);
/* GEANT_TARGET.initialize */
extern void T26f64(T0* C);
/* GEANT_TARGET.initialize */
extern void T26f64p1(T0* C);
/* GEANT_TARGET.set_description */
extern void T26f72(T0* C, T0* a1);
/* GEANT_GLOBAL_ELEMENT.name */
extern T0* T200f2(T0* C);
/* GEANT_GLOBAL_ELEMENT.attribute_value */
extern T0* T200f5(T0* C, T0* a1);
/* GEANT_GLOBAL_ELEMENT.name_attribute_name */
extern unsigned char ge139os7232;
extern T0* ge139ov7232;
extern T0* T200f3(T0* C);
/* GEANT_GLOBAL_ELEMENT.has_name */
extern T1 T200f6(T0* C);
/* GEANT_GLOBAL_ELEMENT.has_attribute */
extern T1 T200f4(T0* C, T0* a1);
/* GEANT_GLOBAL_ELEMENT.make */
extern T0* T200c7(T0* a1);
/* GEANT_GLOBAL_ELEMENT.set_xml_element */
extern void T200f8(T0* C, T0* a1);
/* GEANT_LOCAL_ELEMENT.name */
extern T0* T199f2(T0* C);
/* GEANT_LOCAL_ELEMENT.attribute_value */
extern T0* T199f5(T0* C, T0* a1);
/* GEANT_LOCAL_ELEMENT.name_attribute_name */
extern T0* T199f3(T0* C);
/* GEANT_LOCAL_ELEMENT.has_name */
extern T1 T199f6(T0* C);
/* GEANT_LOCAL_ELEMENT.has_attribute */
extern T1 T199f4(T0* C, T0* a1);
/* GEANT_LOCAL_ELEMENT.make */
extern T0* T199c7(T0* a1);
/* GEANT_LOCAL_ELEMENT.set_xml_element */
extern void T199f8(T0* C, T0* a1);
/* GEANT_TARGET.empty_variables */
extern unsigned char ge59os1745;
extern T0* ge59ov1745;
extern T0* T26f18(T0* C);
/* GEANT_ARGUMENT_ELEMENT.name */
extern T0* T198f2(T0* C);
/* GEANT_ARGUMENT_ELEMENT.attribute_value */
extern T0* T198f5(T0* C, T0* a1);
/* GEANT_ARGUMENT_ELEMENT.name_attribute_name */
extern T0* T198f3(T0* C);
/* GEANT_ARGUMENT_ELEMENT.has_name */
extern T1 T198f6(T0* C);
/* GEANT_ARGUMENT_ELEMENT.has_attribute */
extern T1 T198f4(T0* C, T0* a1);
/* GEANT_ARGUMENT_ELEMENT.make */
extern T0* T198c7(T0* a1);
/* GEANT_ARGUMENT_ELEMENT.set_xml_element */
extern void T198f8(T0* C, T0* a1);
/* GEANT_TARGET.elements_by_name */
extern T0* T26f16(T0* C, T0* a1);
/* GEANT_TARGET.empty_argument_variables */
extern unsigned char ge59os1746;
extern T0* ge59ov1746;
extern T0* T26f42(T0* C);
/* GEANT_TARGET.set_execute_once */
extern void T26f71(T0* C, T1 a1);
/* GEANT_TARGET.boolean_value */
extern T1 T26f36(T0* C, T0* a1);
/* GEANT_TARGET.false_attribute_value */
extern unsigned char ge127os2427;
extern T0* ge127ov2427;
extern T0* T26f32(T0* C);
/* GEANT_TARGET.true_attribute_value */
extern unsigned char ge127os2426;
extern T0* ge127ov2426;
extern T0* T26f31(T0* C);
/* GEANT_TARGET.attribute_value */
extern T0* T26f29(T0* C, T0* a1);
/* GEANT_TARGET.once_attribute_name */
extern unsigned char ge61os2381;
extern T0* ge61ov2381;
extern T0* T26f27(T0* C);
/* GEANT_TARGET.set_exports */
extern void T26f70(T0* C, T0* a1);
/* DS_ARRAYED_LIST [STRING_8].set_equality_tester */
extern void T71f37(T0* C, T0* a1);
/* DS_ARRAYED_LIST [STRING_8].put */
extern void T71f29(T0* C, T0* a1, T6 a2);
/* DS_ARRAYED_LIST [STRING_8].move_cursors_right */
extern void T71f34(T0* C, T6 a1, T6 a2);
/* DS_ARRAYED_LIST_CURSOR [STRING_8].set_position */
extern void T72f10(T0* C, T6 a1);
/* DS_ARRAYED_LIST [STRING_8].move_right */
extern void T71f33(T0* C, T6 a1, T6 a2);
/* DS_ARRAYED_LIST [STRING_8].put_last */
extern void T71f32(T0* C, T0* a1);
/* GEANT_TARGET.export_attribute_name */
extern unsigned char ge61os2380;
extern T0* ge61ov2380;
extern T0* T26f20(T0* C);
/* GEANT_TARGET.set_obsolete_message */
extern void T26f69(T0* C, T0* a1);
/* GEANT_TARGET.set_name */
extern void T26f68(T0* C, T0* a1);
/* GEANT_TARGET.name_attribute_name */
extern unsigned char ge61os2377;
extern T0* ge61ov2377;
extern T0* T26f40(T0* C);
/* GEANT_TARGET.make */
extern void T26f63p1(T0* C, T0* a1, T0* a2);
/* GEANT_TARGET.set_project */
extern void T26f66(T0* C, T0* a1);
/* GEANT_TARGET.element_make */
extern void T26f65(T0* C, T0* a1);
/* GEANT_TARGET.set_xml_element */
extern void T26f73(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [XM_ELEMENT].item */
extern T0* T122f6(T0* C);
/* DS_LINKED_LIST_CURSOR [XM_ELEMENT].start */
extern void T122f8(T0* C);
/* DS_LINKED_LIST [XM_ELEMENT].cursor_start */
extern void T121f10(T0* C, T0* a1);
/* DS_LINKED_LIST [XM_ELEMENT].cursor_off */
extern T1 T121f7(T0* C, T0* a1);
/* DS_LINKED_LIST [XM_ELEMENT].new_cursor */
extern T0* T121f5(T0* C);
/* DS_LINKED_LIST_CURSOR [XM_ELEMENT].make */
extern T0* T122c7(T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].set_key_equality_tester */
extern void T31f47(T0* C, T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].make_map */
extern T0* T31c46(T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].make_with_equality_testers */
extern void T31f50(T0* C, T6 a1, T0* a2, T0* a3);
/* DS_SPARSE_TABLE_KEYS [GEANT_TARGET, STRING_8].make */
extern T0* T127c5(T0* a1);
/* DS_SPARSE_TABLE_KEYS [GEANT_TARGET, STRING_8].new_cursor */
extern T0* T127f4(T0* C);
/* DS_SPARSE_TABLE_KEYS_CURSOR [GEANT_TARGET, STRING_8].make */
extern T0* T218c3(T0* a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].make_sparse_container */
extern void T31f58(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].make_slots */
extern void T31f66(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].make_clashes */
extern void T31f65(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].make_key_storage */
extern void T31f64(T0* C, T6 a1);
/* DS_HASH_TABLE [GEANT_TARGET, STRING_8].make_item_storage */
extern void T31f63(T0* C, T6 a1);
/* GEANT_PROJECT_ELEMENT.elements_by_name */
extern T0* T30f11(T0* C, T0* a1);
/* GEANT_PROJECT_ELEMENT.string_ */
extern T0* T30f19(T0* C);
/* GEANT_PROJECT_ELEMENT.target_element_name */
extern unsigned char ge142os2556;
extern T0* ge142ov2556;
extern T0* T30f10(T0* C);
/* GEANT_PROJECT.set_default_target_name */
extern void T22f38(T0* C, T0* a1);
/* GEANT_PROJECT_ELEMENT.default_attribute_name */
extern unsigned char ge142os2552;
extern T0* ge142ov2552;
extern T0* T30f9(T0* C);
/* KL_WINDOWS_FILE_SYSTEM.basename */
extern T0* T53f24(T0* C, T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.is_root_directory */
extern T1 T53f25(T0* C, T0* a1);
/* KL_UNIX_FILE_SYSTEM.basename */
extern T0* T54f21(T0* C, T0* a1);
/* KL_UNIX_FILE_SYSTEM.is_root_directory */
extern T1 T54f22(T0* C, T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.dirname */
extern T0* T53f23(T0* C, T0* a1);
/* KL_UNIX_FILE_SYSTEM.dirname */
extern T0* T54f20(T0* C, T0* a1);
/* GEANT_PROJECT_ELEMENT.unix_file_system */
extern T0* T30f8(T0* C);
/* GEANT_PROJECT_ELEMENT.file_system */
extern T0* T30f7(T0* C);
/* GEANT_PROJECT_ELEMENT.windows_file_system */
extern T0* T30f18(T0* C);
/* GEANT_PROJECT_ELEMENT.operating_system */
extern T0* T30f17(T0* C);
/* GEANT_PROJECT.set_description */
extern void T22f37(T0* C, T0* a1);
/* XM_ELEMENT.has_element_by_name */
extern T1 T99f15(T0* C, T0* a1);
/* GEANT_PROJECT_ELEMENT.description_element_name */
extern T0* T30f6(T0* C);
/* GEANT_PROJECT_ELEMENT.attribute_value */
extern T0* T30f4(T0* C, T0* a1);
/* GEANT_PROJECT_ELEMENT.exit_application */
extern void T30f22(T0* C, T6 a1, T0* a2);
/* GEANT_PROJECT_ELEMENT.exceptions */
extern T0* T30f13(T0* C);
/* GEANT_PROJECT_ELEMENT.std */
extern T0* T30f12(T0* C);
/* GEANT_PROJECT_ELEMENT.log_messages */
extern void T30f25(T0* C, T0* a1);
/* GEANT_PROJECT_ELEMENT.has_attribute */
extern T1 T30f3(T0* C, T0* a1);
/* GEANT_PROJECT_ELEMENT.name_attribute_name */
extern unsigned char ge142os2551;
extern T0* ge142ov2551;
extern T0* T30f5(T0* C);
/* GEANT_PROJECT.make */
extern T0* T22c30(T0* a1, T0* a2, T0* a3);
/* GEANT_TASK_FACTORY.make */
extern T0* T192c55(T0* a1);
/* GEANT_TASK_FACTORY.create_builders */
extern void T192f56(T0* C);
/* Creation of agent #1 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac1(T0* a1);
/* Creation of agent #2 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac2(T0* a1);
/* Creation of agent #3 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac3(T0* a1);
/* Creation of agent #4 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac4(T0* a1);
/* Creation of agent #5 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac5(T0* a1);
/* Creation of agent #6 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac6(T0* a1);
/* Creation of agent #7 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac7(T0* a1);
/* Creation of agent #8 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac8(T0* a1);
/* Creation of agent #9 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac9(T0* a1);
/* Creation of agent #10 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac10(T0* a1);
/* Creation of agent #11 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac11(T0* a1);
/* Creation of agent #12 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac12(T0* a1);
/* Creation of agent #13 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac13(T0* a1);
/* Creation of agent #14 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac14(T0* a1);
/* Creation of agent #15 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac15(T0* a1);
/* Creation of agent #16 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac16(T0* a1);
/* Creation of agent #17 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac17(T0* a1);
/* Creation of agent #18 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac18(T0* a1);
/* Creation of agent #19 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac19(T0* a1);
/* Creation of agent #20 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac20(T0* a1);
/* Creation of agent #21 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac21(T0* a1);
/* Creation of agent #22 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac22(T0* a1);
/* Creation of agent #23 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac23(T0* a1);
/* Creation of agent #24 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac24(T0* a1);
/* Creation of agent #25 in feature GEANT_TASK_FACTORY.create_builders */
extern T0* T192f56ac25(T0* a1);
/* GEANT_TASK_FACTORY.new_replace_task */
extern T0* T192f52(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.make */
extern T0* T319c31(T0* a1, T0* a2);
/* GEANT_REPLACE_COMMAND.set_fileset */
extern void T463f38(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.make */
extern T0* T385c29(T0* a1, T0* a2);
/* GEANT_FILESET.set_map */
extern void T391f47(T0* C, T0* a1);
/* GEANT_MAP_ELEMENT.make */
extern T0* T500c12(T0* a1, T0* a2);
/* GEANT_MAP.set_map */
extern void T501f21(T0* C, T0* a1);
/* GEANT_MAP_ELEMENT.map_element_name */
extern unsigned char ge138os9066;
extern T0* ge138ov9066;
extern T0* T500f9(T0* C);
/* GEANT_MAP.set_target_pattern */
extern void T501f20(T0* C, T0* a1);
/* GEANT_MAP_ELEMENT.to_attribute_name */
extern unsigned char ge138os9065;
extern T0* ge138ov9065;
extern T0* T500f7(T0* C);
/* GEANT_MAP.set_source_pattern */
extern void T501f19(T0* C, T0* a1);
/* GEANT_MAP_ELEMENT.from_attribute_name */
extern unsigned char ge138os9064;
extern T0* ge138ov9064;
extern T0* T500f6(T0* C);
/* GEANT_MAP.set_type */
extern void T501f18(T0* C, T0* a1);
/* GEANT_MAP_ELEMENT.attribute_value */
extern T0* T500f5(T0* C, T0* a1);
/* GEANT_MAP_ELEMENT.project_variables_resolver */
extern T0* T500f11(T0* C);
/* GEANT_MAP_ELEMENT.has_attribute */
extern T1 T500f10(T0* C, T0* a1);
/* GEANT_MAP_ELEMENT.type_attribute_name */
extern unsigned char ge138os9063;
extern T0* ge138ov9063;
extern T0* T500f8(T0* C);
/* GEANT_MAP.make */
extern T0* T501c17(T0* a1);
/* GEANT_MAP.type_attribute_value_identity */
extern unsigned char ge137os9079;
extern T0* ge137ov9079;
extern T0* T501f6(T0* C);
/* GEANT_MAP_ELEMENT.make */
extern void T500f12p1(T0* C, T0* a1, T0* a2);
/* GEANT_MAP_ELEMENT.set_project */
extern void T500f14(T0* C, T0* a1);
/* GEANT_MAP_ELEMENT.element_make */
extern void T500f13(T0* C, T0* a1);
/* GEANT_MAP_ELEMENT.set_xml_element */
extern void T500f15(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.map_element_name */
extern unsigned char ge130os8749;
extern T0* ge130ov8749;
extern T0* T385f21(T0* C);
/* GEANT_FILESET.add_single_exclude */
extern void T391f46(T0* C, T0* a1);
/* DS_HASH_SET [STRING_8].force_last */
extern void T506f37(T0* C, T0* a1);
/* DS_HASH_SET [STRING_8].slots_put */
extern void T506f47(T0* C, T6 a1, T6 a2);
/* DS_HASH_SET [STRING_8].clashes_put */
extern void T506f46(T0* C, T6 a1, T6 a2);
/* DS_HASH_SET [STRING_8].slots_item */
extern T6 T506f21(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].hash_position */
extern T6 T506f18(T0* C, T0* a1);
/* DS_HASH_SET [STRING_8].resize */
extern void T506f45(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].clashes_resize */
extern void T506f51(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].special_integer_ */
extern T0* T506f19(T0* C);
/* DS_HASH_SET [STRING_8].key_storage_resize */
extern void T506f50(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].item_storage_resize */
extern void T506f49(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].key_storage_item */
extern T0* T506f24(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].item_storage_item */
extern T0* T506f28(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].clashes_item */
extern T6 T506f25(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].slots_resize */
extern void T506f48(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].new_modulus */
extern T6 T506f27(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].new_capacity */
extern T6 T506f17(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].item_storage_put */
extern void T506f44(T0* C, T0* a1, T6 a2);
/* DS_HASH_SET [STRING_8].search_position */
extern void T506f43(T0* C, T0* a1);
/* DS_HASH_SET [STRING_8].key_equality_tester */
extern T0* T506f23(T0* C);
/* DS_HASH_SET [STRING_8].unset_found_item */
extern void T506f42(T0* C);
/* GEANT_FILESET_ELEMENT.exclude_element_name */
extern unsigned char ge130os8748;
extern T0* ge130ov8748;
extern T0* T385f19(T0* C);
/* GEANT_FILESET.add_single_include */
extern void T391f45(T0* C, T0* a1);
/* GEANT_DEFINE_ELEMENT.name */
extern T0* T403f4(T0* C);
/* GEANT_DEFINE_ELEMENT.attribute_value */
extern T0* T403f14(T0* C, T0* a1);
/* GEANT_DEFINE_ELEMENT.project_variables_resolver */
extern T0* T403f6(T0* C);
/* GEANT_DEFINE_ELEMENT.name_attribute_name */
extern T0* T403f13(T0* C);
/* GEANT_DEFINE_ELEMENT.has_name */
extern T1 T403f10(T0* C);
/* GEANT_DEFINE_ELEMENT.has_attribute */
extern T1 T403f9(T0* C, T0* a1);
/* GEANT_DEFINE_ELEMENT.is_enabled */
extern T1 T403f7(T0* C);
/* GEANT_DEFINE_ELEMENT.unless_attribute_name */
extern T0* T403f11(T0* C);
/* GEANT_DEFINE_ELEMENT.if_attribute_name */
extern T0* T403f8(T0* C);
/* GEANT_DEFINE_ELEMENT.make */
extern T0* T403c16(T0* a1, T0* a2);
/* GEANT_DEFINE_ELEMENT.set_project */
extern void T403f18(T0* C, T0* a1);
/* GEANT_DEFINE_ELEMENT.element_make */
extern void T403f17(T0* C, T0* a1);
/* GEANT_DEFINE_ELEMENT.set_xml_element */
extern void T403f19(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.elements_by_name */
extern T0* T385f18(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.string_ */
extern T0* T385f26(T0* C);
/* GEANT_FILESET_ELEMENT.include_element_name */
extern unsigned char ge130os8747;
extern T0* ge130ov8747;
extern T0* T385f17(T0* C);
/* GEANT_FILESET.set_convert_to_filesystem */
extern void T391f44(T0* C, T1 a1);
/* GEANT_FILESET_ELEMENT.convert_attribute_name */
extern unsigned char ge130os8745;
extern T0* ge130ov8745;
extern T0* T385f16(T0* C);
/* GEANT_FILESET.set_mapped_filename_directory_name */
extern void T391f43(T0* C, T0* a1);
/* GEANT_FILESET.set_filename_directory_name */
extern void T391f42(T0* C, T0* a1);
/* GEANT_FILESET.set_mapped_filename_variable_name */
extern void T391f41(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.mapped_filename_variable_name_attribute_name */
extern unsigned char ge130os8743;
extern T0* ge130ov8743;
extern T0* T385f15(T0* C);
/* GEANT_FILESET.set_filename_variable_name */
extern void T391f40(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.filename_variable_name_attribute_name */
extern unsigned char ge130os8742;
extern T0* ge130ov8742;
extern T0* T385f14(T0* C);
/* GEANT_FILESET.set_concat */
extern void T391f39(T0* C, T1 a1);
/* GEANT_FILESET.set_force */
extern void T391f38(T0* C, T1 a1);
/* GEANT_FILESET_ELEMENT.boolean_value */
extern T1 T385f13(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.std */
extern T0* T385f23(T0* C);
/* GEANT_FILESET_ELEMENT.false_attribute_value */
extern T0* T385f28(T0* C);
/* GEANT_FILESET_ELEMENT.true_attribute_value */
extern T0* T385f27(T0* C);
/* GEANT_FILESET_ELEMENT.force_attribute_name */
extern unsigned char ge130os8740;
extern T0* ge130ov8740;
extern T0* T385f12(T0* C);
/* GEANT_FILESET.set_exclude_wc_string */
extern void T391f37(T0* C, T0* a1);
/* LX_DFA_WILDCARD.is_compiled */
extern T1 T508f12(T0* C);
/* LX_DFA_WILDCARD.compile */
extern T0* T508c14(T0* a1, T1 a2);
/* LX_FULL_DFA.make */
extern T0* T550c37(T0* a1);
/* LX_FULL_DFA.build */
extern void T550f40(T0* C);
/* LX_FULL_DFA.build_accept_table */
extern void T550f46(T0* C);
/* ARRAY [INTEGER_32].put */
extern void T205f12(T0* C, T6 a1, T6 a2);
/* DS_ARRAYED_LIST [LX_RULE].first */
extern T0* T573f11(T0* C);
/* ARRAY [INTEGER_32].make */
extern T0* T205c9(T6 a1, T6 a2);
/* ARRAY [INTEGER_32].make_area */
extern void T205f10(T0* C, T6 a1);
/* LX_FULL_DFA.build_nxt_table */
extern void T550f45(T0* C);
/* LX_TRANSITION_TABLE [LX_DFA_STATE].target */
extern T0* T603f6(T0* C, T6 a1);
/* ARRAY [LX_DFA_STATE].item */
extern T0* T649f4(T0* C, T6 a1);
/* LX_DFA_STATE.is_accepting */
extern T1 T598f10(T0* C);
/* DS_ARRAYED_LIST [LX_RULE].is_empty */
extern T1 T573f10(T0* C);
/* LX_FULL_DFA.build_transitions */
extern void T550f44(T0* C, T0* a1);
/* LX_TRANSITION_TABLE [LX_DFA_STATE].set_target */
extern void T603f8(T0* C, T0* a1, T6 a2);
/* ARRAY [LX_DFA_STATE].put */
extern void T649f7(T0* C, T0* a1, T6 a2);
/* LX_SYMBOL_PARTITIONS.previous_symbol */
extern T6 T601f4(T0* C, T6 a1);
/* ARRAY [DS_BILINKABLE [INTEGER_32]].item */
extern T0* T633f4(T0* C, T6 a1);
/* LX_FULL_DFA.new_state */
extern T0* T550f36(T0* C, T0* a1);
/* LX_DFA_STATE.set_id */
extern void T598f17(T0* C, T6 a1);
/* DS_ARRAYED_LIST [LX_DFA_STATE].put_last */
extern void T600f9(T0* C, T0* a1);
/* LX_DFA_STATE.is_equal */
extern T1 T598f11(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].is_equal */
extern T1 T599f19(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].any_ */
extern T0* T599f21(T0* C);
/* LX_DFA_STATE.any_ */
extern T0* T598f14(T0* C);
/* LX_DFA_STATE.new_state */
extern T0* T598f9(T0* C, T6 a1);
/* LX_DFA_STATE.make */
extern T0* T598c16(T0* a1, T6 a2, T6 a3);
/* LX_RULE.set_useful */
extern void T583f22(T0* C, T1 a1);
/* DS_ARRAYED_LIST [LX_RULE].sort */
extern void T573f16(T0* C, T0* a1);
/* DS_BUBBLE_SORTER [LX_RULE].sort */
extern void T639f3(T0* C, T0* a1);
/* DS_BUBBLE_SORTER [LX_RULE].sort_with_comparator */
extern void T639f4(T0* C, T0* a1, T0* a2);
/* DS_BUBBLE_SORTER [LX_RULE].subsort_with_comparator */
extern void T639f5(T0* C, T0* a1, T0* a2, T6 a3, T6 a4);
/* DS_ARRAYED_LIST [LX_RULE].replace */
extern void T573f21(T0* C, T0* a1, T6 a2);
/* KL_COMPARABLE_COMPARATOR [LX_RULE].less_than */
extern T1 T665f1(T0* C, T0* a1, T0* a2);
/* LX_RULE.is_less */
extern T1 T583f12(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_RULE].item */
extern T0* T573f6(T0* C, T6 a1);
/* LX_DFA_STATE.rule_sorter */
extern unsigned char ge316os10053;
extern T0* ge316ov10053;
extern T0* T598f7(T0* C);
/* DS_BUBBLE_SORTER [LX_RULE].make */
extern T0* T639c2(T0* a1);
/* KL_COMPARABLE_COMPARATOR [LX_RULE].make */
extern T0* T665c2(void);
/* DS_ARRAYED_LIST [LX_NFA_STATE].sort */
extern void T599f29(T0* C, T0* a1);
/* DS_BUBBLE_SORTER [LX_NFA_STATE].sort */
extern void T637f3(T0* C, T0* a1);
/* DS_BUBBLE_SORTER [LX_NFA_STATE].sort_with_comparator */
extern void T637f4(T0* C, T0* a1, T0* a2);
/* DS_BUBBLE_SORTER [LX_NFA_STATE].subsort_with_comparator */
extern void T637f5(T0* C, T0* a1, T0* a2, T6 a3, T6 a4);
/* DS_ARRAYED_LIST [LX_NFA_STATE].replace */
extern void T599f26(T0* C, T0* a1, T6 a2);
/* KL_COMPARABLE_COMPARATOR [LX_NFA_STATE].less_than */
extern T1 T668f1(T0* C, T0* a1, T0* a2);
/* LX_NFA_STATE.is_less */
extern T1 T606f8(T0* C, T0* a1);
/* LX_DFA_STATE.bubble_sorter */
extern unsigned char ge316os10052;
extern T0* ge316ov10052;
extern T0* T598f8(T0* C);
/* DS_BUBBLE_SORTER [LX_NFA_STATE].make */
extern T0* T637c2(T0* a1);
/* KL_COMPARABLE_COMPARATOR [LX_NFA_STATE].make */
extern T0* T668c2(void);
/* DS_ARRAYED_LIST [LX_NFA_STATE].last */
extern T0* T599f9(T0* C);
/* DS_ARRAYED_LIST [LX_NFA_STATE].is_empty */
extern T1 T599f8(T0* C);
/* DS_ARRAYED_LIST [LX_RULE].force_last */
extern void T573f13(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_RULE].resize */
extern void T573f14(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [LX_RULE].resize */
extern T0* T616f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [LX_RULE].aliased_resized_area */
extern T0* T596f3(T0* C, T6 a1);
/* DS_ARRAYED_LIST [LX_RULE].new_capacity */
extern T6 T573f9(T0* C, T6 a1);
/* DS_ARRAYED_LIST [LX_RULE].extendible */
extern T1 T573f8(T0* C, T6 a1);
/* LX_NFA_STATE.is_accepting_head */
extern T1 T606f6(T0* C);
/* LX_NFA_STATE.has_transition */
extern T1 T606f9(T0* C);
/* LX_NFA_STATE.is_accepting */
extern T1 T606f7(T0* C);
/* DS_ARRAYED_LIST [LX_NFA_STATE].has */
extern T1 T599f7(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].force_last */
extern void T599f27(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].resize */
extern void T599f31(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [LX_NFA_STATE].resize */
extern T0* T643f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [LX_NFA_STATE].aliased_resized_area */
extern T0* T641f3(T0* C, T6 a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].new_capacity */
extern T6 T599f13(T0* C, T6 a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].extendible */
extern T1 T599f12(T0* C, T6 a1);
/* DS_ARRAYED_LIST [LX_RULE].make */
extern T0* T573c12(T6 a1);
/* DS_ARRAYED_LIST [LX_RULE].new_cursor */
extern T0* T573f7(T0* C);
/* DS_ARRAYED_LIST_CURSOR [LX_RULE].make */
extern T0* T617c4(T0* a1);
/* KL_SPECIAL_ROUTINES [LX_RULE].make */
extern T0* T616f1(T0* C, T6 a1);
/* TO_SPECIAL [LX_RULE].make_area */
extern T0* T671c2(T6 a1);
/* SPECIAL [LX_RULE].make */
extern T0* T596c4(T6 a1);
/* KL_SPECIAL_ROUTINES [LX_RULE].default_create */
extern T0* T616c3(void);
/* LX_TRANSITION_TABLE [LX_DFA_STATE].make */
extern T0* T603c7(T6 a1, T6 a2);
/* KL_ARRAY_ROUTINES [LX_DFA_STATE].default_create */
extern T0* T650c1(void);
/* ARRAY [LX_DFA_STATE].make */
extern T0* T649c5(T6 a1, T6 a2);
/* ARRAY [LX_DFA_STATE].make_area */
extern void T649f6(T0* C, T6 a1);
/* SPECIAL [LX_DFA_STATE].make */
extern T0* T646c4(T6 a1);
/* LX_DFA_STATE.maximum_symbol */
extern T6 T598f13(T0* C);
/* LX_TRANSITION_TABLE [LX_DFA_STATE].upper */
extern T6 T603f5(T0* C);
/* LX_DFA_STATE.minimum_symbol */
extern T6 T598f12(T0* C);
/* LX_TRANSITION_TABLE [LX_DFA_STATE].lower */
extern T6 T603f4(T0* C);
/* DS_ARRAYED_LIST [LX_NFA_STATE].put_last */
extern void T599f24(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].item */
extern T0* T599f10(T0* C, T6 a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].make */
extern T0* T599c23(T6 a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].new_cursor */
extern T0* T599f11(T0* C);
/* DS_ARRAYED_LIST_CURSOR [LX_NFA_STATE].make */
extern T0* T644c7(T0* a1);
/* KL_SPECIAL_ROUTINES [LX_NFA_STATE].make */
extern T0* T643f1(T0* C, T6 a1);
/* TO_SPECIAL [LX_NFA_STATE].make_area */
extern T0* T674c2(T6 a1);
/* SPECIAL [LX_NFA_STATE].make */
extern T0* T641c4(T6 a1);
/* KL_SPECIAL_ROUTINES [LX_NFA_STATE].default_create */
extern T0* T643c3(void);
/* LX_SYMBOL_PARTITIONS.is_representative */
extern T1 T601f8(T0* C, T6 a1);
/* ARRAY [BOOLEAN].item */
extern T1 T564f4(T0* C, T6 a1);
/* LX_DFA_STATE.partition */
extern void T598f18(T0* C, T0* a1);
/* LX_SYMBOL_PARTITIONS.initialize */
extern void T601f10(T0* C);
/* ARRAY [BOOLEAN].clear_all */
extern void T564f7(T0* C);
/* SPECIAL [BOOLEAN].clear_all */
extern void T156f6(T0* C);
/* LX_SYMBOL_PARTITIONS.initialize */
extern void T601f10p1(T0* C);
/* DS_BILINKABLE [INTEGER_32].put_left */
extern void T631f9(T0* C, T0* a1);
/* DS_BILINKABLE [INTEGER_32].attach_right */
extern void T631f10(T0* C, T0* a1);
/* DS_BILINKABLE [INTEGER_32].put */
extern void T631f5(T0* C, T6 a1);
/* LX_SYMBOL_PARTITIONS.lower */
extern T6 T601f7(T0* C);
/* LX_SYMBOL_PARTITIONS.upper */
extern T6 T601f6(T0* C);
/* LX_FULL_DFA.resize */
extern void T550f49(T0* C, T6 a1);
/* DS_ARRAYED_LIST [LX_DFA_STATE].resize */
extern void T600f10(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [LX_DFA_STATE].resize */
extern T0* T647f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [LX_DFA_STATE].aliased_resized_area */
extern T0* T646f3(T0* C, T6 a1);
/* LX_SYMBOL_PARTITIONS.capacity */
extern T6 T601f5(T0* C);
/* ARRAY [DS_BILINKABLE [INTEGER_32]].count */
extern T6 T633f5(T0* C);
/* DS_ARRAYED_LIST [LX_DFA_STATE].item */
extern T0* T600f6(T0* C, T6 a1);
/* LX_SYMBOL_PARTITIONS.make */
extern T0* T601c9(T6 a1, T6 a2);
/* LX_SYMBOL_PARTITIONS.make */
extern void T601f9p1(T0* C, T6 a1, T6 a2);
/* ARRAY [DS_BILINKABLE [INTEGER_32]].put */
extern void T633f7(T0* C, T0* a1, T6 a2);
/* DS_BILINKABLE [INTEGER_32].make */
extern T0* T631c4(T6 a1);
/* ARRAY [DS_BILINKABLE [INTEGER_32]].make */
extern T0* T633c6(T6 a1, T6 a2);
/* ARRAY [DS_BILINKABLE [INTEGER_32]].make_area */
extern void T633f8(T0* C, T6 a1);
/* SPECIAL [DS_BILINKABLE [INTEGER_32]].make */
extern T0* T632c2(T6 a1);
/* ARRAY [BOOLEAN].make */
extern T0* T564c5(T6 a1, T6 a2);
/* ARRAY [BOOLEAN].make_area */
extern void T564f8(T0* C, T6 a1);
/* SPECIAL [BOOLEAN].make */
extern T0* T156c4(T6 a1);
/* LX_FULL_DFA.put_eob_state */
extern void T550f39(T0* C);
/* DS_ARRAYED_LIST [LX_RULE].force_first */
extern void T573f15(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_RULE].put */
extern void T573f17(T0* C, T0* a1, T6 a2);
/* DS_ARRAYED_LIST [LX_RULE].move_cursors_right */
extern void T573f20(T0* C, T6 a1, T6 a2);
/* DS_ARRAYED_LIST_CURSOR [LX_RULE].set_position */
extern void T617f5(T0* C, T6 a1);
/* DS_ARRAYED_LIST [LX_RULE].move_right */
extern void T573f19(T0* C, T6 a1, T6 a2);
/* DS_ARRAYED_LIST [LX_RULE].put_last */
extern void T573f18(T0* C, T0* a1);
/* LX_RULE.make_default */
extern T0* T583c14(T6 a1);
/* LX_RULE.dummy_action */
extern unsigned char ge403os11359;
extern T0* ge403ov11359;
extern T0* T583f11(T0* C);
/* LX_ACTION.make */
extern T0* T635c2(T0* a1);
/* LX_RULE.dummy_pattern */
extern unsigned char ge403os11358;
extern T0* ge403ov11358;
extern T0* T583f13(T0* C);
/* LX_NFA.make_epsilon */
extern T0* T581c12(T1 a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].put_first */
extern void T599f25(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].put */
extern void T599f30(T0* C, T0* a1, T6 a2);
/* DS_ARRAYED_LIST [LX_NFA_STATE].move_cursors_right */
extern void T599f34(T0* C, T6 a1, T6 a2);
/* DS_ARRAYED_LIST_CURSOR [LX_NFA_STATE].set_position */
extern void T644f8(T0* C, T6 a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].move_right */
extern void T599f33(T0* C, T6 a1, T6 a2);
/* LX_NFA_STATE.set_transition */
extern void T606f11(T0* C, T0* a1);
/* LX_EPSILON_TRANSITION [LX_NFA_STATE].make */
extern T0* T628c3(T0* a1);
/* LX_NFA_STATE.make */
extern T0* T606c10(T1 a1);
/* LX_FULL_DFA.initialize */
extern void T550f38(T0* C, T0* a1);
/* LX_FULL_DFA.initialize_dfa */
extern void T550f43(T0* C, T0* a1, T6 a2, T6 a3);
/* LX_FULL_DFA.put_start_condition */
extern void T550f48(T0* C, T0* a1);
/* LX_NFA.start_state */
extern T0* T581f4(T0* C);
/* DS_ARRAYED_LIST [LX_NFA_STATE].first */
extern T0* T599f14(T0* C);
/* DS_ARRAYED_LIST [LX_NFA].item */
extern T0* T604f7(T0* C, T6 a1);
/* LX_START_CONDITIONS.item */
extern T0* T574f7(T0* C, T6 a1);
/* LX_FULL_DFA.set_nfa_state_ids */
extern void T550f47(T0* C, T0* a1);
/* LX_NFA_STATE.set_id */
extern void T606f14(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].force */
extern void T605f37(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].key_storage_put */
extern void T605f45(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].slots_put */
extern void T605f44(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].clashes_put */
extern void T605f43(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].slots_item */
extern T6 T605f29(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].clashes_item */
extern T6 T605f28(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].hash_position */
extern T6 T605f21(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].resize */
extern void T605f42(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].clashes_resize */
extern void T605f50(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].special_integer_ */
extern T0* T605f31(T0* C);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].key_storage_resize */
extern void T605f49(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].item_storage_resize */
extern void T605f48(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [LX_NFA].resize */
extern T0* T585f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [LX_NFA].aliased_resized_area */
extern T0* T584f3(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].key_storage_item */
extern T6 T605f34(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].slots_resize */
extern void T605f47(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].new_modulus */
extern T6 T605f24(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].new_capacity */
extern T6 T605f33(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].item_storage_put */
extern void T605f41(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].search_position */
extern void T605f38(T0* C, T6 a1);
/* KL_EQUALITY_TESTER [INTEGER_32].test */
extern T1 T553f1(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].unset_found_item */
extern void T605f40(T0* C);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].item */
extern T0* T605f22(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].item_storage_item */
extern T0* T605f32(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].has */
extern T1 T605f23(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].make */
extern T0* T605c36(T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].make_with_equality_testers */
extern void T605f39(T0* C, T6 a1, T0* a2, T0* a3);
/* DS_SPARSE_TABLE_KEYS [LX_NFA, INTEGER_32].make */
extern T0* T653c5(T0* a1);
/* DS_SPARSE_TABLE_KEYS [LX_NFA, INTEGER_32].new_cursor */
extern T0* T653f4(T0* C);
/* DS_SPARSE_TABLE_KEYS_CURSOR [LX_NFA, INTEGER_32].make */
extern T0* T676c3(T0* a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].new_cursor */
extern T0* T605f30(T0* C);
/* DS_HASH_TABLE_CURSOR [LX_NFA, INTEGER_32].make */
extern T0* T655c3(T0* a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].make_sparse_container */
extern void T605f46(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].make_slots */
extern void T605f54(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].make_clashes */
extern void T605f53(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].make_key_storage */
extern void T605f52(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_NFA, INTEGER_32].make_item_storage */
extern void T605f51(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [LX_NFA].make */
extern T0* T585f1(T0* C, T6 a1);
/* TO_SPECIAL [LX_NFA].make_area */
extern T0* T636c2(T6 a1);
/* SPECIAL [LX_NFA].make */
extern T0* T584c4(T6 a1);
/* KL_SPECIAL_ROUTINES [LX_NFA].default_create */
extern T0* T585c3(void);
/* KL_EQUALITY_TESTER [INTEGER_32].default_create */
extern T0* T553c2(void);
/* DS_ARRAYED_LIST [LX_DFA_STATE].make */
extern T0* T600c8(T6 a1);
/* DS_ARRAYED_LIST [LX_DFA_STATE].new_cursor */
extern T0* T600f7(T0* C);
/* DS_ARRAYED_LIST_CURSOR [LX_DFA_STATE].make */
extern T0* T648c3(T0* a1);
/* KL_SPECIAL_ROUTINES [LX_DFA_STATE].make */
extern T0* T647f1(T0* C, T6 a1);
/* TO_SPECIAL [LX_DFA_STATE].make_area */
extern T0* T675c2(T6 a1);
/* KL_SPECIAL_ROUTINES [LX_DFA_STATE].default_create */
extern T0* T647c3(void);
/* LX_EQUIVALENCE_CLASSES.to_array */
extern T0* T582f6(T0* C, T6 a1, T6 a2);
/* LX_EQUIVALENCE_CLASSES.lower */
extern T6 T582f5(T0* C);
/* LX_EQUIVALENCE_CLASSES.upper */
extern T6 T582f4(T0* C);
/* LX_EQUIVALENCE_CLASSES.built */
extern T1 T582f3(T0* C);
/* LX_FULL_DFA.build_eof_rules */
extern void T550f42(T0* C, T0* a1, T6 a2, T6 a3);
/* ARRAY [LX_RULE].put */
extern void T597f5(T0* C, T0* a1, T6 a2);
/* ARRAY [LX_RULE].make */
extern T0* T597c4(T6 a1, T6 a2);
/* ARRAY [LX_RULE].make_area */
extern void T597f6(T0* C, T6 a1);
/* LX_FULL_DFA.build_rules */
extern void T550f41(T0* C, T0* a1);
/* LX_START_CONDITIONS.names */
extern T0* T574f8(T0* C);
/* LX_WILDCARD_PARSER.parse_string */
extern void T548f220(T0* C, T0* a1);
/* LX_WILDCARD_PARSER.parse */
extern void T548f224(T0* C);
/* LX_WILDCARD_PARSER.yy_pop_last_value */
extern void T548f237(T0* C, T6 a1);
/* LX_WILDCARD_PARSER.yy_push_error_value */
extern void T548f236(T0* C);
/* KL_SPECIAL_ROUTINES [ANY].resize */
extern T0* T143f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [ANY].aliased_resized_area */
extern T0* T142f2(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [ANY].make */
extern T0* T143f1(T0* C, T6 a1);
/* TO_SPECIAL [ANY].make_area */
extern T0* T235c2(T6 a1);
/* SPECIAL [ANY].make */
extern T0* T142c3(T6 a1);
/* KL_SPECIAL_ROUTINES [ANY].default_create */
extern T0* T143c3(void);
/* LX_WILDCARD_PARSER.yy_do_action */
extern void T548f235(T0* C, T6 a1);
/* LX_WILDCARD_PARSER.append_character_to_string */
extern T0* T548f169(T0* C, T6 a1, T0* a2);
/* LX_WILDCARD_PARSER.new_symbol_nfa */
extern T0* T548f216(T0* C, T6 a1);
/* LX_NFA.make_symbol */
extern T0* T581c13(T6 a1, T1 a2);
/* LX_SYMBOL_TRANSITION [LX_NFA_STATE].make */
extern T0* T630c4(T6 a1, T0* a2);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].force_new */
extern void T577f47(T0* C, T0* a1, T0* a2);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].key_storage_put */
extern void T577f55(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].item_storage_put */
extern void T577f51(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].slots_put */
extern void T577f54(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].clashes_put */
extern void T577f53(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].slots_item */
extern T6 T577f22(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].hash_position */
extern T6 T577f31(T0* C, T0* a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].clashes_item */
extern T6 T577f21(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].resize */
extern void T577f52(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].clashes_resize */
extern void T577f60(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].special_integer_ */
extern T0* T577f33(T0* C);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].key_storage_resize */
extern void T577f59(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].item_storage_resize */
extern void T577f58(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].key_storage_item */
extern T0* T577f25(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].slots_resize */
extern void T577f57(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].new_modulus */
extern T6 T577f27(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].new_capacity */
extern T6 T577f30(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].unset_found_item */
extern void T577f50(T0* C);
/* LX_EQUIVALENCE_CLASSES.add */
extern void T582f11(T0* C, T0* a1);
/* DS_BILINKABLE [INTEGER_32].forget_right */
extern void T631f7(T0* C);
/* DS_BILINKABLE [INTEGER_32].forget_left */
extern void T631f8(T0* C);
/* ARRAY [BOOLEAN].put */
extern void T564f6(T0* C, T1 a1, T6 a2);
/* DS_BILINKABLE [INTEGER_32].put_right */
extern void T631f6(T0* C, T0* a1);
/* DS_BILINKABLE [INTEGER_32].attach_left */
extern void T631f11(T0* C, T0* a1);
/* LX_SYMBOL_CLASS.item */
extern T6 T578f14(T0* C, T6 a1);
/* LX_SYMBOL_CLASS.put */
extern void T578f19(T0* C, T6 a1);
/* LX_SYMBOL_CLASS.force_last */
extern void T578f21(T0* C, T6 a1);
/* LX_SYMBOL_CLASS.resize */
extern void T578f22(T0* C, T6 a1);
/* LX_SYMBOL_CLASS.new_capacity */
extern T6 T578f13(T0* C, T6 a1);
/* LX_SYMBOL_CLASS.extendible */
extern T1 T578f11(T0* C, T6 a1);
/* LX_SYMBOL_CLASS.last */
extern T6 T578f16(T0* C);
/* LX_SYMBOL_CLASS.is_empty */
extern T1 T578f12(T0* C);
/* LX_SYMBOL_CLASS.has */
extern T1 T578f10(T0* C, T6 a1);
/* LX_SYMBOL_CLASS.arrayed_has */
extern T1 T578f15(T0* C, T6 a1);
/* LX_SYMBOL_CLASS.make */
extern T0* T578c18(T6 a1);
/* LX_SYMBOL_CLASS.new_cursor */
extern T0* T578f9(T0* C);
/* DS_ARRAYED_LIST_CURSOR [INTEGER_32].make */
extern T0* T624c3(T0* a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].found_item */
extern T0* T577f24(T0* C);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].item_storage_item */
extern T0* T577f32(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].found */
extern T1 T577f23(T0* C);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].search */
extern void T577f46(T0* C, T0* a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].search_position */
extern void T577f48(T0* C, T0* a1);
/* KL_STRING_EQUALITY_TESTER.test */
extern T1 T567f1(T0* C, T0* a1, T0* a2);
/* LX_WILDCARD_PARSER.new_epsilon_nfa */
extern T0* T548f168(T0* C);
/* LX_WILDCARD_PARSER.append_character_set_to_character_class */
extern T0* T548f167(T0* C, T6 a1, T6 a2, T0* a3);
/* LX_WILDCARD_PARSER.report_negative_range_in_character_class_error */
extern void T548f268(T0* C);
/* UT_ERROR_HANDLER.report_error */
extern void T28f11(T0* C, T0* a1);
/* UT_ERROR_HANDLER.report_error_message */
extern void T28f12(T0* C, T0* a1);
/* KL_NULL_TEXT_OUTPUT_STREAM.put_line */
extern void T558f4(T0* C, T0* a1);
/* KL_NULL_TEXT_OUTPUT_STREAM.put_new_line */
extern void T558f6(T0* C);
/* KL_NULL_TEXT_OUTPUT_STREAM.put_string */
extern void T558f5(T0* C, T0* a1);
/* UT_ERROR_HANDLER.message */
extern T0* T28f5(T0* C, T0* a1);
/* LX_NEGATIVE_RANGE_IN_CHARACTER_CLASS_ERROR.make */
extern T0* T608c7(T0* a1, T6 a2);
/* LX_WILDCARD_PARSER.filename */
extern T0* T548f189(T0* C);
/* KL_SPECIAL_ROUTINES [LX_SYMBOL_CLASS].resize */
extern T0* T580f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [LX_SYMBOL_CLASS].aliased_resized_area */
extern T0* T579f2(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [LX_SYMBOL_CLASS].make */
extern T0* T580f1(T0* C, T6 a1);
/* TO_SPECIAL [LX_SYMBOL_CLASS].make_area */
extern T0* T625c2(T6 a1);
/* SPECIAL [LX_SYMBOL_CLASS].make */
extern T0* T579c4(T6 a1);
/* KL_SPECIAL_ROUTINES [LX_SYMBOL_CLASS].default_create */
extern T0* T580c3(void);
/* LX_WILDCARD_PARSER.append_character_to_character_class */
extern T0* T548f166(T0* C, T6 a1, T0* a2);
/* LX_WILDCARD_PARSER.new_character_class */
extern T0* T548f165(T0* C);
/* LX_SYMBOL_CLASS.set_negated */
extern void T578f20(T0* C, T1 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].force */
extern void T577f45(T0* C, T0* a1, T0* a2);
/* LX_WILDCARD_PARSER.new_nfa_from_character_class */
extern T0* T548f164(T0* C, T0* a1);
/* LX_SYMBOL_CLASS.sort */
extern void T578f24(T0* C);
/* LX_SYMBOL_CLASS.arrayed_sort */
extern void T578f26(T0* C, T0* a1);
/* DS_SHELL_SORTER [INTEGER_32].sort */
extern void T679f3(T0* C, T0* a1);
/* DS_SHELL_SORTER [INTEGER_32].sort_with_comparator */
extern void T679f4(T0* C, T0* a1, T0* a2);
/* DS_SHELL_SORTER [INTEGER_32].subsort_with_comparator */
extern void T679f5(T0* C, T0* a1, T0* a2, T6 a3, T6 a4);
/* LX_SYMBOL_CLASS.replace */
extern void T578f25(T0* C, T6 a1, T6 a2);
/* KL_COMPARABLE_COMPARATOR [INTEGER_32].less_than */
extern T1 T684f1(T0* C, T6 a1, T6 a2);
/* LX_SYMBOL_CLASS.sorter */
extern unsigned char ge321os11205;
extern T0* ge321ov11205;
extern T0* T578f17(T0* C);
/* DS_SHELL_SORTER [INTEGER_32].make */
extern T0* T679c2(T0* a1);
/* KL_COMPARABLE_COMPARATOR [INTEGER_32].make */
extern T0* T684c2(void);
/* LX_WILDCARD_PARSER.new_symbol_class_nfa */
extern T0* T548f162(T0* C, T0* a1);
/* LX_NFA.make_symbol_class */
extern T0* T581c6(T0* a1, T1 a2);
/* LX_SYMBOL_CLASS_TRANSITION [LX_NFA_STATE].make */
extern T0* T626c4(T0* a1, T0* a2);
/* LX_WILDCARD_PARSER.question_character_class */
extern T0* T548f161(T0* C);
/* LX_NFA.build_optional */
extern void T581f11(T0* C);
/* LX_NFA_STATE.set_epsilon_transition */
extern void T606f12(T0* C, T0* a1);
/* LX_NFA.final_state */
extern T0* T581f5(T0* C);
/* LX_NFA.build_positive_closure */
extern void T581f10(T0* C);
/* LX_NFA.build_closure */
extern void T581f9(T0* C);
/* LX_WILDCARD_PARSER.new_nfa_from_character */
extern T0* T548f158(T0* C, T6 a1);
/* LX_NFA.build_concatenation */
extern void T581f8(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].append_last */
extern void T599f28(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].extend_last */
extern void T599f32(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [LX_NFA_STATE].forth */
extern void T644f10(T0* C);
/* DS_ARRAYED_LIST [LX_NFA_STATE].cursor_forth */
extern void T599f36(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].add_traversing_cursor */
extern void T599f37(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [LX_NFA_STATE].set_next_cursor */
extern void T644f11(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].remove_traversing_cursor */
extern void T599f38(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [LX_NFA_STATE].item */
extern T0* T644f4(T0* C);
/* DS_ARRAYED_LIST [LX_NFA_STATE].cursor_item */
extern T0* T599f16(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [LX_NFA_STATE].after */
extern T1 T644f5(T0* C);
/* DS_ARRAYED_LIST [LX_NFA_STATE].cursor_after */
extern T1 T599f15(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [LX_NFA_STATE].start */
extern void T644f9(T0* C);
/* DS_ARRAYED_LIST [LX_NFA_STATE].cursor_start */
extern void T599f35(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [LX_NFA_STATE].off */
extern T1 T644f6(T0* C);
/* DS_ARRAYED_LIST [LX_NFA_STATE].cursor_off */
extern T1 T599f18(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_NFA_STATE].cursor_before */
extern T1 T599f20(T0* C, T0* a1);
/* LX_NFA.build_union */
extern void T581f7(T0* C, T0* a1);
/* LX_WILDCARD_PARSER.report_unrecognized_rule_error */
extern void T548f250(T0* C);
/* LX_UNRECOGNIZED_RULE_ERROR.make */
extern T0* T588c7(T0* a1, T6 a2);
/* LX_WILDCARD_PARSER.process_rule */
extern void T548f249(T0* C, T0* a1);
/* LX_START_CONDITIONS.add_nfa_to_all */
extern void T574f11(T0* C, T0* a1);
/* LX_START_CONDITION.put_nfa */
extern void T602f7(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_NFA].force_last */
extern void T604f11(T0* C, T0* a1);
/* DS_ARRAYED_LIST [LX_NFA].resize */
extern void T604f12(T0* C, T6 a1);
/* DS_ARRAYED_LIST [LX_NFA].new_capacity */
extern T6 T604f9(T0* C, T6 a1);
/* DS_ARRAYED_LIST [LX_NFA].extendible */
extern T1 T604f8(T0* C, T6 a1);
/* LX_START_CONDITIONS.add_nfa_to_non_exclusive */
extern void T574f13(T0* C, T0* a1);
/* LX_START_CONDITIONS.is_empty */
extern T1 T574f6(T0* C);
/* LX_DESCRIPTION.set_variable_trail_context */
extern void T549f34(T0* C, T1 a1);
/* LX_RULE.set_column_count */
extern void T583f21(T0* C, T6 a1);
/* LX_RULE.set_line_count */
extern void T583f20(T0* C, T6 a1);
/* LX_RULE.set_trail_count */
extern void T583f19(T0* C, T6 a1);
/* LX_RULE.set_head_count */
extern void T583f18(T0* C, T6 a1);
/* LX_RULE.set_trail_context */
extern void T583f17(T0* C, T1 a1);
/* LX_RULE.set_line_nb */
extern void T583f16(T0* C, T6 a1);
/* LX_RULE.set_pattern */
extern void T583f15(T0* C, T0* a1);
/* LX_NFA.set_accepted_rule */
extern void T581f14(T0* C, T0* a1);
/* LX_NFA_STATE.set_accepted_rule */
extern void T606f13(T0* C, T0* a1);
/* LX_DESCRIPTION.create_equiv_classes */
extern void T549f33(T0* C);
/* LX_EQUIVALENCE_CLASSES.make */
extern T0* T582c9(T6 a1, T6 a2);
/* LX_EQUIVALENCE_CLASSES.initialize */
extern void T582f12(T0* C);
/* LX_WILDCARD_PARSER.check_options */
extern void T548f248(T0* C);
/* LX_WILDCARD_PARSER.report_full_and_variable_trailing_context_error */
extern void T548f263(T0* C);
/* LX_FULL_AND_VARIABLE_TRAILING_CONTEXT_ERROR.make */
extern T0* T594c7(void);
/* LX_WILDCARD_PARSER.report_full_and_reject_error */
extern void T548f262(T0* C);
/* LX_FULL_AND_REJECT_ERROR.make */
extern T0* T593c7(void);
/* LX_WILDCARD_PARSER.report_full_and_meta_equiv_classes_error */
extern void T548f261(T0* C);
/* LX_FULL_AND_META_ERROR.make */
extern T0* T592c7(void);
/* LX_WILDCARD_PARSER.build_equiv_classes */
extern void T548f247(T0* C);
/* DS_HASH_TABLE_CURSOR [LX_SYMBOL_CLASS, STRING_8].forth */
extern void T587f8(T0* C);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].cursor_forth */
extern void T577f66(T0* C, T0* a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].add_traversing_cursor */
extern void T577f68(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [LX_SYMBOL_CLASS, STRING_8].set_next_cursor */
extern void T587f10(T0* C, T0* a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].remove_traversing_cursor */
extern void T577f67(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [LX_SYMBOL_CLASS, STRING_8].set_position */
extern void T587f9(T0* C, T6 a1);
/* LX_SYMBOL_CLASS.convert_to_equivalence */
extern void T578f23(T0* C, T0* a1);
/* LX_EQUIVALENCE_CLASSES.equivalence_class */
extern T6 T582f8(T0* C, T6 a1);
/* LX_EQUIVALENCE_CLASSES.is_representative */
extern T1 T582f7(T0* C, T6 a1);
/* DS_HASH_TABLE_CURSOR [LX_SYMBOL_CLASS, STRING_8].item */
extern T0* T587f4(T0* C);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].cursor_item */
extern T0* T577f37(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [LX_SYMBOL_CLASS, STRING_8].after */
extern T1 T587f5(T0* C);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].cursor_after */
extern T1 T577f36(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [LX_SYMBOL_CLASS, STRING_8].start */
extern void T587f7(T0* C);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].cursor_start */
extern void T577f65(T0* C, T0* a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].cursor_off */
extern T1 T577f42(T0* C, T0* a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].is_empty */
extern T1 T577f41(T0* C);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].new_cursor */
extern T0* T577f35(T0* C);
/* DS_HASH_TABLE_CURSOR [LX_SYMBOL_CLASS, STRING_8].make */
extern T0* T587c6(T0* a1);
/* LX_EQUIVALENCE_CLASSES.build */
extern void T582f10(T0* C);
/* LX_WILDCARD_PARSER.yy_push_last_value */
extern void T548f234(T0* C, T6 a1);
/* LX_WILDCARD_PARSER.accept */
extern void T548f233(T0* C);
/* LX_WILDCARD_PARSER.yy_do_error_action */
extern void T548f231(T0* C, T6 a1);
/* LX_WILDCARD_PARSER.report_error */
extern void T548f246(T0* C, T0* a1);
/* UT_SYNTAX_ERROR.make */
extern T0* T586c7(T0* a1, T6 a2);
/* LX_WILDCARD_PARSER.report_eof_expected_error */
extern void T548f245(T0* C);
/* LX_WILDCARD_PARSER.read_token */
extern void T548f230(T0* C);
/* LX_WILDCARD_PARSER.yy_execute_action */
extern void T548f244(T0* C, T6 a1);
/* LX_WILDCARD_PARSER.report_bad_character_error */
extern void T548f260(T0* C, T0* a1);
/* LX_BAD_CHARACTER_ERROR.make */
extern T0* T591c7(T0* a1, T6 a2, T0* a3);
/* LX_WILDCARD_PARSER.report_bad_character_class_error */
extern void T548f259(T0* C);
/* LX_BAD_CHARACTER_CLASS_ERROR.make */
extern T0* T590c7(T0* a1, T6 a2);
/* LX_WILDCARD_PARSER.start_condition */
extern T6 T548f184(T0* C);
/* LX_WILDCARD_PARSER.process_escaped_character */
extern void T548f258(T0* C);
/* LX_WILDCARD_PARSER.text_count */
extern T6 T548f205(T0* C);
/* LX_WILDCARD_PARSER.report_missing_quote_error */
extern void T548f257(T0* C);
/* LX_MISSING_QUOTE_ERROR.make */
extern T0* T589c7(T0* a1, T6 a2);
/* LX_WILDCARD_PARSER.process_character */
extern void T548f256(T0* C, T6 a1);
/* LX_WILDCARD_PARSER.report_character_out_of_range_error */
extern void T548f266(T0* C, T0* a1);
/* LX_CHARACTER_OUT_OF_RANGE_ERROR.make */
extern T0* T595c7(T0* a1, T6 a2, T0* a3);
/* LX_WILDCARD_PARSER.text_item */
extern T2 T548f181(T0* C, T6 a1);
/* LX_WILDCARD_PARSER.less */
extern void T548f255(T0* C, T6 a1);
/* LX_WILDCARD_PARSER.yy_set_line_column */
extern void T548f265(T0* C);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].item */
extern T0* T577f34(T0* C, T0* a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].has */
extern T1 T577f26(T0* C, T0* a1);
/* LX_WILDCARD_PARSER.text */
extern T0* T548f175(T0* C);
/* KL_CHARACTER_BUFFER.substring */
extern T0* T369f5(T0* C, T6 a1, T6 a2);
/* LX_WILDCARD_PARSER.set_start_condition */
extern void T548f254(T0* C, T6 a1);
/* LX_WILDCARD_PARSER.yy_execute_eof_action */
extern void T548f243(T0* C, T6 a1);
/* LX_WILDCARD_PARSER.terminate */
extern void T548f253(T0* C);
/* LX_WILDCARD_PARSER.wrap */
extern T1 T548f128(T0* C);
/* LX_WILDCARD_PARSER.yy_refill_input_buffer */
extern void T548f242(T0* C);
/* LX_WILDCARD_PARSER.yy_set_content */
extern void T548f240(T0* C, T0* a1);
/* KL_CHARACTER_BUFFER.count */
extern T6 T369f3(T0* C);
/* YY_BUFFER.fill */
extern void T221f15(T0* C);
/* YY_BUFFER.set_index */
extern void T221f13(T0* C, T6 a1);
/* LX_WILDCARD_PARSER.yy_null_trans_state */
extern T6 T548f127(T0* C, T6 a1);
/* LX_WILDCARD_PARSER.yy_previous_state */
extern T6 T548f126(T0* C);
/* LX_WILDCARD_PARSER.fatal_error */
extern void T548f241(T0* C, T0* a1);
/* LX_WILDCARD_PARSER.std */
extern T0* T548f171(T0* C);
/* LX_WILDCARD_PARSER.special_integer_ */
extern T0* T548f152(T0* C);
/* LX_WILDCARD_PARSER.yy_init_value_stacks */
extern void T548f229(T0* C);
/* LX_WILDCARD_PARSER.yy_clear_all */
extern void T548f238(T0* C);
/* LX_WILDCARD_PARSER.clear_all */
extern void T548f251(T0* C);
/* LX_WILDCARD_PARSER.clear_stacks */
extern void T548f264(T0* C);
/* LX_WILDCARD_PARSER.yy_clear_value_stacks */
extern void T548f267(T0* C);
/* SPECIAL [LX_NFA].clear_all */
extern void T584f6(T0* C);
/* SPECIAL [STRING_8].clear_all */
extern void T32f7(T0* C);
/* SPECIAL [LX_SYMBOL_CLASS].clear_all */
extern void T579f6(T0* C);
/* SPECIAL [INTEGER_32].clear_all */
extern void T63f12(T0* C);
/* SPECIAL [ANY].clear_all */
extern void T142f5(T0* C);
/* LX_WILDCARD_PARSER.abort */
extern void T548f232(T0* C);
/* LX_WILDCARD_PARSER.set_input_buffer */
extern void T548f223(T0* C, T0* a1);
/* LX_WILDCARD_PARSER.yy_load_input_buffer */
extern void T548f228(T0* C);
/* YY_BUFFER.set_position */
extern void T221f14(T0* C, T6 a1, T6 a2, T6 a3);
/* LX_WILDCARD_PARSER.new_string_buffer */
extern T0* T548f123(T0* C, T0* a1);
/* YY_BUFFER.make */
extern T0* T221c12(T0* a1);
/* YY_BUFFER.make_from_buffer */
extern void T221f16(T0* C, T0* a1);
/* KL_CHARACTER_BUFFER.put */
extern void T369f8(T0* C, T2 a1, T6 a2);
/* KL_CHARACTER_BUFFER.fill_from_string */
extern void T369f7(T0* C, T0* a1, T6 a2);
/* STRING_8.subcopy */
extern void T17f54(T0* C, T0* a1, T6 a2, T6 a3, T6 a4);
/* YY_BUFFER.new_default_buffer */
extern T0* T221f11(T0* C, T6 a1);
/* KL_CHARACTER_BUFFER.make */
extern T0* T369c6(T6 a1);
/* LX_WILDCARD_PARSER.make_from_description */
extern T0* T548c219(T0* a1, T0* a2);
/* DS_ARRAYED_STACK [INTEGER_32].make */
extern T0* T576c4(T6 a1);
/* LX_ACTION_FACTORY.make */
extern T0* T575c1(void);
/* LX_START_CONDITIONS.make */
extern void T574f10(T0* C, T6 a1);
/* LX_START_CONDITIONS.make */
extern T0* T574c10(T6 a1);
/* LX_START_CONDITIONS.new_cursor */
extern T0* T574f9(T0* C);
/* DS_ARRAYED_LIST_CURSOR [LX_START_CONDITION].make */
extern T0* T620c4(T0* a1);
/* KL_SPECIAL_ROUTINES [LX_START_CONDITION].make */
extern T0* T619f1(T0* C, T6 a1);
/* TO_SPECIAL [LX_START_CONDITION].make_area */
extern T0* T672c2(T6 a1);
/* SPECIAL [LX_START_CONDITION].make */
extern T0* T618c2(T6 a1);
/* KL_SPECIAL_ROUTINES [LX_START_CONDITION].default_create */
extern T0* T619c2(void);
/* LX_WILDCARD_PARSER.make_parser_skeleton */
extern void T548f222(T0* C);
/* LX_WILDCARD_PARSER.yy_build_parser_tables */
extern void T548f227(T0* C);
/* LX_WILDCARD_PARSER.yycheck_template */
extern unsigned char ge381os9453;
extern T0* ge381ov9453;
extern T0* T548f138(T0* C);
/* LX_WILDCARD_PARSER.yyfixed_array */
extern T0* T548f211(T0* C, T0* a1);
/* KL_SPECIAL_ROUTINES [INTEGER_32].to_special */
extern T0* T65f3(T0* C, T0* a1);
/* LX_WILDCARD_PARSER.yytable_template */
extern unsigned char ge381os9452;
extern T0* ge381ov9452;
extern T0* T548f137(T0* C);
/* LX_WILDCARD_PARSER.yypgoto_template */
extern unsigned char ge381os9451;
extern T0* ge381ov9451;
extern T0* T548f136(T0* C);
/* LX_WILDCARD_PARSER.yypact_template */
extern unsigned char ge381os9450;
extern T0* ge381ov9450;
extern T0* T548f134(T0* C);
/* LX_WILDCARD_PARSER.yydefgoto_template */
extern unsigned char ge381os9449;
extern T0* ge381ov9449;
extern T0* T548f133(T0* C);
/* LX_WILDCARD_PARSER.yydefact_template */
extern unsigned char ge381os9448;
extern T0* ge381ov9448;
extern T0* T548f132(T0* C);
/* LX_WILDCARD_PARSER.yytypes2_template */
extern unsigned char ge381os9447;
extern T0* ge381ov9447;
extern T0* T548f129(T0* C);
/* LX_WILDCARD_PARSER.yytypes1_template */
extern unsigned char ge381os9446;
extern T0* ge381ov9446;
extern T0* T548f122(T0* C);
/* LX_WILDCARD_PARSER.yyr1_template */
extern unsigned char ge381os9445;
extern T0* ge381ov9445;
extern T0* T548f119(T0* C);
/* LX_WILDCARD_PARSER.yytranslate_template */
extern unsigned char ge381os9444;
extern T0* ge381ov9444;
extern T0* T548f116(T0* C);
/* LX_WILDCARD_PARSER.yy_create_value_stacks */
extern void T548f226(T0* C);
/* LX_WILDCARD_PARSER.make_lex_scanner_from_description */
extern void T548f221(T0* C, T0* a1, T0* a2);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].set_key_equality_tester */
extern void T577f44(T0* C, T0* a1);
/* DS_SPARSE_TABLE_KEYS [LX_SYMBOL_CLASS, STRING_8].internal_set_equality_tester */
extern void T622f6(T0* C, T0* a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].make_map */
extern T0* T577c43(T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].make_with_equality_testers */
extern void T577f49(T0* C, T6 a1, T0* a2, T0* a3);
/* DS_SPARSE_TABLE_KEYS [LX_SYMBOL_CLASS, STRING_8].make */
extern T0* T622c5(T0* a1);
/* DS_SPARSE_TABLE_KEYS [LX_SYMBOL_CLASS, STRING_8].new_cursor */
extern T0* T622f4(T0* C);
/* DS_SPARSE_TABLE_KEYS_CURSOR [LX_SYMBOL_CLASS, STRING_8].make */
extern T0* T673c3(T0* a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].make_sparse_container */
extern void T577f56(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].make_slots */
extern void T577f64(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].make_clashes */
extern void T577f63(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].make_key_storage */
extern void T577f62(T0* C, T6 a1);
/* DS_HASH_TABLE [LX_SYMBOL_CLASS, STRING_8].make_item_storage */
extern void T577f61(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].set_key_equality_tester */
extern void T81f44(T0* C, T0* a1);
/* LX_WILDCARD_PARSER.string_equality_tester */
extern unsigned char ge179os2927;
extern T0* ge179ov2927;
extern T0* T548f121(T0* C);
/* KL_STRING_EQUALITY_TESTER.default_create */
extern T0* T567c2(void);
/* DS_HASH_TABLE [STRING_8, STRING_8].make_map */
extern void T81f46(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].make_map */
extern T0* T81c46(T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].make_with_equality_testers */
extern void T81f47(T0* C, T6 a1, T0* a2, T0* a3);
/* DS_HASH_TABLE [STRING_8, STRING_8].make_sparse_container */
extern void T81f48(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].unset_found_item */
extern void T81f53(T0* C);
/* DS_HASH_TABLE [STRING_8, STRING_8].make_slots */
extern void T81f52(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].special_integer_ */
extern T0* T81f41(T0* C);
/* DS_HASH_TABLE [STRING_8, STRING_8].new_modulus */
extern T6 T81f21(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].make_clashes */
extern void T81f51(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].make_key_storage */
extern void T81f50(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].make_item_storage */
extern void T81f49(T0* C, T6 a1);
/* LX_WILDCARD_PARSER.make_with_buffer */
extern void T548f225(T0* C, T0* a1);
/* LX_WILDCARD_PARSER.yy_initialize */
extern void T548f239(T0* C);
/* LX_WILDCARD_PARSER.yy_build_tables */
extern void T548f252(T0* C);
/* LX_WILDCARD_PARSER.yy_accept_template */
extern unsigned char ge382os9720;
extern T0* ge382ov9720;
extern T0* T548f197(T0* C);
/* LX_WILDCARD_PARSER.yy_fixed_array */
extern T0* T548f218(T0* C, T0* a1);
/* LX_WILDCARD_PARSER.yy_meta_template */
extern unsigned char ge382os9719;
extern T0* ge382ov9719;
extern T0* T548f196(T0* C);
/* LX_WILDCARD_PARSER.yy_ec_template */
extern unsigned char ge382os9718;
extern T0* ge382ov9718;
extern T0* T548f195(T0* C);
/* LX_WILDCARD_PARSER.yy_def_template */
extern unsigned char ge382os9717;
extern T0* ge382ov9717;
extern T0* T548f194(T0* C);
/* LX_WILDCARD_PARSER.yy_base_template */
extern unsigned char ge382os9716;
extern T0* ge382ov9716;
extern T0* T548f193(T0* C);
/* LX_WILDCARD_PARSER.yy_chk_template */
extern unsigned char ge382os9715;
extern T0* ge382ov9715;
extern T0* T548f192(T0* C);
/* LX_WILDCARD_PARSER.yy_nxt_template */
extern unsigned char ge382os9714;
extern T0* ge382ov9714;
extern T0* T548f191(T0* C);
/* LX_WILDCARD_PARSER.empty_buffer */
extern unsigned char ge398os6357;
extern T0* ge398ov6357;
extern T0* T548f144(T0* C);
/* LX_DESCRIPTION.set_case_insensitive */
extern void T549f32(T0* C, T1 a1);
/* LX_DESCRIPTION.set_full_table */
extern void T549f31(T0* C, T1 a1);
/* LX_DESCRIPTION.set_meta_equiv_classes_used */
extern void T549f30(T0* C, T1 a1);
/* LX_DESCRIPTION.set_equiv_classes_used */
extern void T549f29(T0* C, T1 a1);
/* LX_DESCRIPTION.make */
extern T0* T549c28(void);
/* LX_START_CONDITIONS.make_with_initial */
extern T0* T574c12(T6 a1);
/* LX_START_CONDITIONS.put_first */
extern void T574f14(T0* C, T0* a1);
/* LX_START_CONDITIONS.put */
extern void T574f15(T0* C, T0* a1, T6 a2);
/* LX_START_CONDITIONS.move_cursors_right */
extern void T574f18(T0* C, T6 a1, T6 a2);
/* DS_ARRAYED_LIST_CURSOR [LX_START_CONDITION].set_position */
extern void T620f5(T0* C, T6 a1);
/* LX_START_CONDITIONS.move_right */
extern void T574f17(T0* C, T6 a1, T6 a2);
/* LX_START_CONDITIONS.put_last */
extern void T574f16(T0* C, T0* a1);
/* LX_START_CONDITION.make */
extern T0* T602c6(T0* a1, T6 a2, T1 a3);
/* DS_ARRAYED_LIST [LX_NFA].make */
extern T0* T604c10(T6 a1);
/* DS_ARRAYED_LIST [LX_NFA].new_cursor */
extern T0* T604f6(T0* C);
/* DS_ARRAYED_LIST_CURSOR [LX_NFA].make */
extern T0* T651c3(T0* a1);
/* UT_ERROR_HANDLER.make_null */
extern T0* T28c10(void);
/* UT_ERROR_HANDLER.null_output_stream */
extern unsigned char ge216os2545;
extern T0* ge216ov2545;
extern T0* T28f6(T0* C);
/* KL_NULL_TEXT_OUTPUT_STREAM.make */
extern T0* T558c3(T0* a1);
/* LX_DFA_WILDCARD.wipe_out */
extern void T508f15(T0* C);
/* GEANT_FILESET_ELEMENT.exclude_attribute_name */
extern unsigned char ge130os8739;
extern T0* ge130ov8739;
extern T0* T385f11(T0* C);
/* GEANT_FILESET.set_include_wc_string */
extern void T391f36(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.include_attribute_name */
extern unsigned char ge130os8738;
extern T0* ge130ov8738;
extern T0* T385f10(T0* C);
/* GEANT_FILESET.set_directory_name */
extern void T391f35(T0* C, T0* a1);
/* GEANT_FILESET.set_dir_name */
extern void T391f34(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.attribute_value */
extern T0* T385f9(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.project_variables_resolver */
extern T0* T385f25(T0* C);
/* GEANT_FILESET_ELEMENT.dir_attribute_name */
extern T0* T385f8(T0* C);
/* GEANT_FILESET.make */
extern T0* T391c33(T0* a1);
/* DS_HASH_SET [STRING_8].set_equality_tester */
extern void T506f36(T0* C, T0* a1);
/* DS_HASH_SET [STRING_8].make */
extern T0* T506c35(T6 a1);
/* DS_HASH_SET [STRING_8].new_cursor */
extern T0* T506f22(T0* C);
/* DS_HASH_SET_CURSOR [STRING_8].make */
extern T0* T547c6(T0* a1);
/* DS_HASH_SET [STRING_8].make_slots */
extern void T506f41(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].make_clashes */
extern void T506f40(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].make_key_storage */
extern void T506f39(T0* C, T6 a1);
/* DS_HASH_SET [STRING_8].make_item_storage */
extern void T506f38(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].make_equal */
extern T0* T504c39(T6 a1);
/* KL_EQUALITY_TESTER [GEANT_FILESET_ENTRY].default_create */
extern T0* T542c2(void);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].make */
extern void T504f40(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].new_cursor */
extern T0* T504f25(T0* C);
/* DS_HASH_SET_CURSOR [GEANT_FILESET_ENTRY].make */
extern T0* T543c4(T0* a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].unset_found_item */
extern void T504f45(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].make_slots */
extern void T504f44(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].special_integer_ */
extern T0* T504f27(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].new_modulus */
extern T6 T504f33(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].make_clashes */
extern void T504f43(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].make_key_storage */
extern void T504f42(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].make_item_storage */
extern void T504f41(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_FILESET_ENTRY].make */
extern T0* T544f1(T0* C, T6 a1);
/* TO_SPECIAL [GEANT_FILESET_ENTRY].make_area */
extern T0* T572c2(T6 a1);
/* SPECIAL [GEANT_FILESET_ENTRY].make */
extern T0* T546c4(T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_FILESET_ENTRY].default_create */
extern T0* T544c3(void);
/* GEANT_FILESET_ELEMENT.exit_application */
extern void T385f30(T0* C, T6 a1, T0* a2);
/* GEANT_FILESET_ELEMENT.exceptions */
extern T0* T385f24(T0* C);
/* GEANT_FILESET_ELEMENT.log_messages */
extern void T385f33(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.mapped_filename_directory_attribute_name */
extern unsigned char ge130os8746;
extern T0* ge130ov8746;
extern T0* T385f6(T0* C);
/* GEANT_FILESET_ELEMENT.filename_directory_attribute_name */
extern unsigned char ge130os8744;
extern T0* ge130ov8744;
extern T0* T385f5(T0* C);
/* GEANT_FILESET_ELEMENT.directory_attribute_name */
extern unsigned char ge130os8737;
extern T0* ge130ov8737;
extern T0* T385f22(T0* C);
/* GEANT_FILESET_ELEMENT.has_attribute */
extern T1 T385f20(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.concat_attribute_name */
extern unsigned char ge130os8741;
extern T0* ge130ov8741;
extern T0* T385f7(T0* C);
/* GEANT_FILESET_ELEMENT.make */
extern void T385f29p1(T0* C, T0* a1, T0* a2);
/* GEANT_FILESET_ELEMENT.set_project */
extern void T385f32(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.element_make */
extern void T385f31(T0* C, T0* a1);
/* GEANT_FILESET_ELEMENT.set_xml_element */
extern void T385f34(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.fileset_element_name */
extern unsigned char ge117os8368;
extern T0* ge117ov8368;
extern T0* T319f13(T0* C);
/* GEANT_REPLACE_COMMAND.set_flags */
extern void T463f37(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.flags_attribute_name */
extern unsigned char ge117os8367;
extern T0* ge117ov8367;
extern T0* T319f12(T0* C);
/* GEANT_REPLACE_COMMAND.set_replace */
extern void T463f36(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.replace_attribute_name */
extern unsigned char ge117os8366;
extern T0* ge117ov8366;
extern T0* T319f11(T0* C);
/* GEANT_REPLACE_COMMAND.set_variable_pattern */
extern void T463f35(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.variable_pattern_attribute_name */
extern unsigned char ge117os8365;
extern T0* ge117ov8365;
extern T0* T319f9(T0* C);
/* GEANT_REPLACE_COMMAND.set_token */
extern void T463f34(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.token_attribute_name */
extern unsigned char ge117os8364;
extern T0* ge117ov8364;
extern T0* T319f8(T0* C);
/* GEANT_REPLACE_COMMAND.set_match */
extern void T463f33(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.match_attribute_name */
extern unsigned char ge117os8363;
extern T0* ge117ov8363;
extern T0* T319f7(T0* C);
/* GEANT_REPLACE_COMMAND.set_to_directory */
extern void T463f32(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.to_directory_attribute_name */
extern unsigned char ge117os8362;
extern T0* ge117ov8362;
extern T0* T319f6(T0* C);
/* GEANT_REPLACE_COMMAND.set_to_file */
extern void T463f31(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.to_file_attribute_name */
extern unsigned char ge117os8361;
extern T0* ge117ov8361;
extern T0* T319f5(T0* C);
/* GEANT_REPLACE_COMMAND.set_file */
extern void T463f30(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.attribute_value */
extern T0* T319f14(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.project_variables_resolver */
extern T0* T319f17(T0* C);
/* GEANT_REPLACE_TASK.has_attribute */
extern T1 T319f10(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.file_attribute_name */
extern unsigned char ge117os8360;
extern T0* ge117ov8360;
extern T0* T319f15(T0* C);
/* GEANT_REPLACE_TASK.make */
extern void T319f31p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_REPLACE_TASK.make */
extern T0* T319f31p1ac1(T0* a1);
/* DS_CELL [PROCEDURE [ANY, TUPLE]].put */
extern void T379f3(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.make_with_command */
extern void T319f33(T0* C, T0* a1, T0* a2);
/* GEANT_REPLACE_TASK.interpreting_element_make */
extern void T319f36(T0* C, T0* a1, T0* a2);
/* GEANT_REPLACE_TASK.set_project */
extern void T319f38(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.element_make */
extern void T319f37(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.set_xml_element */
extern void T319f39(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.set_command */
extern void T319f35(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.build_command */
extern void T319f32(T0* C, T0* a1);
/* GEANT_REPLACE_COMMAND.make */
extern T0* T463c29(T0* a1);
/* DS_CELL [PROCEDURE [ANY, TUPLE]].make */
extern T0* T379c2(T0* a1);
/* GEANT_REPLACE_COMMAND.set_project */
extern void T463f39(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_input_task */
extern T0* T192f50(T0* C, T0* a1);
/* GEANT_INPUT_TASK.make */
extern T0* T317c32(T0* a1, T0* a2);
/* GEANT_INPUT_COMMAND.set_answer_required */
extern void T460f21(T0* C, T1 a1);
/* GEANT_INPUT_TASK.boolean_value */
extern T1 T317f10(T0* C, T0* a1);
/* GEANT_INPUT_TASK.std */
extern T0* T317f18(T0* C);
/* GEANT_INPUT_TASK.false_attribute_value */
extern T0* T317f17(T0* C);
/* GEANT_INPUT_TASK.true_attribute_value */
extern T0* T317f16(T0* C);
/* GEANT_INPUT_TASK.string_ */
extern T0* T317f15(T0* C);
/* GEANT_INPUT_TASK.answer_required_attribute_name */
extern unsigned char ge110os8342;
extern T0* ge110ov8342;
extern T0* T317f9(T0* C);
/* GEANT_INPUT_COMMAND.set_validregexp */
extern void T460f20(T0* C, T0* a1);
/* GEANT_INPUT_TASK.validregexp_attribute_name */
extern unsigned char ge110os8341;
extern T0* ge110ov8341;
extern T0* T317f8(T0* C);
/* GEANT_INPUT_COMMAND.set_validargs */
extern void T460f19(T0* C, T0* a1);
/* GEANT_INPUT_TASK.validargs_attribute_name */
extern unsigned char ge110os8340;
extern T0* ge110ov8340;
extern T0* T317f7(T0* C);
/* GEANT_INPUT_COMMAND.set_default_value */
extern void T460f18(T0* C, T0* a1);
/* GEANT_INPUT_TASK.defaultvalue_attribute_name */
extern unsigned char ge110os8339;
extern T0* ge110ov8339;
extern T0* T317f6(T0* C);
/* GEANT_INPUT_COMMAND.set_message */
extern void T460f17(T0* C, T0* a1);
/* GEANT_INPUT_TASK.message_attribute_name */
extern unsigned char ge110os8338;
extern T0* ge110ov8338;
extern T0* T317f5(T0* C);
/* GEANT_INPUT_COMMAND.set_variable */
extern void T460f16(T0* C, T0* a1);
/* GEANT_INPUT_TASK.attribute_value */
extern T0* T317f12(T0* C, T0* a1);
/* GEANT_INPUT_TASK.project_variables_resolver */
extern T0* T317f19(T0* C);
/* GEANT_INPUT_TASK.has_attribute */
extern T1 T317f11(T0* C, T0* a1);
/* GEANT_INPUT_TASK.variable_attribute_name */
extern unsigned char ge110os8337;
extern T0* ge110ov8337;
extern T0* T317f14(T0* C);
/* GEANT_INPUT_TASK.make */
extern void T317f32p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_INPUT_TASK.make */
extern T0* T317f32p1ac1(T0* a1);
/* GEANT_INPUT_TASK.make_with_command */
extern void T317f34(T0* C, T0* a1, T0* a2);
/* GEANT_INPUT_TASK.interpreting_element_make */
extern void T317f37(T0* C, T0* a1, T0* a2);
/* GEANT_INPUT_TASK.set_project */
extern void T317f39(T0* C, T0* a1);
/* GEANT_INPUT_TASK.element_make */
extern void T317f38(T0* C, T0* a1);
/* GEANT_INPUT_TASK.set_xml_element */
extern void T317f40(T0* C, T0* a1);
/* GEANT_INPUT_TASK.set_command */
extern void T317f36(T0* C, T0* a1);
/* GEANT_INPUT_TASK.build_command */
extern void T317f33(T0* C, T0* a1);
/* GEANT_INPUT_COMMAND.make */
extern T0* T460c15(T0* a1);
/* GEANT_INPUT_COMMAND.set_project */
extern void T460f22(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_available_task */
extern T0* T192f48(T0* C, T0* a1);
/* GEANT_AVAILABLE_TASK.make_from_interpreting_element */
extern T0* T315c21(T0* a1);
/* Creation of agent #1 in feature GEANT_AVAILABLE_TASK.make_from_interpreting_element */
extern T0* T315f21ac1(T0* a1, T0* a2);
/* Creation of agent #2 in feature GEANT_AVAILABLE_TASK.make_from_interpreting_element */
extern T0* T315f21ac2(T0* a1, T0* a2);
/* Creation of agent #3 in feature GEANT_AVAILABLE_TASK.make_from_interpreting_element */
extern T0* T315f21ac3(T0* a1, T0* a2);
/* Creation of agent #4 in feature GEANT_AVAILABLE_TASK.make_from_interpreting_element */
extern T0* T315f21ac4(T0* a1, T0* a2);
/* GEANT_INTERPRETING_ELEMENT.attribute_value_if_existing */
extern T0* T197f5(T0* C, T0* a1);
/* GEANT_INTERPRETING_ELEMENT.has_attribute */
extern T1 T197f8(T0* C, T0* a1);
/* GEANT_INTERPRETING_ELEMENT.attribute_value */
extern T0* T197f4(T0* C, T0* a1);
/* GEANT_INTERPRETING_ELEMENT.project_variables_resolver */
extern T0* T197f7(T0* C);
/* GEANT_STRING_PROPERTY.set_string_value_agent */
extern void T387f9(T0* C, T0* a1);
/* GEANT_AVAILABLE_TASK.make_from_interpreting_element */
extern void T315f21p1(T0* C, T0* a1);
/* GEANT_AVAILABLE_TASK.make */
extern void T315f22(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_AVAILABLE_TASK.make */
extern T0* T315f22ac1(T0* a1);
/* GEANT_AVAILABLE_TASK.make_with_command */
extern void T315f24(T0* C, T0* a1, T0* a2);
/* GEANT_AVAILABLE_TASK.interpreting_element_make */
extern void T315f27(T0* C, T0* a1, T0* a2);
/* GEANT_AVAILABLE_TASK.set_project */
extern void T315f29(T0* C, T0* a1);
/* GEANT_AVAILABLE_TASK.element_make */
extern void T315f28(T0* C, T0* a1);
/* GEANT_AVAILABLE_TASK.set_xml_element */
extern void T315f30(T0* C, T0* a1);
/* GEANT_AVAILABLE_TASK.set_command */
extern void T315f26(T0* C, T0* a1);
/* GEANT_AVAILABLE_TASK.build_command */
extern void T315f23(T0* C, T0* a1);
/* GEANT_AVAILABLE_COMMAND.make */
extern T0* T457c17(T0* a1);
/* Creation of agent #1 in feature GEANT_AVAILABLE_COMMAND.make */
extern T0* T457f17ac1(T0* a1);
/* GEANT_AVAILABLE_COMMAND.is_resource_existing */
extern T1 T457f15(T0* C, T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.file_exists */
extern T1 T53f29(T0* C, T0* a1);
/* KL_TEXT_INPUT_FILE.exists */
extern T1 T55f34(T0* C);
/* KL_TEXT_INPUT_FILE.is_plain */
extern T1 T55f24(T0* C);
/* UNIX_FILE_INFO.is_plain */
extern T1 T87f7(T0* C);
/* UNIX_FILE_INFO.file_info */
extern T6 T87f5(T0* C, T14 a1, T6 a2);
/* KL_TEXT_INPUT_FILE.buffered_file_info */
extern unsigned char ge2325os3257;
extern T0* ge2325ov3257;
extern T0* T55f14(T0* C);
/* UNIX_FILE_INFO.make */
extern T0* T87c14(void);
/* UNIX_FILE_INFO.make_buffered_file_info */
extern void T87f16(T0* C, T6 a1);
/* UNIX_FILE_INFO.stat_size */
extern T6 T87f6(T0* C);
/* KL_TEXT_INPUT_FILE.set_buffer */
extern void T55f61(T0* C);
/* UNIX_FILE_INFO.update */
extern void T87f15(T0* C, T0* a1);
/* UNIX_FILE_INFO.file_stat */
extern void T87f17(T0* C, T14 a1, T14 a2);
/* KL_TEXT_INPUT_FILE.old_exists */
extern T1 T55f20(T0* C);
/* KL_TEXT_INPUT_FILE.file_exists */
extern T1 T55f13(T0* C, T14 a1);
/* KL_TEXT_INPUT_FILE.reset */
extern void T55f60(T0* C, T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.tmp_file */
extern unsigned char ge205os3841;
extern T0* ge205ov3841;
extern T0* T53f5(T0* C);
/* KL_UNIX_FILE_SYSTEM.file_exists */
extern T1 T54f26(T0* C, T0* a1);
/* KL_UNIX_FILE_SYSTEM.tmp_file */
extern T0* T54f6(T0* C);
/* GEANT_AVAILABLE_COMMAND.unix_file_system */
extern T0* T457f10(T0* C);
/* GEANT_AVAILABLE_COMMAND.file_system */
extern T0* T457f9(T0* C);
/* GEANT_AVAILABLE_COMMAND.windows_file_system */
extern T0* T457f12(T0* C);
/* GEANT_AVAILABLE_COMMAND.operating_system */
extern T0* T457f11(T0* C);
/* DS_CELL [FUNCTION [ANY, TUPLE [STRING_8], BOOLEAN]].make */
extern T0* T526c2(T0* a1);
/* GEANT_STRING_PROPERTY.make */
extern T0* T387c8(void);
/* GEANT_AVAILABLE_COMMAND.make */
extern void T457f17p1(T0* C, T0* a1);
/* GEANT_AVAILABLE_COMMAND.set_project */
extern void T457f18(T0* C, T0* a1);
/* GEANT_INTERPRETING_ELEMENT.make */
extern T0* T197c12(T0* a1, T0* a2);
/* GEANT_INTERPRETING_ELEMENT.set_project */
extern void T197f14(T0* C, T0* a1);
/* GEANT_INTERPRETING_ELEMENT.element_make */
extern void T197f13(T0* C, T0* a1);
/* GEANT_INTERPRETING_ELEMENT.set_xml_element */
extern void T197f15(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_precursor_task */
extern T0* T192f46(T0* C, T0* a1);
/* GEANT_PRECURSOR_TASK.make */
extern T0* T313c28(T0* a1, T0* a2);
/* GEANT_ARGUMENT_VARIABLES.force_last_new */
extern void T34f75(T0* C, T0* a1, T0* a2);
/* GEANT_ARGUMENT_VARIABLES.key_storage_put */
extern void T34f58(T0* C, T0* a1, T6 a2);
/* GEANT_ARGUMENT_VARIABLES.item_storage_put */
extern void T34f54(T0* C, T0* a1, T6 a2);
/* GEANT_ARGUMENT_VARIABLES.slots_put */
extern void T34f57(T0* C, T6 a1, T6 a2);
/* GEANT_ARGUMENT_VARIABLES.clashes_put */
extern void T34f56(T0* C, T6 a1, T6 a2);
/* GEANT_ARGUMENT_VARIABLES.slots_item */
extern T6 T34f29(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.hash_position */
extern T6 T34f24(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.resize */
extern void T34f55(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.clashes_resize */
extern void T34f63(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.key_storage_resize */
extern void T34f62(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.item_storage_resize */
extern void T34f61(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.key_storage_item */
extern T0* T34f28(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.clashes_item */
extern T6 T34f27(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.slots_resize */
extern void T34f60(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.new_capacity */
extern T6 T34f23(T0* C, T6 a1);
/* GEANT_DEFINE_ELEMENT.value */
extern T0* T403f5(T0* C);
/* GEANT_DEFINE_ELEMENT.value_attribute_name */
extern T0* T403f12(T0* C);
/* DS_LINKED_LIST_CURSOR [STRING_8].forth */
extern void T345f9(T0* C);
/* DS_LINKED_LIST [STRING_8].cursor_forth */
extern void T241f14(T0* C, T0* a1);
/* DS_LINKED_LIST [STRING_8].add_traversing_cursor */
extern void T241f15(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [STRING_8].set_next_cursor */
extern void T345f11(T0* C, T0* a1);
/* DS_LINKED_LIST [STRING_8].remove_traversing_cursor */
extern void T241f16(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [STRING_8].set */
extern void T345f10(T0* C, T0* a1, T1 a2, T1 a3);
/* DS_LINKED_LIST_CURSOR [STRING_8].item */
extern T0* T345f6(T0* C);
/* DS_LINKED_LIST_CURSOR [STRING_8].start */
extern void T345f8(T0* C);
/* DS_LINKED_LIST [STRING_8].cursor_start */
extern void T241f13(T0* C, T0* a1);
/* DS_LINKED_LIST [STRING_8].cursor_off */
extern T1 T241f8(T0* C, T0* a1);
/* ST_SPLITTER.split */
extern T0* T420f5(T0* C, T0* a1);
/* GEANT_PRECURSOR_TASK.arguments_string_splitter */
extern unsigned char ge59os1748;
extern T0* ge59ov1748;
extern T0* T313f8(T0* C);
/* ST_SPLITTER.make */
extern T0* T420c11(void);
/* GEANT_PRECURSOR_TASK.exit_application */
extern void T313f29(T0* C, T6 a1, T0* a2);
/* GEANT_PRECURSOR_TASK.exceptions */
extern T0* T313f11(T0* C);
/* GEANT_PRECURSOR_TASK.std */
extern T0* T313f10(T0* C);
/* GEANT_PRECURSOR_TASK.log_messages */
extern void T313f33(T0* C, T0* a1);
/* GEANT_PRECURSOR_TASK.arguments_attribute_name */
extern unsigned char ge116os8315;
extern T0* ge116ov8315;
extern T0* T313f7(T0* C);
/* GEANT_PRECURSOR_TASK.elements_by_name */
extern T0* T313f6(T0* C, T0* a1);
/* GEANT_PRECURSOR_TASK.string_ */
extern T0* T313f15(T0* C);
/* GEANT_PRECURSOR_TASK.argument_element_name */
extern unsigned char ge116os8314;
extern T0* ge116ov8314;
extern T0* T313f5(T0* C);
/* GEANT_PRECURSOR_COMMAND.set_parent */
extern void T454f9(T0* C, T0* a1);
/* GEANT_PRECURSOR_TASK.attribute_value */
extern T0* T313f12(T0* C, T0* a1);
/* GEANT_PRECURSOR_TASK.project_variables_resolver */
extern T0* T313f16(T0* C);
/* GEANT_PRECURSOR_TASK.has_attribute */
extern T1 T313f9(T0* C, T0* a1);
/* GEANT_PRECURSOR_TASK.parent_attribute_name */
extern unsigned char ge116os8313;
extern T0* ge116ov8313;
extern T0* T313f14(T0* C);
/* GEANT_PRECURSOR_TASK.make */
extern void T313f28p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_PRECURSOR_TASK.make */
extern T0* T313f28p1ac1(T0* a1);
/* GEANT_PRECURSOR_TASK.make_with_command */
extern void T313f31(T0* C, T0* a1, T0* a2);
/* GEANT_PRECURSOR_TASK.interpreting_element_make */
extern void T313f35(T0* C, T0* a1, T0* a2);
/* GEANT_PRECURSOR_TASK.set_project */
extern void T313f37(T0* C, T0* a1);
/* GEANT_PRECURSOR_TASK.element_make */
extern void T313f36(T0* C, T0* a1);
/* GEANT_PRECURSOR_TASK.set_xml_element */
extern void T313f38(T0* C, T0* a1);
/* GEANT_PRECURSOR_TASK.set_command */
extern void T313f34(T0* C, T0* a1);
/* GEANT_PRECURSOR_TASK.build_command */
extern void T313f30(T0* C, T0* a1);
/* GEANT_PRECURSOR_COMMAND.make */
extern T0* T454c8(T0* a1);
/* GEANT_PRECURSOR_COMMAND.make */
extern void T454f8p1(T0* C, T0* a1);
/* GEANT_PRECURSOR_COMMAND.set_project */
extern void T454f10(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_exit_task */
extern T0* T192f44(T0* C, T0* a1);
/* GEANT_EXIT_TASK.make */
extern T0* T311c23(T0* a1, T0* a2);
/* UC_UTF8_STRING.to_integer */
extern T6 T207f48(T0* C);
/* STRING_TO_INTEGER_CONVERTOR.parsed_integer */
extern T6 T119f13(T0* C);
/* STRING_TO_INTEGER_CONVERTOR.parse_string_with_type */
extern void T119f17(T0* C, T0* a1, T6 a2);
/* STRING_TO_INTEGER_CONVERTOR.parse_character */
extern void T119f23(T0* C, T2 a1);
/* STRING_TO_INTEGER_CONVERTOR.overflowed */
extern T1 T119f15(T0* C);
/* INTEGER_OVERFLOW_CHECKER.will_overflow */
extern T1 T214f7(T0* C, T11 a1, T11 a2, T6 a3, T6 a4);
/* NATURAL_64.is_greater */
extern T1 T11f4(T11* C, T11 a1);
/* STRING_TO_INTEGER_CONVERTOR.overflow_checker */
extern unsigned char ge2353os6081;
extern T0* ge2353ov6081;
extern T0* T119f14(T0* C);
/* INTEGER_OVERFLOW_CHECKER.make */
extern T0* T214c13(void);
/* NATURAL_64.to_natural_64 */
extern T11 T11f7(T11* C);
/* NATURAL_32.to_natural_64 */
extern T11 T10f5(T10* C);
/* NATURAL_16.to_natural_64 */
extern T11 T9f3(T9* C);
/* NATURAL_8.to_natural_64 */
extern T11 T8f8(T8* C);
/* INTEGER_64.to_natural_64 */
extern T11 T7f3(T7* C);
/* INTEGER_16.to_natural_64 */
extern T11 T5f3(T5* C);
/* INTEGER_8.to_natural_64 */
extern T11 T4f3(T4* C);
/* SPECIAL [NATURAL_64].make */
extern T0* T329c2(T6 a1);
/* STRING_8.has */
extern T1 T17f29(T0* C, T2 a1);
/* INTEGER_32.to_natural_64 */
extern T11 T6f20(T6* C);
/* CHARACTER_8.is_digit */
extern T1 T2f6(T2* C);
/* STRING_TO_INTEGER_CONVERTOR.reset */
extern void T119f18(T0* C, T6 a1);
/* UC_UTF8_STRING.ctoi_convertor */
extern unsigned char ge2345os1237;
extern T0* ge2345ov1237;
extern T0* T207f50(T0* C);
/* STRING_TO_INTEGER_CONVERTOR.set_trailing_separators_acceptable */
extern void T119f22(T0* C, T1 a1);
/* STRING_TO_INTEGER_CONVERTOR.set_leading_separators_acceptable */
extern void T119f21(T0* C, T1 a1);
/* STRING_TO_INTEGER_CONVERTOR.set_trailing_separators */
extern void T119f20(T0* C, T0* a1);
/* STRING_TO_INTEGER_CONVERTOR.set_leading_separators */
extern void T119f19(T0* C, T0* a1);
/* STRING_TO_INTEGER_CONVERTOR.make */
extern T0* T119c16(void);
/* STRING_8.to_integer */
extern T6 T17f16(T0* C);
/* STRING_8.ctoi_convertor */
extern T0* T17f22(T0* C);
/* GEANT_EXIT_COMMAND.set_code */
extern void T451f8(T0* C, T6 a1);
/* UC_UTF8_STRING.is_integer */
extern T1 T207f47(T0* C);
/* UC_UTF8_STRING.is_valid_integer_or_natural */
extern T1 T207f49(T0* C, T6 a1);
/* STRING_TO_INTEGER_CONVERTOR.is_integral_integer */
extern T1 T119f12(T0* C);
/* STRING_8.is_integer */
extern T1 T17f15(T0* C);
/* STRING_8.is_valid_integer_or_natural */
extern T1 T17f21(T0* C, T6 a1);
/* GEANT_EXIT_TASK.attribute_value */
extern T0* T311f6(T0* C, T0* a1);
/* GEANT_EXIT_TASK.project_variables_resolver */
extern T0* T311f9(T0* C);
/* GEANT_EXIT_TASK.has_attribute */
extern T1 T311f5(T0* C, T0* a1);
/* GEANT_EXIT_TASK.code_attribute_name */
extern unsigned char ge102os8304;
extern T0* ge102ov8304;
extern T0* T311f8(T0* C);
/* GEANT_EXIT_TASK.make */
extern void T311f23p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_EXIT_TASK.make */
extern T0* T311f23p1ac1(T0* a1);
/* GEANT_EXIT_TASK.make_with_command */
extern void T311f25(T0* C, T0* a1, T0* a2);
/* GEANT_EXIT_TASK.interpreting_element_make */
extern void T311f28(T0* C, T0* a1, T0* a2);
/* GEANT_EXIT_TASK.set_project */
extern void T311f30(T0* C, T0* a1);
/* GEANT_EXIT_TASK.element_make */
extern void T311f29(T0* C, T0* a1);
/* GEANT_EXIT_TASK.set_xml_element */
extern void T311f31(T0* C, T0* a1);
/* GEANT_EXIT_TASK.set_command */
extern void T311f27(T0* C, T0* a1);
/* GEANT_EXIT_TASK.build_command */
extern void T311f24(T0* C, T0* a1);
/* GEANT_EXIT_COMMAND.make */
extern T0* T451c7(T0* a1);
/* GEANT_EXIT_COMMAND.set_project */
extern void T451f9(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_outofdate_task */
extern T0* T192f42(T0* C, T0* a1);
/* GEANT_OUTOFDATE_TASK.make */
extern T0* T309c28(T0* a1, T0* a2);
/* GEANT_OUTOFDATE_COMMAND.set_fileset */
extern void T448f26(T0* C, T0* a1);
/* GEANT_OUTOFDATE_TASK.fileset_element_name */
extern unsigned char ge115os8283;
extern T0* ge115ov8283;
extern T0* T309f10(T0* C);
/* GEANT_OUTOFDATE_COMMAND.set_variable_name */
extern void T448f25(T0* C, T0* a1);
/* GEANT_OUTOFDATE_TASK.variable_attribute_name */
extern unsigned char ge115os8280;
extern T0* ge115ov8280;
extern T0* T309f8(T0* C);
/* GEANT_OUTOFDATE_TASK.false_value_attribute_name */
extern unsigned char ge115os8282;
extern T0* ge115ov8282;
extern T0* T309f7(T0* C);
/* GEANT_OUTOFDATE_COMMAND.set_false_value */
extern void T448f24(T0* C, T0* a1);
/* GEANT_OUTOFDATE_TASK.true_value_attribute_name */
extern unsigned char ge115os8281;
extern T0* ge115ov8281;
extern T0* T309f6(T0* C);
/* GEANT_OUTOFDATE_COMMAND.set_true_value */
extern void T448f23(T0* C, T0* a1);
/* GEANT_OUTOFDATE_COMMAND.set_target_filename */
extern void T448f22(T0* C, T0* a1);
/* GEANT_OUTOFDATE_TASK.target_attribute_name */
extern unsigned char ge115os8279;
extern T0* ge115ov8279;
extern T0* T309f5(T0* C);
/* GEANT_OUTOFDATE_COMMAND.set_source_filename */
extern void T448f21(T0* C, T0* a1);
/* GEANT_OUTOFDATE_TASK.attribute_value */
extern T0* T309f11(T0* C, T0* a1);
/* GEANT_OUTOFDATE_TASK.project_variables_resolver */
extern T0* T309f14(T0* C);
/* GEANT_OUTOFDATE_TASK.has_attribute */
extern T1 T309f9(T0* C, T0* a1);
/* GEANT_OUTOFDATE_TASK.source_attribute_name */
extern unsigned char ge115os8278;
extern T0* ge115ov8278;
extern T0* T309f12(T0* C);
/* GEANT_OUTOFDATE_TASK.make */
extern void T309f28p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_OUTOFDATE_TASK.make */
extern T0* T309f28p1ac1(T0* a1);
/* GEANT_OUTOFDATE_TASK.make_with_command */
extern void T309f30(T0* C, T0* a1, T0* a2);
/* GEANT_OUTOFDATE_TASK.interpreting_element_make */
extern void T309f33(T0* C, T0* a1, T0* a2);
/* GEANT_OUTOFDATE_TASK.set_project */
extern void T309f35(T0* C, T0* a1);
/* GEANT_OUTOFDATE_TASK.element_make */
extern void T309f34(T0* C, T0* a1);
/* GEANT_OUTOFDATE_TASK.set_xml_element */
extern void T309f36(T0* C, T0* a1);
/* GEANT_OUTOFDATE_TASK.set_command */
extern void T309f32(T0* C, T0* a1);
/* GEANT_OUTOFDATE_TASK.build_command */
extern void T309f29(T0* C, T0* a1);
/* GEANT_OUTOFDATE_COMMAND.make */
extern T0* T448c20(T0* a1);
/* GEANT_OUTOFDATE_COMMAND.set_project */
extern void T448f27(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_xslt_task */
extern T0* T192f40(T0* C, T0* a1);
/* GEANT_XSLT_TASK.make */
extern T0* T307c41(T0* a1, T0* a2);
/* GEANT_XSLT_COMMAND.set_classpath */
extern void T444f38(T0* C, T0* a1);
/* GEANT_XSLT_TASK.classpath_attribute_name */
extern unsigned char ge122os8238;
extern T0* ge122ov8238;
extern T0* T307f21(T0* C);
/* GEANT_XSLT_COMMAND.set_extdirs */
extern void T444f37(T0* C, T0* a1);
/* GEANT_XSLT_TASK.extdirs_attribute_name */
extern unsigned char ge122os8237;
extern T0* ge122ov8237;
extern T0* T307f20(T0* C);
/* GEANT_XSLT_COMMAND.set_format */
extern void T444f36(T0* C, T0* a1);
/* GEANT_XSLT_TASK.format_attribute_name */
extern unsigned char ge122os8235;
extern T0* ge122ov8235;
extern T0* T307f19(T0* C);
/* DS_ARRAYED_LIST [DS_PAIR [STRING_8, STRING_8]].force_last */
extern void T445f11(T0* C, T0* a1);
/* DS_ARRAYED_LIST [DS_PAIR [STRING_8, STRING_8]].resize */
extern void T445f12(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [DS_PAIR [STRING_8, STRING_8]].resize */
extern T0* T523f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [DS_PAIR [STRING_8, STRING_8]].aliased_resized_area */
extern T0* T524f2(T0* C, T6 a1);
/* DS_ARRAYED_LIST [DS_PAIR [STRING_8, STRING_8]].new_capacity */
extern T6 T445f8(T0* C, T6 a1);
/* DS_ARRAYED_LIST [DS_PAIR [STRING_8, STRING_8]].extendible */
extern T1 T445f6(T0* C, T6 a1);
/* DS_PAIR [STRING_8, STRING_8].make */
extern T0* T443c3(T0* a1, T0* a2);
/* GEANT_DEFINE_ELEMENT.has_value */
extern T1 T403f15(T0* C);
/* GEANT_XSLT_TASK.elements_by_name */
extern T0* T307f17(T0* C, T0* a1);
/* GEANT_XSLT_TASK.parameter_element_name */
extern unsigned char ge122os8239;
extern T0* ge122ov8239;
extern T0* T307f16(T0* C);
/* GEANT_XSLT_COMMAND.set_indent */
extern void T444f35(T0* C, T0* a1);
/* GEANT_XSLT_TASK.indent_attribute_name */
extern unsigned char ge122os8236;
extern T0* ge122ov8236;
extern T0* T307f15(T0* C);
/* GEANT_XSLT_COMMAND.set_force */
extern void T444f34(T0* C, T1 a1);
/* GEANT_XSLT_TASK.boolean_value */
extern T1 T307f14(T0* C, T0* a1);
/* GEANT_XSLT_TASK.std */
extern T0* T307f27(T0* C);
/* GEANT_XSLT_TASK.false_attribute_value */
extern T0* T307f26(T0* C);
/* GEANT_XSLT_TASK.true_attribute_value */
extern T0* T307f25(T0* C);
/* GEANT_XSLT_TASK.force_attribute_name */
extern unsigned char ge122os8229;
extern T0* ge122ov8229;
extern T0* T307f13(T0* C);
/* GEANT_XSLT_COMMAND.set_stylesheet_filename */
extern void T444f33(T0* C, T0* a1);
/* GEANT_XSLT_TASK.stylesheet_filename_attribute_name */
extern unsigned char ge122os8228;
extern T0* ge122ov8228;
extern T0* T307f12(T0* C);
/* GEANT_XSLT_COMMAND.set_output_filename */
extern void T444f32(T0* C, T0* a1);
/* GEANT_XSLT_TASK.output_filename_attribute_name */
extern unsigned char ge122os8227;
extern T0* ge122ov8227;
extern T0* T307f11(T0* C);
/* GEANT_XSLT_COMMAND.set_input_filename */
extern void T444f31(T0* C, T0* a1);
/* GEANT_XSLT_TASK.input_filename_attribute_name */
extern unsigned char ge122os8226;
extern T0* ge122ov8226;
extern T0* T307f10(T0* C);
/* GEANT_XSLT_COMMAND.set_processor_gexslt */
extern void T444f30(T0* C);
/* GEANT_XSLT_COMMAND.set_processor */
extern void T444f40(T0* C, T6 a1);
/* GEANT_XSLT_TASK.processor_attribute_value_gexslt */
extern unsigned char ge122os8234;
extern T0* ge122ov8234;
extern T0* T307f9(T0* C);
/* GEANT_XSLT_COMMAND.set_processor_xsltproc */
extern void T444f29(T0* C);
/* GEANT_XSLT_TASK.processor_attribute_value_xsltproc */
extern unsigned char ge122os8233;
extern T0* ge122ov8233;
extern T0* T307f8(T0* C);
/* GEANT_XSLT_COMMAND.set_processor_xalan_java */
extern void T444f28(T0* C);
/* GEANT_XSLT_TASK.processor_attribute_value_xalan_java */
extern unsigned char ge122os8232;
extern T0* ge122ov8232;
extern T0* T307f7(T0* C);
/* GEANT_XSLT_COMMAND.set_processor_xalan_cpp */
extern void T444f27(T0* C);
/* GEANT_XSLT_TASK.processor_attribute_value_xalan_cpp */
extern unsigned char ge122os8231;
extern T0* ge122ov8231;
extern T0* T307f5(T0* C);
/* GEANT_XSLT_TASK.string_ */
extern T0* T307f24(T0* C);
/* GEANT_XSLT_TASK.attribute_value */
extern T0* T307f22(T0* C, T0* a1);
/* GEANT_XSLT_TASK.project_variables_resolver */
extern T0* T307f28(T0* C);
/* GEANT_XSLT_TASK.has_attribute */
extern T1 T307f18(T0* C, T0* a1);
/* GEANT_XSLT_TASK.processor_attribute_name */
extern unsigned char ge122os8230;
extern T0* ge122ov8230;
extern T0* T307f6(T0* C);
/* GEANT_XSLT_TASK.make */
extern void T307f41p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_XSLT_TASK.make */
extern T0* T307f41p1ac1(T0* a1);
/* GEANT_XSLT_TASK.make_with_command */
extern void T307f43(T0* C, T0* a1, T0* a2);
/* GEANT_XSLT_TASK.interpreting_element_make */
extern void T307f46(T0* C, T0* a1, T0* a2);
/* GEANT_XSLT_TASK.set_project */
extern void T307f48(T0* C, T0* a1);
/* GEANT_XSLT_TASK.element_make */
extern void T307f47(T0* C, T0* a1);
/* GEANT_XSLT_TASK.set_xml_element */
extern void T307f49(T0* C, T0* a1);
/* GEANT_XSLT_TASK.set_command */
extern void T307f45(T0* C, T0* a1);
/* GEANT_XSLT_TASK.build_command */
extern void T307f42(T0* C, T0* a1);
/* GEANT_XSLT_COMMAND.make */
extern T0* T444c26(T0* a1);
/* DS_ARRAYED_LIST [DS_PAIR [STRING_8, STRING_8]].make */
extern T0* T445c10(T6 a1);
/* DS_ARRAYED_LIST [DS_PAIR [STRING_8, STRING_8]].new_cursor */
extern T0* T445f7(T0* C);
/* DS_ARRAYED_LIST_CURSOR [DS_PAIR [STRING_8, STRING_8]].make */
extern T0* T525c3(T0* a1);
/* KL_SPECIAL_ROUTINES [DS_PAIR [STRING_8, STRING_8]].make */
extern T0* T523f1(T0* C, T6 a1);
/* TO_SPECIAL [DS_PAIR [STRING_8, STRING_8]].make_area */
extern T0* T554c2(T6 a1);
/* SPECIAL [DS_PAIR [STRING_8, STRING_8]].make */
extern T0* T524c4(T6 a1);
/* KL_SPECIAL_ROUTINES [DS_PAIR [STRING_8, STRING_8]].default_create */
extern T0* T523c3(void);
/* GEANT_XSLT_COMMAND.make */
extern void T444f26p1(T0* C, T0* a1);
/* GEANT_XSLT_COMMAND.set_project */
extern void T444f39(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_setenv_task */
extern T0* T192f38(T0* C, T0* a1);
/* GEANT_SETENV_TASK.make */
extern T0* T305c24(T0* a1, T0* a2);
/* GEANT_SETENV_COMMAND.set_value */
extern void T440f11(T0* C, T0* a1);
/* GEANT_SETENV_TASK.value_attribute_name */
extern unsigned char ge118os8216;
extern T0* ge118ov8216;
extern T0* T305f5(T0* C);
/* GEANT_SETENV_COMMAND.set_name */
extern void T440f10(T0* C, T0* a1);
/* GEANT_SETENV_TASK.attribute_value */
extern T0* T305f7(T0* C, T0* a1);
/* GEANT_SETENV_TASK.project_variables_resolver */
extern T0* T305f10(T0* C);
/* GEANT_SETENV_TASK.has_attribute */
extern T1 T305f6(T0* C, T0* a1);
/* GEANT_SETENV_TASK.name_attribute_name */
extern unsigned char ge118os8215;
extern T0* ge118ov8215;
extern T0* T305f9(T0* C);
/* GEANT_SETENV_TASK.make */
extern void T305f24p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_SETENV_TASK.make */
extern T0* T305f24p1ac1(T0* a1);
/* GEANT_SETENV_TASK.make_with_command */
extern void T305f26(T0* C, T0* a1, T0* a2);
/* GEANT_SETENV_TASK.interpreting_element_make */
extern void T305f29(T0* C, T0* a1, T0* a2);
/* GEANT_SETENV_TASK.set_project */
extern void T305f31(T0* C, T0* a1);
/* GEANT_SETENV_TASK.element_make */
extern void T305f30(T0* C, T0* a1);
/* GEANT_SETENV_TASK.set_xml_element */
extern void T305f32(T0* C, T0* a1);
/* GEANT_SETENV_TASK.set_command */
extern void T305f28(T0* C, T0* a1);
/* GEANT_SETENV_TASK.build_command */
extern void T305f25(T0* C, T0* a1);
/* GEANT_SETENV_COMMAND.make */
extern T0* T440c9(T0* a1);
/* GEANT_SETENV_COMMAND.set_project */
extern void T440f12(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_move_task */
extern T0* T192f36(T0* C, T0* a1);
/* GEANT_MOVE_TASK.make */
extern T0* T303c26(T0* a1, T0* a2);
/* GEANT_MOVE_COMMAND.set_fileset */
extern void T437f21(T0* C, T0* a1);
/* GEANT_MOVE_TASK.fileset_element_name */
extern unsigned char ge114os8197;
extern T0* ge114ov8197;
extern T0* T303f8(T0* C);
/* GEANT_MOVE_COMMAND.set_to_directory */
extern void T437f20(T0* C, T0* a1);
/* GEANT_MOVE_TASK.to_directory_attribute_name */
extern unsigned char ge114os8196;
extern T0* ge114ov8196;
extern T0* T303f6(T0* C);
/* GEANT_MOVE_COMMAND.set_to_file */
extern void T437f19(T0* C, T0* a1);
/* GEANT_MOVE_TASK.to_file_attribute_name */
extern unsigned char ge114os8195;
extern T0* ge114ov8195;
extern T0* T303f5(T0* C);
/* GEANT_MOVE_COMMAND.set_file */
extern void T437f18(T0* C, T0* a1);
/* GEANT_MOVE_TASK.attribute_value */
extern T0* T303f9(T0* C, T0* a1);
/* GEANT_MOVE_TASK.project_variables_resolver */
extern T0* T303f12(T0* C);
/* GEANT_MOVE_TASK.has_attribute */
extern T1 T303f7(T0* C, T0* a1);
/* GEANT_MOVE_TASK.file_attribute_name */
extern unsigned char ge114os8194;
extern T0* ge114ov8194;
extern T0* T303f10(T0* C);
/* GEANT_MOVE_TASK.make */
extern void T303f26p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_MOVE_TASK.make */
extern T0* T303f26p1ac1(T0* a1);
/* GEANT_MOVE_TASK.make_with_command */
extern void T303f28(T0* C, T0* a1, T0* a2);
/* GEANT_MOVE_TASK.interpreting_element_make */
extern void T303f31(T0* C, T0* a1, T0* a2);
/* GEANT_MOVE_TASK.set_project */
extern void T303f33(T0* C, T0* a1);
/* GEANT_MOVE_TASK.element_make */
extern void T303f32(T0* C, T0* a1);
/* GEANT_MOVE_TASK.set_xml_element */
extern void T303f34(T0* C, T0* a1);
/* GEANT_MOVE_TASK.set_command */
extern void T303f30(T0* C, T0* a1);
/* GEANT_MOVE_TASK.build_command */
extern void T303f27(T0* C, T0* a1);
/* GEANT_MOVE_COMMAND.make */
extern T0* T437c17(T0* a1);
/* GEANT_MOVE_COMMAND.set_project */
extern void T437f22(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_copy_task */
extern T0* T192f34(T0* C, T0* a1);
/* GEANT_COPY_TASK.make */
extern T0* T301c31(T0* a1, T0* a2);
/* GEANT_COPY_COMMAND.set_fileset */
extern void T434f25(T0* C, T0* a1);
/* GEANT_COPY_TASK.fileset_element_name */
extern unsigned char ge98os8174;
extern T0* ge98ov8174;
extern T0* T301f10(T0* C);
/* GEANT_COPY_COMMAND.set_force */
extern void T434f24(T0* C, T1 a1);
/* GEANT_COPY_TASK.boolean_value */
extern T1 T301f8(T0* C, T0* a1);
/* GEANT_COPY_TASK.std */
extern T0* T301f17(T0* C);
/* GEANT_COPY_TASK.false_attribute_value */
extern T0* T301f16(T0* C);
/* GEANT_COPY_TASK.true_attribute_value */
extern T0* T301f15(T0* C);
/* GEANT_COPY_TASK.string_ */
extern T0* T301f14(T0* C);
/* GEANT_COPY_TASK.force_attribute_name */
extern unsigned char ge98os8173;
extern T0* ge98ov8173;
extern T0* T301f7(T0* C);
/* GEANT_COPY_COMMAND.set_to_directory */
extern void T434f23(T0* C, T0* a1);
/* GEANT_COPY_TASK.to_directory_attribute_name */
extern unsigned char ge98os8172;
extern T0* ge98ov8172;
extern T0* T301f6(T0* C);
/* GEANT_COPY_COMMAND.set_to_file */
extern void T434f22(T0* C, T0* a1);
/* GEANT_COPY_TASK.to_file_attribute_name */
extern unsigned char ge98os8171;
extern T0* ge98ov8171;
extern T0* T301f5(T0* C);
/* GEANT_COPY_COMMAND.set_file */
extern void T434f21(T0* C, T0* a1);
/* GEANT_COPY_TASK.attribute_value */
extern T0* T301f11(T0* C, T0* a1);
/* GEANT_COPY_TASK.project_variables_resolver */
extern T0* T301f18(T0* C);
/* GEANT_COPY_TASK.has_attribute */
extern T1 T301f9(T0* C, T0* a1);
/* GEANT_COPY_TASK.file_attribute_name */
extern unsigned char ge98os8170;
extern T0* ge98ov8170;
extern T0* T301f12(T0* C);
/* GEANT_COPY_TASK.make */
extern void T301f31p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_COPY_TASK.make */
extern T0* T301f31p1ac1(T0* a1);
/* GEANT_COPY_TASK.make_with_command */
extern void T301f33(T0* C, T0* a1, T0* a2);
/* GEANT_COPY_TASK.interpreting_element_make */
extern void T301f36(T0* C, T0* a1, T0* a2);
/* GEANT_COPY_TASK.set_project */
extern void T301f38(T0* C, T0* a1);
/* GEANT_COPY_TASK.element_make */
extern void T301f37(T0* C, T0* a1);
/* GEANT_COPY_TASK.set_xml_element */
extern void T301f39(T0* C, T0* a1);
/* GEANT_COPY_TASK.set_command */
extern void T301f35(T0* C, T0* a1);
/* GEANT_COPY_TASK.build_command */
extern void T301f32(T0* C, T0* a1);
/* GEANT_COPY_COMMAND.make */
extern T0* T434c20(T0* a1);
/* GEANT_COPY_COMMAND.set_project */
extern void T434f26(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_delete_task */
extern T0* T192f32(T0* C, T0* a1);
/* GEANT_DELETE_TASK.make */
extern T0* T299c26(T0* a1, T0* a2);
/* GEANT_DELETE_COMMAND.set_directoryset */
extern void T430f23(T0* C, T0* a1);
/* GEANT_DIRECTORYSET_ELEMENT.make */
extern T0* T429c20(T0* a1, T0* a2);
/* GEANT_DIRECTORYSET.add_single_exclude */
extern void T431f27(T0* C, T0* a1);
/* GEANT_DIRECTORYSET_ELEMENT.exclude_element_name */
extern unsigned char ge126os8872;
extern T0* ge126ov8872;
extern T0* T429f12(T0* C);
/* GEANT_DIRECTORYSET.add_single_include */
extern void T431f26(T0* C, T0* a1);
/* GEANT_DIRECTORYSET_ELEMENT.elements_by_name */
extern T0* T429f11(T0* C, T0* a1);
/* GEANT_DIRECTORYSET_ELEMENT.string_ */
extern T0* T429f16(T0* C);
/* GEANT_DIRECTORYSET_ELEMENT.include_element_name */
extern unsigned char ge126os8871;
extern T0* ge126ov8871;
extern T0* T429f10(T0* C);
/* GEANT_DIRECTORYSET.set_concat */
extern void T431f25(T0* C, T1 a1);
/* GEANT_DIRECTORYSET_ELEMENT.boolean_value */
extern T1 T429f9(T0* C, T0* a1);
/* GEANT_DIRECTORYSET_ELEMENT.std */
extern T0* T429f19(T0* C);
/* GEANT_DIRECTORYSET_ELEMENT.false_attribute_value */
extern T0* T429f18(T0* C);
/* GEANT_DIRECTORYSET_ELEMENT.true_attribute_value */
extern T0* T429f17(T0* C);
/* GEANT_DIRECTORYSET_ELEMENT.concat_attribute_name */
extern unsigned char ge126os8870;
extern T0* ge126ov8870;
extern T0* T429f8(T0* C);
/* GEANT_DIRECTORYSET.set_exclude_wc_string */
extern void T431f24(T0* C, T0* a1);
/* GEANT_DIRECTORYSET_ELEMENT.exclude_attribute_name */
extern unsigned char ge126os8869;
extern T0* ge126ov8869;
extern T0* T429f7(T0* C);
/* GEANT_DIRECTORYSET.set_include_wc_string */
extern void T431f23(T0* C, T0* a1);
/* GEANT_DIRECTORYSET_ELEMENT.include_attribute_name */
extern unsigned char ge126os8868;
extern T0* ge126ov8868;
extern T0* T429f6(T0* C);
/* GEANT_DIRECTORYSET.set_directory_name */
extern void T431f22(T0* C, T0* a1);
/* GEANT_DIRECTORYSET_ELEMENT.attribute_value */
extern T0* T429f5(T0* C, T0* a1);
/* GEANT_DIRECTORYSET_ELEMENT.project_variables_resolver */
extern T0* T429f15(T0* C);
/* GEANT_DIRECTORYSET_ELEMENT.has_attribute */
extern T1 T429f14(T0* C, T0* a1);
/* GEANT_DIRECTORYSET_ELEMENT.directory_attribute_name */
extern unsigned char ge126os8867;
extern T0* ge126ov8867;
extern T0* T429f13(T0* C);
/* GEANT_DIRECTORYSET.make */
extern T0* T431c21(T0* a1);
/* GEANT_DIRECTORYSET.set_directory_name_variable_name */
extern void T431f28(T0* C, T0* a1);
/* GEANT_DIRECTORYSET_ELEMENT.make */
extern void T429f20p1(T0* C, T0* a1, T0* a2);
/* GEANT_DIRECTORYSET_ELEMENT.set_project */
extern void T429f22(T0* C, T0* a1);
/* GEANT_DIRECTORYSET_ELEMENT.element_make */
extern void T429f21(T0* C, T0* a1);
/* GEANT_DIRECTORYSET_ELEMENT.set_xml_element */
extern void T429f23(T0* C, T0* a1);
/* GEANT_DELETE_TASK.directoryset_element_name */
extern unsigned char ge99os8152;
extern T0* ge99ov8152;
extern T0* T299f9(T0* C);
/* GEANT_DELETE_COMMAND.set_fileset */
extern void T430f22(T0* C, T0* a1);
/* GEANT_DELETE_TASK.fileset_element_name */
extern unsigned char ge99os8151;
extern T0* ge99ov8151;
extern T0* T299f7(T0* C);
/* GEANT_DELETE_COMMAND.set_file */
extern void T430f21(T0* C, T0* a1);
/* GEANT_DELETE_TASK.file_attribute_name */
extern unsigned char ge99os8150;
extern T0* ge99ov8150;
extern T0* T299f5(T0* C);
/* GEANT_DELETE_COMMAND.set_directory */
extern void T430f20(T0* C, T0* a1);
/* GEANT_DELETE_TASK.attribute_value */
extern T0* T299f8(T0* C, T0* a1);
/* GEANT_DELETE_TASK.project_variables_resolver */
extern T0* T299f12(T0* C);
/* GEANT_DELETE_TASK.has_attribute */
extern T1 T299f6(T0* C, T0* a1);
/* GEANT_DELETE_TASK.directory_attribute_name */
extern unsigned char ge99os8149;
extern T0* ge99ov8149;
extern T0* T299f10(T0* C);
/* GEANT_DELETE_TASK.make */
extern void T299f26p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_DELETE_TASK.make */
extern T0* T299f26p1ac1(T0* a1);
/* GEANT_DELETE_TASK.make_with_command */
extern void T299f28(T0* C, T0* a1, T0* a2);
/* GEANT_DELETE_TASK.interpreting_element_make */
extern void T299f31(T0* C, T0* a1, T0* a2);
/* GEANT_DELETE_TASK.set_project */
extern void T299f33(T0* C, T0* a1);
/* GEANT_DELETE_TASK.element_make */
extern void T299f32(T0* C, T0* a1);
/* GEANT_DELETE_TASK.set_xml_element */
extern void T299f34(T0* C, T0* a1);
/* GEANT_DELETE_TASK.set_command */
extern void T299f30(T0* C, T0* a1);
/* GEANT_DELETE_TASK.build_command */
extern void T299f27(T0* C, T0* a1);
/* GEANT_DELETE_COMMAND.make */
extern T0* T430c19(T0* a1);
/* GEANT_DELETE_COMMAND.set_project */
extern void T430f24(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_mkdir_task */
extern T0* T192f30(T0* C, T0* a1);
/* GEANT_MKDIR_TASK.make_from_interpreting_element */
extern T0* T297c21(T0* a1);
/* Creation of agent #1 in feature GEANT_MKDIR_TASK.make_from_interpreting_element */
extern T0* T297f21ac1(T0* a1, T0* a2);
/* GEANT_MKDIR_TASK.make_from_interpreting_element */
extern void T297f21p1(T0* C, T0* a1);
/* GEANT_MKDIR_TASK.make */
extern void T297f22(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_MKDIR_TASK.make */
extern T0* T297f22ac1(T0* a1);
/* GEANT_MKDIR_TASK.make_with_command */
extern void T297f24(T0* C, T0* a1, T0* a2);
/* GEANT_MKDIR_TASK.interpreting_element_make */
extern void T297f27(T0* C, T0* a1, T0* a2);
/* GEANT_MKDIR_TASK.set_project */
extern void T297f29(T0* C, T0* a1);
/* GEANT_MKDIR_TASK.element_make */
extern void T297f28(T0* C, T0* a1);
/* GEANT_MKDIR_TASK.set_xml_element */
extern void T297f30(T0* C, T0* a1);
/* GEANT_MKDIR_TASK.set_command */
extern void T297f26(T0* C, T0* a1);
/* GEANT_MKDIR_TASK.build_command */
extern void T297f23(T0* C, T0* a1);
/* GEANT_MKDIR_COMMAND.make */
extern T0* T426c13(T0* a1);
/* Creation of agent #1 in feature GEANT_MKDIR_COMMAND.make */
extern T0* T426f13ac1(T0* a1);
/* GEANT_MKDIR_COMMAND.create_directory */
extern void T426f14(T0* C, T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.recursive_create_directory */
extern void T53f38(T0* C, T0* a1);
/* KL_DIRECTORY.recursive_create_directory */
extern void T490f41(T0* C);
/* KL_UNIX_FILE_SYSTEM.canonical_pathname */
extern T0* T54f28(T0* C, T0* a1);
/* KL_PATHNAME.set_canonical */
extern void T86f18(T0* C);
/* KL_WINDOWS_FILE_SYSTEM.canonical_pathname */
extern T0* T53f34(T0* C, T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.string_to_pathname */
extern T0* T53f35(T0* C, T0* a1);
/* KL_PATHNAME.set_drive */
extern void T86f21(T0* C, T0* a1);
/* KL_PATHNAME.set_sharename */
extern void T86f20(T0* C, T0* a1);
/* KL_PATHNAME.set_hostname */
extern void T86f19(T0* C, T0* a1);
/* KL_DIRECTORY.file_system */
extern T0* T490f16(T0* C);
/* KL_DIRECTORY.unix_file_system */
extern T0* T490f26(T0* C);
/* KL_DIRECTORY.windows_file_system */
extern T0* T490f25(T0* C);
/* KL_DIRECTORY.operating_system */
extern T0* T490f24(T0* C);
/* KL_DIRECTORY.create_directory */
extern void T490f45(T0* C);
/* KL_DIRECTORY.create_dir */
extern void T490f48(T0* C);
/* KL_DIRECTORY.file_mkdir */
extern void T490f49(T0* C, T14 a1);
/* KL_UNIX_FILE_SYSTEM.recursive_create_directory */
extern void T54f34(T0* C, T0* a1);
/* GEANT_MKDIR_COMMAND.unix_file_system */
extern T0* T426f7(T0* C);
/* GEANT_MKDIR_COMMAND.file_system */
extern T0* T426f6(T0* C);
/* GEANT_MKDIR_COMMAND.windows_file_system */
extern T0* T426f9(T0* C);
/* GEANT_MKDIR_COMMAND.operating_system */
extern T0* T426f8(T0* C);
/* DS_CELL [PROCEDURE [ANY, TUPLE [STRING_8]]].make */
extern T0* T511c2(T0* a1);
/* GEANT_MKDIR_COMMAND.make */
extern void T426f13p1(T0* C, T0* a1);
/* GEANT_MKDIR_COMMAND.set_project */
extern void T426f15(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_echo_task */
extern T0* T192f28(T0* C, T0* a1);
/* GEANT_ECHO_TASK.make_from_interpreting_element */
extern T0* T295c21(T0* a1);
/* Creation of agent #1 in feature GEANT_ECHO_TASK.make_from_interpreting_element */
extern T0* T295f21ac1(T0* a1, T0* a2);
/* Creation of agent #2 in feature GEANT_ECHO_TASK.make_from_interpreting_element */
extern T0* T295f21ac2(T0* a1, T0* a2);
/* Creation of agent #3 in feature GEANT_ECHO_TASK.make_from_interpreting_element */
extern T0* T295f21ac3(T0* a1, T0* a2);
/* GEANT_INTERPRETING_ELEMENT.attribute_or_content_value */
extern T0* T197f6(T0* C, T0* a1);
/* GEANT_INTERPRETING_ELEMENT.exit_application */
extern void T197f17(T0* C, T6 a1, T0* a2);
/* GEANT_INTERPRETING_ELEMENT.exceptions */
extern T0* T197f11(T0* C);
/* GEANT_INTERPRETING_ELEMENT.std */
extern T0* T197f10(T0* C);
/* GEANT_INTERPRETING_ELEMENT.log_messages */
extern void T197f16(T0* C, T0* a1);
/* GEANT_INTERPRETING_ELEMENT.content */
extern T0* T197f9(T0* C);
/* GEANT_BOOLEAN_PROPERTY.set_string_value_agent */
extern void T390f13(T0* C, T0* a1);
/* GEANT_ECHO_TASK.make_from_interpreting_element */
extern void T295f21p1(T0* C, T0* a1);
/* GEANT_ECHO_TASK.make */
extern void T295f22(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_ECHO_TASK.make */
extern T0* T295f22ac1(T0* a1);
/* GEANT_ECHO_TASK.make_with_command */
extern void T295f24(T0* C, T0* a1, T0* a2);
/* GEANT_ECHO_TASK.interpreting_element_make */
extern void T295f27(T0* C, T0* a1, T0* a2);
/* GEANT_ECHO_TASK.set_project */
extern void T295f29(T0* C, T0* a1);
/* GEANT_ECHO_TASK.element_make */
extern void T295f28(T0* C, T0* a1);
/* GEANT_ECHO_TASK.set_xml_element */
extern void T295f30(T0* C, T0* a1);
/* GEANT_ECHO_TASK.set_command */
extern void T295f26(T0* C, T0* a1);
/* GEANT_ECHO_TASK.build_command */
extern void T295f23(T0* C, T0* a1);
/* GEANT_ECHO_COMMAND.make */
extern T0* T423c12(T0* a1);
/* Creation of agent #1 in feature GEANT_ECHO_COMMAND.make */
extern T0* T423f12ac1(T0* a1);
/* Creation of agent #2 in feature GEANT_ECHO_COMMAND.make */
extern T0* T423f12ac2(T0* a1);
/* GEANT_ECHO_COMMAND.write_message_to_file */
extern void T423f14(T0* C, T0* a1, T0* a2, T1 a3);
/* KL_TEXT_OUTPUT_FILE.put_line */
extern void T517f24(T0* C, T0* a1);
/* KL_TEXT_OUTPUT_FILE.put_new_line */
extern void T517f31(T0* C);
/* KL_TEXT_OUTPUT_FILE.put_string */
extern void T517f30(T0* C, T0* a1);
/* KL_TEXT_OUTPUT_FILE.old_put_string */
extern void T517f33(T0* C, T0* a1);
/* KL_TEXT_OUTPUT_FILE.file_ps */
extern void T517f34(T0* C, T14 a1, T14 a2, T6 a3);
/* KL_TEXT_OUTPUT_FILE.string_ */
extern T0* T517f9(T0* C);
/* KL_TEXT_OUTPUT_FILE.is_open_write */
extern T1 T517f15(T0* C);
/* KL_TEXT_OUTPUT_FILE.old_is_open_write */
extern T1 T517f12(T0* C);
/* GEANT_ECHO_COMMAND.write_message */
extern void T423f13(T0* C, T0* a1);
/* DS_CELL [PROCEDURE [ANY, TUPLE [STRING_8, KL_TEXT_OUTPUT_FILE, BOOLEAN]]].make */
extern T0* T516c2(T0* a1);
/* GEANT_BOOLEAN_PROPERTY.make */
extern T0* T390c12(void);
/* GEANT_ECHO_COMMAND.make */
extern void T423f12p1(T0* C, T0* a1);
/* GEANT_ECHO_COMMAND.set_project */
extern void T423f15(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_geant_task */
extern T0* T192f26(T0* C, T0* a1);
/* GEANT_GEANT_TASK.make */
extern T0* T293c36(T0* a1, T0* a2);
/* GEANT_GEANT_TASK.arguments_string_splitter */
extern T0* T293f16(T0* C);
/* GEANT_GEANT_TASK.exit_application */
extern void T293f37(T0* C, T6 a1, T0* a2);
/* GEANT_GEANT_TASK.exceptions */
extern T0* T293f18(T0* C);
/* GEANT_GEANT_TASK.std */
extern T0* T293f17(T0* C);
/* GEANT_GEANT_TASK.log_messages */
extern void T293f41(T0* C, T0* a1);
/* GEANT_GEANT_TASK.arguments_attribute_name */
extern unsigned char ge103os8097;
extern T0* ge103ov8097;
extern T0* T293f15(T0* C);
/* GEANT_GEANT_TASK.elements_by_name */
extern T0* T293f14(T0* C, T0* a1);
/* GEANT_GEANT_TASK.string_ */
extern T0* T293f21(T0* C);
/* GEANT_GEANT_TASK.argument_element_name */
extern unsigned char ge103os8096;
extern T0* ge103ov8096;
extern T0* T293f13(T0* C);
/* GEANT_GEANT_COMMAND.set_exit_code_variable_name */
extern void T419f32(T0* C, T0* a1);
/* GEANT_GEANT_TASK.exit_code_variable_attribute_name */
extern unsigned char ge103os8098;
extern T0* ge103ov8098;
extern T0* T293f12(T0* C);
/* GEANT_GEANT_TASK.fork_attribute_name */
extern unsigned char ge103os8094;
extern T0* ge103ov8094;
extern T0* T293f11(T0* C);
/* GEANT_GEANT_COMMAND.set_fileset */
extern void T419f31(T0* C, T0* a1);
/* GEANT_GEANT_TASK.fileset_element_name */
extern unsigned char ge103os8095;
extern T0* ge103ov8095;
extern T0* T293f9(T0* C);
/* GEANT_GEANT_COMMAND.set_fork */
extern void T419f30(T0* C, T1 a1);
/* GEANT_GEANT_COMMAND.set_filename */
extern void T419f29(T0* C, T0* a1);
/* GEANT_GEANT_TASK.filename_attribute_name */
extern unsigned char ge103os8091;
extern T0* ge103ov8091;
extern T0* T293f7(T0* C);
/* GEANT_GEANT_COMMAND.set_reuse_variables */
extern void T419f28(T0* C, T1 a1);
/* GEANT_GEANT_TASK.boolean_value */
extern T1 T293f6(T0* C, T0* a1);
/* GEANT_GEANT_TASK.false_attribute_value */
extern T0* T293f23(T0* C);
/* GEANT_GEANT_TASK.true_attribute_value */
extern T0* T293f22(T0* C);
/* GEANT_GEANT_TASK.reuse_variables_attribute_name */
extern unsigned char ge103os8093;
extern T0* ge103ov8093;
extern T0* T293f5(T0* C);
/* GEANT_GEANT_COMMAND.set_start_target_name */
extern void T419f27(T0* C, T0* a1);
/* GEANT_GEANT_TASK.attribute_value */
extern T0* T293f10(T0* C, T0* a1);
/* GEANT_GEANT_TASK.project_variables_resolver */
extern T0* T293f24(T0* C);
/* GEANT_GEANT_TASK.has_attribute */
extern T1 T293f8(T0* C, T0* a1);
/* GEANT_GEANT_TASK.start_target_attribute_name */
extern unsigned char ge103os8092;
extern T0* ge103ov8092;
extern T0* T293f19(T0* C);
/* GEANT_GEANT_TASK.make */
extern void T293f36p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_GEANT_TASK.make */
extern T0* T293f36p1ac1(T0* a1);
/* GEANT_GEANT_TASK.make_with_command */
extern void T293f39(T0* C, T0* a1, T0* a2);
/* GEANT_GEANT_TASK.interpreting_element_make */
extern void T293f43(T0* C, T0* a1, T0* a2);
/* GEANT_GEANT_TASK.set_project */
extern void T293f45(T0* C, T0* a1);
/* GEANT_GEANT_TASK.element_make */
extern void T293f44(T0* C, T0* a1);
/* GEANT_GEANT_TASK.set_xml_element */
extern void T293f46(T0* C, T0* a1);
/* GEANT_GEANT_TASK.set_command */
extern void T293f42(T0* C, T0* a1);
/* GEANT_GEANT_TASK.build_command */
extern void T293f38(T0* C, T0* a1);
/* GEANT_GEANT_COMMAND.make */
extern T0* T419c26(T0* a1);
/* GEANT_GEANT_COMMAND.make */
extern void T419f26p1(T0* C, T0* a1);
/* GEANT_GEANT_COMMAND.set_project */
extern void T419f33(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_getest_task */
extern T0* T192f24(T0* C, T0* a1);
/* GEANT_GETEST_TASK.make */
extern T0* T291c39(T0* a1, T0* a2);
/* DS_HASH_TABLE [STRING_8, STRING_8].force */
extern void T81f55(T0* C, T0* a1, T0* a2);
/* DS_HASH_TABLE [STRING_8, STRING_8].key_storage_put */
extern void T81f64(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [STRING_8, STRING_8].slots_put */
extern void T81f63(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [STRING_8, STRING_8].clashes_put */
extern void T81f62(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [STRING_8, STRING_8].slots_item */
extern T6 T81f34(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].clashes_item */
extern T6 T81f37(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].hash_position */
extern T6 T81f32(T0* C, T0* a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].resize */
extern void T81f61(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].clashes_resize */
extern void T81f70(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].key_storage_resize */
extern void T81f69(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].item_storage_resize */
extern void T81f68(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].key_storage_item */
extern T0* T81f30(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].slots_resize */
extern void T81f67(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].new_capacity */
extern T6 T81f31(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].item_storage_put */
extern void T81f60(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [STRING_8, STRING_8].search_position */
extern void T81f59(T0* C, T0* a1);
/* GEANT_GETEST_TASK.define_element_name */
extern unsigned char ge107os8062;
extern T0* ge107ov8062;
extern T0* T291f20(T0* C);
/* GEANT_GETEST_TASK.true_attribute_value */
extern T0* T291f19(T0* C);
/* GEANT_GETEST_TASK.string_ */
extern T0* T291f18(T0* C);
/* GEANT_GETEST_TASK.elements_by_name */
extern T0* T291f16(T0* C, T0* a1);
/* GEANT_GETEST_TASK.attribute_element_name */
extern unsigned char ge107os8061;
extern T0* ge107ov8061;
extern T0* T291f15(T0* C);
/* GEANT_GETEST_COMMAND.set_abort */
extern void T416f32(T0* C, T1 a1);
/* GEANT_GETEST_TASK.abort_attribute_name */
extern unsigned char ge107os8060;
extern T0* ge107ov8060;
extern T0* T291f14(T0* C);
/* GEANT_GETEST_COMMAND.set_execution */
extern void T416f31(T0* C, T1 a1);
/* GEANT_GETEST_TASK.execution_attribute_name */
extern unsigned char ge107os8059;
extern T0* ge107ov8059;
extern T0* T291f13(T0* C);
/* GEANT_GETEST_COMMAND.set_compilation */
extern void T416f30(T0* C, T1 a1);
/* GEANT_GETEST_TASK.compilation_attribute_name */
extern unsigned char ge107os8058;
extern T0* ge107ov8058;
extern T0* T291f12(T0* C);
/* GEANT_GETEST_COMMAND.set_generation */
extern void T416f29(T0* C, T1 a1);
/* GEANT_GETEST_TASK.generation_attribute_name */
extern unsigned char ge107os8057;
extern T0* ge107ov8057;
extern T0* T291f11(T0* C);
/* GEANT_GETEST_COMMAND.set_default_test_included */
extern void T416f28(T0* C, T1 a1);
/* GEANT_GETEST_TASK.default_test_attribute_name */
extern unsigned char ge107os8056;
extern T0* ge107ov8056;
extern T0* T291f10(T0* C);
/* GEANT_GETEST_COMMAND.set_feature_regexp */
extern void T416f27(T0* C, T0* a1);
/* GEANT_GETEST_TASK.feature_attribute_name */
extern unsigned char ge107os8055;
extern T0* ge107ov8055;
extern T0* T291f9(T0* C);
/* GEANT_GETEST_COMMAND.set_class_regexp */
extern void T416f26(T0* C, T0* a1);
/* GEANT_GETEST_TASK.class_attribute_name */
extern unsigned char ge107os8054;
extern T0* ge107ov8054;
extern T0* T291f8(T0* C);
/* GEANT_GETEST_COMMAND.set_compile */
extern void T416f25(T0* C, T0* a1);
/* GEANT_GETEST_TASK.compile_attribute_name */
extern unsigned char ge107os8053;
extern T0* ge107ov8053;
extern T0* T291f7(T0* C);
/* GEANT_GETEST_COMMAND.set_config_filename */
extern void T416f24(T0* C, T0* a1);
/* GEANT_GETEST_TASK.attribute_value */
extern T0* T291f6(T0* C, T0* a1);
/* GEANT_GETEST_TASK.project_variables_resolver */
extern T0* T291f24(T0* C);
/* GEANT_GETEST_TASK.config_filename_attribute_name */
extern unsigned char ge107os8052;
extern T0* ge107ov8052;
extern T0* T291f5(T0* C);
/* GEANT_GETEST_COMMAND.set_verbose */
extern void T416f23(T0* C, T1 a1);
/* GEANT_GETEST_TASK.boolean_value */
extern T1 T291f23(T0* C, T0* a1);
/* GEANT_GETEST_TASK.std */
extern T0* T291f26(T0* C);
/* GEANT_GETEST_TASK.false_attribute_value */
extern T0* T291f25(T0* C);
/* GEANT_GETEST_TASK.has_attribute */
extern T1 T291f17(T0* C, T0* a1);
/* GEANT_GETEST_TASK.verbose_attribute_name */
extern unsigned char ge107os8051;
extern T0* ge107ov8051;
extern T0* T291f21(T0* C);
/* GEANT_GETEST_TASK.make */
extern void T291f39p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_GETEST_TASK.make */
extern T0* T291f39p1ac1(T0* a1);
/* GEANT_GETEST_TASK.make_with_command */
extern void T291f41(T0* C, T0* a1, T0* a2);
/* GEANT_GETEST_TASK.interpreting_element_make */
extern void T291f44(T0* C, T0* a1, T0* a2);
/* GEANT_GETEST_TASK.set_project */
extern void T291f46(T0* C, T0* a1);
/* GEANT_GETEST_TASK.element_make */
extern void T291f45(T0* C, T0* a1);
/* GEANT_GETEST_TASK.set_xml_element */
extern void T291f47(T0* C, T0* a1);
/* GEANT_GETEST_TASK.set_command */
extern void T291f43(T0* C, T0* a1);
/* GEANT_GETEST_TASK.build_command */
extern void T291f40(T0* C, T0* a1);
/* GEANT_GETEST_COMMAND.make */
extern T0* T416c22(T0* a1);
/* GEANT_GETEST_COMMAND.make */
extern void T416f22p1(T0* C, T0* a1);
/* GEANT_GETEST_COMMAND.set_project */
extern void T416f33(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_gepp_task */
extern T0* T192f22(T0* C, T0* a1);
/* GEANT_GEPP_TASK.make */
extern T0* T289c34(T0* a1, T0* a2);
/* GEANT_GEPP_COMMAND.set_fileset */
extern void T413f27(T0* C, T0* a1);
/* GEANT_GEPP_TASK.fileset_element_name */
extern unsigned char ge106os8026;
extern T0* ge106ov8026;
extern T0* T289f14(T0* C);
/* GEANT_GEPP_COMMAND.set_force */
extern void T413f26(T0* C, T1 a1);
/* GEANT_GEPP_TASK.force_attribute_name */
extern unsigned char ge106os8025;
extern T0* ge106ov8025;
extern T0* T289f12(T0* C);
/* GEANT_GEPP_COMMAND.set_to_directory */
extern void T413f25(T0* C, T0* a1);
/* GEANT_GEPP_TASK.to_directory_attribute_name */
extern unsigned char ge106os8024;
extern T0* ge106ov8024;
extern T0* T289f11(T0* C);
/* GEANT_GEPP_TASK.elements_by_name */
extern T0* T289f9(T0* C, T0* a1);
/* GEANT_GEPP_TASK.string_ */
extern T0* T289f17(T0* C);
/* GEANT_GEPP_TASK.define_element_name */
extern unsigned char ge106os8023;
extern T0* ge106ov8023;
extern T0* T289f8(T0* C);
/* GEANT_GEPP_COMMAND.set_empty_lines */
extern void T413f24(T0* C, T1 a1);
/* GEANT_GEPP_TASK.boolean_value */
extern T1 T289f7(T0* C, T0* a1);
/* GEANT_GEPP_TASK.std */
extern T0* T289f20(T0* C);
/* GEANT_GEPP_TASK.false_attribute_value */
extern T0* T289f19(T0* C);
/* GEANT_GEPP_TASK.true_attribute_value */
extern T0* T289f18(T0* C);
/* GEANT_GEPP_TASK.lines_attribute_name */
extern unsigned char ge106os8022;
extern T0* ge106ov8022;
extern T0* T289f6(T0* C);
/* GEANT_GEPP_COMMAND.set_output_filename */
extern void T413f23(T0* C, T0* a1);
/* GEANT_GEPP_TASK.output_filename_attribute_name */
extern unsigned char ge106os8021;
extern T0* ge106ov8021;
extern T0* T289f5(T0* C);
/* GEANT_GEPP_COMMAND.set_input_filename */
extern void T413f22(T0* C, T0* a1);
/* GEANT_GEPP_TASK.attribute_value */
extern T0* T289f13(T0* C, T0* a1);
/* GEANT_GEPP_TASK.project_variables_resolver */
extern T0* T289f21(T0* C);
/* GEANT_GEPP_TASK.has_attribute */
extern T1 T289f10(T0* C, T0* a1);
/* GEANT_GEPP_TASK.input_filename_attribute_name */
extern unsigned char ge106os8020;
extern T0* ge106ov8020;
extern T0* T289f15(T0* C);
/* GEANT_GEPP_TASK.make */
extern void T289f34p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_GEPP_TASK.make */
extern T0* T289f34p1ac1(T0* a1);
/* GEANT_GEPP_TASK.make_with_command */
extern void T289f36(T0* C, T0* a1, T0* a2);
/* GEANT_GEPP_TASK.interpreting_element_make */
extern void T289f39(T0* C, T0* a1, T0* a2);
/* GEANT_GEPP_TASK.set_project */
extern void T289f41(T0* C, T0* a1);
/* GEANT_GEPP_TASK.element_make */
extern void T289f40(T0* C, T0* a1);
/* GEANT_GEPP_TASK.set_xml_element */
extern void T289f42(T0* C, T0* a1);
/* GEANT_GEPP_TASK.set_command */
extern void T289f38(T0* C, T0* a1);
/* GEANT_GEPP_TASK.build_command */
extern void T289f35(T0* C, T0* a1);
/* GEANT_GEPP_COMMAND.make */
extern T0* T413c21(T0* a1);
/* GEANT_GEPP_COMMAND.make */
extern void T413f21p1(T0* C, T0* a1);
/* GEANT_GEPP_COMMAND.set_project */
extern void T413f28(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_geyacc_task */
extern T0* T192f20(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.make */
extern T0* T287c34(T0* a1, T0* a2);
/* GEANT_GEYACC_COMMAND.set_input_filename */
extern void T410f27(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.input_filename_attribute_name */
extern unsigned char ge109os7995;
extern T0* ge109ov7995;
extern T0* T287f12(T0* C);
/* GEANT_GEYACC_COMMAND.set_output_filename */
extern void T410f26(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.output_filename_attribute_name */
extern unsigned char ge109os7994;
extern T0* ge109ov7994;
extern T0* T287f11(T0* C);
/* GEANT_GEYACC_COMMAND.set_tokens_filename */
extern void T410f25(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.tokens_filename_attribute_name */
extern unsigned char ge109os7993;
extern T0* ge109ov7993;
extern T0* T287f10(T0* C);
/* GEANT_GEYACC_COMMAND.set_tokens_classname */
extern void T410f24(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.tokens_classname_attribute_name */
extern unsigned char ge109os7992;
extern T0* ge109ov7992;
extern T0* T287f9(T0* C);
/* GEANT_GEYACC_COMMAND.set_new_typing */
extern void T410f23(T0* C, T1 a1);
/* GEANT_GEYACC_TASK.new_typing_attribute_name */
extern unsigned char ge109os7997;
extern T0* ge109ov7997;
extern T0* T287f8(T0* C);
/* GEANT_GEYACC_COMMAND.set_old_typing */
extern void T410f22(T0* C, T1 a1);
/* GEANT_GEYACC_TASK.old_typing_attribute_name */
extern unsigned char ge109os7996;
extern T0* ge109ov7996;
extern T0* T287f7(T0* C);
/* GEANT_GEYACC_COMMAND.set_verbose_filename */
extern void T410f21(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.attribute_value */
extern T0* T287f6(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.project_variables_resolver */
extern T0* T287f17(T0* C);
/* GEANT_GEYACC_TASK.verbose_filename_attribute_name */
extern unsigned char ge109os7991;
extern T0* ge109ov7991;
extern T0* T287f5(T0* C);
/* GEANT_GEYACC_COMMAND.set_separate_actions */
extern void T410f20(T0* C, T1 a1);
/* GEANT_GEYACC_TASK.boolean_value */
extern T1 T287f16(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.std */
extern T0* T287f21(T0* C);
/* GEANT_GEYACC_TASK.false_attribute_value */
extern T0* T287f20(T0* C);
/* GEANT_GEYACC_TASK.true_attribute_value */
extern T0* T287f19(T0* C);
/* GEANT_GEYACC_TASK.string_ */
extern T0* T287f18(T0* C);
/* GEANT_GEYACC_TASK.has_attribute */
extern T1 T287f13(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.separate_actions_attribute_name */
extern unsigned char ge109os7990;
extern T0* ge109ov7990;
extern T0* T287f14(T0* C);
/* GEANT_GEYACC_TASK.make */
extern void T287f34p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_GEYACC_TASK.make */
extern T0* T287f34p1ac1(T0* a1);
/* GEANT_GEYACC_TASK.make_with_command */
extern void T287f36(T0* C, T0* a1, T0* a2);
/* GEANT_GEYACC_TASK.interpreting_element_make */
extern void T287f39(T0* C, T0* a1, T0* a2);
/* GEANT_GEYACC_TASK.set_project */
extern void T287f41(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.element_make */
extern void T287f40(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.set_xml_element */
extern void T287f42(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.set_command */
extern void T287f38(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.build_command */
extern void T287f35(T0* C, T0* a1);
/* GEANT_GEYACC_COMMAND.make */
extern T0* T410c19(T0* a1);
/* GEANT_GEYACC_COMMAND.make */
extern void T410f19p1(T0* C, T0* a1);
/* GEANT_GEYACC_COMMAND.set_project */
extern void T410f28(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_gelex_task */
extern T0* T192f18(T0* C, T0* a1);
/* GEANT_GELEX_TASK.make */
extern T0* T285c37(T0* a1, T0* a2);
/* GEANT_GELEX_COMMAND.set_input_filename */
extern void T407f33(T0* C, T0* a1);
/* GEANT_GELEX_TASK.input_filename_attribute_name */
extern unsigned char ge105os7961;
extern T0* ge105ov7961;
extern T0* T285f15(T0* C);
/* GEANT_GELEX_COMMAND.set_output_filename */
extern void T407f32(T0* C, T0* a1);
/* GEANT_GELEX_TASK.output_filename_attribute_name */
extern unsigned char ge105os7960;
extern T0* ge105ov7960;
extern T0* T285f14(T0* C);
/* GEANT_GELEX_COMMAND.set_separate_actions */
extern void T407f31(T0* C, T1 a1);
/* GEANT_GELEX_TASK.separate_actions_attribute_name */
extern unsigned char ge105os7959;
extern T0* ge105ov7959;
extern T0* T285f13(T0* C);
/* GEANT_GELEX_COMMAND.set_no_warn */
extern void T407f30(T0* C, T1 a1);
/* GEANT_GELEX_TASK.no_warn_attribute_name */
extern unsigned char ge105os7958;
extern T0* ge105ov7958;
extern T0* T285f12(T0* C);
/* GEANT_GELEX_COMMAND.set_no_default */
extern void T407f29(T0* C, T1 a1);
/* GEANT_GELEX_TASK.no_default_attribute_name */
extern unsigned char ge105os7957;
extern T0* ge105ov7957;
extern T0* T285f11(T0* C);
/* GEANT_GELEX_COMMAND.set_meta_ecs */
extern void T407f28(T0* C, T1 a1);
/* GEANT_GELEX_TASK.meta_ecs_attribute_name */
extern unsigned char ge105os7956;
extern T0* ge105ov7956;
extern T0* T285f10(T0* C);
/* GEANT_GELEX_COMMAND.set_case_insensitive */
extern void T407f27(T0* C, T1 a1);
/* GEANT_GELEX_TASK.case_insensitive_attribute_name */
extern unsigned char ge105os7955;
extern T0* ge105ov7955;
extern T0* T285f9(T0* C);
/* GEANT_GELEX_COMMAND.set_full */
extern void T407f26(T0* C, T1 a1);
/* GEANT_GELEX_TASK.full_attribute_name */
extern unsigned char ge105os7954;
extern T0* ge105ov7954;
extern T0* T285f8(T0* C);
/* GEANT_GELEX_COMMAND.set_ecs */
extern void T407f25(T0* C, T1 a1);
/* GEANT_GELEX_TASK.ecs_attribute_name */
extern unsigned char ge105os7953;
extern T0* ge105ov7953;
extern T0* T285f7(T0* C);
/* GEANT_GELEX_COMMAND.set_backup */
extern void T407f24(T0* C, T1 a1);
/* GEANT_GELEX_TASK.boolean_value */
extern T1 T285f6(T0* C, T0* a1);
/* GEANT_GELEX_TASK.std */
extern T0* T285f23(T0* C);
/* GEANT_GELEX_TASK.false_attribute_value */
extern T0* T285f22(T0* C);
/* GEANT_GELEX_TASK.true_attribute_value */
extern T0* T285f21(T0* C);
/* GEANT_GELEX_TASK.string_ */
extern T0* T285f20(T0* C);
/* GEANT_GELEX_TASK.backup_attribute_name */
extern unsigned char ge105os7952;
extern T0* ge105ov7952;
extern T0* T285f5(T0* C);
/* GEANT_GELEX_COMMAND.set_size */
extern void T407f23(T0* C, T0* a1);
/* GEANT_GELEX_TASK.attribute_value */
extern T0* T285f17(T0* C, T0* a1);
/* GEANT_GELEX_TASK.project_variables_resolver */
extern T0* T285f24(T0* C);
/* GEANT_GELEX_TASK.has_attribute */
extern T1 T285f16(T0* C, T0* a1);
/* GEANT_GELEX_TASK.size_attribute_name */
extern unsigned char ge105os7951;
extern T0* ge105ov7951;
extern T0* T285f19(T0* C);
/* GEANT_GELEX_TASK.make */
extern void T285f37p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_GELEX_TASK.make */
extern T0* T285f37p1ac1(T0* a1);
/* GEANT_GELEX_TASK.make_with_command */
extern void T285f39(T0* C, T0* a1, T0* a2);
/* GEANT_GELEX_TASK.interpreting_element_make */
extern void T285f42(T0* C, T0* a1, T0* a2);
/* GEANT_GELEX_TASK.set_project */
extern void T285f44(T0* C, T0* a1);
/* GEANT_GELEX_TASK.element_make */
extern void T285f43(T0* C, T0* a1);
/* GEANT_GELEX_TASK.set_xml_element */
extern void T285f45(T0* C, T0* a1);
/* GEANT_GELEX_TASK.set_command */
extern void T285f41(T0* C, T0* a1);
/* GEANT_GELEX_TASK.build_command */
extern void T285f38(T0* C, T0* a1);
/* GEANT_GELEX_COMMAND.make */
extern T0* T407c22(T0* a1);
/* GEANT_GELEX_COMMAND.make */
extern void T407f22p1(T0* C, T0* a1);
/* GEANT_GELEX_COMMAND.set_project */
extern void T407f34(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_gexace_task */
extern T0* T192f16(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.make */
extern T0* T283c35(T0* a1, T0* a2);
/* DS_HASH_TABLE [STRING_8, STRING_8].force_last */
extern void T81f54(T0* C, T0* a1, T0* a2);
/* GEANT_GEXACE_TASK.elements_by_name */
extern T0* T283f13(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.string_ */
extern T0* T283f19(T0* C);
/* GEANT_GEXACE_TASK.define_element_name */
extern unsigned char ge108os7925;
extern T0* ge108ov7925;
extern T0* T283f12(T0* C);
/* GEANT_GEXACE_COMMAND.set_output_filename */
extern void T404f30(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.output_filename_attribute_name */
extern unsigned char ge108os7924;
extern T0* ge108ov7924;
extern T0* T283f11(T0* C);
/* GEANT_GEXACE_COMMAND.set_xace_filename */
extern void T404f29(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.xace_filename_attribute_name */
extern unsigned char ge108os7923;
extern T0* ge108ov7923;
extern T0* T283f10(T0* C);
/* GEANT_GEXACE_COMMAND.set_format */
extern void T404f28(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.format_attribute_name */
extern unsigned char ge108os7922;
extern T0* ge108ov7922;
extern T0* T283f9(T0* C);
/* GEANT_GEXACE_COMMAND.set_library_command */
extern void T404f27(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.library_attribute_name */
extern unsigned char ge108os7921;
extern T0* ge108ov7921;
extern T0* T283f8(T0* C);
/* GEANT_GEXACE_COMMAND.set_system_command */
extern void T404f26(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.attribute_value */
extern T0* T283f7(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.project_variables_resolver */
extern T0* T283f18(T0* C);
/* GEANT_GEXACE_TASK.system_attribute_name */
extern unsigned char ge108os7920;
extern T0* ge108ov7920;
extern T0* T283f6(T0* C);
/* GEANT_GEXACE_COMMAND.set_validate_command */
extern void T404f25(T0* C, T1 a1);
/* GEANT_GEXACE_TASK.validate_attribute_name */
extern unsigned char ge108os7919;
extern T0* ge108ov7919;
extern T0* T283f5(T0* C);
/* GEANT_GEXACE_COMMAND.set_verbose */
extern void T404f24(T0* C, T1 a1);
/* GEANT_GEXACE_TASK.boolean_value */
extern T1 T283f17(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.std */
extern T0* T283f22(T0* C);
/* GEANT_GEXACE_TASK.false_attribute_value */
extern T0* T283f21(T0* C);
/* GEANT_GEXACE_TASK.true_attribute_value */
extern T0* T283f20(T0* C);
/* GEANT_GEXACE_TASK.has_attribute */
extern T1 T283f14(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.verbose_attribute_name */
extern unsigned char ge108os7918;
extern T0* ge108ov7918;
extern T0* T283f15(T0* C);
/* GEANT_GEXACE_TASK.make */
extern void T283f35p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_GEXACE_TASK.make */
extern T0* T283f35p1ac1(T0* a1);
/* GEANT_GEXACE_TASK.make_with_command */
extern void T283f37(T0* C, T0* a1, T0* a2);
/* GEANT_GEXACE_TASK.interpreting_element_make */
extern void T283f40(T0* C, T0* a1, T0* a2);
/* GEANT_GEXACE_TASK.set_project */
extern void T283f42(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.element_make */
extern void T283f41(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.set_xml_element */
extern void T283f43(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.set_command */
extern void T283f39(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.build_command */
extern void T283f36(T0* C, T0* a1);
/* GEANT_GEXACE_COMMAND.make */
extern T0* T404c23(T0* a1);
/* GEANT_GEXACE_COMMAND.make */
extern void T404f23p1(T0* C, T0* a1);
/* GEANT_GEXACE_COMMAND.set_project */
extern void T404f31(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_unset_task */
extern T0* T192f14(T0* C, T0* a1);
/* GEANT_UNSET_TASK.make */
extern T0* T281c23(T0* a1, T0* a2);
/* GEANT_UNSET_COMMAND.set_name */
extern void T400f8(T0* C, T0* a1);
/* GEANT_UNSET_TASK.attribute_value */
extern T0* T281f6(T0* C, T0* a1);
/* GEANT_UNSET_TASK.project_variables_resolver */
extern T0* T281f9(T0* C);
/* GEANT_UNSET_TASK.has_attribute */
extern T1 T281f5(T0* C, T0* a1);
/* GEANT_UNSET_TASK.name_attribute_name */
extern unsigned char ge121os7910;
extern T0* ge121ov7910;
extern T0* T281f8(T0* C);
/* GEANT_UNSET_TASK.make */
extern void T281f23p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_UNSET_TASK.make */
extern T0* T281f23p1ac1(T0* a1);
/* GEANT_UNSET_TASK.make_with_command */
extern void T281f25(T0* C, T0* a1, T0* a2);
/* GEANT_UNSET_TASK.interpreting_element_make */
extern void T281f28(T0* C, T0* a1, T0* a2);
/* GEANT_UNSET_TASK.set_project */
extern void T281f30(T0* C, T0* a1);
/* GEANT_UNSET_TASK.element_make */
extern void T281f29(T0* C, T0* a1);
/* GEANT_UNSET_TASK.set_xml_element */
extern void T281f31(T0* C, T0* a1);
/* GEANT_UNSET_TASK.set_command */
extern void T281f27(T0* C, T0* a1);
/* GEANT_UNSET_TASK.build_command */
extern void T281f24(T0* C, T0* a1);
/* GEANT_UNSET_COMMAND.make */
extern T0* T400c7(T0* a1);
/* GEANT_UNSET_COMMAND.set_project */
extern void T400f9(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_set_task */
extern T0* T192f12(T0* C, T0* a1);
/* GEANT_SET_TASK.make */
extern T0* T279c24(T0* a1, T0* a2);
/* GEANT_SET_COMMAND.set_value */
extern void T397f15(T0* C, T0* a1);
/* GEANT_SET_TASK.value_attribute_name */
extern unsigned char ge119os7900;
extern T0* ge119ov7900;
extern T0* T279f5(T0* C);
/* GEANT_SET_COMMAND.set_name */
extern void T397f14(T0* C, T0* a1);
/* GEANT_SET_TASK.attribute_value */
extern T0* T279f7(T0* C, T0* a1);
/* GEANT_SET_TASK.project_variables_resolver */
extern T0* T279f10(T0* C);
/* GEANT_SET_TASK.has_attribute */
extern T1 T279f6(T0* C, T0* a1);
/* GEANT_SET_TASK.name_attribute_name */
extern unsigned char ge119os7899;
extern T0* ge119ov7899;
extern T0* T279f9(T0* C);
/* GEANT_SET_TASK.make */
extern void T279f24p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_SET_TASK.make */
extern T0* T279f24p1ac1(T0* a1);
/* GEANT_SET_TASK.make_with_command */
extern void T279f26(T0* C, T0* a1, T0* a2);
/* GEANT_SET_TASK.interpreting_element_make */
extern void T279f29(T0* C, T0* a1, T0* a2);
/* GEANT_SET_TASK.set_project */
extern void T279f31(T0* C, T0* a1);
/* GEANT_SET_TASK.element_make */
extern void T279f30(T0* C, T0* a1);
/* GEANT_SET_TASK.set_xml_element */
extern void T279f32(T0* C, T0* a1);
/* GEANT_SET_TASK.set_command */
extern void T279f28(T0* C, T0* a1);
/* GEANT_SET_TASK.build_command */
extern void T279f25(T0* C, T0* a1);
/* GEANT_SET_COMMAND.make */
extern T0* T397c13(T0* a1);
/* GEANT_SET_COMMAND.set_project */
extern void T397f16(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_lcc_task */
extern T0* T192f10(T0* C, T0* a1);
/* GEANT_LCC_TASK.make */
extern T0* T277c24(T0* a1, T0* a2);
/* GEANT_LCC_COMMAND.set_source_filename */
extern void T394f15(T0* C, T0* a1);
/* GEANT_LCC_TASK.source_filename_attribute_name */
extern unsigned char ge112os7889;
extern T0* ge112ov7889;
extern T0* T277f5(T0* C);
/* GEANT_LCC_COMMAND.set_executable */
extern void T394f14(T0* C, T0* a1);
/* GEANT_LCC_TASK.attribute_value */
extern T0* T277f7(T0* C, T0* a1);
/* GEANT_LCC_TASK.project_variables_resolver */
extern T0* T277f10(T0* C);
/* GEANT_LCC_TASK.has_attribute */
extern T1 T277f6(T0* C, T0* a1);
/* GEANT_LCC_TASK.executable_attribute_name */
extern unsigned char ge112os7888;
extern T0* ge112ov7888;
extern T0* T277f9(T0* C);
/* GEANT_LCC_TASK.make */
extern void T277f24p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_LCC_TASK.make */
extern T0* T277f24p1ac1(T0* a1);
/* GEANT_LCC_TASK.make_with_command */
extern void T277f26(T0* C, T0* a1, T0* a2);
/* GEANT_LCC_TASK.interpreting_element_make */
extern void T277f29(T0* C, T0* a1, T0* a2);
/* GEANT_LCC_TASK.set_project */
extern void T277f31(T0* C, T0* a1);
/* GEANT_LCC_TASK.element_make */
extern void T277f30(T0* C, T0* a1);
/* GEANT_LCC_TASK.set_xml_element */
extern void T277f32(T0* C, T0* a1);
/* GEANT_LCC_TASK.set_command */
extern void T277f28(T0* C, T0* a1);
/* GEANT_LCC_TASK.build_command */
extern void T277f25(T0* C, T0* a1);
/* GEANT_LCC_COMMAND.make */
extern T0* T394c13(T0* a1);
/* GEANT_LCC_COMMAND.set_project */
extern void T394f16(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_exec_task */
extern T0* T192f8(T0* C, T0* a1);
/* GEANT_EXEC_TASK.make_from_interpreting_element */
extern T0* T275c22(T0* a1);
/* Creation of agent #1 in feature GEANT_EXEC_TASK.make_from_interpreting_element */
extern T0* T275f22ac1(T0* a1, T0* a2);
/* Creation of agent #2 in feature GEANT_EXEC_TASK.make_from_interpreting_element */
extern T0* T275f22ac2(T0* a1, T0* a2);
/* Creation of agent #3 in feature GEANT_EXEC_TASK.make_from_interpreting_element */
extern T0* T275f22ac3(T0* a1, T0* a2);
/* GEANT_EXEC_COMMAND.set_fileset */
extern void T386f14(T0* C, T0* a1);
/* GEANT_EXEC_TASK.fileset_element_name */
extern unsigned char ge101os7875;
extern T0* ge101ov7875;
extern T0* T275f5(T0* C);
/* GEANT_EXEC_TASK.make_from_interpreting_element */
extern void T275f22p1(T0* C, T0* a1);
/* GEANT_EXEC_TASK.make */
extern void T275f23(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_EXEC_TASK.make */
extern T0* T275f23ac1(T0* a1);
/* GEANT_EXEC_TASK.make_with_command */
extern void T275f25(T0* C, T0* a1, T0* a2);
/* GEANT_EXEC_TASK.interpreting_element_make */
extern void T275f28(T0* C, T0* a1, T0* a2);
/* GEANT_EXEC_TASK.set_project */
extern void T275f30(T0* C, T0* a1);
/* GEANT_EXEC_TASK.element_make */
extern void T275f29(T0* C, T0* a1);
/* GEANT_EXEC_TASK.set_xml_element */
extern void T275f31(T0* C, T0* a1);
/* GEANT_EXEC_TASK.set_command */
extern void T275f27(T0* C, T0* a1);
/* GEANT_EXEC_TASK.build_command */
extern void T275f24(T0* C, T0* a1);
/* GEANT_EXEC_COMMAND.make */
extern T0* T386c13(T0* a1);
/* GEANT_EXEC_COMMAND.make */
extern void T386f13p1(T0* C, T0* a1);
/* GEANT_EXEC_COMMAND.set_project */
extern void T386f15(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_ise_task */
extern T0* T192f6(T0* C, T0* a1);
/* GEANT_ISE_TASK.make */
extern T0* T273c33(T0* a1, T0* a2);
/* GEANT_ISE_COMMAND.set_exit_code_variable_name */
extern void T382f25(T0* C, T0* a1);
/* GEANT_ISE_TASK.attribute_value */
extern T0* T273f11(T0* C, T0* a1);
/* GEANT_ISE_TASK.project_variables_resolver */
extern T0* T273f20(T0* C);
/* GEANT_ISE_TASK.exit_code_variable_attribute_name */
extern unsigned char ge111os7853;
extern T0* ge111ov7853;
extern T0* T273f10(T0* C);
/* GEANT_ISE_COMMAND.set_finish_freezing */
extern void T382f24(T0* C, T1 a1);
/* GEANT_ISE_TASK.finish_freezing_attribute_name */
extern unsigned char ge111os7851;
extern T0* ge111ov7851;
extern T0* T273f9(T0* C);
/* GEANT_ISE_COMMAND.set_finalize_mode */
extern void T382f23(T0* C, T1 a1);
/* GEANT_ISE_TASK.boolean_value */
extern T1 T273f8(T0* C, T0* a1);
/* GEANT_ISE_TASK.std */
extern T0* T273f19(T0* C);
/* GEANT_ISE_TASK.false_attribute_value */
extern T0* T273f18(T0* C);
/* GEANT_ISE_TASK.true_attribute_value */
extern T0* T273f17(T0* C);
/* GEANT_ISE_TASK.string_ */
extern T0* T273f16(T0* C);
/* GEANT_ISE_TASK.finalize_attribute_name */
extern unsigned char ge111os7850;
extern T0* ge111ov7850;
extern T0* T273f7(T0* C);
/* GEANT_ISE_COMMAND.set_clean */
extern void T382f22(T0* C, T0* a1);
/* GEANT_ISE_TASK.clean_attribute_name */
extern unsigned char ge111os7852;
extern T0* ge111ov7852;
extern T0* T273f6(T0* C);
/* GEANT_ISE_COMMAND.set_system_name */
extern void T382f21(T0* C, T0* a1);
/* GEANT_ISE_TASK.system_attribute_name */
extern unsigned char ge111os7849;
extern T0* ge111ov7849;
extern T0* T273f5(T0* C);
/* GEANT_ISE_COMMAND.set_ace_filename */
extern void T382f20(T0* C, T0* a1);
/* GEANT_ISE_TASK.attribute_value_or_default */
extern T0* T273f13(T0* C, T0* a1, T0* a2);
/* GEANT_ISE_TASK.has_attribute */
extern T1 T273f12(T0* C, T0* a1);
/* GEANT_ISE_TASK.ace_attribute_name */
extern unsigned char ge111os7848;
extern T0* ge111ov7848;
extern T0* T273f15(T0* C);
/* GEANT_ISE_TASK.make */
extern void T273f33p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_ISE_TASK.make */
extern T0* T273f33p1ac1(T0* a1);
/* GEANT_ISE_TASK.make_with_command */
extern void T273f35(T0* C, T0* a1, T0* a2);
/* GEANT_ISE_TASK.interpreting_element_make */
extern void T273f38(T0* C, T0* a1, T0* a2);
/* GEANT_ISE_TASK.set_project */
extern void T273f40(T0* C, T0* a1);
/* GEANT_ISE_TASK.element_make */
extern void T273f39(T0* C, T0* a1);
/* GEANT_ISE_TASK.set_xml_element */
extern void T273f41(T0* C, T0* a1);
/* GEANT_ISE_TASK.set_command */
extern void T273f37(T0* C, T0* a1);
/* GEANT_ISE_TASK.build_command */
extern void T273f34(T0* C, T0* a1);
/* GEANT_ISE_COMMAND.make */
extern T0* T382c19(T0* a1);
/* GEANT_ISE_COMMAND.set_project */
extern void T382f26(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.new_gec_task */
extern T0* T192f4(T0* C, T0* a1);
/* GEANT_GEC_TASK.make */
extern T0* T266c37(T0* a1, T0* a2);
/* GEANT_GEC_COMMAND.set_exit_code_variable_name */
extern void T378f35(T0* C, T0* a1);
/* GEANT_GEC_TASK.exit_code_variable_attribute_name */
extern unsigned char ge104os7785;
extern T0* ge104ov7785;
extern T0* T266f15(T0* C);
/* GEANT_GEC_COMMAND.set_garbage_collector */
extern void T378f34(T0* C, T0* a1);
/* GEANT_GEC_TASK.gc_attribute_name */
extern unsigned char ge104os7787;
extern T0* ge104ov7787;
extern T0* T266f14(T0* C);
/* GEANT_GEC_COMMAND.set_split_size */
extern void T378f33(T0* C, T6 a1);
/* GEANT_GEC_TASK.split_size_attribute_name */
extern unsigned char ge104os7790;
extern T0* ge104ov7790;
extern T0* T266f13(T0* C);
/* GEANT_GEC_COMMAND.set_split_mode */
extern void T378f32(T0* C, T1 a1);
/* GEANT_GEC_TASK.split_attribute_name */
extern unsigned char ge104os7789;
extern T0* ge104ov7789;
extern T0* T266f12(T0* C);
/* GEANT_GEC_COMMAND.set_catcall_mode */
extern void T378f31(T0* C, T0* a1);
/* GEANT_GEC_TASK.attribute_value */
extern T0* T266f11(T0* C, T0* a1);
/* GEANT_GEC_TASK.project_variables_resolver */
extern T0* T266f24(T0* C);
/* GEANT_GEC_TASK.catcall_attribute_name */
extern unsigned char ge104os7783;
extern T0* ge104ov7783;
extern T0* T266f10(T0* C);
/* GEANT_GEC_COMMAND.set_gelint */
extern void T378f30(T0* C, T1 a1);
/* GEANT_GEC_TASK.gelint_attribute_name */
extern unsigned char ge104os7788;
extern T0* ge104ov7788;
extern T0* T266f9(T0* C);
/* GEANT_GEC_COMMAND.set_finalize */
extern void T378f29(T0* C, T1 a1);
/* GEANT_GEC_TASK.finalize_attribute_name */
extern unsigned char ge104os7786;
extern T0* ge104ov7786;
extern T0* T266f8(T0* C);
/* GEANT_GEC_COMMAND.set_c_compile */
extern void T378f28(T0* C, T1 a1);
/* GEANT_GEC_TASK.boolean_value */
extern T1 T266f7(T0* C, T0* a1);
/* GEANT_GEC_TASK.std */
extern T0* T266f23(T0* C);
/* GEANT_GEC_TASK.false_attribute_value */
extern T0* T266f22(T0* C);
/* GEANT_GEC_TASK.true_attribute_value */
extern T0* T266f21(T0* C);
/* GEANT_GEC_TASK.string_ */
extern T0* T266f20(T0* C);
/* GEANT_GEC_TASK.c_compile_attribute_name */
extern unsigned char ge104os7782;
extern T0* ge104ov7782;
extern T0* T266f6(T0* C);
/* GEANT_GEC_COMMAND.set_clean */
extern void T378f27(T0* C, T0* a1);
/* GEANT_GEC_TASK.clean_attribute_name */
extern unsigned char ge104os7784;
extern T0* ge104ov7784;
extern T0* T266f5(T0* C);
/* GEANT_GEC_COMMAND.set_ace_filename */
extern void T378f26(T0* C, T0* a1);
/* GEANT_GEC_TASK.attribute_value_or_default */
extern T0* T266f17(T0* C, T0* a1, T0* a2);
/* GEANT_GEC_TASK.has_attribute */
extern T1 T266f16(T0* C, T0* a1);
/* GEANT_GEC_TASK.ace_attribute_name */
extern unsigned char ge104os7781;
extern T0* ge104ov7781;
extern T0* T266f19(T0* C);
/* GEANT_GEC_TASK.make */
extern void T266f37p1(T0* C, T0* a1, T0* a2);
/* Creation of agent #1 in feature GEANT_GEC_TASK.make */
extern T0* T266f37p1ac1(T0* a1);
/* GEANT_GEC_TASK.make_with_command */
extern void T266f39(T0* C, T0* a1, T0* a2);
/* GEANT_GEC_TASK.interpreting_element_make */
extern void T266f42(T0* C, T0* a1, T0* a2);
/* GEANT_GEC_TASK.set_project */
extern void T266f44(T0* C, T0* a1);
/* GEANT_GEC_TASK.element_make */
extern void T266f43(T0* C, T0* a1);
/* GEANT_GEC_TASK.set_xml_element */
extern void T266f45(T0* C, T0* a1);
/* GEANT_GEC_TASK.set_command */
extern void T266f41(T0* C, T0* a1);
/* GEANT_GEC_TASK.build_command */
extern void T266f38(T0* C, T0* a1);
/* GEANT_GEC_COMMAND.make */
extern T0* T378c25(T0* a1);
/* GEANT_GEC_COMMAND.make */
extern void T378f25p1(T0* C, T0* a1);
/* GEANT_GEC_COMMAND.set_project */
extern void T378f36(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.replace_task_name */
extern unsigned char ge128os2454;
extern T0* ge128ov2454;
extern T0* T192f53(T0* C);
/* GEANT_TASK_FACTORY.input_task_name */
extern unsigned char ge128os2453;
extern T0* ge128ov2453;
extern T0* T192f51(T0* C);
/* GEANT_TASK_FACTORY.available_task_name */
extern unsigned char ge128os2452;
extern T0* ge128ov2452;
extern T0* T192f49(T0* C);
/* GEANT_TASK_FACTORY.precursor_task_name */
extern unsigned char ge128os2451;
extern T0* ge128ov2451;
extern T0* T192f47(T0* C);
/* GEANT_TASK_FACTORY.exit_task_name */
extern unsigned char ge128os2450;
extern T0* ge128ov2450;
extern T0* T192f45(T0* C);
/* GEANT_TASK_FACTORY.outofdate_task_name */
extern unsigned char ge128os2449;
extern T0* ge128ov2449;
extern T0* T192f43(T0* C);
/* GEANT_TASK_FACTORY.xslt_task_name */
extern unsigned char ge128os2448;
extern T0* ge128ov2448;
extern T0* T192f41(T0* C);
/* GEANT_TASK_FACTORY.setenv_task_name */
extern unsigned char ge128os2447;
extern T0* ge128ov2447;
extern T0* T192f39(T0* C);
/* GEANT_TASK_FACTORY.move_task_name */
extern unsigned char ge128os2446;
extern T0* ge128ov2446;
extern T0* T192f37(T0* C);
/* GEANT_TASK_FACTORY.copy_task_name */
extern unsigned char ge128os2445;
extern T0* ge128ov2445;
extern T0* T192f35(T0* C);
/* GEANT_TASK_FACTORY.delete_task_name */
extern unsigned char ge128os2444;
extern T0* ge128ov2444;
extern T0* T192f33(T0* C);
/* GEANT_TASK_FACTORY.mkdir_task_name */
extern unsigned char ge128os2443;
extern T0* ge128ov2443;
extern T0* T192f31(T0* C);
/* GEANT_TASK_FACTORY.echo_task_name */
extern unsigned char ge128os2442;
extern T0* ge128ov2442;
extern T0* T192f29(T0* C);
/* GEANT_TASK_FACTORY.geant_task_name */
extern unsigned char ge128os2441;
extern T0* ge128ov2441;
extern T0* T192f27(T0* C);
/* GEANT_TASK_FACTORY.getest_task_name */
extern unsigned char ge128os2440;
extern T0* ge128ov2440;
extern T0* T192f25(T0* C);
/* GEANT_TASK_FACTORY.gepp_task_name */
extern unsigned char ge128os2439;
extern T0* ge128ov2439;
extern T0* T192f23(T0* C);
/* GEANT_TASK_FACTORY.geyacc_task_name */
extern unsigned char ge128os2438;
extern T0* ge128ov2438;
extern T0* T192f21(T0* C);
/* GEANT_TASK_FACTORY.gelex_task_name */
extern unsigned char ge128os2437;
extern T0* ge128ov2437;
extern T0* T192f19(T0* C);
/* GEANT_TASK_FACTORY.gexace_task_name */
extern unsigned char ge128os2436;
extern T0* ge128ov2436;
extern T0* T192f17(T0* C);
/* GEANT_TASK_FACTORY.unset_task_name */
extern unsigned char ge128os2435;
extern T0* ge128ov2435;
extern T0* T192f15(T0* C);
/* GEANT_TASK_FACTORY.set_task_name */
extern unsigned char ge128os2434;
extern T0* ge128ov2434;
extern T0* T192f13(T0* C);
/* GEANT_TASK_FACTORY.lcc_task_name */
extern unsigned char ge128os2433;
extern T0* ge128ov2433;
extern T0* T192f11(T0* C);
/* GEANT_TASK_FACTORY.exec_task_name */
extern unsigned char ge128os2432;
extern T0* ge128ov2432;
extern T0* T192f9(T0* C);
/* GEANT_TASK_FACTORY.ise_task_name */
extern unsigned char ge128os2431;
extern T0* ge128ov2431;
extern T0* T192f7(T0* C);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].force_new */
extern void T265f38(T0* C, T0* a1, T0* a2);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].key_storage_put */
extern void T265f45(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].item_storage_put */
extern void T265f44(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].slots_put */
extern void T265f43(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].clashes_put */
extern void T265f42(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].resize */
extern void T265f41(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].clashes_resize */
extern void T265f50(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].special_integer_ */
extern T0* T265f26(T0* C);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].key_storage_resize */
extern void T265f49(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].item_storage_resize */
extern void T265f48(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]].resize */
extern T0* T377f1(T0* C, T0* a1, T6 a2);
/* SPECIAL [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]].aliased_resized_area */
extern T0* T375f2(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].slots_resize */
extern void T265f47(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].new_modulus */
extern T6 T265f24(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].new_capacity */
extern T6 T265f23(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].unset_found_item */
extern void T265f40(T0* C);
/* GEANT_TASK_FACTORY.gec_task_name */
extern unsigned char ge128os2430;
extern T0* ge128ov2430;
extern T0* T192f5(T0* C);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].set_key_equality_tester */
extern void T265f37(T0* C, T0* a1);
/* DS_SPARSE_TABLE_KEYS [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].internal_set_equality_tester */
extern void T373f6(T0* C, T0* a1);
/* GEANT_TASK_FACTORY.string_equality_tester */
extern T0* T192f3(T0* C);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].make_map */
extern T0* T265c36(T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].make_with_equality_testers */
extern void T265f39(T0* C, T6 a1, T0* a2, T0* a3);
/* DS_SPARSE_TABLE_KEYS [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].make */
extern T0* T373c5(T0* a1);
/* DS_SPARSE_TABLE_KEYS [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].new_cursor */
extern T0* T373f4(T0* C);
/* DS_SPARSE_TABLE_KEYS_CURSOR [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].make */
extern T0* T496c3(T0* a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].new_cursor */
extern T0* T265f25(T0* C);
/* DS_HASH_TABLE_CURSOR [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].make */
extern T0* T376c3(T0* a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].make_sparse_container */
extern void T265f46(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].make_slots */
extern void T265f54(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].make_clashes */
extern void T265f53(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].make_key_storage */
extern void T265f52(T0* C, T6 a1);
/* DS_HASH_TABLE [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK], STRING_8].make_item_storage */
extern void T265f51(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]].make */
extern T0* T377f2(T0* C, T6 a1);
/* TO_SPECIAL [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]].make_area */
extern T0* T497c2(T6 a1);
/* SPECIAL [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]].make */
extern T0* T375c4(T6 a1);
/* KL_SPECIAL_ROUTINES [FUNCTION [ANY, TUPLE [XM_ELEMENT], GEANT_TASK]].default_create */
extern T0* T377c3(void);
/* GEANT_PROJECT.set_options */
extern void T22f45(T0* C, T0* a1);
/* GEANT_PROJECT.set_variables */
extern void T22f44(T0* C, T0* a1);
/* GEANT_PROJECT_ELEMENT.element_make */
extern void T30f21(T0* C, T0* a1);
/* GEANT_PROJECT_ELEMENT.set_xml_element */
extern void T30f24(T0* C, T0* a1);
/* XM_TREE_CALLBACKS_PIPE.document */
extern T0* T94f8(T0* C);
/* XM_EIFFEL_PARSER.is_correct */
extern T1 T93f121(T0* C);
/* XM_EIFFEL_PARSER.parse_from_stream */
extern void T93f205(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.parse_with_events */
extern void T93f209(T0* C);
/* XM_EIFFEL_PARSER.on_finish */
extern void T93f215(T0* C);
/* XM_EIFFEL_PARSER.parse */
extern void T93f214(T0* C);
/* XM_EIFFEL_PARSER.yy_pop_last_value */
extern void T93f224(T0* C, T6 a1);
/* XM_EIFFEL_PARSER.yy_push_error_value */
extern void T93f223(T0* C);
/* XM_EIFFEL_PARSER.yy_do_action */
extern void T93f222(T0* C, T6 a1);
/* XM_EIFFEL_PARSER.on_notation_declaration */
extern void T93f252(T0* C, T0* a1, T0* a2);
/* XM_DTD_CALLBACKS_NULL.on_notation_declaration */
extern void T174f8(T0* C, T0* a1, T0* a2);
/* XM_DTD_EXTERNAL_ID.set_public */
extern void T146f6(T0* C, T0* a1);
/* KL_SPECIAL_ROUTINES [XM_DTD_EXTERNAL_ID].resize */
extern T0* T172f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [XM_DTD_EXTERNAL_ID].aliased_resized_area */
extern T0* T157f3(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [XM_DTD_EXTERNAL_ID].make */
extern T0* T172f1(T0* C, T6 a1);
/* TO_SPECIAL [XM_DTD_EXTERNAL_ID].make_area */
extern T0* T252c2(T6 a1);
/* SPECIAL [XM_DTD_EXTERNAL_ID].make */
extern T0* T157c4(T6 a1);
/* KL_SPECIAL_ROUTINES [XM_DTD_EXTERNAL_ID].default_create */
extern T0* T172c3(void);
/* XM_DTD_EXTERNAL_ID.set_system */
extern void T146f5(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.new_dtd_external_id */
extern T0* T93f169(T0* C);
/* XM_DTD_EXTERNAL_ID.make */
extern T0* T146c4(void);
/* XM_EIFFEL_PARSER.when_pe_entity_declared */
extern void T93f251(T0* C, T0* a1, T0* a2);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].force_new */
extern void T139f40(T0* C, T0* a1, T0* a2);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].key_storage_put */
extern void T139f54(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].item_storage_put */
extern void T139f53(T0* C, T0* a1, T6 a2);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].slots_put */
extern void T139f52(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].clashes_put */
extern void T139f51(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].slots_item */
extern T6 T139f28(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].hash_position */
extern T6 T139f27(T0* C, T0* a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].clashes_item */
extern T6 T139f26(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].resize */
extern void T139f50(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].clashes_resize */
extern void T139f59(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].special_integer_ */
extern T0* T139f32(T0* C);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].key_storage_resize */
extern void T139f58(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].item_storage_resize */
extern void T139f57(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [XM_EIFFEL_ENTITY_DEF].resize */
extern T0* T234f1(T0* C, T0* a1, T6 a2);
/* SPECIAL [XM_EIFFEL_ENTITY_DEF].aliased_resized_area */
extern T0* T229f3(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].key_storage_item */
extern T0* T139f22(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].slots_resize */
extern void T139f56(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].new_modulus */
extern T6 T139f29(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].new_capacity */
extern T6 T139f23(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].unset_found_item */
extern void T139f45(T0* C);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].has */
extern T1 T139f33(T0* C, T0* a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].search_position */
extern void T139f42(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.make_def */
extern T0* T177c208(T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.make_literal */
extern void T177f210(T0* C, T0* a1, T0* a2);
/* XM_NULL_EXTERNAL_RESOLVER.default_create */
extern T0* T141c4(void);
/* XM_EIFFEL_PE_ENTITY_DEF.make_scanner */
extern void T177f211(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.reset */
extern void T177f213(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.reset_sent */
extern void T177f216(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.reset */
extern void T177f213p1(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.reset */
extern void T177f213p0(T0* C);
/* DS_LINKED_STACK [INTEGER_32].make */
extern T0* T224c5(void);
/* XM_EIFFEL_PE_ENTITY_DEF.reset */
extern void T177f213p2(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.make_with_buffer */
extern void T177f212(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_load_input_buffer */
extern void T177f215(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_set_content */
extern void T177f218(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.special_integer_ */
extern T0* T177f70(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_initialize */
extern void T177f214(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_build_tables */
extern void T177f217(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_accept_template */
extern unsigned char ge1538os6165;
extern T0* ge1538ov6165;
extern T0* T177f50(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_fixed_array */
extern T0* T177f54(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_meta_template */
extern unsigned char ge1538os6164;
extern T0* ge1538ov6164;
extern T0* T177f91(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_ec_template */
extern unsigned char ge1538os6163;
extern T0* ge1538ov6163;
extern T0* T177f69(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_def_template */
extern unsigned char ge1538os6162;
extern T0* ge1538ov6162;
extern T0* T177f59(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_base_template */
extern unsigned char ge1538os6161;
extern T0* ge1538ov6161;
extern T0* T177f52(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_chk_template */
extern unsigned char ge1538os6154;
extern T0* ge1538ov6154;
extern T0* T177f49(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_chk_template_6 */
extern void T177f230(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_array_subcopy */
extern void T177f231(T0* C, T0* a1, T0* a2, T6 a3, T6 a4, T6 a5);
/* KL_ARRAY_ROUTINES [INTEGER_32].subcopy */
extern void T262f2(T0* C, T0* a1, T0* a2, T6 a3, T6 a4, T6 a5);
/* ARRAY [INTEGER_32].subcopy */
extern void T205f11(T0* C, T0* a1, T6 a2, T6 a3, T6 a4);
/* SPECIAL [INTEGER_32].copy_data */
extern void T63f6(T0* C, T0* a1, T6 a2, T6 a3, T6 a4);
/* SPECIAL [INTEGER_32].move_data */
extern void T63f7(T0* C, T6 a1, T6 a2, T6 a3);
/* SPECIAL [INTEGER_32].overlapping_move */
extern void T63f9(T0* C, T6 a1, T6 a2, T6 a3);
/* SPECIAL [INTEGER_32].non_overlapping_move */
extern void T63f8(T0* C, T6 a1, T6 a2, T6 a3);
/* XM_EIFFEL_PE_ENTITY_DEF.integer_array_ */
extern unsigned char ge171os2930;
extern T0* ge171ov2930;
extern T0* T177f55(T0* C);
/* KL_ARRAY_ROUTINES [INTEGER_32].default_create */
extern T0* T262c1(void);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_chk_template_5 */
extern void T177f229(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_chk_template_4 */
extern void T177f228(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_chk_template_3 */
extern void T177f227(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_chk_template_2 */
extern void T177f226(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_chk_template_1 */
extern void T177f225(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_nxt_template */
extern unsigned char ge1538os6147;
extern T0* ge1538ov6147;
extern T0* T177f65(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_nxt_template_6 */
extern void T177f224(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_nxt_template_5 */
extern void T177f223(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_nxt_template_4 */
extern void T177f222(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_nxt_template_3 */
extern void T177f221(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_nxt_template_2 */
extern void T177f220(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_nxt_template_1 */
extern void T177f219(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.empty_buffer */
extern T0* T177f58(T0* C);
/* XM_EIFFEL_CHARACTER_ENTITY.make */
extern T0* T220c8(void);
/* XM_EIFFEL_PE_ENTITY_DEF.make_external */
extern void T177f209(T0* C, T0* a1, T0* a2);
/* XM_EIFFEL_ENTITY_DEF.is_external */
extern T1 T171f51(T0* C);
/* XM_EIFFEL_PARSER.new_external_entity */
extern T0* T93f168(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.make_external */
extern T0* T171c207(T0* a1, T0* a2);
/* XM_EIFFEL_ENTITY_DEF.make_scanner */
extern void T171f208(T0* C);
/* XM_EIFFEL_ENTITY_DEF.reset */
extern void T171f210(T0* C);
/* XM_EIFFEL_ENTITY_DEF.reset */
extern void T171f210p1(T0* C);
/* XM_EIFFEL_ENTITY_DEF.reset */
extern void T171f210p0(T0* C);
/* XM_EIFFEL_ENTITY_DEF.make_with_buffer */
extern void T171f209(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.yy_load_input_buffer */
extern void T171f212(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_set_content */
extern void T171f214(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.special_integer_ */
extern T0* T171f57(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_initialize */
extern void T171f211(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_build_tables */
extern void T171f213(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_accept_template */
extern T0* T171f48(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_fixed_array */
extern T0* T171f53(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.yy_meta_template */
extern T0* T171f88(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_ec_template */
extern T0* T171f67(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_def_template */
extern T0* T171f58(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_base_template */
extern T0* T171f50(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_chk_template */
extern T0* T171f47(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_chk_template_6 */
extern void T171f226(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.yy_array_subcopy */
extern void T171f227(T0* C, T0* a1, T0* a2, T6 a3, T6 a4, T6 a5);
/* XM_EIFFEL_ENTITY_DEF.integer_array_ */
extern T0* T171f54(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_chk_template_5 */
extern void T171f225(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.yy_chk_template_4 */
extern void T171f224(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.yy_chk_template_3 */
extern void T171f223(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.yy_chk_template_2 */
extern void T171f222(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.yy_chk_template_1 */
extern void T171f221(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.yy_nxt_template */
extern T0* T171f64(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_nxt_template_6 */
extern void T171f220(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.yy_nxt_template_5 */
extern void T171f219(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.yy_nxt_template_4 */
extern void T171f218(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.yy_nxt_template_3 */
extern void T171f217(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.yy_nxt_template_2 */
extern void T171f216(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.yy_nxt_template_1 */
extern void T171f215(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.empty_buffer */
extern T0* T171f49(T0* C);
/* XM_EIFFEL_PARSER.on_entity_declaration */
extern void T93f250(T0* C, T0* a1, T1 a2, T0* a3, T0* a4, T0* a5);
/* XM_DTD_CALLBACKS_NULL.on_entity_declaration */
extern void T174f7(T0* C, T0* a1, T1 a2, T0* a3, T0* a4, T0* a5);
/* XM_EIFFEL_PARSER.when_entity_declared */
extern void T93f249(T0* C, T0* a1, T0* a2);
/* XM_EIFFEL_PARSER.new_literal_entity */
extern T0* T93f167(T0* C, T0* a1, T0* a2);
/* XM_EIFFEL_ENTITY_DEF.make_literal */
extern T0* T171c206(T0* a1, T0* a2);
/* XM_DTD_ATTRIBUTE_CONTENT.set_default_value */
extern void T150f26(T0* C, T0* a1);
/* XM_DTD_ATTRIBUTE_CONTENT.set_value_fixed */
extern void T150f25(T0* C, T0* a1);
/* XM_DTD_ATTRIBUTE_CONTENT.set_value_implied */
extern void T150f24(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.set_value_required */
extern void T150f23(T0* C);
/* KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [STRING_8]].resize */
extern T0* T170f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [DS_BILINKED_LIST [STRING_8]].aliased_resized_area */
extern T0* T169f3(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [STRING_8]].make */
extern T0* T170f1(T0* C, T6 a1);
/* TO_SPECIAL [DS_BILINKED_LIST [STRING_8]].make_area */
extern T0* T251c2(T6 a1);
/* SPECIAL [DS_BILINKED_LIST [STRING_8]].make */
extern T0* T169c4(T6 a1);
/* KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [STRING_8]].default_create */
extern T0* T170c3(void);
/* DS_BILINKED_LIST [STRING_8].force_last */
extern void T151f12(T0* C, T0* a1);
/* DS_BILINKABLE [STRING_8].put_right */
extern void T243f5(T0* C, T0* a1);
/* DS_BILINKABLE [STRING_8].attach_left */
extern void T243f6(T0* C, T0* a1);
/* DS_BILINKABLE [STRING_8].make */
extern T0* T243c4(T0* a1);
/* DS_BILINKED_LIST [STRING_8].is_empty */
extern T1 T151f7(T0* C);
/* XM_EIFFEL_PARSER.new_string_bilinked_list */
extern T0* T93f162(T0* C);
/* DS_BILINKED_LIST [STRING_8].set_equality_tester */
extern void T151f13(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.string_equality_tester */
extern T0* T93f182(T0* C);
/* DS_BILINKED_LIST [STRING_8].make */
extern T0* T151c11(void);
/* DS_BILINKED_LIST [STRING_8].new_cursor */
extern T0* T151f6(T0* C);
/* DS_BILINKED_LIST_CURSOR [STRING_8].make */
extern T0* T242c7(T0* a1);
/* XM_DTD_ATTRIBUTE_CONTENT.set_enumeration_list */
extern void T150f22(T0* C, T0* a1);
/* XM_DTD_ATTRIBUTE_CONTENT.set_enumeration */
extern void T150f27(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.default_enumeration_list */
extern unsigned char ge1449os6975;
extern T0* ge1449ov6975;
extern T0* T150f7(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.set_notation */
extern void T150f21(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.set_token */
extern void T150f20(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.set_entity */
extern void T150f19(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.set_list_type */
extern void T150f18(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.set_id_ref */
extern void T150f17(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.set_id */
extern void T150f16(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.set_data */
extern void T150f15(T0* C);
/* XM_EIFFEL_PARSER.new_dtd_attribute_content */
extern T0* T93f160(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.make */
extern T0* T150c12(void);
/* KL_SPECIAL_ROUTINES [XM_DTD_ATTRIBUTE_CONTENT].resize */
extern T0* T168f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [XM_DTD_ATTRIBUTE_CONTENT].aliased_resized_area */
extern T0* T166f3(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [XM_DTD_ATTRIBUTE_CONTENT].make */
extern T0* T168f1(T0* C, T6 a1);
/* TO_SPECIAL [XM_DTD_ATTRIBUTE_CONTENT].make_area */
extern T0* T250c2(T6 a1);
/* SPECIAL [XM_DTD_ATTRIBUTE_CONTENT].make */
extern T0* T166c4(T6 a1);
/* KL_SPECIAL_ROUTINES [XM_DTD_ATTRIBUTE_CONTENT].default_create */
extern T0* T168c3(void);
/* XM_DTD_ATTRIBUTE_CONTENT.copy_default */
extern void T150f14(T0* C, T0* a1);
/* XM_DTD_ATTRIBUTE_CONTENT.is_value_implied */
extern T1 T150f11(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.is_value_required */
extern T1 T150f10(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.has_default_value */
extern T1 T150f9(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.is_value_fixed */
extern T1 T150f8(T0* C);
/* XM_DTD_ATTRIBUTE_CONTENT.set_name */
extern void T150f13(T0* C, T0* a1);
/* KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]].resize */
extern T0* T167f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]].aliased_resized_area */
extern T0* T164f3(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]].make */
extern T0* T167f1(T0* C, T6 a1);
/* TO_SPECIAL [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]].make_area */
extern T0* T249c2(T6 a1);
/* SPECIAL [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]].make */
extern T0* T164c4(T6 a1);
/* KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]].default_create */
extern T0* T167c3(void);
/* DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT].force_last */
extern void T149f9(T0* C, T0* a1);
/* DS_BILINKABLE [XM_DTD_ATTRIBUTE_CONTENT].put_right */
extern void T240f5(T0* C, T0* a1);
/* DS_BILINKABLE [XM_DTD_ATTRIBUTE_CONTENT].attach_left */
extern void T240f6(T0* C, T0* a1);
/* DS_BILINKABLE [XM_DTD_ATTRIBUTE_CONTENT].make */
extern T0* T240c4(T0* a1);
/* DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT].is_empty */
extern T1 T149f5(T0* C);
/* XM_EIFFEL_PARSER.new_dtd_attribute_content_list */
extern T0* T93f153(T0* C);
/* DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT].make */
extern T0* T149c8(void);
/* DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT].new_cursor */
extern T0* T149f6(T0* C);
/* DS_BILINKED_LIST_CURSOR [XM_DTD_ATTRIBUTE_CONTENT].make */
extern T0* T239c7(T0* a1);
/* XM_EIFFEL_PARSER.on_attribute_declarations */
extern void T93f248(T0* C, T0* a1, T0* a2);
/* DS_BILINKED_LIST_CURSOR [XM_DTD_ATTRIBUTE_CONTENT].forth */
extern void T239f9(T0* C);
/* DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT].cursor_forth */
extern void T149f11(T0* C, T0* a1);
/* DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT].add_traversing_cursor */
extern void T149f12(T0* C, T0* a1);
/* DS_BILINKED_LIST_CURSOR [XM_DTD_ATTRIBUTE_CONTENT].set_next_cursor */
extern void T239f11(T0* C, T0* a1);
/* DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT].remove_traversing_cursor */
extern void T149f13(T0* C, T0* a1);
/* DS_BILINKED_LIST_CURSOR [XM_DTD_ATTRIBUTE_CONTENT].set */
extern void T239f10(T0* C, T0* a1, T1 a2, T1 a3);
/* XM_EIFFEL_PARSER.on_attribute_declaration */
extern void T93f258(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_DTD_CALLBACKS_NULL.on_attribute_declaration */
extern void T174f9(T0* C, T0* a1, T0* a2, T0* a3);
/* DS_BILINKED_LIST_CURSOR [XM_DTD_ATTRIBUTE_CONTENT].item */
extern T0* T239f6(T0* C);
/* DS_BILINKED_LIST_CURSOR [XM_DTD_ATTRIBUTE_CONTENT].start */
extern void T239f8(T0* C);
/* DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT].cursor_start */
extern void T149f10(T0* C, T0* a1);
/* DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT].cursor_off */
extern T1 T149f7(T0* C, T0* a1);
/* XM_DTD_ELEMENT_CONTENT.set_zero_or_more */
extern void T148f11(T0* C);
/* XM_DTD_ELEMENT_CONTENT.make_mixed */
extern T0* T148c10(void);
/* XM_DTD_ELEMENT_CONTENT.set_content_mixed */
extern void T148f21(T0* C);
/* XM_DTD_ELEMENT_CONTENT.set_choice */
extern void T148f19(T0* C);
/* XM_DTD_ELEMENT_CONTENT.make_list */
extern void T148f16(T0* C);
/* XM_DTD_ELEMENT_CONTENT.set_default */
extern void T148f22(T0* C);
/* XM_DTD_ELEMENT_CONTENT.set_one */
extern void T148f12(T0* C);
/* XM_DTD_ELEMENT_CONTENT.set_sequence */
extern void T148f20(T0* C);
/* DS_BILINKED_LIST [XM_DTD_ELEMENT_CONTENT].make */
extern T0* T238c7(void);
/* DS_BILINKED_LIST [XM_DTD_ELEMENT_CONTENT].new_cursor */
extern T0* T238f6(T0* C);
/* DS_BILINKED_LIST_CURSOR [XM_DTD_ELEMENT_CONTENT].make */
extern T0* T343c3(T0* a1);
/* XM_DTD_ELEMENT_CONTENT.make_sequence */
extern T0* T148c9(void);
/* DS_BILINKED_LIST [XM_DTD_ELEMENT_CONTENT].force_last */
extern void T238f9(T0* C, T0* a1);
/* DS_BILINKABLE [XM_DTD_ELEMENT_CONTENT].put_right */
extern void T344f5(T0* C, T0* a1);
/* DS_BILINKABLE [XM_DTD_ELEMENT_CONTENT].attach_left */
extern void T344f6(T0* C, T0* a1);
/* DS_BILINKABLE [XM_DTD_ELEMENT_CONTENT].make */
extern T0* T344c4(T0* a1);
/* DS_BILINKED_LIST [XM_DTD_ELEMENT_CONTENT].is_empty */
extern T1 T238f5(T0* C);
/* XM_DTD_ELEMENT_CONTENT.make_choice */
extern T0* T148c8(void);
/* DS_BILINKED_LIST [XM_DTD_ELEMENT_CONTENT].force_first */
extern void T238f8(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.element_name */
extern T0* T93f147(T0* C, T0* a1);
/* XM_DTD_ELEMENT_CONTENT.make_name */
extern T0* T148c15(T0* a1);
/* XM_EIFFEL_PARSER.set_element_repetition */
extern void T93f247(T0* C, T0* a1, T0* a2);
/* XM_DTD_ELEMENT_CONTENT.set_zero_or_one */
extern void T148f14(T0* C);
/* XM_DTD_ELEMENT_CONTENT.set_one_or_more */
extern void T148f13(T0* C);
/* XM_DTD_ELEMENT_CONTENT.make_any */
extern T0* T148c7(void);
/* XM_DTD_ELEMENT_CONTENT.set_content_any */
extern void T148f18(T0* C);
/* KL_SPECIAL_ROUTINES [XM_DTD_ELEMENT_CONTENT].resize */
extern T0* T162f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [XM_DTD_ELEMENT_CONTENT].aliased_resized_area */
extern T0* T161f3(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [XM_DTD_ELEMENT_CONTENT].make */
extern T0* T162f1(T0* C, T6 a1);
/* TO_SPECIAL [XM_DTD_ELEMENT_CONTENT].make_area */
extern T0* T248c2(T6 a1);
/* SPECIAL [XM_DTD_ELEMENT_CONTENT].make */
extern T0* T161c4(T6 a1);
/* KL_SPECIAL_ROUTINES [XM_DTD_ELEMENT_CONTENT].default_create */
extern T0* T162c3(void);
/* XM_DTD_ELEMENT_CONTENT.make_empty */
extern T0* T148c6(void);
/* XM_DTD_ELEMENT_CONTENT.set_content_empty */
extern void T148f17(T0* C);
/* XM_EIFFEL_PARSER.on_element_declaration */
extern void T93f246(T0* C, T0* a1, T0* a2);
/* XM_DTD_CALLBACKS_NULL.on_element_declaration */
extern void T174f6(T0* C, T0* a1, T0* a2);
/* XM_EIFFEL_PARSER.on_attribute */
extern void T93f245(T0* C, T0* a1, T0* a2, T0* a3, T0* a4);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].has */
extern T1 T147f30(T0* C, T0* a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].search_position */
extern void T147f34(T0* C, T0* a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].clashes_item */
extern T6 T147f22(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].hash_position */
extern T6 T147f24(T0* C, T0* a1);
/* XM_EIFFEL_PARSER_NAME.hash_code */
extern T6 T144f9(T0* C);
/* XM_EIFFEL_PARSER_NAME.item */
extern T0* T144f13(T0* C, T6 a1);
/* DS_BILINKED_LIST [STRING_8].item */
extern T0* T151f8(T0* C, T6 a1);
/* KL_EQUALITY_TESTER [XM_EIFFEL_PARSER_NAME].test */
extern T1 T236f1(T0* C, T0* a1, T0* a2);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].key_storage_item */
extern T0* T147f18(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].item_storage_item */
extern T0* T147f29(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].key_equality_tester */
extern T0* T147f17(T0* C);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].slots_item */
extern T6 T147f25(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]].resize */
extern T0* T160f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]].aliased_resized_area */
extern T0* T159f2(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]].make */
extern T0* T160f1(T0* C, T6 a1);
/* TO_SPECIAL [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]].make_area */
extern T0* T247c2(T6 a1);
/* SPECIAL [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]].make */
extern T0* T159c4(T6 a1);
/* KL_SPECIAL_ROUTINES [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]].default_create */
extern T0* T160c3(void);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].force_new */
extern void T147f33(T0* C, T0* a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].item_storage_put */
extern void T147f40(T0* C, T0* a1, T6 a2);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].slots_put */
extern void T147f39(T0* C, T6 a1, T6 a2);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].clashes_put */
extern void T147f38(T0* C, T6 a1, T6 a2);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].resize */
extern void T147f37(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].clashes_resize */
extern void T147f48(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].special_integer_ */
extern T0* T147f28(T0* C);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].key_storage_resize */
extern void T147f47(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].item_storage_resize */
extern void T147f46(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].slots_resize */
extern void T147f45(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].new_modulus */
extern T6 T147f19(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].new_capacity */
extern T6 T147f26(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].unset_found_item */
extern void T147f36(T0* C);
/* XM_EIFFEL_PARSER.new_name_set */
extern T0* T93f134(T0* C);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].make_equal */
extern T0* T147c32(T6 a1);
/* KL_EQUALITY_TESTER [XM_EIFFEL_PARSER_NAME].default_create */
extern T0* T236c2(void);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].make */
extern void T147f35(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].new_cursor */
extern T0* T147f21(T0* C);
/* DS_HASH_SET_CURSOR [XM_EIFFEL_PARSER_NAME].make */
extern T0* T237c3(T0* a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].make_slots */
extern void T147f44(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].make_clashes */
extern void T147f43(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].make_key_storage */
extern void T147f42(T0* C, T6 a1);
/* DS_HASH_SET [XM_EIFFEL_PARSER_NAME].make_item_storage */
extern void T147f41(T0* C, T6 a1);
/* XM_EIFFEL_PARSER.on_start_tag */
extern void T93f244(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_EIFFEL_PARSER.on_end_tag */
extern void T93f243(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_EIFFEL_PARSER_NAME.local_part */
extern T0* T144f12(T0* C);
/* DS_BILINKED_LIST_CURSOR [STRING_8].forth */
extern void T242f9(T0* C);
/* DS_BILINKED_LIST [STRING_8].cursor_forth */
extern void T151f15(T0* C, T0* a1);
/* DS_BILINKED_LIST [STRING_8].add_traversing_cursor */
extern void T151f16(T0* C, T0* a1);
/* DS_BILINKED_LIST_CURSOR [STRING_8].set_next_cursor */
extern void T242f11(T0* C, T0* a1);
/* DS_BILINKED_LIST [STRING_8].remove_traversing_cursor */
extern void T151f17(T0* C, T0* a1);
/* DS_BILINKED_LIST_CURSOR [STRING_8].set */
extern void T242f10(T0* C, T0* a1, T1 a2, T1 a3);
/* DS_BILINKED_LIST_CURSOR [STRING_8].item */
extern T0* T242f6(T0* C);
/* DS_BILINKED_LIST_CURSOR [STRING_8].start */
extern void T242f8(T0* C);
/* DS_BILINKED_LIST [STRING_8].cursor_start */
extern void T151f14(T0* C, T0* a1);
/* DS_BILINKED_LIST [STRING_8].cursor_off */
extern T1 T151f10(T0* C, T0* a1);
/* XM_EIFFEL_PARSER_NAME.string_ */
extern T0* T144f17(T0* C);
/* XM_EIFFEL_PARSER_NAME.last */
extern T0* T144f16(T0* C);
/* DS_BILINKED_LIST [STRING_8].last */
extern T0* T151f9(T0* C);
/* XM_EIFFEL_PARSER_NAME.ns_prefix */
extern T0* T144f11(T0* C);
/* XM_EIFFEL_PARSER_NAME.is_namespace_name */
extern T1 T144f15(T0* C);
/* XM_EIFFEL_PARSER.on_start_tag_finish */
extern void T93f242(T0* C);
/* XM_EIFFEL_PARSER_NAME.is_equal */
extern T1 T144f10(T0* C, T0* a1);
/* XM_EIFFEL_PARSER_NAME.same_string */
extern T1 T144f14(T0* C, T0* a1, T0* a2);
/* XM_EIFFEL_PARSER_NAME.string_equality_tester */
extern T0* T144f8(T0* C);
/* KL_SPECIAL_ROUTINES [BOOLEAN].resize */
extern T0* T158f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [BOOLEAN].aliased_resized_area */
extern T0* T156f3(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [BOOLEAN].make */
extern T0* T158f1(T0* C, T6 a1);
/* TO_SPECIAL [BOOLEAN].make_area */
extern T0* T246c2(T6 a1);
/* KL_SPECIAL_ROUTINES [BOOLEAN].default_create */
extern T0* T158c3(void);
/* XM_EIFFEL_PARSER.when_external_dtd */
extern void T93f241(T0* C, T0* a1);
/* XM_NULL_EXTERNAL_RESOLVER.last_error */
extern T0* T141f2(T0* C);
/* XM_EIFFEL_PARSER.null_resolver */
extern unsigned char ge1536os4996;
extern T0* ge1536ov4996;
extern T0* T93f103(T0* C);
/* XM_EIFFEL_SCANNER_DTD.make_scanner */
extern T0* T175c198(void);
/* XM_EIFFEL_SCANNER_DTD.set_start_condition */
extern void T175f205(T0* C, T6 a1);
/* XM_EIFFEL_SCANNER_DTD.make_scanner */
extern void T175f198p1(T0* C);
/* XM_EIFFEL_SCANNER_DTD.reset */
extern void T175f207(T0* C);
/* XM_EIFFEL_SCANNER_DTD.reset */
extern void T175f207p1(T0* C);
/* XM_EIFFEL_SCANNER_DTD.make_with_buffer */
extern void T175f206(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.yy_load_input_buffer */
extern void T175f217(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_set_content */
extern void T175f218(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.special_integer_ */
extern T0* T175f183(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_initialize */
extern void T175f216(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_build_tables */
extern void T175f221(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_accept_template */
extern T0* T175f192(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_fixed_array */
extern T0* T175f195(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.yy_meta_template */
extern T0* T175f191(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_ec_template */
extern T0* T175f190(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_def_template */
extern T0* T175f189(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_base_template */
extern T0* T175f188(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_chk_template */
extern T0* T175f187(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_chk_template_6 */
extern void T175f233(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.yy_array_subcopy */
extern void T175f234(T0* C, T0* a1, T0* a2, T6 a3, T6 a4, T6 a5);
/* XM_EIFFEL_SCANNER_DTD.integer_array_ */
extern T0* T175f197(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_chk_template_5 */
extern void T175f232(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.yy_chk_template_4 */
extern void T175f231(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.yy_chk_template_3 */
extern void T175f230(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.yy_chk_template_2 */
extern void T175f229(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.yy_chk_template_1 */
extern void T175f228(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.yy_nxt_template */
extern T0* T175f186(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_nxt_template_6 */
extern void T175f227(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.yy_nxt_template_5 */
extern void T175f226(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.yy_nxt_template_4 */
extern void T175f225(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.yy_nxt_template_3 */
extern void T175f224(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.yy_nxt_template_2 */
extern void T175f223(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.yy_nxt_template_1 */
extern void T175f222(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.empty_buffer */
extern T0* T175f49(T0* C);
/* DS_LINKED_STACK [XM_EIFFEL_SCANNER].force */
extern void T137f8(T0* C, T0* a1);
/* XM_NULL_EXTERNAL_RESOLVER.has_error */
extern T1 T141f1(T0* C);
/* XM_EIFFEL_PARSER.resolve_external_id */
extern void T93f257(T0* C, T0* a1, T0* a2);
/* XM_NULL_EXTERNAL_RESOLVER.resolve */
extern void T141f6(T0* C, T0* a1);
/* XM_NULL_EXTERNAL_RESOLVER.resolve_public */
extern void T141f5(T0* C, T0* a1, T0* a2);
/* XM_DTD_EXTERNAL_ID.is_public */
extern T1 T146f3(T0* C);
/* XM_EIFFEL_PARSER.on_dtd_end */
extern void T93f240(T0* C);
/* XM_DTD_CALLBACKS_NULL.on_dtd_end */
extern void T174f5(T0* C);
/* XM_EIFFEL_PARSER.on_doctype */
extern void T93f239(T0* C, T0* a1, T0* a2, T1 a3);
/* XM_DTD_CALLBACKS_NULL.on_doctype */
extern void T174f4(T0* C, T0* a1, T0* a2, T1 a3);
/* XM_DTD_CALLBACKS_NULL.make */
extern T0* T174c1(void);
/* XM_EIFFEL_DECLARATION.set_encoding */
extern void T145f9(T0* C, T0* a1);
/* XM_EIFFEL_DECLARATION.set_stand_alone */
extern void T145f8(T0* C, T1 a1);
/* XM_EIFFEL_DECLARATION.set_version */
extern void T145f11(T0* C, T0* a1);
/* KL_SPECIAL_ROUTINES [XM_EIFFEL_DECLARATION].resize */
extern T0* T155f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [XM_EIFFEL_DECLARATION].aliased_resized_area */
extern T0* T154f3(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [XM_EIFFEL_DECLARATION].make */
extern T0* T155f1(T0* C, T6 a1);
/* TO_SPECIAL [XM_EIFFEL_DECLARATION].make_area */
extern T0* T245c2(T6 a1);
/* SPECIAL [XM_EIFFEL_DECLARATION].make */
extern T0* T154c4(T6 a1);
/* KL_SPECIAL_ROUTINES [XM_EIFFEL_DECLARATION].default_create */
extern T0* T155c3(void);
/* XM_EIFFEL_DECLARATION.make */
extern T0* T145c7(void);
/* XM_EIFFEL_DECLARATION.process */
extern void T145f10(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.on_xml_declaration */
extern void T93f261(T0* C, T0* a1, T0* a2, T1 a3);
/* XM_EIFFEL_PARSER.apply_encoding */
extern void T93f238(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.on_content */
extern void T93f237(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.on_dtd_processing_instruction */
extern void T93f236(T0* C, T0* a1, T0* a2);
/* XM_DTD_CALLBACKS_NULL.on_dtd_processing_instruction */
extern void T174f3(T0* C, T0* a1, T0* a2);
/* XM_EIFFEL_PARSER.on_processing_instruction */
extern void T93f235(T0* C, T0* a1, T0* a2);
/* XM_EIFFEL_PARSER.on_dtd_comment */
extern void T93f234(T0* C, T0* a1);
/* XM_DTD_CALLBACKS_NULL.on_dtd_comment */
extern void T174f2(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.on_comment */
extern void T93f233(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.entity_referenced_in_entity_value */
extern T0* T93f117(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.defined_entity_referenced */
extern T0* T93f194(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.external_entity_to_string */
extern T0* T93f200(T0* C, T0* a1);
/* STRING_8.put */
extern void T17f50(T0* C, T2 a1, T6 a2);
/* STRING_8.remove */
extern void T17f49(T0* C, T6 a1);
/* XM_NULL_EXTERNAL_RESOLVER.resolve_finish */
extern void T141f7(T0* C);
/* XM_EIFFEL_INPUT_STREAM.read_string */
extern void T209f29(T0* C, T6 a1);
/* XM_EIFFEL_INPUT_STREAM.last_character */
extern T2 T209f19(T0* C);
/* DS_LINKED_QUEUE [CHARACTER_8].item */
extern T2 T326f5(T0* C);
/* XM_EIFFEL_INPUT_STREAM.end_of_input */
extern T1 T209f18(T0* C);
/* KL_TEXT_INPUT_FILE.end_of_input */
extern T1 T55f28(T0* C);
/* XM_EIFFEL_INPUT_STREAM.read_character */
extern void T209f31(T0* C);
/* DS_LINKED_QUEUE [CHARACTER_8].remove */
extern void T326f7(T0* C);
/* DS_LINKED_QUEUE [CHARACTER_8].wipe_out */
extern void T326f9(T0* C);
/* XM_EIFFEL_INPUT_STREAM.noqueue_read_character */
extern void T209f33(T0* C);
/* XM_EIFFEL_INPUT_STREAM.utf16_read_character */
extern void T209f35(T0* C);
/* XM_EIFFEL_INPUT_STREAM.append_character */
extern void T209f36(T0* C, T6 a1);
/* DS_LINKED_QUEUE [CHARACTER_8].force */
extern void T326f8(T0* C, T2 a1);
/* DS_LINKABLE [CHARACTER_8].put_right */
extern void T469f4(T0* C, T0* a1);
/* DS_LINKED_QUEUE [CHARACTER_8].is_empty */
extern T1 T326f4(T0* C);
/* DS_LINKABLE [CHARACTER_8].make */
extern T0* T469c3(T2 a1);
/* UC_UTF8_ROUTINES.append_code_to_utf8 */
extern void T206f37(T0* C, T0* a1, T6 a2);
/* UC_UTF8_ROUTINES.integer_ */
extern T0* T206f29(T0* C);
/* XM_EIFFEL_INPUT_STREAM.utf8 */
extern T0* T209f22(T0* C);
/* KL_STRING_ROUTINES.wipe_out */
extern void T76f21(T0* C, T0* a1);
/* UC_UTF8_STRING.old_clear_all */
extern void T207f87(T0* C);
/* XM_EIFFEL_INPUT_STREAM.string_ */
extern T0* T209f17(T0* C);
/* XM_EIFFEL_INPUT_STREAM.utf8_buffer */
extern unsigned char ge1531os7365;
extern T0* ge1531ov7365;
extern T0* T209f25(T0* C);
/* UC_UTF16_ROUTINES.surrogate */
extern T6 T327f7(T0* C, T6 a1, T6 a2);
/* UC_UTF16_ROUTINES.is_low_surrogate */
extern T1 T327f6(T0* C, T6 a1);
/* UC_UTF16_ROUTINES.least_10_bits */
extern T6 T327f5(T0* C, T6 a1, T6 a2);
/* UC_UTF16_ROUTINES.is_high_surrogate */
extern T1 T327f4(T0* C, T6 a1);
/* UC_UTF16_ROUTINES.is_surrogate */
extern T1 T327f3(T0* C, T6 a1);
/* XM_EIFFEL_INPUT_STREAM.utf16 */
extern unsigned char ge264os4781;
extern T0* ge264ov4781;
extern T0* T209f20(T0* C);
/* UC_UTF16_ROUTINES.default_create */
extern T0* T327c16(void);
/* XM_EIFFEL_INPUT_STREAM.least_significant */
extern T6 T209f24(T0* C, T2 a1, T2 a2);
/* XM_EIFFEL_INPUT_STREAM.most_significant */
extern T6 T209f23(T0* C, T2 a1, T2 a2);
/* XM_EIFFEL_INPUT_STREAM.latin1_read_character */
extern void T209f34(T0* C);
/* KL_STRING_INPUT_STREAM.read_character */
extern void T491f10(T0* C);
/* KL_TEXT_INPUT_FILE.read_character */
extern void T55f66(T0* C);
/* KL_TEXT_INPUT_FILE.old_read_character */
extern void T55f67(T0* C);
/* KL_TEXT_INPUT_FILE.file_gc */
extern T2 T55f31(T0* C, T14 a1);
/* KL_TEXT_INPUT_FILE.old_end_of_file */
extern T1 T55f30(T0* C);
/* KL_TEXT_INPUT_FILE.file_feof */
extern T1 T55f32(T0* C, T14 a1);
/* XM_EIFFEL_INPUT_STREAM.utf16_detect_read_character */
extern void T209f32(T0* C);
/* UC_UTF8_ROUTINES.is_endian_detection_character */
extern T1 T206f31(T0* C, T2 a1, T2 a2, T2 a3);
/* UC_UTF8_ROUTINES.is_endian_detection_character_start */
extern T1 T206f30(T0* C, T2 a1, T2 a2);
/* UC_UTF16_ROUTINES.is_endian_detection_character_least_first */
extern T1 T327f2(T0* C, T6 a1, T6 a2);
/* UC_UTF16_ROUTINES.is_endian_detection_character_most_first */
extern T1 T327f1(T0* C, T6 a1, T6 a2);
/* STRING_8.clear_all */
extern void T17f51(T0* C);
/* KL_PLATFORM.maximum_integer */
extern unsigned char ge247os7426;
extern T6 ge247ov7426;
extern T6 T211f2(T0* C);
/* KL_INTEGER_ROUTINES.platform */
extern T0* T210f1(T0* C);
/* XM_EIFFEL_PARSER.integer_ */
extern T0* T93f201(T0* C);
/* XM_EIFFEL_INPUT_STREAM.make_from_stream */
extern T0* T209c28(T0* a1);
/* DS_LINKED_QUEUE [CHARACTER_8].make */
extern T0* T326c6(void);
/* XM_NULL_EXTERNAL_RESOLVER.last_stream */
extern T0* T141f3(T0* C);
/* XM_EIFFEL_ENTITY_DEF.is_literal */
extern T1 T171f62(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.is_literal */
extern T1 T177f63(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.is_external */
extern T1 T177f66(T0* C);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].item */
extern T0* T139f21(T0* C, T0* a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].item_storage_item */
extern T0* T139f36(T0* C, T6 a1);
/* XM_EIFFEL_PARSER.force_error */
extern void T93f232(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.report_error */
extern void T93f230(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.on_error */
extern void T93f256(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.setup_error_state */
extern void T93f255(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.onstring_utf8 */
extern T0* T93f96(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.maximum_item_code */
extern T6 T93f189(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.is_string_mode_latin1 */
extern T1 T93f188(T0* C);
/* XM_EIFFEL_PARSER.new_unicode_string_from_utf8 */
extern T0* T93f184(T0* C, T0* a1);
/* UC_UTF8_STRING.make_from_utf8 */
extern T0* T207c56(T0* a1);
/* UC_UTF8_STRING.append_utf8 */
extern void T207f64(T0* C, T0* a1);
/* UC_UTF8_ROUTINES.valid_utf8 */
extern T1 T206f1(T0* C, T0* a1);
/* UC_UTF8_ROUTINES.is_encoded_next_byte */
extern T1 T206f10(T0* C, T2 a1);
/* UC_UTF8_ROUTINES.is_encoded_second_byte */
extern T1 T206f5(T0* C, T2 a1, T2 a2);
/* UC_UTF8_ROUTINES.is_encoded_first_byte */
extern T1 T206f2(T0* C, T2 a1);
/* XM_EIFFEL_PARSER.utf8 */
extern T0* T93f187(T0* C);
/* XM_EIFFEL_PARSER.is_string_mode_ascii */
extern T1 T93f185(T0* C);
/* XM_EIFFEL_PARSER.onstring_ascii */
extern T0* T93f94(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.is_string_mode_unicode */
extern T1 T93f183(T0* C);
/* XM_EIFFEL_PARSER.shared_empty_string */
extern T0* T93f115(T0* C);
/* XM_EIFFEL_PARSER.shared_empty_string_string */
extern unsigned char ge1536os5063;
extern T0* ge1536ov5063;
extern T0* T93f193(T0* C);
/* XM_EIFFEL_PARSER.shared_empty_string_uc */
extern unsigned char ge1536os5064;
extern T0* ge1536ov5064;
extern T0* T93f192(T0* C);
/* XM_EIFFEL_PARSER.new_unicode_string_empty */
extern T0* T93f199(T0* C);
/* UC_UTF8_STRING.make_empty */
extern T0* T207c60(void);
/* KL_SPECIAL_ROUTINES [XM_EIFFEL_PARSER_NAME].resize */
extern T0* T153f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [XM_EIFFEL_PARSER_NAME].aliased_resized_area */
extern T0* T152f2(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [XM_EIFFEL_PARSER_NAME].make */
extern T0* T153f1(T0* C, T6 a1);
/* TO_SPECIAL [XM_EIFFEL_PARSER_NAME].make_area */
extern T0* T244c2(T6 a1);
/* SPECIAL [XM_EIFFEL_PARSER_NAME].make */
extern T0* T152c4(T6 a1);
/* KL_SPECIAL_ROUTINES [XM_EIFFEL_PARSER_NAME].default_create */
extern T0* T153c3(void);
/* XM_EIFFEL_PARSER.namespace_force_last */
extern void T93f231(T0* C, T0* a1, T0* a2);
/* XM_EIFFEL_PARSER_NAME.force_last */
extern void T144f19(T0* C, T0* a1);
/* XM_EIFFEL_PARSER_NAME.new_string_bilinked_list */
extern T0* T144f7(T0* C);
/* XM_EIFFEL_PARSER_NAME.can_force_last */
extern T1 T144f6(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.new_namespace_name */
extern T0* T93f111(T0* C);
/* XM_EIFFEL_PARSER_NAME.make_no_namespaces */
extern void T144f20(T0* C);
/* XM_EIFFEL_PARSER_NAME.make_no_namespaces */
extern T0* T144c20(void);
/* XM_EIFFEL_PARSER_NAME.make_namespaces */
extern T0* T144c18(void);
/* XM_EIFFEL_PARSER.yy_push_last_value */
extern void T93f221(T0* C, T6 a1);
/* XM_EIFFEL_PARSER.accept */
extern void T93f220(T0* C);
/* XM_EIFFEL_PARSER.yy_do_error_action */
extern void T93f218(T0* C, T6 a1);
/* XM_EIFFEL_PARSER.report_eof_expected_error */
extern void T93f229(T0* C);
/* XM_EIFFEL_PARSER.read_token */
extern void T93f217(T0* C);
/* XM_EIFFEL_PARSER.process_attribute_entity */
extern void T93f228(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.process_entity_scanner */
extern void T93f254(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.set_start_condition */
extern void T171f229(T0* C, T6 a1);
/* XM_EIFFEL_PE_ENTITY_DEF.set_start_condition */
extern void T177f233(T0* C, T6 a1);
/* XM_EIFFEL_ENTITY_DEF.has_error */
extern T1 T171f55(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.has_error */
extern T1 T177f56(T0* C);
/* XM_EIFFEL_ENTITY_DEF.apply_input_buffer */
extern void T171f228(T0* C);
/* KL_STRING_INPUT_STREAM.make */
extern T0* T491c9(T0* a1);
/* UC_UTF8_ROUTINES.to_utf8 */
extern T0* T206f35(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.utf8 */
extern T0* T171f66(T0* C);
/* XM_EIFFEL_ENTITY_DEF.fatal_error */
extern void T171f236(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.apply_input_buffer */
extern void T177f232(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.utf8 */
extern T0* T177f68(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.fatal_error */
extern void T177f240(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.process_entity */
extern void T93f227(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.process_pe_entity */
extern void T93f226(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.special_integer_ */
extern T0* T93f113(T0* C);
/* XM_EIFFEL_PARSER.yy_init_value_stacks */
extern void T93f216(T0* C);
/* XM_EIFFEL_PARSER.yy_clear_all */
extern void T93f225(T0* C);
/* XM_EIFFEL_PARSER.clear_all */
extern void T93f253(T0* C);
/* XM_EIFFEL_PARSER.clear_stacks */
extern void T93f259(T0* C);
/* XM_EIFFEL_PARSER.yy_clear_value_stacks */
extern void T93f260(T0* C);
/* SPECIAL [XM_EIFFEL_DECLARATION].clear_all */
extern void T154f6(T0* C);
/* SPECIAL [DS_BILINKED_LIST [STRING_8]].clear_all */
extern void T169f6(T0* C);
/* SPECIAL [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]].clear_all */
extern void T164f6(T0* C);
/* SPECIAL [XM_DTD_ATTRIBUTE_CONTENT].clear_all */
extern void T166f6(T0* C);
/* SPECIAL [XM_DTD_ELEMENT_CONTENT].clear_all */
extern void T161f6(T0* C);
/* SPECIAL [XM_DTD_EXTERNAL_ID].clear_all */
extern void T157f6(T0* C);
/* SPECIAL [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]].clear_all */
extern void T159f6(T0* C);
/* SPECIAL [XM_EIFFEL_PARSER_NAME].clear_all */
extern void T152f6(T0* C);
/* XM_EIFFEL_PARSER.abort */
extern void T93f219(T0* C);
/* XM_EIFFEL_PARSER.on_start */
extern void T93f213(T0* C);
/* XM_CALLBACKS_NULL.make */
extern T0* T138c1(void);
/* XM_EIFFEL_PARSER.reset_error_state */
extern void T93f212(T0* C);
/* XM_EIFFEL_PARSER.reset */
extern void T93f208(T0* C);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].wipe_out */
extern void T139f39(T0* C);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].slots_wipe_out */
extern void T139f49(T0* C);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].clashes_wipe_out */
extern void T139f48(T0* C);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].key_storage_wipe_out */
extern void T139f47(T0* C);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].item_storage_wipe_out */
extern void T139f46(T0* C);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].move_all_cursors_after */
extern void T139f44(T0* C);
/* DS_HASH_TABLE_CURSOR [XM_EIFFEL_ENTITY_DEF, STRING_8].set_next_cursor */
extern void T232f6(T0* C, T0* a1);
/* DS_HASH_TABLE_CURSOR [XM_EIFFEL_ENTITY_DEF, STRING_8].set_position */
extern void T232f5(T0* C, T6 a1);
/* XM_EIFFEL_PARSER.make_scanner */
extern void T93f206(T0* C);
/* XM_EIFFEL_SCANNER.make_scanner */
extern T0* T133c196(void);
/* XM_EIFFEL_SCANNER.reset */
extern void T133f204(T0* C);
/* XM_EIFFEL_SCANNER.reset */
extern void T133f204p1(T0* C);
/* XM_EIFFEL_SCANNER.make_with_buffer */
extern void T133f203(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.yy_load_input_buffer */
extern void T133f212(T0* C);
/* XM_EIFFEL_SCANNER.yy_set_content */
extern void T133f213(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.special_integer_ */
extern T0* T133f181(T0* C);
/* XM_EIFFEL_SCANNER.yy_initialize */
extern void T133f211(T0* C);
/* XM_EIFFEL_SCANNER.yy_build_tables */
extern void T133f219(T0* C);
/* XM_EIFFEL_SCANNER.yy_accept_template */
extern T0* T133f190(T0* C);
/* XM_EIFFEL_SCANNER.yy_fixed_array */
extern T0* T133f193(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.yy_meta_template */
extern T0* T133f189(T0* C);
/* XM_EIFFEL_SCANNER.yy_ec_template */
extern T0* T133f188(T0* C);
/* XM_EIFFEL_SCANNER.yy_def_template */
extern T0* T133f187(T0* C);
/* XM_EIFFEL_SCANNER.yy_base_template */
extern T0* T133f186(T0* C);
/* XM_EIFFEL_SCANNER.yy_chk_template */
extern T0* T133f185(T0* C);
/* XM_EIFFEL_SCANNER.yy_chk_template_6 */
extern void T133f231(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.yy_array_subcopy */
extern void T133f232(T0* C, T0* a1, T0* a2, T6 a3, T6 a4, T6 a5);
/* XM_EIFFEL_SCANNER.integer_array_ */
extern T0* T133f195(T0* C);
/* XM_EIFFEL_SCANNER.yy_chk_template_5 */
extern void T133f230(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.yy_chk_template_4 */
extern void T133f229(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.yy_chk_template_3 */
extern void T133f228(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.yy_chk_template_2 */
extern void T133f227(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.yy_chk_template_1 */
extern void T133f226(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.yy_nxt_template */
extern T0* T133f184(T0* C);
/* XM_EIFFEL_SCANNER.yy_nxt_template_6 */
extern void T133f225(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.yy_nxt_template_5 */
extern void T133f224(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.yy_nxt_template_4 */
extern void T133f223(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.yy_nxt_template_3 */
extern void T133f222(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.yy_nxt_template_2 */
extern void T133f221(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.yy_nxt_template_1 */
extern void T133f220(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.empty_buffer */
extern T0* T133f42(T0* C);
/* GEANT_PROJECT_PARSER.make */
extern T0* T56c8(T0* a1, T0* a2, T0* a3);
/* XM_CALLBACKS_TO_TREE_FILTER.enable_position_table */
extern void T97f10(T0* C, T0* a1);
/* XM_POSITION_TABLE.make */
extern T0* T101c4(void);
/* DS_LINKED_LIST [DS_PAIR [XM_POSITION, XM_NODE]].make */
extern T0* T181c8(void);
/* XM_EIFFEL_PARSER.set_callbacks */
extern void T93f204(T0* C, T0* a1);
/* XM_TREE_CALLBACKS_PIPE.make */
extern T0* T94c10(void);
/* XM_TREE_CALLBACKS_PIPE.callbacks_pipe */
extern T0* T94f9(T0* C, T0* a1);
/* ARRAY [XM_CALLBACKS_FILTER].item */
extern T0* T180f4(T0* C, T6 a1);
/* XM_CALLBACKS_TO_TREE_FILTER.make_null */
extern T0* T97c9(void);
/* XM_TREE_CALLBACKS_PIPE.new_stop_on_error */
extern T0* T94f7(T0* C);
/* XM_STOP_ON_ERROR_FILTER.make_null */
extern T0* T100c4(void);
/* XM_TREE_CALLBACKS_PIPE.new_namespace_resolver */
extern T0* T94f6(T0* C);
/* XM_NAMESPACE_RESOLVER.make_null */
extern T0* T178c25(void);
/* XM_EIFFEL_PARSER.set_string_mode_mixed */
extern void T93f203(T0* C);
/* XM_EIFFEL_PARSER.make */
extern T0* T93c202(void);
/* XM_EIFFEL_PARSER.new_entities_table */
extern T0* T93f87(T0* C);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].set_key_equality_tester */
extern void T139f41(T0* C, T0* a1);
/* DS_SPARSE_TABLE_KEYS [XM_EIFFEL_ENTITY_DEF, STRING_8].internal_set_equality_tester */
extern void T230f6(T0* C, T0* a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].make_map_default */
extern T0* T139c38(void);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].make_map */
extern void T139f43(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].make_with_equality_testers */
extern void T139f55(T0* C, T6 a1, T0* a2, T0* a3);
/* DS_SPARSE_TABLE_KEYS [XM_EIFFEL_ENTITY_DEF, STRING_8].make */
extern T0* T230c5(T0* a1);
/* DS_SPARSE_TABLE_KEYS [XM_EIFFEL_ENTITY_DEF, STRING_8].new_cursor */
extern T0* T230f4(T0* C);
/* DS_SPARSE_TABLE_KEYS_CURSOR [XM_EIFFEL_ENTITY_DEF, STRING_8].make */
extern T0* T341c3(T0* a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].new_cursor */
extern T0* T139f35(T0* C);
/* DS_HASH_TABLE_CURSOR [XM_EIFFEL_ENTITY_DEF, STRING_8].make */
extern T0* T232c4(T0* a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].make_sparse_container */
extern void T139f60(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].make_slots */
extern void T139f64(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].make_clashes */
extern void T139f63(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].make_key_storage */
extern void T139f62(T0* C, T6 a1);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].make_item_storage */
extern void T139f61(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [XM_EIFFEL_ENTITY_DEF].make */
extern T0* T234f2(T0* C, T6 a1);
/* TO_SPECIAL [XM_EIFFEL_ENTITY_DEF].make_area */
extern T0* T342c2(T6 a1);
/* SPECIAL [XM_EIFFEL_ENTITY_DEF].make */
extern T0* T229c4(T6 a1);
/* KL_SPECIAL_ROUTINES [XM_EIFFEL_ENTITY_DEF].default_create */
extern T0* T234c3(void);
/* DS_HASH_TABLE [XM_EIFFEL_ENTITY_DEF, STRING_8].default_capacity */
extern T6 T139f31(T0* C);
/* XM_EIFFEL_PARSER.make_parser */
extern void T93f207(T0* C);
/* XM_EIFFEL_PARSER.yy_build_parser_tables */
extern void T93f211(T0* C);
/* XM_EIFFEL_PARSER.yycheck_template */
extern unsigned char ge1532os4943;
extern T0* ge1532ov4943;
extern T0* T93f104(T0* C);
/* XM_EIFFEL_PARSER.yyfixed_array */
extern T0* T93f181(T0* C, T0* a1);
/* XM_EIFFEL_PARSER.yytable_template */
extern unsigned char ge1532os4942;
extern T0* ge1532ov4942;
extern T0* T93f92(T0* C);
/* XM_EIFFEL_PARSER.yypgoto_template */
extern unsigned char ge1532os4941;
extern T0* ge1532ov4941;
extern T0* T93f90(T0* C);
/* XM_EIFFEL_PARSER.yypact_template */
extern unsigned char ge1532os4940;
extern T0* ge1532ov4940;
extern T0* T93f88(T0* C);
/* XM_EIFFEL_PARSER.yydefgoto_template */
extern unsigned char ge1532os4939;
extern T0* ge1532ov4939;
extern T0* T93f86(T0* C);
/* XM_EIFFEL_PARSER.yydefact_template */
extern unsigned char ge1532os4938;
extern T0* ge1532ov4938;
extern T0* T93f84(T0* C);
/* XM_EIFFEL_PARSER.yytypes2_template */
extern unsigned char ge1532os4937;
extern T0* ge1532ov4937;
extern T0* T93f171(T0* C);
/* XM_EIFFEL_PARSER.yytypes1_template */
extern unsigned char ge1532os4936;
extern T0* ge1532ov4936;
extern T0* T93f155(T0* C);
/* XM_EIFFEL_PARSER.yyr1_template */
extern unsigned char ge1532os4935;
extern T0* ge1532ov4935;
extern T0* T93f136(T0* C);
/* XM_EIFFEL_PARSER.yytranslate_template */
extern unsigned char ge1532os4934;
extern T0* ge1532ov4934;
extern T0* T93f125(T0* C);
/* XM_EIFFEL_PARSER.yy_create_value_stacks */
extern void T93f210(T0* C);
/* XM_EXPAT_PARSER_FACTORY.new_expat_parser */
extern T0* T91f2(T0* C);
/* XM_EXPAT_PARSER_FACTORY.is_expat_parser_available */
extern T1 T91f1(T0* C);
/* XM_EXPAT_PARSER_FACTORY.default_create */
extern T0* T91c3(void);
/* KL_TEXT_INPUT_FILE.is_open_read */
extern T1 T55f16(T0* C);
/* KL_TEXT_INPUT_FILE.old_is_open_read */
extern T1 T55f15(T0* C);
/* KL_TEXT_INPUT_FILE.open_read */
extern void T55f58(T0* C);
/* KL_TEXT_INPUT_FILE.is_closed */
extern T1 T55f21(T0* C);
/* KL_TEXT_INPUT_FILE.old_is_closed */
extern T1 T55f18(T0* C);
/* KL_TEXT_INPUT_FILE.old_open_read */
extern void T55f64(T0* C);
/* KL_TEXT_INPUT_FILE.default_pointer */
extern T14 T55f25(T0* C);
/* KL_TEXT_INPUT_FILE.open_read */
extern void T55f64p1(T0* C);
/* KL_TEXT_INPUT_FILE.file_open */
extern T14 T55f26(T0* C, T14 a1, T6 a2);
/* KL_TEXT_INPUT_FILE.old_is_readable */
extern T1 T55f23(T0* C);
/* UNIX_FILE_INFO.is_readable */
extern T1 T87f3(T0* C);
/* UNIX_FILE_INFO.file_eaccess */
extern T1 T87f4(T0* C, T14 a1, T6 a2);
/* KL_TEXT_INPUT_FILE.make */
extern void T55f56(T0* C, T0* a1);
/* KL_TEXT_INPUT_FILE.make */
extern T0* T55c56(T0* a1);
/* KL_TEXT_INPUT_FILE.make */
extern void T55f56p1(T0* C, T0* a1);
/* KL_TEXT_INPUT_FILE.old_make */
extern void T55f62(T0* C, T0* a1);
/* KL_TEXT_INPUT_FILE.string_ */
extern T0* T55f17(T0* C);
/* GEANT_PROJECT_LOADER.make */
extern T0* T23c9(T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.is_file_readable */
extern T1 T53f2(T0* C, T0* a1);
/* KL_TEXT_INPUT_FILE.is_readable */
extern T1 T55f29(T0* C);
/* KL_UNIX_FILE_SYSTEM.is_file_readable */
extern T1 T54f2(T0* C, T0* a1);
/* GEANT.default_build_filename */
extern unsigned char ge51os1741;
extern T0* ge51ov1741;
extern T0* T21f8(T0* C);
/* GEANT_PROJECT_OPTIONS.set_no_exec */
extern void T24f8(T0* C, T1 a1);
/* GEANT_PROJECT_OPTIONS.set_debug_mode */
extern void T24f7(T0* C, T1 a1);
/* GEANT_PROJECT_OPTIONS.set_verbose */
extern void T24f6(T0* C, T1 a1);
/* GEANT_PROJECT_OPTIONS.make */
extern T0* T24c5(void);
/* GEANT_PROJECT_VARIABLES.make */
extern T0* T25c59(void);
/* GEANT_PROJECT_VARIABLES.verbose_name */
extern unsigned char ge57os1893;
extern T0* ge57ov1893;
extern T0* T25f38(T0* C);
/* GEANT_PROJECT_VARIABLES.exe_name */
extern unsigned char ge57os1892;
extern T0* ge57ov1892;
extern T0* T25f37(T0* C);
/* GEANT_PROJECT_VARIABLES.path_separator_name */
extern unsigned char ge57os1891;
extern T0* ge57ov1891;
extern T0* T25f34(T0* C);
/* GEANT_PROJECT_VARIABLES.is_unix_name */
extern unsigned char ge57os1890;
extern T0* ge57ov1890;
extern T0* T25f31(T0* C);
/* GEANT_PROJECT_VARIABLES.is_windows_name */
extern unsigned char ge57os1889;
extern T0* ge57ov1889;
extern T0* T25f28(T0* C);
/* GEANT_VARIABLES.value */
extern T0* T29f31(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.default_builtin_variables */
extern unsigned char ge59os1747;
extern T0* ge59ov1747;
extern T0* T25f25(T0* C);
/* GEANT_PROJECT_VARIABLES.file_system */
extern T0* T25f40(T0* C);
/* GEANT_PROJECT_VARIABLES.unix_file_system */
extern T0* T25f43(T0* C);
/* GEANT_PROJECT_VARIABLES.windows_file_system */
extern T0* T25f42(T0* C);
/* GEANT_PROJECT_VARIABLES.operating_system */
extern T0* T25f39(T0* C);
/* GEANT_PROJECT_VARIABLES.gobo_os_name */
extern unsigned char ge57os1888;
extern T0* ge57ov1888;
extern T0* T25f24(T0* C);
/* GEANT_PROJECT_VARIABLES.project_variables_resolver */
extern T0* T25f23(T0* C);
/* GEANT_PROJECT_VARIABLES.make */
extern void T25f59p1(T0* C);
/* GEANT_PROJECT_VARIABLES.set_key_equality_tester */
extern void T25f62(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.make_map */
extern void T25f61(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.make_with_equality_testers */
extern void T25f64(T0* C, T6 a1, T0* a2, T0* a3);
/* GEANT_PROJECT_VARIABLES.make_sparse_container */
extern void T25f72(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.unset_found_item */
extern void T25f65(T0* C);
/* GEANT_PROJECT_VARIABLES.make_slots */
extern void T25f80(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.special_integer_ */
extern T0* T25f36(T0* C);
/* GEANT_PROJECT_VARIABLES.new_modulus */
extern T6 T25f29(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.make_clashes */
extern void T25f79(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.make_key_storage */
extern void T25f78(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.make_item_storage */
extern void T25f77(T0* C, T6 a1);
/* GEANT.default_builtin_variables */
extern T0* T21f9(T0* C);
/* GEANT.file_system */
extern T0* T21f17(T0* C);
/* GEANT.unix_file_system */
extern T0* T21f19(T0* C);
/* GEANT.windows_file_system */
extern T0* T21f18(T0* C);
/* GEANT.operating_system */
extern T0* T21f16(T0* C);
/* GEANT.read_command_line */
extern void T21f21(T0* C);
/* DS_ARRAYED_LIST [STRING_8].first */
extern T0* T71f17(T0* C);
/* GEANT_VARIABLES.force */
extern void T29f50(T0* C, T0* a1, T0* a2);
/* GEANT_VARIABLES.key_storage_put */
extern void T29f59(T0* C, T0* a1, T6 a2);
/* GEANT_VARIABLES.slots_put */
extern void T29f58(T0* C, T6 a1, T6 a2);
/* GEANT_VARIABLES.clashes_put */
extern void T29f57(T0* C, T6 a1, T6 a2);
/* GEANT_VARIABLES.resize */
extern void T29f56(T0* C, T6 a1);
/* GEANT_VARIABLES.clashes_resize */
extern void T29f64(T0* C, T6 a1);
/* GEANT_VARIABLES.key_storage_resize */
extern void T29f63(T0* C, T6 a1);
/* GEANT_VARIABLES.item_storage_resize */
extern void T29f62(T0* C, T6 a1);
/* GEANT_VARIABLES.slots_resize */
extern void T29f61(T0* C, T6 a1);
/* GEANT_VARIABLES.new_capacity */
extern T6 T29f23(T0* C, T6 a1);
/* GEANT_VARIABLES.item_storage_put */
extern void T29f55(T0* C, T0* a1, T6 a2);
/* GEANT.commandline_variables */
extern T0* T21f12(T0* C);
/* DS_ARRAYED_LIST_CURSOR [STRING_8].forth */
extern void T72f9(T0* C);
/* DS_ARRAYED_LIST [STRING_8].cursor_forth */
extern void T71f31(T0* C, T0* a1);
/* DS_ARRAYED_LIST [STRING_8].add_traversing_cursor */
extern void T71f35(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [STRING_8].set_next_cursor */
extern void T72f11(T0* C, T0* a1);
/* DS_ARRAYED_LIST [STRING_8].remove_traversing_cursor */
extern void T71f36(T0* C, T0* a1);
/* AP_PARSER.final_error_action */
extern void T38f29(T0* C);
/* AP_PARSER.exceptions */
extern T0* T38f13(T0* C);
/* AP_ERROR_HANDLER.report_error_message */
extern void T45f9(T0* C, T0* a1);
/* AP_ERROR_HANDLER.report_error_message */
extern void T45f9p1(T0* C, T0* a1);
/* AP_ERROR_HANDLER.report_error */
extern void T45f8(T0* C, T0* a1);
/* AP_ERROR_HANDLER.message */
extern T0* T45f6(T0* C, T0* a1);
/* AP_ERROR.default_message */
extern T0* T40f16(T0* C);
/* AP_ERROR.message */
extern T0* T40f17(T0* C, T0* a1);
/* AP_ERROR.arguments */
extern unsigned char ge248os1768;
extern T0* ge248ov1768;
extern T0* T40f19(T0* C);
/* KL_ARGUMENTS.make */
extern T0* T27c4(void);
/* KL_ARGUMENTS.argument */
extern T0* T27f2(T0* C, T6 a1);
/* ARRAY [STRING_8].valid_index */
extern T1 T33f5(T0* C, T6 a1);
/* AP_ERROR.string_ */
extern T0* T40f18(T0* C);
/* AP_ERROR.make_invalid_parameter_error */
extern T0* T40c20(T0* a1, T0* a2);
/* GEANT_ARGUMENT_VARIABLES.force */
extern void T34f49(T0* C, T0* a1, T0* a2);
/* GEANT_ARGUMENT_VARIABLES.search_position */
extern void T34f53(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [STRING_8].item */
extern T0* T72f5(T0* C);
/* DS_ARRAYED_LIST [STRING_8].cursor_item */
extern T0* T71f11(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [STRING_8].after */
extern T1 T72f6(T0* C);
/* DS_ARRAYED_LIST [STRING_8].cursor_after */
extern T1 T71f10(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [STRING_8].start */
extern void T72f8(T0* C);
/* DS_ARRAYED_LIST [STRING_8].cursor_start */
extern void T71f30(T0* C, T0* a1);
/* DS_ARRAYED_LIST [STRING_8].is_empty */
extern T1 T71f20(T0* C);
/* DS_ARRAYED_LIST_CURSOR [STRING_8].off */
extern T1 T72f4(T0* C);
/* DS_ARRAYED_LIST [STRING_8].cursor_off */
extern T1 T71f12(T0* C, T0* a1);
/* DS_ARRAYED_LIST [STRING_8].cursor_before */
extern T1 T71f15(T0* C, T0* a1);
/* GEANT.set_show_target_info */
extern void T21f27(T0* C, T1 a1);
/* AP_STRING_OPTION.parameter */
extern T0* T37f15(T0* C);
/* DS_ARRAYED_LIST [STRING_8].last */
extern T0* T71f8(T0* C);
/* GEANT.set_debug_mode */
extern void T21f26(T0* C, T1 a1);
/* GEANT.set_no_exec */
extern void T21f25(T0* C, T1 a1);
/* GEANT.set_verbose */
extern void T21f24(T0* C, T1 a1);
/* GEANT.report_version_number */
extern void T21f23(T0* C);
/* UT_ERROR_HANDLER.report_info */
extern void T28f8(T0* C, T0* a1);
/* UT_ERROR_HANDLER.report_info_message */
extern void T28f9(T0* C, T0* a1);
/* UT_VERSION_NUMBER.make */
extern T0* T49c7(T0* a1);
/* AP_PARSER.parse_arguments */
extern void T38f28(T0* C);
/* AP_PARSER.parse_list */
extern void T38f31(T0* C, T0* a1);
/* AP_PARSER.check_options_after_parsing */
extern void T38f34(T0* C);
/* AP_ALTERNATIVE_OPTIONS_LIST.forth */
extern void T36f16(T0* C);
/* AP_ALTERNATIVE_OPTIONS_LIST.cursor_forth */
extern void T36f18(T0* C, T0* a1);
/* AP_ALTERNATIVE_OPTIONS_LIST.add_traversing_cursor */
extern void T36f19(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [AP_OPTION].set_next_cursor */
extern void T69f8(T0* C, T0* a1);
/* AP_ALTERNATIVE_OPTIONS_LIST.remove_traversing_cursor */
extern void T36f20(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [AP_OPTION].set */
extern void T69f7(T0* C, T0* a1, T1 a2, T1 a3);
/* DS_ARRAYED_LIST [AP_OPTION].forth */
extern void T74f23(T0* C);
/* DS_ARRAYED_LIST [AP_OPTION].cursor_forth */
extern void T74f26(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [AP_OPTION].set_position */
extern void T110f6(T0* C, T6 a1);
/* DS_ARRAYED_LIST [AP_OPTION].add_traversing_cursor */
extern void T74f27(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [AP_OPTION].set_next_cursor */
extern void T110f7(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_OPTION].remove_traversing_cursor */
extern void T74f28(T0* C, T0* a1);
/* AP_ERROR.make_surplus_option_error */
extern T0* T40c22(T0* a1);
/* AP_ERROR.make_missing_option_error */
extern T0* T40c21(T0* a1);
/* AP_ALTERNATIVE_OPTIONS_LIST.item_for_iteration */
extern T0* T36f6(T0* C);
/* AP_ALTERNATIVE_OPTIONS_LIST.cursor_item */
extern T0* T36f8(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_OPTION].item_for_iteration */
extern T0* T74f7(T0* C);
/* DS_ARRAYED_LIST [AP_OPTION].cursor_item */
extern T0* T74f13(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_OPTION].item */
extern T0* T74f11(T0* C, T6 a1);
/* AP_ALTERNATIVE_OPTIONS_LIST.after */
extern T1 T36f5(T0* C);
/* AP_ALTERNATIVE_OPTIONS_LIST.cursor_after */
extern T1 T36f7(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_OPTION].after */
extern T1 T74f9(T0* C);
/* DS_ARRAYED_LIST [AP_OPTION].cursor_after */
extern T1 T74f12(T0* C, T0* a1);
/* AP_ALTERNATIVE_OPTIONS_LIST.start */
extern void T36f15(T0* C);
/* AP_ALTERNATIVE_OPTIONS_LIST.cursor_start */
extern void T36f17(T0* C, T0* a1);
/* AP_ALTERNATIVE_OPTIONS_LIST.cursor_off */
extern T1 T36f9(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_OPTION].start */
extern void T74f22(T0* C);
/* DS_ARRAYED_LIST [AP_OPTION].cursor_start */
extern void T74f25(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_OPTION].is_empty */
extern T1 T74f17(T0* C);
/* DS_ARRAYED_LIST_CURSOR [AP_OPTION].off */
extern T1 T110f4(T0* C);
/* DS_ARRAYED_LIST [AP_OPTION].cursor_off */
extern T1 T74f18(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_OPTION].cursor_before */
extern T1 T74f19(T0* C, T0* a1);
/* AP_PARSER.parse_argument */
extern void T38f33(T0* C);
/* AP_PARSER.parse_short */
extern void T38f36(T0* C);
/* AP_ERROR.make_missing_parameter_error */
extern T0* T40c24(T0* a1);
/* DS_ARRAYED_LIST [STRING_8].off */
extern T1 T71f7(T0* C);
/* AP_ERROR.make_unknown_option_error */
extern T0* T40c23(T0* a1);
/* CHARACTER_8.out */
extern T0* T2f1(T2* C);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].forth */
extern void T75f21(T0* C);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].cursor_forth */
extern void T75f24(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [AP_ALTERNATIVE_OPTIONS_LIST].set_position */
extern void T114f6(T0* C, T6 a1);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].add_traversing_cursor */
extern void T75f25(T0* C, T0* a1);
/* DS_ARRAYED_LIST_CURSOR [AP_ALTERNATIVE_OPTIONS_LIST].set_next_cursor */
extern void T114f7(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].remove_traversing_cursor */
extern void T75f26(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].item_for_iteration */
extern T0* T75f8(T0* C);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].cursor_item */
extern T0* T75f13(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].item */
extern T0* T75f7(T0* C, T6 a1);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].after */
extern T1 T75f9(T0* C);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].cursor_after */
extern T1 T75f10(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].start */
extern void T75f20(T0* C);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].cursor_start */
extern void T75f23(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].is_empty */
extern T1 T75f15(T0* C);
/* DS_ARRAYED_LIST_CURSOR [AP_ALTERNATIVE_OPTIONS_LIST].off */
extern T1 T114f4(T0* C);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].cursor_off */
extern T1 T75f16(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].cursor_before */
extern T1 T75f17(T0* C, T0* a1);
/* AP_PARSER.parse_long */
extern void T38f35(T0* C);
/* AP_ERROR.make_unnecessary_parameter_error */
extern T0* T40c25(T0* a1, T0* a2);
/* AP_PARSER.string_ */
extern T0* T38f23(T0* C);
/* DS_ARRAYED_LIST [STRING_8].forth */
extern void T71f26(T0* C);
/* DS_ARRAYED_LIST [STRING_8].item_for_iteration */
extern T0* T71f21(T0* C);
/* DS_ARRAYED_LIST [STRING_8].after */
extern T1 T71f16(T0* C);
/* DS_ARRAYED_LIST [STRING_8].start */
extern void T71f25(T0* C);
/* AP_PARSER.reset_parser */
extern void T38f32(T0* C);
/* AP_PARSER.all_options */
extern T0* T38f17(T0* C);
/* DS_ARRAYED_LIST [AP_OPTION].has */
extern T1 T74f8(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_OPTION].make */
extern T0* T74c20(T6 a1);
/* DS_ARRAYED_LIST [AP_OPTION].new_cursor */
extern T0* T74f14(T0* C);
/* DS_ARRAYED_LIST_CURSOR [AP_OPTION].make */
extern T0* T110c5(T0* a1);
/* KL_SPECIAL_ROUTINES [AP_OPTION].make */
extern T0* T113f1(T0* C, T6 a1);
/* TO_SPECIAL [AP_OPTION].make_area */
extern T0* T187c2(T6 a1);
/* SPECIAL [AP_OPTION].make */
extern T0* T112c4(T6 a1);
/* KL_SPECIAL_ROUTINES [AP_OPTION].default_create */
extern T0* T113c3(void);
/* AP_ERROR_HANDLER.reset */
extern void T45f10(T0* C);
/* DS_ARRAYED_LIST [STRING_8].force */
extern void T71f24(T0* C, T0* a1, T6 a2);
/* AP_PARSER.arguments */
extern T0* T38f24(T0* C);
/* AP_STRING_OPTION.make */
extern T0* T37c25(T2 a1, T0* a2);
/* AP_STRING_OPTION.set_long_form */
extern void T37f29(T0* C, T0* a1);
/* AP_STRING_OPTION.set_short_form */
extern void T37f27(T0* C, T2 a1);
/* AP_STRING_OPTION.initialize */
extern void T37f26(T0* C);
/* AP_STRING_OPTION.initialize */
extern void T37f26p1(T0* C);
/* AP_STRING_OPTION.initialize */
extern void T37f26p0(T0* C);
/* AP_FLAG.make */
extern T0* T35c20(T2 a1, T0* a2);
/* AP_FLAG.set_long_form */
extern void T35f22(T0* C, T0* a1);
/* AP_FLAG.set_short_form */
extern void T35f24(T0* C, T2 a1);
/* AP_FLAG.initialize */
extern void T35f21(T0* C);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].force_last */
extern void T75f19(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].resize */
extern void T75f22(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [AP_ALTERNATIVE_OPTIONS_LIST].resize */
extern T0* T116f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [AP_ALTERNATIVE_OPTIONS_LIST].aliased_resized_area */
extern T0* T115f3(T0* C, T6 a1);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].new_capacity */
extern T6 T75f14(T0* C, T6 a1);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].extendible */
extern T1 T75f12(T0* C, T6 a1);
/* AP_ALTERNATIVE_OPTIONS_LIST.make */
extern T0* T36c11(T0* a1);
/* AP_ALTERNATIVE_OPTIONS_LIST.old_make */
extern void T36f14(T0* C);
/* AP_ALTERNATIVE_OPTIONS_LIST.new_cursor */
extern T0* T36f10(T0* C);
/* DS_LINKED_LIST_CURSOR [AP_OPTION].make */
extern T0* T69c6(T0* a1);
/* AP_ALTERNATIVE_OPTIONS_LIST.set_parameters_description */
extern void T36f13(T0* C, T0* a1);
/* AP_ALTERNATIVE_OPTIONS_LIST.set_introduction_option */
extern void T36f12(T0* C, T0* a1);
/* AP_FLAG.set_description */
extern void T35f19(T0* C, T0* a1);
/* AP_FLAG.make_with_long_form */
extern T0* T35c18(T0* a1);
/* DS_ARRAYED_LIST [AP_OPTION].force_last */
extern void T74f21(T0* C, T0* a1);
/* DS_ARRAYED_LIST [AP_OPTION].resize */
extern void T74f24(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [AP_OPTION].resize */
extern T0* T113f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [AP_OPTION].aliased_resized_area */
extern T0* T112f3(T0* C, T6 a1);
/* DS_ARRAYED_LIST [AP_OPTION].new_capacity */
extern T6 T74f16(T0* C, T6 a1);
/* DS_ARRAYED_LIST [AP_OPTION].extendible */
extern T1 T74f15(T0* C, T6 a1);
/* AP_STRING_OPTION.set_parameter_description */
extern void T37f24(T0* C, T0* a1);
/* AP_STRING_OPTION.set_description */
extern void T37f23(T0* C, T0* a1);
/* AP_STRING_OPTION.make_with_short_form */
extern T0* T37c22(T2 a1);
/* AP_PARSER.set_parameters_description */
extern void T38f27(T0* C, T0* a1);
/* AP_PARSER.set_application_description */
extern void T38f26(T0* C, T0* a1);
/* AP_PARSER.make */
extern T0* T38c25(void);
/* AP_DISPLAY_HELP_FLAG.set_description */
extern void T73f37(T0* C, T0* a1);
/* AP_DISPLAY_HELP_FLAG.make */
extern T0* T73c36(T2 a1, T0* a2);
/* AP_DISPLAY_HELP_FLAG.set_long_form */
extern void T73f40(T0* C, T0* a1);
/* AP_DISPLAY_HELP_FLAG.set_short_form */
extern void T73f39(T0* C, T2 a1);
/* AP_DISPLAY_HELP_FLAG.initialize */
extern void T73f38(T0* C);
/* AP_PARSER.make_empty */
extern void T38f30(T0* C);
/* AP_ERROR_HANDLER.make_standard */
extern T0* T45c7(void);
/* AP_ERROR_HANDLER.std */
extern T0* T45f5(T0* C);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].make */
extern T0* T75c18(T6 a1);
/* DS_ARRAYED_LIST [AP_ALTERNATIVE_OPTIONS_LIST].new_cursor */
extern T0* T75f11(T0* C);
/* DS_ARRAYED_LIST_CURSOR [AP_ALTERNATIVE_OPTIONS_LIST].make */
extern T0* T114c5(T0* a1);
/* KL_SPECIAL_ROUTINES [AP_ALTERNATIVE_OPTIONS_LIST].make */
extern T0* T116f1(T0* C, T6 a1);
/* TO_SPECIAL [AP_ALTERNATIVE_OPTIONS_LIST].make_area */
extern T0* T188c2(T6 a1);
/* SPECIAL [AP_ALTERNATIVE_OPTIONS_LIST].make */
extern T0* T115c4(T6 a1);
/* KL_SPECIAL_ROUTINES [AP_ALTERNATIVE_OPTIONS_LIST].default_create */
extern T0* T116c3(void);
/* UT_ERROR_HANDLER.make_standard */
extern T0* T28c7(void);
/* UT_ERROR_HANDLER.std */
extern T0* T28f4(T0* C);
/* KL_ARGUMENTS.set_program_name */
extern void T27f5(T0* C, T0* a1);
/* GEANT.arguments */
extern T0* T21f10(T0* C);
/* DIRECTORY.dispose */
extern void T661f15(T0* C);
/* DIRECTORY.close */
extern void T661f20(T0* C);
/* DIRECTORY.default_pointer */
extern T14 T661f9(T0* C);
/* DIRECTORY.dir_close */
extern void T661f25(T0* C, T14 a1);
/* DIRECTORY.is_closed */
extern T1 T661f5(T0* C);
/* RAW_FILE.dispose */
extern void T660f14(T0* C);
/* RAW_FILE.close */
extern void T660f17(T0* C);
/* RAW_FILE.file_close */
extern void T660f19(T0* C, T14 a1);
/* RAW_FILE.is_closed */
extern T1 T660f10(T0* C);
/* KL_BINARY_OUTPUT_FILE.dispose */
extern void T657f20(T0* C);
/* KL_BINARY_OUTPUT_FILE.old_close */
extern void T657f25(T0* C);
/* KL_BINARY_OUTPUT_FILE.file_close */
extern void T657f28(T0* C, T14 a1);
/* KL_BINARY_OUTPUT_FILE.old_is_closed */
extern T1 T657f11(T0* C);
/* KL_BINARY_INPUT_FILE.dispose */
extern void T656f34(T0* C);
/* KL_BINARY_INPUT_FILE.old_close */
extern void T656f39(T0* C);
/* KL_BINARY_INPUT_FILE.file_close */
extern void T656f41(T0* C, T14 a1);
/* KL_BINARY_INPUT_FILE.old_is_closed */
extern T1 T656f12(T0* C);
/* KL_TEXT_OUTPUT_FILE.dispose */
extern void T517f21(T0* C);
/* KL_TEXT_OUTPUT_FILE.old_close */
extern void T517f27(T0* C);
/* KL_TEXT_OUTPUT_FILE.file_close */
extern void T517f32(T0* C, T14 a1);
/* KL_TEXT_OUTPUT_FILE.old_is_closed */
extern T1 T517f11(T0* C);
/* KL_DIRECTORY.dispose */
extern void T490f36(T0* C);
/* KL_DIRECTORY.old_close */
extern void T490f39(T0* C);
/* KL_DIRECTORY.default_pointer */
extern T14 T490f13(T0* C);
/* KL_DIRECTORY.dir_close */
extern void T490f40(T0* C, T14 a1);
/* KL_DIRECTORY.is_closed */
extern T1 T490f9(T0* C);
/* MANAGED_POINTER.dispose */
extern void T264f8(T0* C);
/* POINTER.memory_free */
extern void T14f8(T14* C);
/* POINTER.default_pointer */
extern T14 T14f5(T14* C);
/* POINTER.c_free */
extern void T14f9(T14* C, T14 a1);
/* KL_TEXT_INPUT_FILE.dispose */
extern void T55f57(T0* C);
/* LX_SYMBOL_TRANSITION [LX_NFA_STATE].record */
extern void T630f5(T0* C, T0* a1);
/* LX_SYMBOL_PARTITIONS.put */
extern void T601f12(T0* C, T6 a1);
/* LX_SYMBOL_PARTITIONS.put */
extern void T601f12p1(T0* C, T6 a1);
/* LX_EPSILON_TRANSITION [LX_NFA_STATE].record */
extern void T628f4(T0* C, T0* a1);
/* LX_SYMBOL_CLASS_TRANSITION [LX_NFA_STATE].record */
extern void T626f5(T0* C, T0* a1);
/* LX_SYMBOL_PARTITIONS.add */
extern void T601f11(T0* C, T0* a1);
/* LX_SYMBOL_PARTITIONS.add */
extern void T601f11p1(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.log_validation_messages */
extern void T319f34(T0* C);
/* GEANT_REPLACE_TASK.validation_messages */
extern unsigned char ge59os1751;
extern T0* ge59ov1751;
extern T0* T319f16(T0* C);
/* GEANT_INPUT_TASK.log_validation_messages */
extern void T317f35(T0* C);
/* GEANT_INPUT_TASK.validation_messages */
extern T0* T317f13(T0* C);
/* GEANT_AVAILABLE_TASK.log_validation_messages */
extern void T315f25(T0* C);
/* GEANT_AVAILABLE_TASK.validation_messages */
extern T0* T315f5(T0* C);
/* GEANT_PRECURSOR_TASK.log_validation_messages */
extern void T313f32(T0* C);
/* GEANT_PRECURSOR_TASK.validation_messages */
extern T0* T313f13(T0* C);
/* GEANT_EXIT_TASK.log_validation_messages */
extern void T311f26(T0* C);
/* GEANT_EXIT_TASK.validation_messages */
extern T0* T311f7(T0* C);
/* GEANT_OUTOFDATE_TASK.log_validation_messages */
extern void T309f31(T0* C);
/* GEANT_OUTOFDATE_TASK.validation_messages */
extern T0* T309f13(T0* C);
/* GEANT_XSLT_TASK.log_validation_messages */
extern void T307f44(T0* C);
/* GEANT_XSLT_TASK.validation_messages */
extern T0* T307f23(T0* C);
/* GEANT_SETENV_TASK.log_validation_messages */
extern void T305f27(T0* C);
/* GEANT_SETENV_TASK.validation_messages */
extern T0* T305f8(T0* C);
/* GEANT_MOVE_TASK.log_validation_messages */
extern void T303f29(T0* C);
/* GEANT_MOVE_TASK.validation_messages */
extern T0* T303f11(T0* C);
/* GEANT_COPY_TASK.log_validation_messages */
extern void T301f34(T0* C);
/* GEANT_COPY_TASK.validation_messages */
extern T0* T301f13(T0* C);
/* GEANT_DELETE_TASK.log_validation_messages */
extern void T299f29(T0* C);
/* GEANT_DELETE_TASK.validation_messages */
extern T0* T299f11(T0* C);
/* GEANT_MKDIR_TASK.log_validation_messages */
extern void T297f25(T0* C);
/* GEANT_MKDIR_TASK.validation_messages */
extern T0* T297f5(T0* C);
/* GEANT_ECHO_TASK.log_validation_messages */
extern void T295f25(T0* C);
/* GEANT_ECHO_TASK.validation_messages */
extern T0* T295f5(T0* C);
/* GEANT_GEANT_TASK.log_validation_messages */
extern void T293f40(T0* C);
/* GEANT_GEANT_TASK.validation_messages */
extern T0* T293f20(T0* C);
/* GEANT_GETEST_TASK.log_validation_messages */
extern void T291f42(T0* C);
/* GEANT_GETEST_TASK.validation_messages */
extern T0* T291f22(T0* C);
/* GEANT_GEPP_TASK.log_validation_messages */
extern void T289f37(T0* C);
/* GEANT_GEPP_TASK.validation_messages */
extern T0* T289f16(T0* C);
/* GEANT_GEYACC_TASK.log_validation_messages */
extern void T287f37(T0* C);
/* GEANT_GEYACC_TASK.validation_messages */
extern T0* T287f15(T0* C);
/* GEANT_GELEX_TASK.log_validation_messages */
extern void T285f40(T0* C);
/* GEANT_GELEX_TASK.validation_messages */
extern T0* T285f18(T0* C);
/* GEANT_GEXACE_TASK.log_validation_messages */
extern void T283f38(T0* C);
/* GEANT_GEXACE_TASK.validation_messages */
extern T0* T283f16(T0* C);
/* GEANT_UNSET_TASK.log_validation_messages */
extern void T281f26(T0* C);
/* GEANT_UNSET_TASK.validation_messages */
extern T0* T281f7(T0* C);
/* GEANT_SET_TASK.log_validation_messages */
extern void T279f27(T0* C);
/* GEANT_SET_TASK.validation_messages */
extern T0* T279f8(T0* C);
/* GEANT_LCC_TASK.log_validation_messages */
extern void T277f27(T0* C);
/* GEANT_LCC_TASK.validation_messages */
extern T0* T277f8(T0* C);
/* GEANT_EXEC_TASK.log_validation_messages */
extern void T275f26(T0* C);
/* GEANT_EXEC_TASK.validation_messages */
extern T0* T275f6(T0* C);
/* GEANT_ISE_TASK.log_validation_messages */
extern void T273f36(T0* C);
/* GEANT_ISE_TASK.validation_messages */
extern T0* T273f14(T0* C);
/* GEANT_GEC_TASK.log_validation_messages */
extern void T266f40(T0* C);
/* GEANT_GEC_TASK.validation_messages */
extern T0* T266f18(T0* C);
/* GEANT_REPLACE_TASK.execute */
extern void T319f40(T0* C);
/* GEANT_REPLACE_COMMAND.execute */
extern void T463f40(T0* C);
/* GEANT_FILESET.forth */
extern void T391f50(T0* C);
/* GEANT_FILESET.update_project_variables */
extern void T391f55(T0* C);
/* GEANT_FILESET.remove_project_variables */
extern void T391f51(T0* C);
/* GEANT_PROJECT_VARIABLES.remove */
extern void T25f86(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.remove_position */
extern void T25f88(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.key_storage_put */
extern void T25f71(T0* C, T0* a1, T6 a2);
/* GEANT_PROJECT_VARIABLES.item_storage_put */
extern void T25f67(T0* C, T0* a1, T6 a2);
/* GEANT_PROJECT_VARIABLES.clashes_put */
extern void T25f69(T0* C, T6 a1, T6 a2);
/* GEANT_PROJECT_VARIABLES.slots_put */
extern void T25f70(T0* C, T6 a1, T6 a2);
/* GEANT_PROJECT_VARIABLES.clashes_item */
extern T6 T25f21(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.move_cursors_forth */
extern void T25f90(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.move_all_cursors */
extern void T25f92(T0* C, T6 a1, T6 a2);
/* DS_HASH_TABLE_CURSOR [STRING_8, STRING_8].set_position */
extern void T64f10(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.move_cursors_after */
extern void T25f91(T0* C, T6 a1);
/* DS_HASH_TABLE_CURSOR [STRING_8, STRING_8].set_next_cursor */
extern void T64f11(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.internal_set_key_equality_tester */
extern void T25f89(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.slots_item */
extern T6 T25f22(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.hash_position */
extern T6 T25f33(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.key_storage_item */
extern T0* T25f27(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.search_position */
extern void T25f66(T0* C, T0* a1);
/* GEANT_FILESET.off */
extern T1 T391f27(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].off */
extern T1 T504f37(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].cursor_off */
extern T1 T504f29(T0* C, T0* a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].forth */
extern void T504f47(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].cursor_forth */
extern void T504f51(T0* C, T0* a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].add_traversing_cursor */
extern void T504f59(T0* C, T0* a1);
/* DS_HASH_SET_CURSOR [GEANT_FILESET_ENTRY].set_next_cursor */
extern void T543f6(T0* C, T0* a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].remove_traversing_cursor */
extern void T504f58(T0* C, T0* a1);
/* DS_HASH_SET_CURSOR [GEANT_FILESET_ENTRY].set_position */
extern void T543f5(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].clashes_item */
extern T6 T504f30(T0* C, T6 a1);
/* GEANT_REPLACE_COMMAND.create_directory_for_pathname */
extern void T463f42(T0* C, T0* a1);
/* GEANT_REPLACE_COMMAND.file_system */
extern T0* T463f20(T0* C);
/* GEANT_REPLACE_COMMAND.windows_file_system */
extern T0* T463f27(T0* C);
/* GEANT_REPLACE_COMMAND.operating_system */
extern T0* T463f26(T0* C);
/* GEANT_FILESET.item_mapped_filename */
extern T0* T391f26(T0* C);
/* GEANT_FILESET_ENTRY.mapped_filename_converted */
extern T0* T545f7(T0* C);
/* GEANT_FILESET_ENTRY.unix_file_system */
extern T0* T545f9(T0* C);
/* GEANT_FILESET_ENTRY.file_system */
extern T0* T545f8(T0* C);
/* GEANT_FILESET_ENTRY.windows_file_system */
extern T0* T545f11(T0* C);
/* GEANT_FILESET_ENTRY.operating_system */
extern T0* T545f10(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].item_for_iteration */
extern T0* T504f18(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].cursor_item */
extern T0* T504f20(T0* C, T0* a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].item_storage_item */
extern T0* T504f22(T0* C, T6 a1);
/* GEANT_FILESET.item_filename */
extern T0* T391f25(T0* C);
/* GEANT_FILESET_ENTRY.filename_converted */
extern T0* T545f6(T0* C);
/* GEANT_REPLACE_COMMAND.unix_file_system */
extern T0* T463f19(T0* C);
/* GEANT_FILESET.is_in_gobo_31_format */
extern T1 T391f21(T0* C);
/* GEANT_FILESET.after */
extern T1 T391f20(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].after */
extern T1 T504f17(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].cursor_after */
extern T1 T504f19(T0* C, T0* a1);
/* GEANT_FILESET.start */
extern void T391f49(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].start */
extern void T504f46(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].cursor_start */
extern void T504f50(T0* C, T0* a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].is_empty */
extern T1 T504f28(T0* C);
/* GEANT_FILESET.execute */
extern void T391f48(T0* C);
/* GEANT_FILESET.remove_fileset_entry */
extern void T391f54(T0* C, T0* a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].remove */
extern void T504f49(T0* C, T0* a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].remove_position */
extern void T504f57(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].key_storage_put */
extern void T504f66(T0* C, T0* a1, T6 a2);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].item_storage_put */
extern void T504f53(T0* C, T0* a1, T6 a2);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].clashes_put */
extern void T504f55(T0* C, T6 a1, T6 a2);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].slots_put */
extern void T504f56(T0* C, T6 a1, T6 a2);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].move_cursors_forth */
extern void T504f65(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].move_all_cursors */
extern void T504f68(T0* C, T6 a1, T6 a2);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].move_cursors_after */
extern void T504f67(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].internal_set_key_equality_tester */
extern void T504f64(T0* C, T0* a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].key_equality_tester */
extern T0* T504f34(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].slots_item */
extern T6 T504f26(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].hash_position */
extern T6 T504f24(T0* C, T0* a1);
/* GEANT_FILESET_ENTRY.hash_code */
extern T6 T545f3(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].key_storage_item */
extern T0* T504f35(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].search_position */
extern void T504f52(T0* C, T0* a1);
/* KL_EQUALITY_TESTER [GEANT_FILESET_ENTRY].test */
extern T1 T542f1(T0* C, T0* a1, T0* a2);
/* GEANT_FILESET_ENTRY.is_equal */
extern T1 T545f4(T0* C, T0* a1);
/* GEANT_FILESET_ENTRY.string_ */
extern T0* T545f5(T0* C);
/* GEANT_FILESET_ENTRY.make */
extern T0* T545c12(T0* a1, T0* a2);
/* DS_HASH_SET_CURSOR [STRING_8].forth */
extern void T547f8(T0* C);
/* DS_HASH_SET [STRING_8].cursor_forth */
extern void T506f53(T0* C, T0* a1);
/* DS_HASH_SET [STRING_8].add_traversing_cursor */
extern void T506f55(T0* C, T0* a1);
/* DS_HASH_SET_CURSOR [STRING_8].set_next_cursor */
extern void T547f10(T0* C, T0* a1);
/* DS_HASH_SET [STRING_8].remove_traversing_cursor */
extern void T506f54(T0* C, T0* a1);
/* DS_HASH_SET_CURSOR [STRING_8].set_position */
extern void T547f9(T0* C, T6 a1);
/* GEANT_FILESET.add_fileset_entry_if_necessary */
extern void T391f53(T0* C, T0* a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].force_last */
extern void T504f48(T0* C, T0* a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].resize */
extern void T504f54(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].clashes_resize */
extern void T504f63(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].key_storage_resize */
extern void T504f62(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].item_storage_resize */
extern void T504f61(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [GEANT_FILESET_ENTRY].resize */
extern T0* T544f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [GEANT_FILESET_ENTRY].aliased_resized_area */
extern T0* T546f3(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].slots_resize */
extern void T504f60(T0* C, T6 a1);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].new_capacity */
extern T6 T504f23(T0* C, T6 a1);
/* GEANT_FILESET.is_file_outofdate */
extern T1 T391f29(T0* C, T0* a1, T0* a2);
/* KL_WINDOWS_FILE_SYSTEM.file_time_stamp */
extern T6 T53f32(T0* C, T0* a1);
/* KL_TEXT_INPUT_FILE.time_stamp */
extern T6 T55f40(T0* C);
/* KL_TEXT_INPUT_FILE.date */
extern T6 T55f42(T0* C);
/* UNIX_FILE_INFO.date */
extern T6 T87f8(T0* C);
/* KL_UNIX_FILE_SYSTEM.file_time_stamp */
extern T6 T54f30(T0* C, T0* a1);
/* GEANT_MAP.mapped_filename */
extern T0* T501f8(T0* C, T0* a1);
/* UC_UTF8_STRING.remove_tail */
extern void T207f86(T0* C, T6 a1);
/* STRING_8.remove_tail */
extern void T17f56(T0* C, T6 a1);
/* UC_UTF8_STRING.remove_head */
extern void T207f85(T0* C, T6 a1);
/* STRING_8.remove_head */
extern void T17f55(T0* C, T6 a1);
/* GEANT_MAP.glob_postfix */
extern T0* T501f16(T0* C, T0* a1);
/* GEANT_MAP.glob_prefix */
extern T0* T501f15(T0* C, T0* a1);
/* RX_PCRE_REGULAR_EXPRESSION.replace_all */
extern T0* T566f54(T0* C, T0* a1);
/* RX_PCRE_REGULAR_EXPRESSION.append_replace_all_to_string */
extern void T566f303(T0* C, T0* a1, T0* a2);
/* RX_PCRE_REGULAR_EXPRESSION.match_substring */
extern void T566f315(T0* C, T0* a1, T6 a2, T6 a3);
/* RX_PCRE_REGULAR_EXPRESSION.match_it */
extern void T566f328(T0* C, T0* a1, T6 a2, T6 a3);
/* RX_PCRE_REGULAR_EXPRESSION.match_start */
extern T1 T566f149(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.match_internal */
extern T6 T566f231(T0* C, T6 a1, T1 a2, T1 a3);
/* RX_PCRE_REGULAR_EXPRESSION.match_repeated_type */
extern T6 T566f295(T0* C, T6 a1, T6 a2, T6 a3, T1 a4);
/* RX_PCRE_REGULAR_EXPRESSION.match_not_repeated_characters */
extern T6 T566f294(T0* C, T6 a1, T6 a2, T6 a3, T1 a4);
/* RX_PCRE_REGULAR_EXPRESSION.infinity */
extern unsigned char ge494os10452;
extern T6 ge494ov10452;
extern T6 T566f60(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.platform */
extern T0* T566f193(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.match_repeated_characters */
extern T6 T566f293(T0* C, T6 a1, T6 a2, T6 a3, T1 a4);
/* RX_BYTE_CODE.character_item */
extern T6 T610f8(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.match_repeated_classes */
extern T6 T566f292(T0* C, T6 a1);
/* RX_BYTE_CODE.character_set_has */
extern T1 T610f10(T0* C, T6 a1, T6 a2);
/* RX_PCRE_REGULAR_EXPRESSION.match_repeated_refs */
extern T6 T566f291(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.match_ref */
extern T6 T566f297(T0* C, T6 a1, T6 a2, T6 a3);
/* RX_PCRE_REGULAR_EXPRESSION.space_set */
extern unsigned char ge500os10619;
extern T0* ge500ov10619;
extern T0* T566f150(T0* C);
/* RX_CHARACTER_SET.make */
extern T0* T612c4(T0* a1);
/* RX_CHARACTER_SET.add_string */
extern void T612f10(T0* C, T0* a1);
/* RX_CHARACTER_SET.add_character */
extern void T612f9(T0* C, T6 a1);
/* RX_CHARACTER_SET.make_empty */
extern void T612f5(T0* C);
/* RX_CHARACTER_SET.make_empty */
extern T0* T612c5(void);
/* RX_CHARACTER_SET.special_boolean_ */
extern unsigned char ge176os2157;
extern T0* ge176ov2157;
extern T0* T612f3(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.digit_set */
extern unsigned char ge500os10611;
extern T0* ge500ov10611;
extern T0* T566f166(T0* C);
/* RX_CHARACTER_SET.has */
extern T1 T612f2(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_ims_options */
extern void T566f326(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.is_option_dotall */
extern T1 T566f85(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.is_option_multiline */
extern T1 T566f84(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.is_option_caseless */
extern T1 T566f83(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_match_count */
extern void T566f335(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_next_start */
extern void T566f334(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.match_recursive */
extern T6 T566f290(T0* C, T6 a1, T1 a2, T1 a3);
/* RX_BYTE_CODE.integer_item */
extern T6 T610f11(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.next_matching_alternate */
extern T6 T566f288(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.match_additional_bracket */
extern T6 T566f269(T0* C, T6 a1, T6 a2);
/* RX_BYTE_CODE.opcode_item */
extern T6 T610f7(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.special_integer_ */
extern T0* T566f56(T0* C);
/* RX_CASE_MAPPING.flip_case */
extern T6 T611f4(T0* C, T6 a1);
/* RX_CASE_MAPPING.to_lower */
extern T6 T611f3(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.captured_end_position */
extern T6 T566f53(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.append_replacement_to_string */
extern void T566f316(T0* C, T0* a1, T0* a2);
/* UC_UTF8_STRING.append_code */
extern void T207f88(T0* C, T10 a1);
/* UC_UTF8_STRING.append_item_code */
extern void T207f89(T0* C, T6 a1);
/* STRING_8.append_code */
extern void T17f57(T0* C, T10 a1);
/* STRING_8.put_code */
extern void T17f58(T0* C, T10 a1, T6 a2);
/* RX_PCRE_REGULAR_EXPRESSION.append_captured_substring_to_string */
extern void T566f329(T0* C, T0* a1, T6 a2);
/* RX_PCRE_REGULAR_EXPRESSION.captured_start_position */
extern T6 T566f52(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.string_ */
extern T0* T566f58(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.has_matched */
extern T1 T566f229(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.match */
extern void T566f302(T0* C, T0* a1);
/* RX_PCRE_REGULAR_EXPRESSION.is_compiled */
extern T1 T566f230(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.compile */
extern void T566f299(T0* C, T0* a1);
/* RX_PCRE_REGULAR_EXPRESSION.compile */
extern void T566f299p1(T0* C, T0* a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_startline */
extern void T566f314(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.has_startline */
extern T1 T566f228(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.first_significant_code */
extern T6 T566f188(T0* C, T6 a1, T6 a2, T1 a3);
/* RX_PCRE_REGULAR_EXPRESSION.find_firstchar */
extern T6 T566f227(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_anchored */
extern void T566f313(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.can_anchored */
extern T1 T566f226(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.ims_options */
extern T6 T566f82(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.set_option_dotall */
extern T6 T566f131(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_option_multiline */
extern T6 T566f129(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_option_caseless */
extern T6 T566f127(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.compile_regexp */
extern void T566f312(T0* C, T6 a1, T1 a2, T1 a3, T6 a4);
/* RX_BYTE_CODE.set_count */
extern void T610f18(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.find_fixed_code_length */
extern T6 T566f65(T0* C, T6 a1);
/* RX_BYTE_CODE.put_integer */
extern void T610f17(T0* C, T6 a1, T6 a2);
/* RX_PCRE_REGULAR_EXPRESSION.compile_branch */
extern void T566f327(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.meta_set */
extern unsigned char ge500os10620;
extern T0* ge500ov10620;
extern T0* T566f146(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.maxlit */
extern unsigned char ge494os10453;
extern T6 ge494ov10453;
extern T6 T566f145(T0* C);
/* RX_BYTE_CODE.append_character */
extern void T610f19(T0* C, T6 a1);
/* RX_BYTE_CODE.put_character */
extern void T610f25(T0* C, T6 a1, T6 a2);
/* RX_BYTE_CODE.resize_byte_code */
extern void T610f24(T0* C, T6 a1);
/* RX_BYTE_CODE.special_integer_ */
extern T0* T610f9(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.scan_escape */
extern T6 T566f140(T0* C, T6 a1, T1 a2);
/* RX_PCRE_REGULAR_EXPRESSION.scan_hex_number */
extern T6 T566f221(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.xdigit_set */
extern unsigned char ge500os10613;
extern T0* ge500ov10613;
extern T0* T566f243(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.scan_octal_number */
extern T6 T566f220(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.escape_character */
extern T6 T566f216(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.to_option_ims */
extern T6 T566f134(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_ichanged */
extern void T566f325(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.unset_option_dotall */
extern T6 T566f132(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.unset_option_multiline */
extern T6 T566f130(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.unset_option_caseless */
extern T6 T566f128(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.scan_decimal_number */
extern T6 T566f109(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.compile_repeats */
extern void T566f332(T0* C, T6 a1, T6 a2, T6 a3, T6 a4, T6 a5);
/* RX_BYTE_CODE.append_subcopy */
extern void T610f23(T0* C, T6 a1, T6 a2);
/* RX_BYTE_CODE.put_opcode */
extern void T610f22(T0* C, T6 a1, T6 a2);
/* RX_BYTE_CODE.move_right */
extern void T610f21(T0* C, T6 a1, T6 a2);
/* RX_PCRE_REGULAR_EXPRESSION.compile_single_repeat */
extern void T566f333(T0* C, T6 a1, T6 a2, T6 a3, T6 a4, T6 a5, T6 a6);
/* RX_PCRE_REGULAR_EXPRESSION.compile_character_class */
extern void T566f331(T0* C);
/* RX_BYTE_CODE.append_character_set */
extern void T610f20(T0* C, T0* a1, T1 a2);
/* RX_BYTE_CODE.resize_character_sets */
extern void T610f26(T0* C, T6 a1);
/* RX_BYTE_CODE.special_boolean_ */
extern T0* T610f12(T0* C);
/* RX_CHARACTER_SET.add_set */
extern void T612f8(T0* C, T0* a1);
/* RX_CHARACTER_SET.add_negated_set */
extern void T612f7(T0* C, T0* a1);
/* ARRAY [RX_CHARACTER_SET].item */
extern T0* T615f4(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.class_sets */
extern unsigned char ge500os10622;
extern T0* ge500ov10622;
extern T0* T566f158(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.default_word_set */
extern unsigned char ge500os10607;
extern T0* ge500ov10607;
extern T0* T566f147(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.punct_set */
extern unsigned char ge500os10617;
extern T0* ge500ov10617;
extern T0* T566f242(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.print_set */
extern unsigned char ge500os10616;
extern T0* ge500ov10616;
extern T0* T566f241(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.graph_set */
extern unsigned char ge500os10615;
extern T0* ge500ov10615;
extern T0* T566f240(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.cntrl_set */
extern unsigned char ge500os10614;
extern T0* ge500ov10614;
extern T0* T566f239(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.ascii_set */
extern unsigned char ge500os10618;
extern T0* ge500ov10618;
extern T0* T566f238(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.alnum_set */
extern unsigned char ge500os10612;
extern T0* ge500ov10612;
extern T0* T566f237(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.upper_set */
extern unsigned char ge500os10608;
extern T0* ge500ov10608;
extern T0* T566f236(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.lower_set */
extern unsigned char ge500os10609;
extern T0* ge500ov10609;
extern T0* T566f235(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.alpha_set */
extern unsigned char ge500os10610;
extern T0* ge500ov10610;
extern T0* T566f233(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.check_posix_name */
extern T6 T566f156(T0* C, T6 a1, T6 a2);
/* RX_PCRE_REGULAR_EXPRESSION.class_names */
extern unsigned char ge500os10621;
extern T0* ge500ov10621;
extern T0* T566f234(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.check_posix_syntax */
extern T6 T566f154(T0* C, T6 a1);
/* RX_CHARACTER_SET.wipe_out */
extern void T612f6(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.actual_set */
extern unsigned char ge494os10451;
extern T0* ge494ov10451;
extern T0* T566f151(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.compile_counted_repeats */
extern T1 T566f87(T0* C, T6 a1, T6 a2, T6 a3);
/* RX_PCRE_REGULAR_EXPRESSION.scan_comment */
extern void T566f330(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.is_option_undef */
extern T1 T566f62(T0* C, T6 a1);
/* RX_BYTE_CODE.append_integer */
extern void T610f16(T0* C, T6 a1);
/* RX_BYTE_CODE.append_opcode */
extern void T610f15(T0* C, T6 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_error */
extern void T566f311(T0* C, T0* a1, T6 a2, T6 a3);
/* RX_PCRE_REGULAR_EXPRESSION.set_default_internal_options */
extern void T566f310(T0* C);
/* RX_BYTE_CODE.wipe_out */
extern void T610f14(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.wipe_out */
extern void T566f309(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.wipe_out */
extern void T566f309p1(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.make */
extern T0* T566c298(void);
/* RX_PCRE_REGULAR_EXPRESSION.make */
extern void T566f298p1(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.set_default_options */
extern void T566f308(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.set_strict */
extern void T566f324(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_greedy */
extern void T566f323(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_eol */
extern void T566f322(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_bol */
extern void T566f321(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_dollar_endonly */
extern void T566f320(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_empty_allowed */
extern void T566f319(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_extended */
extern void T566f318(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_dotall */
extern void T566f317(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_multiline */
extern void T566f301(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_caseless */
extern void T566f300(T0* C, T1 a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_word_set */
extern void T566f307(T0* C, T0* a1);
/* RX_PCRE_REGULAR_EXPRESSION.set_character_case_mapping */
extern void T566f306(T0* C, T0* a1);
/* RX_PCRE_REGULAR_EXPRESSION.default_character_case_mapping */
extern unsigned char ge500os10606;
extern T0* ge500ov10606;
extern T0* T566f76(T0* C);
/* RX_CASE_MAPPING.make */
extern T0* T611c6(T0* a1, T0* a2);
/* RX_CASE_MAPPING.add */
extern void T611f8(T0* C, T0* a1, T0* a2);
/* RX_CASE_MAPPING.make_default */
extern void T611f7(T0* C);
/* RX_CASE_MAPPING.clear */
extern void T611f9(T0* C);
/* RX_CASE_MAPPING.special_integer_ */
extern T0* T611f5(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.reset */
extern void T566f305(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.reset */
extern void T566f305p1(T0* C);
/* RX_PCRE_REGULAR_EXPRESSION.empty_pattern */
extern unsigned char ge494os10450;
extern T0* ge494ov10450;
extern T0* T566f75(T0* C);
/* RX_BYTE_CODE.make */
extern T0* T610c13(T6 a1);
/* GEANT_MAP.type_attribute_value_regexp */
extern unsigned char ge137os9083;
extern T0* ge137ov9083;
extern T0* T501f12(T0* C);
/* GEANT_MAP.type_attribute_value_merge */
extern unsigned char ge137os9081;
extern T0* ge137ov9081;
extern T0* T501f11(T0* C);
/* GEANT_MAP.unix_file_system */
extern T0* T501f14(T0* C);
/* GEANT_MAP.type_attribute_value_flat */
extern unsigned char ge137os9080;
extern T0* ge137ov9080;
extern T0* T501f10(T0* C);
/* GEANT_MAP.string_ */
extern T0* T501f9(T0* C);
/* GEANT_MAP.is_executable */
extern T1 T501f7(T0* C);
/* GEANT_MAP.type_attribute_value_glob */
extern unsigned char ge137os9082;
extern T0* ge137ov9082;
extern T0* T501f13(T0* C);
/* DS_HASH_SET_CURSOR [STRING_8].item */
extern T0* T547f4(T0* C);
/* DS_HASH_SET [STRING_8].cursor_item */
extern T0* T506f30(T0* C, T0* a1);
/* DS_HASH_SET_CURSOR [STRING_8].after */
extern T1 T547f5(T0* C);
/* DS_HASH_SET [STRING_8].cursor_after */
extern T1 T506f29(T0* C, T0* a1);
/* DS_HASH_SET_CURSOR [STRING_8].start */
extern void T547f7(T0* C);
/* DS_HASH_SET [STRING_8].cursor_start */
extern void T506f52(T0* C, T0* a1);
/* DS_HASH_SET [STRING_8].cursor_off */
extern T1 T506f34(T0* C, T0* a1);
/* DS_HASH_SET [STRING_8].is_empty */
extern T1 T506f33(T0* C);
/* GEANT_FILESET.scan_internal */
extern void T391f52(T0* C, T0* a1);
/* KL_DIRECTORY.close */
extern void T490f44(T0* C);
/* LX_DFA_WILDCARD.recognizes */
extern T1 T508f10(T0* C, T0* a1);
/* LX_DFA_WILDCARD.longest_end_position */
extern T6 T508f11(T0* C, T0* a1, T6 a2);
/* KL_WINDOWS_FILE_SYSTEM.is_directory_readable */
extern T1 T53f31(T0* C, T0* a1);
/* KL_DIRECTORY.is_readable */
extern T1 T490f29(T0* C);
/* KL_DIRECTORY.old_is_readable */
extern T1 T490f18(T0* C);
/* KL_DIRECTORY.eif_dir_is_readable */
extern T1 T490f27(T0* C, T14 a1);
/* KL_UNIX_FILE_SYSTEM.is_directory_readable */
extern T1 T54f29(T0* C, T0* a1);
/* GEANT_FILESET.string_ */
extern T0* T391f28(T0* C);
/* KL_DIRECTORY.read_entry */
extern void T490f43(T0* C);
/* KL_DIRECTORY.readentry */
extern void T490f47(T0* C);
/* KL_DIRECTORY.dir_next */
extern T0* T490f23(T0* C, T14 a1);
/* KL_DIRECTORY.old_end_of_input */
extern T1 T490f20(T0* C);
/* KL_DIRECTORY.is_open_read */
extern T1 T490f14(T0* C);
/* KL_DIRECTORY.open_read */
extern void T490f42(T0* C);
/* KL_DIRECTORY.old_open_read */
extern void T490f46(T0* C);
/* KL_DIRECTORY.dir_open */
extern T14 T490f21(T0* C, T14 a1);
/* GEANT_FILESET.unix_file_system */
extern T0* T391f24(T0* C);
/* GEANT_FILESET.file_system */
extern T0* T391f23(T0* C);
/* GEANT_FILESET.windows_file_system */
extern T0* T391f32(T0* C);
/* GEANT_FILESET.operating_system */
extern T0* T391f31(T0* C);
/* GEANT_FILESET.is_executable */
extern T1 T391f19(T0* C);
/* GEANT_FILESET.is_in_gobo_32_format */
extern T1 T391f22(T0* C);
/* GEANT_REPLACE_COMMAND.execute_replace */
extern void T463f41(T0* C, T0* a1, T0* a2);
/* GEANT_REPLACE_COMMAND.execute_replace_token */
extern void T463f45(T0* C, T0* a1, T0* a2);
/* KL_TEXT_OUTPUT_FILE.close */
extern void T517f25(T0* C);
/* KL_STRING_ROUTINES.replaced_first_substring */
extern T0* T76f16(T0* C, T0* a1, T0* a2, T0* a3);
/* KL_STRING_ROUTINES.substring_index */
extern T6 T76f17(T0* C, T0* a1, T0* a2, T6 a3);
/* KL_STRING_ROUTINES.platform */
extern T0* T76f18(T0* C);
/* STRING_8.substring_index */
extern T6 T17f32(T0* C, T0* a1, T6 a2);
/* STRING_SEARCHER.substring_index */
extern T6 T677f2(T0* C, T0* a1, T0* a2, T6 a3, T6 a4);
/* STRING_SEARCHER.substring_index_with_deltas */
extern T6 T677f3(T0* C, T0* a1, T0* a2, T6 a3, T6 a4);
/* STRING_SEARCHER.internal_initialize_deltas */
extern void T677f6(T0* C, T0* a1, T6 a2, T0* a3);
/* SPECIAL [INTEGER_32].fill_with */
extern void T63f13(T0* C, T6 a1, T6 a2, T6 a3);
/* STRING_8.string_searcher */
extern unsigned char ge2345os1235;
extern T0* ge2345ov1235;
extern T0* T17f33(T0* C);
/* STRING_SEARCHER.make */
extern T0* T677c5(void);
/* KL_STRING_ROUTINES.replaced_all_substrings */
extern T0* T76f15(T0* C, T0* a1, T0* a2, T0* a3);
/* GEANT_REPLACE_COMMAND.string_ */
extern T0* T463f25(T0* C);
/* UC_UTF8_STRING.has */
extern T1 T207f53(T0* C, T2 a1);
/* KL_TEXT_OUTPUT_FILE.open_write */
extern void T517f23(T0* C);
/* KL_TEXT_OUTPUT_FILE.is_closed */
extern T1 T517f13(T0* C);
/* KL_TEXT_OUTPUT_FILE.old_open_write */
extern void T517f29(T0* C);
/* KL_TEXT_OUTPUT_FILE.default_pointer */
extern T14 T517f17(T0* C);
/* KL_TEXT_OUTPUT_FILE.open_write */
extern void T517f29p1(T0* C);
/* KL_TEXT_OUTPUT_FILE.file_open */
extern T14 T517f18(T0* C, T14 a1, T6 a2);
/* KL_TEXT_OUTPUT_FILE.reset */
extern void T517f35(T0* C, T0* a1);
/* KL_TEXT_OUTPUT_FILE.make */
extern void T517f20(T0* C, T0* a1);
/* KL_TEXT_OUTPUT_FILE.make */
extern T0* T517c20(T0* a1);
/* KL_TEXT_OUTPUT_FILE.old_make */
extern void T517f26(T0* C, T0* a1);
/* GEANT_REPLACE_COMMAND.tmp_output_file */
extern unsigned char ge91os8397;
extern T0* ge91ov8397;
extern T0* T463f24(T0* C);
/* KL_TEXT_INPUT_FILE.read_string */
extern void T55f68(T0* C, T6 a1);
/* KL_TEXT_INPUT_FILE.read_to_string */
extern T6 T55f33(T0* C, T0* a1, T6 a2, T6 a3);
/* KL_TEXT_INPUT_FILE.dummy_kl_character_buffer */
extern unsigned char ge206os4019;
extern T0* ge206ov4019;
extern T0* T55f38(T0* C);
/* KL_TEXT_INPUT_FILE.any_ */
extern T0* T55f35(T0* C);
/* KL_TEXT_INPUT_FILE.old_read_to_string */
extern T6 T55f37(T0* C, T0* a1, T6 a2, T6 a3);
/* KL_TEXT_INPUT_FILE.file_gss */
extern T6 T55f39(T0* C, T14 a1, T14 a2, T6 a3);
/* SPECIAL [CHARACTER_8].item_address */
extern T14 T15f6(T0* C, T6 a1);
/* GEANT_REPLACE_COMMAND.tmp_input_file */
extern unsigned char ge91os8396;
extern T0* ge91ov8396;
extern T0* T463f22(T0* C);
/* GEANT_REPLACE_COMMAND.execute_replace_regexp */
extern void T463f44(T0* C, T0* a1, T0* a2);
/* RX_PCRE_REGULAR_EXPRESSION.replace */
extern T0* T566f55(T0* C, T0* a1);
/* RX_PCRE_REGULAR_EXPRESSION.append_replace_to_string */
extern void T566f304(T0* C, T0* a1, T0* a2);
/* GEANT_REPLACE_COMMAND.execute_replace_variable_pattern */
extern void T463f43(T0* C, T0* a1, T0* a2);
/* ARRAY [GEANT_VARIABLES].item */
extern T0* T569f4(T0* C, T6 a1);
/* GEANT_PROJECT.aggregated_variables_array */
extern T0* T22f27(T0* C);
/* ARRAY [GEANT_VARIABLES].put */
extern void T569f6(T0* C, T0* a1, T6 a2);
/* ARRAY [GEANT_VARIABLES].make */
extern T0* T569c5(T6 a1, T6 a2);
/* ARRAY [GEANT_VARIABLES].make_area */
extern void T569f7(T0* C, T6 a1);
/* UC_UTF8_STRING.occurrences */
extern T6 T207f52(T0* C, T2 a1);
/* UC_UTF8_STRING.code_occurrences */
extern T6 T207f54(T0* C, T6 a1);
/* STRING_8.occurrences */
extern T6 T17f31(T0* C, T2 a1);
/* GEANT_REPLACE_COMMAND.is_file_to_file_executable */
extern T1 T463f16(T0* C);
/* GEANT_REPLACE_COMMAND.is_replace_executable */
extern T1 T463f18(T0* C);
/* GEANT_REPLACE_TASK.exit_application */
extern void T319f41(T0* C, T6 a1, T0* a2);
/* GEANT_REPLACE_TASK.exceptions */
extern T0* T319f27(T0* C);
/* GEANT_REPLACE_TASK.std */
extern T0* T319f26(T0* C);
/* GEANT_REPLACE_TASK.log_messages */
extern void T319f42(T0* C, T0* a1);
/* GEANT_REPLACE_TASK.dir_attribute_name */
extern T0* T319f25(T0* C);
/* GEANT_REPLACE_TASK.file_system */
extern T0* T319f24(T0* C);
/* GEANT_REPLACE_TASK.unix_file_system */
extern T0* T319f30(T0* C);
/* GEANT_REPLACE_TASK.windows_file_system */
extern T0* T319f29(T0* C);
/* GEANT_REPLACE_TASK.operating_system */
extern T0* T319f28(T0* C);
/* GEANT_INPUT_TASK.execute */
extern void T317f41(T0* C);
/* GEANT_INPUT_COMMAND.execute */
extern void T460f23(T0* C);
/* GEANT_PROJECT.set_variable_value */
extern void T22f51(T0* C, T0* a1, T0* a2);
/* GEANT_PROJECT.is_local_variable */
extern T1 T22f26(T0* C, T0* a1);
/* RX_PCRE_REGULAR_EXPRESSION.matches */
extern T1 T566f70(T0* C, T0* a1);
/* DS_LINKED_LIST [STRING_8].has */
extern T1 T241f9(T0* C, T0* a1);
/* GEANT_INPUT_COMMAND.string_ */
extern T0* T460f14(T0* C);
/* KL_STDIN_FILE.read_line */
extern void T568f16(T0* C);
/* KL_STDIN_FILE.unread_character */
extern void T568f19(T0* C, T2 a1);
/* ? KL_LINKABLE [CHARACTER_8].put_right */
extern void T89f4(T0* C, T0* a1);
/* ? KL_LINKABLE [CHARACTER_8].make */
extern T0* T89c3(T2 a1);
/* KL_STDIN_FILE.read_character */
extern void T568f18(T0* C);
/* KL_STDIN_FILE.old_read_character */
extern void T568f22(T0* C);
/* KL_STDIN_FILE.console_readchar */
extern T2 T568f12(T0* C, T14 a1);
/* KL_STDIN_FILE.old_end_of_file */
extern T1 T568f9(T0* C);
/* KL_STDIN_FILE.console_eof */
extern T1 T568f13(T0* C, T14 a1);
/* GEANT_INPUT_COMMAND.input */
extern unsigned char ge217os2962;
extern T0* ge217ov2962;
extern T0* T460f13(T0* C);
/* KL_STDIN_FILE.make */
extern T0* T568c14(void);
/* KL_STDIN_FILE.make_open_stdin */
extern void T568f17(T0* C, T0* a1);
/* KL_STDIN_FILE.set_read_mode */
extern void T568f21(T0* C);
/* KL_STDIN_FILE.console_def */
extern T14 T568f8(T0* C, T6 a1);
/* KL_STDIN_FILE.old_make */
extern void T568f20(T0* C, T0* a1);
/* GEANT_INPUT_COMMAND.output */
extern T0* T460f12(T0* C);
/* DS_LINKED_LIST [STRING_8].set_equality_tester */
extern void T241f17(T0* C, T0* a1);
/* GEANT_INPUT_TASK.exit_application */
extern void T317f42(T0* C, T6 a1, T0* a2);
/* GEANT_INPUT_TASK.exceptions */
extern T0* T317f28(T0* C);
/* GEANT_INPUT_TASK.log_messages */
extern void T317f43(T0* C, T0* a1);
/* GEANT_INPUT_TASK.dir_attribute_name */
extern T0* T317f27(T0* C);
/* GEANT_INPUT_TASK.file_system */
extern T0* T317f26(T0* C);
/* GEANT_INPUT_TASK.unix_file_system */
extern T0* T317f31(T0* C);
/* GEANT_INPUT_TASK.windows_file_system */
extern T0* T317f30(T0* C);
/* GEANT_INPUT_TASK.operating_system */
extern T0* T317f29(T0* C);
/* GEANT_AVAILABLE_TASK.execute */
extern void T315f31(T0* C);
/* GEANT_AVAILABLE_COMMAND.execute */
extern void T457f19(T0* C);
/* GEANT_STRING_PROPERTY.non_empty_value_or_else */
extern T0* T387f7(T0* C, T0* a1);
/* GEANT_STRING_PROPERTY.string_value */
extern T0* T387f4(T0* C);
/* GEANT_STRING_PROPERTY.is_defined */
extern T1 T387f5(T0* C);
/* GEANT_STRING_PROPERTY.value */
extern T0* T387f6(T0* C);
/* GEANT_AVAILABLE_TASK.exit_application */
extern void T315f32(T0* C, T6 a1, T0* a2);
/* GEANT_AVAILABLE_TASK.exceptions */
extern T0* T315f17(T0* C);
/* GEANT_AVAILABLE_TASK.std */
extern T0* T315f16(T0* C);
/* GEANT_AVAILABLE_TASK.log_messages */
extern void T315f33(T0* C, T0* a1);
/* GEANT_AVAILABLE_TASK.project_variables_resolver */
extern T0* T315f10(T0* C);
/* GEANT_AVAILABLE_TASK.dir_attribute_name */
extern T0* T315f15(T0* C);
/* GEANT_AVAILABLE_TASK.file_system */
extern T0* T315f14(T0* C);
/* GEANT_AVAILABLE_TASK.unix_file_system */
extern T0* T315f20(T0* C);
/* GEANT_AVAILABLE_TASK.windows_file_system */
extern T0* T315f19(T0* C);
/* GEANT_AVAILABLE_TASK.operating_system */
extern T0* T315f18(T0* C);
/* GEANT_PRECURSOR_TASK.execute */
extern void T313f39(T0* C);
/* GEANT_PRECURSOR_COMMAND.execute */
extern void T454f11(T0* C);
/* GEANT_PRECURSOR_TASK.dir_attribute_name */
extern T0* T313f24(T0* C);
/* GEANT_PRECURSOR_TASK.file_system */
extern T0* T313f23(T0* C);
/* GEANT_PRECURSOR_TASK.unix_file_system */
extern T0* T313f27(T0* C);
/* GEANT_PRECURSOR_TASK.windows_file_system */
extern T0* T313f26(T0* C);
/* GEANT_PRECURSOR_TASK.operating_system */
extern T0* T313f25(T0* C);
/* GEANT_EXIT_TASK.execute */
extern void T311f32(T0* C);
/* GEANT_EXIT_COMMAND.execute */
extern void T451f10(T0* C);
/* GEANT_EXIT_TASK.exit_application */
extern void T311f33(T0* C, T6 a1, T0* a2);
/* GEANT_EXIT_TASK.exceptions */
extern T0* T311f19(T0* C);
/* GEANT_EXIT_TASK.std */
extern T0* T311f18(T0* C);
/* GEANT_EXIT_TASK.log_messages */
extern void T311f34(T0* C, T0* a1);
/* GEANT_EXIT_TASK.dir_attribute_name */
extern T0* T311f17(T0* C);
/* GEANT_EXIT_TASK.file_system */
extern T0* T311f16(T0* C);
/* GEANT_EXIT_TASK.unix_file_system */
extern T0* T311f22(T0* C);
/* GEANT_EXIT_TASK.windows_file_system */
extern T0* T311f21(T0* C);
/* GEANT_EXIT_TASK.operating_system */
extern T0* T311f20(T0* C);
/* GEANT_OUTOFDATE_TASK.execute */
extern void T309f37(T0* C);
/* GEANT_OUTOFDATE_COMMAND.execute */
extern void T448f28(T0* C);
/* GEANT_FILESET.go_after */
extern void T391f56(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].go_after */
extern void T504f69(T0* C);
/* DS_HASH_SET [GEANT_FILESET_ENTRY].cursor_go_after */
extern void T504f70(T0* C, T0* a1);
/* GEANT_OUTOFDATE_COMMAND.is_file_outofdate */
extern T1 T448f17(T0* C, T0* a1, T0* a2);
/* GEANT_OUTOFDATE_COMMAND.unix_file_system */
extern T0* T448f15(T0* C);
/* GEANT_OUTOFDATE_COMMAND.file_system */
extern T0* T448f14(T0* C);
/* GEANT_OUTOFDATE_COMMAND.windows_file_system */
extern T0* T448f19(T0* C);
/* GEANT_OUTOFDATE_COMMAND.operating_system */
extern T0* T448f18(T0* C);
/* GEANT_OUTOFDATE_COMMAND.is_file_executable */
extern T1 T448f12(T0* C);
/* GEANT_OUTOFDATE_TASK.exit_application */
extern void T309f38(T0* C, T6 a1, T0* a2);
/* GEANT_OUTOFDATE_TASK.exceptions */
extern T0* T309f24(T0* C);
/* GEANT_OUTOFDATE_TASK.std */
extern T0* T309f23(T0* C);
/* GEANT_OUTOFDATE_TASK.log_messages */
extern void T309f39(T0* C, T0* a1);
/* GEANT_OUTOFDATE_TASK.dir_attribute_name */
extern T0* T309f22(T0* C);
/* GEANT_OUTOFDATE_TASK.file_system */
extern T0* T309f21(T0* C);
/* GEANT_OUTOFDATE_TASK.unix_file_system */
extern T0* T309f27(T0* C);
/* GEANT_OUTOFDATE_TASK.windows_file_system */
extern T0* T309f26(T0* C);
/* GEANT_OUTOFDATE_TASK.operating_system */
extern T0* T309f25(T0* C);
/* GEANT_XSLT_TASK.execute */
extern void T307f50(T0* C);
/* GEANT_XSLT_COMMAND.execute */
extern void T444f41(T0* C);
/* GEANT_XSLT_COMMAND.execute_gexslt */
extern void T444f45(T0* C, T0* a1);
/* GEANT_XSLT_COMMAND.execute_shell */
extern void T444f46(T0* C, T0* a1);
/* DP_SHELL_COMMAND.execute */
extern void T560f13(T0* C);
/* DP_SHELL_COMMAND.operating_system */
extern T0* T560f6(T0* C);
/* DP_SHELL_COMMAND.system */
extern void T560f14(T0* C, T0* a1);
/* DP_SHELL_COMMAND.system_call */
extern T6 T560f9(T0* C, T14 a1);
/* C_STRING.item */
extern T14 T189f4(T0* C);
/* C_STRING.make */
extern T0* T189c9(T0* a1);
/* C_STRING.set_string */
extern void T189f10(T0* C, T0* a1);
/* C_STRING.set_substring */
extern void T189f11(T0* C, T0* a1, T6 a2, T6 a3);
/* MANAGED_POINTER.put_natural_8 */
extern void T264f12(T0* C, T8 a1, T6 a2);
/* POINTER.memory_copy */
extern void T14f12(T14* C, T14 a1, T6 a2);
/* POINTER.c_memcpy */
extern void T14f14(T14* C, T14 a1, T14 a2, T6 a3);
/* NATURAL_32.to_natural_8 */
extern T8 T10f9(T10* C);
/* MANAGED_POINTER.resize */
extern void T264f11(T0* C, T6 a1);
/* POINTER.memory_set */
extern void T14f11(T14* C, T6 a1, T6 a2);
/* POINTER.c_memset */
extern void T14f13(T14* C, T14 a1, T6 a2, T6 a3);
/* POINTER.memory_realloc */
extern T14 T14f6(T14* C, T6 a1);
/* POINTER.c_realloc */
extern T14 T14f7(T14* C, T14 a1, T6 a2);
/* DP_SHELL_COMMAND.default_shell */
extern unsigned char ge2469os4786;
extern T0* ge2469ov4786;
extern T0* T560f8(T0* C);
/* DP_SHELL_COMMAND.get */
extern T0* T560f10(T0* C, T0* a1);
/* DP_SHELL_COMMAND.eif_getenv */
extern T14 T560f11(T0* C, T14 a1);
/* DP_SHELL_COMMAND.make */
extern T0* T560c12(T0* a1);
/* DP_SHELL_COMMAND.string_ */
extern T0* T560f7(T0* C);
/* DS_ARRAYED_LIST [DS_PAIR [STRING_8, STRING_8]].item */
extern T0* T445f9(T0* C, T6 a1);
/* GEANT_XSLT_COMMAND.string_ */
extern T0* T444f23(T0* C);
/* GEANT_VARIABLES_VARIABLE_RESOLVER.set_variables */
extern void T565f5(T0* C, T0* a1);
/* GEANT_VARIABLES_VARIABLE_RESOLVER.make */
extern T0* T565c4(void);
/* GEANT_XSLT_COMMAND.execute_xsltproc */
extern void T444f44(T0* C, T0* a1);
/* GEANT_XSLT_COMMAND.execute_xalan_java */
extern void T444f43(T0* C, T0* a1);
/* GEANT_XSLT_COMMAND.execute_xalan_cpp */
extern void T444f42(T0* C, T0* a1);
/* GEANT_XSLT_COMMAND.is_file_outofdate */
extern T1 T444f22(T0* C, T0* a1, T0* a2);
/* GEANT_VARIABLES.put */
extern void T29f76(T0* C, T0* a1, T0* a2);
/* GEANT_XSLT_COMMAND.unix_file_system */
extern T0* T444f21(T0* C);
/* GEANT_XSLT_COMMAND.file_system */
extern T0* T444f20(T0* C);
/* GEANT_XSLT_COMMAND.windows_file_system */
extern T0* T444f25(T0* C);
/* GEANT_XSLT_COMMAND.operating_system */
extern T0* T444f24(T0* C);
/* GEANT_XSLT_TASK.exit_application */
extern void T307f51(T0* C, T6 a1, T0* a2);
/* GEANT_XSLT_TASK.exceptions */
extern T0* T307f37(T0* C);
/* GEANT_XSLT_TASK.log_messages */
extern void T307f52(T0* C, T0* a1);
/* GEANT_XSLT_TASK.dir_attribute_name */
extern T0* T307f36(T0* C);
/* GEANT_XSLT_TASK.file_system */
extern T0* T307f35(T0* C);
/* GEANT_XSLT_TASK.unix_file_system */
extern T0* T307f40(T0* C);
/* GEANT_XSLT_TASK.windows_file_system */
extern T0* T307f39(T0* C);
/* GEANT_XSLT_TASK.operating_system */
extern T0* T307f38(T0* C);
/* GEANT_SETENV_TASK.execute */
extern void T305f33(T0* C);
/* GEANT_SETENV_COMMAND.execute */
extern void T440f13(T0* C);
/* KL_EXECUTION_ENVIRONMENT.set_variable_value */
extern void T104f5(T0* C, T0* a1, T0* a2);
/* EXECUTION_ENVIRONMENT.put */
extern void T83f10(T0* C, T0* a1, T0* a2);
/* EXECUTION_ENVIRONMENT.eif_putenv */
extern T6 T83f7(T0* C, T14 a1);
/* HASH_TABLE [C_STRING, STRING_8].force */
extern void T678f25(T0* C, T0* a1, T0* a2);
/* HASH_TABLE [C_STRING, STRING_8].table_force */
extern void T678f26(T0* C, T0* a1, T0* a2);
/* HASH_TABLE [C_STRING, STRING_8].add_space */
extern void T678f28(T0* C);
/* HASH_TABLE [C_STRING, STRING_8].accommodate */
extern void T678f29(T0* C, T6 a1);
/* HASH_TABLE [C_STRING, STRING_8].set_deleted_marks */
extern void T678f33(T0* C, T0* a1);
/* HASH_TABLE [C_STRING, STRING_8].set_keys */
extern void T678f32(T0* C, T0* a1);
/* HASH_TABLE [C_STRING, STRING_8].set_content */
extern void T678f31(T0* C, T0* a1);
/* HASH_TABLE [C_STRING, STRING_8].put */
extern void T678f30(T0* C, T0* a1, T0* a2);
/* HASH_TABLE [C_STRING, STRING_8].set_conflict */
extern void T678f34(T0* C);
/* HASH_TABLE [C_STRING, STRING_8].found */
extern T1 T678f21(T0* C);
/* HASH_TABLE [C_STRING, STRING_8].occupied */
extern T1 T678f20(T0* C, T6 a1);
/* SPECIAL [STRING_8].is_default */
extern T1 T32f4(T0* C, T6 a1);
/* HASH_TABLE [C_STRING, STRING_8].make */
extern T0* T678c24(T6 a1);
/* SPECIAL [C_STRING].make */
extern T0* T688c2(T6 a1);
/* PRIMES.higher_prime */
extern T6 T687f1(T0* C, T6 a1);
/* PRIMES.is_prime */
extern T1 T687f3(T0* C, T6 a1);
/* PRIMES.default_create */
extern T0* T687c5(void);
/* HASH_TABLE [C_STRING, STRING_8].soon_full */
extern T1 T678f15(T0* C);
/* HASH_TABLE [C_STRING, STRING_8].not_found */
extern T1 T678f14(T0* C);
/* HASH_TABLE [C_STRING, STRING_8].internal_search */
extern void T678f27(T0* C, T0* a1);
/* HASH_TABLE [C_STRING, STRING_8].same_keys */
extern T1 T678f19(T0* C, T0* a1, T0* a2);
extern T1 T678f19oe1(T0* a1, T0* a2);
/* UC_UTF8_STRING.is_equal */
extern T1 T207f55(T0* C, T0* a1);
/* EXECUTION_ENVIRONMENT.environ */
extern unsigned char ge2469os4797;
extern T0* ge2469ov4797;
extern T0* T83f6(T0* C);
/* GEANT_SETENV_COMMAND.execution_environment */
extern T0* T440f8(T0* C);
/* GEANT_SETENV_TASK.exit_application */
extern void T305f34(T0* C, T6 a1, T0* a2);
/* GEANT_SETENV_TASK.exceptions */
extern T0* T305f20(T0* C);
/* GEANT_SETENV_TASK.std */
extern T0* T305f19(T0* C);
/* GEANT_SETENV_TASK.log_messages */
extern void T305f35(T0* C, T0* a1);
/* GEANT_SETENV_TASK.dir_attribute_name */
extern T0* T305f18(T0* C);
/* GEANT_SETENV_TASK.file_system */
extern T0* T305f17(T0* C);
/* GEANT_SETENV_TASK.unix_file_system */
extern T0* T305f23(T0* C);
/* GEANT_SETENV_TASK.windows_file_system */
extern T0* T305f22(T0* C);
/* GEANT_SETENV_TASK.operating_system */
extern T0* T305f21(T0* C);
/* GEANT_MOVE_TASK.execute */
extern void T303f35(T0* C);
/* GEANT_MOVE_COMMAND.execute */
extern void T437f23(T0* C);
/* GEANT_MOVE_COMMAND.create_directory_for_pathname */
extern void T437f26(T0* C, T0* a1);
/* GEANT_MOVE_COMMAND.file_system */
extern T0* T437f14(T0* C);
/* GEANT_MOVE_COMMAND.windows_file_system */
extern T0* T437f16(T0* C);
/* GEANT_MOVE_COMMAND.operating_system */
extern T0* T437f15(T0* C);
/* GEANT_MOVE_COMMAND.is_file_to_file_executable */
extern T1 T437f10(T0* C);
/* GEANT_MOVE_COMMAND.move_file */
extern void T437f25(T0* C, T0* a1, T0* a2);
/* KL_WINDOWS_FILE_SYSTEM.same_physical_file */
extern T1 T53f33(T0* C, T0* a1, T0* a2);
/* KL_TEXT_INPUT_FILE.same_physical_file */
extern T1 T55f41(T0* C, T0* a1);
/* KL_TEXT_INPUT_FILE.old_change_name */
extern void T55f72(T0* C, T0* a1);
/* KL_TEXT_INPUT_FILE.file_rename */
extern void T55f74(T0* C, T14 a1, T14 a2);
/* KL_TEXT_INPUT_FILE.file_system */
extern T0* T55f46(T0* C);
/* KL_TEXT_INPUT_FILE.unix_file_system */
extern T0* T55f51(T0* C);
/* KL_TEXT_INPUT_FILE.windows_file_system */
extern T0* T55f50(T0* C);
/* KL_TEXT_INPUT_FILE.operating_system */
extern T0* T55f49(T0* C);
/* KL_TEXT_INPUT_FILE.count */
extern T6 T55f45(T0* C);
/* KL_TEXT_INPUT_FILE.old_count */
extern T6 T55f48(T0* C);
/* KL_TEXT_INPUT_FILE.file_size */
extern T6 T55f53(T0* C, T14 a1);
/* UNIX_FILE_INFO.size */
extern T6 T87f10(T0* C);
/* KL_TEXT_INPUT_FILE.old_is_open_write */
extern T1 T55f52(T0* C);
/* KL_TEXT_INPUT_FILE.inode */
extern T6 T55f44(T0* C);
/* UNIX_FILE_INFO.inode */
extern T6 T87f9(T0* C);
/* KL_TEXT_INPUT_FILE.tmp_file1 */
extern unsigned char ge204os4039;
extern T0* ge204ov4039;
extern T0* T55f43(T0* C);
/* KL_UNIX_FILE_SYSTEM.same_physical_file */
extern T1 T54f31(T0* C, T0* a1, T0* a2);
/* KL_WINDOWS_FILE_SYSTEM.rename_file */
extern void T53f44(T0* C, T0* a1, T0* a2);
/* KL_TEXT_INPUT_FILE.change_name */
extern void T55f71(T0* C, T0* a1);
/* KL_UNIX_FILE_SYSTEM.rename_file */
extern void T54f40(T0* C, T0* a1, T0* a2);
/* GEANT_MOVE_COMMAND.unix_file_system */
extern T0* T437f13(T0* C);
/* GEANT_MOVE_COMMAND.create_directory */
extern void T437f24(T0* C, T0* a1);
/* GEANT_MOVE_COMMAND.is_file_to_directory_executable */
extern T1 T437f11(T0* C);
/* GEANT_MOVE_TASK.exit_application */
extern void T303f36(T0* C, T6 a1, T0* a2);
/* GEANT_MOVE_TASK.exceptions */
extern T0* T303f22(T0* C);
/* GEANT_MOVE_TASK.std */
extern T0* T303f21(T0* C);
/* GEANT_MOVE_TASK.log_messages */
extern void T303f37(T0* C, T0* a1);
/* GEANT_MOVE_TASK.dir_attribute_name */
extern T0* T303f20(T0* C);
/* GEANT_MOVE_TASK.file_system */
extern T0* T303f19(T0* C);
/* GEANT_MOVE_TASK.unix_file_system */
extern T0* T303f25(T0* C);
/* GEANT_MOVE_TASK.windows_file_system */
extern T0* T303f24(T0* C);
/* GEANT_MOVE_TASK.operating_system */
extern T0* T303f23(T0* C);
/* GEANT_COPY_TASK.execute */
extern void T301f40(T0* C);
/* GEANT_COPY_COMMAND.execute */
extern void T434f27(T0* C);
/* GEANT_COPY_COMMAND.create_directory_for_pathname */
extern void T434f30(T0* C, T0* a1);
/* GEANT_COPY_COMMAND.file_system */
extern T0* T434f16(T0* C);
/* GEANT_COPY_COMMAND.windows_file_system */
extern T0* T434f19(T0* C);
/* GEANT_COPY_COMMAND.operating_system */
extern T0* T434f18(T0* C);
/* GEANT_COPY_COMMAND.is_file_to_file_executable */
extern T1 T434f12(T0* C);
/* GEANT_COPY_COMMAND.copy_file */
extern void T434f29(T0* C, T0* a1, T0* a2);
/* KL_WINDOWS_FILE_SYSTEM.copy_file */
extern void T53f43(T0* C, T0* a1, T0* a2);
/* KL_TEXT_INPUT_FILE.copy_file */
extern void T55f70(T0* C, T0* a1);
/* KL_BINARY_INPUT_FILE.close */
extern void T656f37(T0* C);
/* KL_BINARY_OUTPUT_FILE.close */
extern void T657f23(T0* C);
/* KL_BINARY_OUTPUT_FILE.put_string */
extern void T657f22(T0* C, T0* a1);
/* KL_BINARY_OUTPUT_FILE.old_put_string */
extern void T657f27(T0* C, T0* a1);
/* KL_BINARY_OUTPUT_FILE.file_ps */
extern void T657f29(T0* C, T14 a1, T14 a2, T6 a3);
/* KL_BINARY_OUTPUT_FILE.string_ */
extern T0* T657f9(T0* C);
/* KL_BINARY_INPUT_FILE.read_string */
extern void T656f36(T0* C, T6 a1);
/* KL_BINARY_INPUT_FILE.read_to_string */
extern T6 T656f20(T0* C, T0* a1, T6 a2, T6 a3);
/* KL_BINARY_INPUT_FILE.dummy_kl_character_buffer */
extern T0* T656f32(T0* C);
/* KL_BINARY_INPUT_FILE.any_ */
extern T0* T656f30(T0* C);
/* KL_BINARY_INPUT_FILE.old_read_to_string */
extern T6 T656f19(T0* C, T0* a1, T6 a2, T6 a3);
/* KL_BINARY_INPUT_FILE.file_gss */
extern T6 T656f29(T0* C, T14 a1, T14 a2, T6 a3);
/* KL_BINARY_INPUT_FILE.old_end_of_file */
extern T1 T656f18(T0* C);
/* KL_BINARY_INPUT_FILE.file_feof */
extern T1 T656f28(T0* C, T14 a1);
/* KL_BINARY_OUTPUT_FILE.is_open_write */
extern T1 T657f12(T0* C);
/* KL_BINARY_OUTPUT_FILE.old_is_open_write */
extern T1 T657f8(T0* C);
/* KL_BINARY_OUTPUT_FILE.open_write */
extern void T657f21(T0* C);
/* KL_BINARY_OUTPUT_FILE.is_closed */
extern T1 T657f13(T0* C);
/* KL_BINARY_OUTPUT_FILE.old_open_write */
extern void T657f26(T0* C);
/* KL_BINARY_OUTPUT_FILE.default_pointer */
extern T14 T657f17(T0* C);
/* KL_BINARY_OUTPUT_FILE.open_write */
extern void T657f26p1(T0* C);
/* KL_BINARY_OUTPUT_FILE.file_open */
extern T14 T657f18(T0* C, T14 a1, T6 a2);
/* KL_BINARY_OUTPUT_FILE.make */
extern T0* T657c19(T0* a1);
/* KL_BINARY_OUTPUT_FILE.old_make */
extern void T657f24(T0* C, T0* a1);
/* KL_BINARY_INPUT_FILE.is_open_read */
extern T1 T656f13(T0* C);
/* KL_BINARY_INPUT_FILE.old_is_open_read */
extern T1 T656f9(T0* C);
/* KL_BINARY_INPUT_FILE.open_read */
extern void T656f35(T0* C);
/* KL_BINARY_INPUT_FILE.is_closed */
extern T1 T656f17(T0* C);
/* KL_BINARY_INPUT_FILE.old_open_read */
extern void T656f40(T0* C);
/* KL_BINARY_INPUT_FILE.default_pointer */
extern T14 T656f24(T0* C);
/* KL_BINARY_INPUT_FILE.open_read */
extern void T656f40p1(T0* C);
/* KL_BINARY_INPUT_FILE.file_open */
extern T14 T656f25(T0* C, T14 a1, T6 a2);
/* KL_BINARY_INPUT_FILE.old_is_readable */
extern T1 T656f16(T0* C);
/* KL_BINARY_INPUT_FILE.buffered_file_info */
extern T0* T656f27(T0* C);
/* KL_BINARY_INPUT_FILE.set_buffer */
extern void T656f42(T0* C);
/* KL_BINARY_INPUT_FILE.old_exists */
extern T1 T656f15(T0* C);
/* KL_BINARY_INPUT_FILE.file_exists */
extern T1 T656f26(T0* C, T14 a1);
/* KL_BINARY_INPUT_FILE.make */
extern T0* T656c33(T0* a1);
/* KL_BINARY_INPUT_FILE.make */
extern void T656f33p1(T0* C, T0* a1);
/* KL_BINARY_INPUT_FILE.old_make */
extern void T656f38(T0* C, T0* a1);
/* KL_BINARY_INPUT_FILE.string_ */
extern T0* T656f10(T0* C);
/* KL_UNIX_FILE_SYSTEM.copy_file */
extern void T54f39(T0* C, T0* a1, T0* a2);
/* GEANT_COPY_COMMAND.is_file_outofdate */
extern T1 T434f17(T0* C, T0* a1, T0* a2);
/* GEANT_COPY_COMMAND.unix_file_system */
extern T0* T434f15(T0* C);
/* GEANT_COPY_COMMAND.create_directory */
extern void T434f28(T0* C, T0* a1);
/* GEANT_COPY_COMMAND.is_file_to_directory_executable */
extern T1 T434f13(T0* C);
/* GEANT_COPY_TASK.exit_application */
extern void T301f41(T0* C, T6 a1, T0* a2);
/* GEANT_COPY_TASK.exceptions */
extern T0* T301f27(T0* C);
/* GEANT_COPY_TASK.log_messages */
extern void T301f42(T0* C, T0* a1);
/* GEANT_COPY_TASK.dir_attribute_name */
extern T0* T301f26(T0* C);
/* GEANT_COPY_TASK.file_system */
extern T0* T301f25(T0* C);
/* GEANT_COPY_TASK.unix_file_system */
extern T0* T301f30(T0* C);
/* GEANT_COPY_TASK.windows_file_system */
extern T0* T301f29(T0* C);
/* GEANT_COPY_TASK.operating_system */
extern T0* T301f28(T0* C);
/* GEANT_DELETE_TASK.execute */
extern void T299f35(T0* C);
/* GEANT_DELETE_COMMAND.execute */
extern void T430f25(T0* C);
/* GEANT_DIRECTORYSET.forth */
extern void T431f31(T0* C);
/* GEANT_DIRECTORYSET.update_project_variables */
extern void T431f35(T0* C);
/* GEANT_DIRECTORYSET.item_directory_name */
extern T0* T431f14(T0* C);
/* GEANT_DIRECTORYSET.after */
extern T1 T431f13(T0* C);
/* GEANT_DIRECTORYSET.start */
extern void T431f30(T0* C);
/* GEANT_DIRECTORYSET.execute */
extern void T431f29(T0* C);
/* GEANT_DIRECTORYSET.remove_fileset_entry */
extern void T431f34(T0* C, T0* a1);
/* GEANT_DIRECTORYSET.add_fileset_entry_if_necessary */
extern void T431f33(T0* C, T0* a1);
/* GEANT_DIRECTORYSET.scan_internal */
extern void T431f32(T0* C, T0* a1);
/* GEANT_DIRECTORYSET.file_system */
extern T0* T431f18(T0* C);
/* GEANT_DIRECTORYSET.windows_file_system */
extern T0* T431f20(T0* C);
/* GEANT_DIRECTORYSET.operating_system */
extern T0* T431f19(T0* C);
/* GEANT_DIRECTORYSET.string_ */
extern T0* T431f17(T0* C);
/* GEANT_DIRECTORYSET.unix_file_system */
extern T0* T431f16(T0* C);
/* GEANT_DIRECTORYSET.is_executable */
extern T1 T431f15(T0* C);
/* GEANT_DELETE_COMMAND.is_directoryset_executable */
extern T1 T430f14(T0* C);
/* GEANT_DELETE_COMMAND.is_fileset_executable */
extern T1 T430f13(T0* C);
/* KL_WINDOWS_FILE_SYSTEM.delete_file */
extern void T53f39(T0* C, T0* a1);
/* KL_TEXT_INPUT_FILE.delete */
extern void T55f69(T0* C);
/* KL_TEXT_INPUT_FILE.old_delete */
extern void T55f73(T0* C);
/* KL_TEXT_INPUT_FILE.file_unlink */
extern void T55f75(T0* C, T14 a1);
/* KL_UNIX_FILE_SYSTEM.delete_file */
extern void T54f35(T0* C, T0* a1);
/* GEANT_DELETE_COMMAND.is_file_executable */
extern T1 T430f11(T0* C);
/* KL_WINDOWS_FILE_SYSTEM.recursive_delete_directory */
extern void T53f41(T0* C, T0* a1);
/* KL_DIRECTORY.recursive_delete */
extern void T490f50(T0* C);
/* KL_DIRECTORY.old_recursive_delete */
extern void T490f52(T0* C);
/* KL_DIRECTORY.old_delete */
extern void T490f53(T0* C);
/* KL_DIRECTORY.eif_dir_delete */
extern void T490f55(T0* C, T14 a1);
/* KL_DIRECTORY.old_is_empty */
extern T1 T490f32(T0* C);
/* KL_DIRECTORY.count */
extern T6 T490f34(T0* C);
/* DIRECTORY.readentry */
extern void T661f19(T0* C);
/* DIRECTORY.dir_next */
extern T0* T661f8(T0* C, T14 a1);
/* DIRECTORY.start */
extern void T661f18(T0* C);
/* DIRECTORY.dir_rewind */
extern void T661f24(T0* C, T14 a1);
/* DIRECTORY.make_open_read */
extern T0* T661c17(T0* a1);
/* DIRECTORY.open_read */
extern void T661f23(T0* C);
/* DIRECTORY.dir_open */
extern T14 T661f11(T0* C, T14 a1);
/* DIRECTORY.make */
extern void T661f14(T0* C, T0* a1);
/* DIRECTORY.make */
extern T0* T661c14(T0* a1);
/* KL_DIRECTORY.delete_content */
extern void T490f54(T0* C);
/* ARRAYED_LIST [STRING_8].forth */
extern void T662f14(T0* C);
/* RAW_FILE.delete */
extern void T660f15(T0* C);
/* RAW_FILE.file_unlink */
extern void T660f18(T0* C, T14 a1);
/* RAW_FILE.is_writable */
extern T1 T660f12(T0* C);
/* UNIX_FILE_INFO.is_writable */
extern T1 T87f13(T0* C);
/* RAW_FILE.buffered_file_info */
extern T0* T660f7(T0* C);
/* RAW_FILE.set_buffer */
extern void T660f16(T0* C);
/* DIRECTORY.recursive_delete */
extern void T661f16(T0* C);
/* DIRECTORY.delete */
extern void T661f22(T0* C);
/* DIRECTORY.eif_dir_delete */
extern void T661f26(T0* C, T14 a1);
/* DIRECTORY.is_empty */
extern T1 T661f6(T0* C);
/* DIRECTORY.count */
extern T6 T661f13(T0* C);
/* DIRECTORY.delete_content */
extern void T661f21(T0* C);
/* DIRECTORY.linear_representation */
extern T0* T661f10(T0* C);
/* ARRAYED_LIST [STRING_8].extend */
extern void T662f15(T0* C, T0* a1);
/* ARRAYED_LIST [STRING_8].force_i_th */
extern void T662f18(T0* C, T0* a1, T6 a2);
/* ARRAYED_LIST [STRING_8].put_i_th */
extern void T662f21(T0* C, T0* a1, T6 a2);
/* ARRAYED_LIST [STRING_8].auto_resize */
extern void T662f20(T0* C, T6 a1, T6 a2);
/* ARRAYED_LIST [STRING_8].capacity */
extern T6 T662f10(T0* C);
/* ARRAYED_LIST [STRING_8].make_area */
extern void T662f19(T0* C, T6 a1);
/* ARRAYED_LIST [STRING_8].additional_space */
extern T6 T662f9(T0* C);
/* ARRAYED_LIST [STRING_8].empty_area */
extern T1 T662f8(T0* C);
/* ARRAYED_LIST [STRING_8].set_count */
extern void T662f16(T0* C, T6 a1);
/* ARRAYED_LIST [STRING_8].make */
extern T0* T662c12(T6 a1);
/* ARRAYED_LIST [STRING_8].array_make */
extern void T662f17(T0* C, T6 a1, T6 a2);
/* RAW_FILE.is_directory */
extern T1 T660f11(T0* C);
/* UNIX_FILE_INFO.is_directory */
extern T1 T87f12(T0* C);
/* RAW_FILE.is_symlink */
extern T1 T660f8(T0* C);
/* UNIX_FILE_INFO.is_symlink */
extern T1 T87f11(T0* C);
/* RAW_FILE.exists */
extern T1 T660f5(T0* C);
/* RAW_FILE.file_exists */
extern T1 T660f6(T0* C, T14 a1);
/* RAW_FILE.make */
extern T0* T660c13(T0* a1);
/* FILE_NAME.set_file_name */
extern void T659f11(T0* C, T0* a1);
/* FILE_NAME.set_count */
extern void T659f16(T0* C, T6 a1);
/* FILE_NAME.c_strlen */
extern T6 T659f4(T0* C, T14 a1);
/* FILE_NAME.eif_append_file_name */
extern void T659f15(T0* C, T14 a1, T14 a2, T14 a3);
/* FILE_NAME.resize */
extern void T659f14(T0* C, T6 a1);
/* FILE_NAME.capacity */
extern T6 T659f5(T0* C);
/* FILE_NAME.make_from_string */
extern T0* T659c10(T0* a1);
/* FILE_NAME.append */
extern void T659f13(T0* C, T0* a1);
/* FILE_NAME.additional_space */
extern T6 T659f7(T0* C);
/* FILE_NAME.string_make */
extern void T659f12(T0* C, T6 a1);
/* ARRAYED_LIST [STRING_8].item */
extern T0* T662f6(T0* C);
/* ARRAYED_LIST [STRING_8].after */
extern T1 T662f7(T0* C);
/* ARRAYED_LIST [STRING_8].start */
extern void T662f13(T0* C);
/* KL_DIRECTORY.linear_representation */
extern T0* T490f33(T0* C);
/* KL_UNIX_FILE_SYSTEM.recursive_delete_directory */
extern void T54f37(T0* C, T0* a1);
/* GEANT_DELETE_COMMAND.unix_file_system */
extern T0* T430f16(T0* C);
/* GEANT_DELETE_COMMAND.file_system */
extern T0* T430f15(T0* C);
/* GEANT_DELETE_COMMAND.windows_file_system */
extern T0* T430f18(T0* C);
/* GEANT_DELETE_COMMAND.operating_system */
extern T0* T430f17(T0* C);
/* GEANT_DELETE_COMMAND.is_directory_executable */
extern T1 T430f12(T0* C);
/* GEANT_DELETE_TASK.exit_application */
extern void T299f36(T0* C, T6 a1, T0* a2);
/* GEANT_DELETE_TASK.exceptions */
extern T0* T299f22(T0* C);
/* GEANT_DELETE_TASK.std */
extern T0* T299f21(T0* C);
/* GEANT_DELETE_TASK.log_messages */
extern void T299f37(T0* C, T0* a1);
/* GEANT_DELETE_TASK.dir_attribute_name */
extern T0* T299f20(T0* C);
/* GEANT_DELETE_TASK.file_system */
extern T0* T299f19(T0* C);
/* GEANT_DELETE_TASK.unix_file_system */
extern T0* T299f25(T0* C);
/* GEANT_DELETE_TASK.windows_file_system */
extern T0* T299f24(T0* C);
/* GEANT_DELETE_TASK.operating_system */
extern T0* T299f23(T0* C);
/* GEANT_MKDIR_TASK.execute */
extern void T297f31(T0* C);
/* GEANT_MKDIR_COMMAND.execute */
extern void T426f16(T0* C);
/* GEANT_MKDIR_TASK.exit_application */
extern void T297f32(T0* C, T6 a1, T0* a2);
/* GEANT_MKDIR_TASK.exceptions */
extern T0* T297f17(T0* C);
/* GEANT_MKDIR_TASK.std */
extern T0* T297f16(T0* C);
/* GEANT_MKDIR_TASK.log_messages */
extern void T297f33(T0* C, T0* a1);
/* GEANT_MKDIR_TASK.project_variables_resolver */
extern T0* T297f10(T0* C);
/* GEANT_MKDIR_TASK.dir_attribute_name */
extern T0* T297f15(T0* C);
/* GEANT_MKDIR_TASK.file_system */
extern T0* T297f14(T0* C);
/* GEANT_MKDIR_TASK.unix_file_system */
extern T0* T297f20(T0* C);
/* GEANT_MKDIR_TASK.windows_file_system */
extern T0* T297f19(T0* C);
/* GEANT_MKDIR_TASK.operating_system */
extern T0* T297f18(T0* C);
/* GEANT_ECHO_TASK.execute */
extern void T295f31(T0* C);
/* GEANT_ECHO_COMMAND.execute */
extern void T423f16(T0* C);
/* KL_TEXT_OUTPUT_FILE.open_append */
extern void T517f22(T0* C);
/* KL_TEXT_OUTPUT_FILE.old_open_append */
extern void T517f28(T0* C);
/* KL_TEXT_OUTPUT_FILE.open_append */
extern void T517f28p1(T0* C);
/* GEANT_BOOLEAN_PROPERTY.non_empty_value_or_else */
extern T1 T390f6(T0* C, T1 a1);
/* GEANT_BOOLEAN_PROPERTY.value */
extern T1 T390f5(T0* C);
/* GEANT_BOOLEAN_PROPERTY.boolean_value */
extern T1 T390f8(T0* C, T0* a1);
/* GEANT_BOOLEAN_PROPERTY.false_attribute_value */
extern unsigned char ge68os8781;
extern T0* ge68ov8781;
extern T0* T390f11(T0* C);
/* GEANT_BOOLEAN_PROPERTY.true_attribute_value */
extern unsigned char ge68os8780;
extern T0* ge68ov8780;
extern T0* T390f10(T0* C);
/* GEANT_BOOLEAN_PROPERTY.string_ */
extern T0* T390f9(T0* C);
/* GEANT_BOOLEAN_PROPERTY.string_value */
extern T0* T390f4(T0* C);
/* GEANT_BOOLEAN_PROPERTY.is_defined */
extern T1 T390f7(T0* C);
/* GEANT_ECHO_TASK.exit_application */
extern void T295f32(T0* C, T6 a1, T0* a2);
/* GEANT_ECHO_TASK.exceptions */
extern T0* T295f17(T0* C);
/* GEANT_ECHO_TASK.std */
extern T0* T295f16(T0* C);
/* GEANT_ECHO_TASK.log_messages */
extern void T295f33(T0* C, T0* a1);
/* GEANT_ECHO_TASK.project_variables_resolver */
extern T0* T295f10(T0* C);
/* GEANT_ECHO_TASK.dir_attribute_name */
extern T0* T295f15(T0* C);
/* GEANT_ECHO_TASK.file_system */
extern T0* T295f14(T0* C);
/* GEANT_ECHO_TASK.unix_file_system */
extern T0* T295f20(T0* C);
/* GEANT_ECHO_TASK.windows_file_system */
extern T0* T295f19(T0* C);
/* GEANT_ECHO_TASK.operating_system */
extern T0* T295f18(T0* C);
/* GEANT_GEANT_TASK.execute */
extern void T293f47(T0* C);
/* GEANT_GEANT_COMMAND.execute */
extern void T419f34(T0* C);
/* GEANT_GEANT_COMMAND.execute_with_target */
extern void T419f38(T0* C, T0* a1);
/* GEANT_GEANT_COMMAND.is_fileset_executable */
extern T1 T419f21(T0* C);
/* GEANT_GEANT_COMMAND.execute_forked_with_target */
extern void T419f37(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.item */
extern T0* T25f54(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.item_storage_item */
extern T0* T25f50(T0* C, T6 a1);
/* GEANT_GEANT_COMMAND.string_ */
extern T0* T419f19(T0* C);
/* GEANT_GEANT_COMMAND.execute_with_filename */
extern void T419f36(T0* C, T0* a1);
/* GEANT_TARGET.is_exported_to_project */
extern T1 T26f62(T0* C, T0* a1);
/* GEANT_PROJECT.has_parent_with_name */
extern T1 T22f28(T0* C, T0* a1);
/* GEANT_PROJECT.string_ */
extern T0* T22f29(T0* C);
/* GEANT_GEANT_COMMAND.exit_application */
extern void T419f39(T0* C, T6 a1, T0* a2);
/* GEANT_GEANT_COMMAND.exceptions */
extern T0* T419f23(T0* C);
/* GEANT_GEANT_COMMAND.std */
extern T0* T419f22(T0* C);
/* GEANT_GEANT_COMMAND.log_messages */
extern void T419f41(T0* C, T0* a1);
/* GEANT_GEANT_COMMAND.execute_forked_with_filename_and_target */
extern void T419f35(T0* C, T0* a1, T0* a2);
/* GEANT_GEANT_COMMAND.execute_shell */
extern void T419f40(T0* C, T0* a1);
/* GEANT_GEANT_COMMAND.options_and_arguments_for_cmdline */
extern T0* T419f20(T0* C);
/* GEANT_PROJECT_VARIABLES.put */
extern void T25f87(T0* C, T0* a1, T0* a2);
/* GEANT_GEANT_COMMAND.project_variables_resolver */
extern T0* T419f18(T0* C);
/* GEANT_GEANT_COMMAND.unix_file_system */
extern T0* T419f17(T0* C);
/* GEANT_GEANT_COMMAND.file_system */
extern T0* T419f16(T0* C);
/* GEANT_GEANT_COMMAND.windows_file_system */
extern T0* T419f25(T0* C);
/* GEANT_GEANT_COMMAND.operating_system */
extern T0* T419f24(T0* C);
/* GEANT_GEANT_COMMAND.is_filename_executable */
extern T1 T419f14(T0* C);
/* GEANT_GEANT_TASK.dir_attribute_name */
extern T0* T293f32(T0* C);
/* GEANT_GEANT_TASK.file_system */
extern T0* T293f31(T0* C);
/* GEANT_GEANT_TASK.unix_file_system */
extern T0* T293f35(T0* C);
/* GEANT_GEANT_TASK.windows_file_system */
extern T0* T293f34(T0* C);
/* GEANT_GEANT_TASK.operating_system */
extern T0* T293f33(T0* C);
/* GEANT_GETEST_TASK.execute */
extern void T291f48(T0* C);
/* GEANT_GETEST_COMMAND.execute */
extern void T416f34(T0* C);
/* GEANT_GETEST_COMMAND.execute_shell */
extern void T416f35(T0* C, T0* a1);
/* GEANT_GETEST_COMMAND.unix_file_system */
extern T0* T416f19(T0* C);
/* GEANT_GETEST_COMMAND.file_system */
extern T0* T416f18(T0* C);
/* GEANT_GETEST_COMMAND.windows_file_system */
extern T0* T416f21(T0* C);
/* GEANT_GETEST_COMMAND.operating_system */
extern T0* T416f20(T0* C);
/* GEANT_GETEST_COMMAND.string_ */
extern T0* T416f17(T0* C);
/* GEANT_GETEST_TASK.exit_application */
extern void T291f49(T0* C, T6 a1, T0* a2);
/* GEANT_GETEST_TASK.exceptions */
extern T0* T291f35(T0* C);
/* GEANT_GETEST_TASK.log_messages */
extern void T291f50(T0* C, T0* a1);
/* GEANT_GETEST_TASK.dir_attribute_name */
extern T0* T291f34(T0* C);
/* GEANT_GETEST_TASK.file_system */
extern T0* T291f33(T0* C);
/* GEANT_GETEST_TASK.unix_file_system */
extern T0* T291f38(T0* C);
/* GEANT_GETEST_TASK.windows_file_system */
extern T0* T291f37(T0* C);
/* GEANT_GETEST_TASK.operating_system */
extern T0* T291f36(T0* C);
/* GEANT_GEPP_TASK.execute */
extern void T289f43(T0* C);
/* GEANT_GEPP_COMMAND.execute */
extern void T413f29(T0* C);
/* GEANT_FILESET.has_map */
extern T1 T391f30(T0* C);
/* GEANT_GEPP_COMMAND.execute_shell */
extern void T413f31(T0* C, T0* a1);
/* GEANT_GEPP_COMMAND.is_file_outofdate */
extern T1 T413f18(T0* C, T0* a1, T0* a2);
/* GEANT_GEPP_COMMAND.unix_file_system */
extern T0* T413f17(T0* C);
/* GEANT_GEPP_COMMAND.file_system */
extern T0* T413f16(T0* C);
/* GEANT_GEPP_COMMAND.windows_file_system */
extern T0* T413f20(T0* C);
/* GEANT_GEPP_COMMAND.operating_system */
extern T0* T413f19(T0* C);
/* GEANT_GEPP_COMMAND.is_file_executable */
extern T1 T413f13(T0* C);
/* GEANT_GEPP_COMMAND.create_directory */
extern void T413f30(T0* C, T0* a1);
/* GEANT_GEPP_COMMAND.string_ */
extern T0* T413f15(T0* C);
/* GEANT_GEPP_TASK.exit_application */
extern void T289f44(T0* C, T6 a1, T0* a2);
/* GEANT_GEPP_TASK.exceptions */
extern T0* T289f30(T0* C);
/* GEANT_GEPP_TASK.log_messages */
extern void T289f45(T0* C, T0* a1);
/* GEANT_GEPP_TASK.dir_attribute_name */
extern T0* T289f29(T0* C);
/* GEANT_GEPP_TASK.file_system */
extern T0* T289f28(T0* C);
/* GEANT_GEPP_TASK.unix_file_system */
extern T0* T289f33(T0* C);
/* GEANT_GEPP_TASK.windows_file_system */
extern T0* T289f32(T0* C);
/* GEANT_GEPP_TASK.operating_system */
extern T0* T289f31(T0* C);
/* GEANT_GEYACC_TASK.execute */
extern void T287f43(T0* C);
/* GEANT_GEYACC_COMMAND.execute */
extern void T410f29(T0* C);
/* GEANT_GEYACC_COMMAND.execute_shell */
extern void T410f30(T0* C, T0* a1);
/* GEANT_GEYACC_COMMAND.string_ */
extern T0* T410f16(T0* C);
/* GEANT_GEYACC_COMMAND.unix_file_system */
extern T0* T410f15(T0* C);
/* GEANT_GEYACC_COMMAND.file_system */
extern T0* T410f14(T0* C);
/* GEANT_GEYACC_COMMAND.windows_file_system */
extern T0* T410f18(T0* C);
/* GEANT_GEYACC_COMMAND.operating_system */
extern T0* T410f17(T0* C);
/* GEANT_GEYACC_TASK.exit_application */
extern void T287f44(T0* C, T6 a1, T0* a2);
/* GEANT_GEYACC_TASK.exceptions */
extern T0* T287f30(T0* C);
/* GEANT_GEYACC_TASK.log_messages */
extern void T287f45(T0* C, T0* a1);
/* GEANT_GEYACC_TASK.dir_attribute_name */
extern T0* T287f29(T0* C);
/* GEANT_GEYACC_TASK.file_system */
extern T0* T287f28(T0* C);
/* GEANT_GEYACC_TASK.unix_file_system */
extern T0* T287f33(T0* C);
/* GEANT_GEYACC_TASK.windows_file_system */
extern T0* T287f32(T0* C);
/* GEANT_GEYACC_TASK.operating_system */
extern T0* T287f31(T0* C);
/* GEANT_GELEX_TASK.execute */
extern void T285f46(T0* C);
/* GEANT_GELEX_COMMAND.execute */
extern void T407f35(T0* C);
/* GEANT_GELEX_COMMAND.execute_shell */
extern void T407f36(T0* C, T0* a1);
/* GEANT_GELEX_COMMAND.unix_file_system */
extern T0* T407f19(T0* C);
/* GEANT_GELEX_COMMAND.file_system */
extern T0* T407f18(T0* C);
/* GEANT_GELEX_COMMAND.windows_file_system */
extern T0* T407f21(T0* C);
/* GEANT_GELEX_COMMAND.operating_system */
extern T0* T407f20(T0* C);
/* GEANT_GELEX_COMMAND.string_ */
extern T0* T407f17(T0* C);
/* GEANT_GELEX_TASK.exit_application */
extern void T285f47(T0* C, T6 a1, T0* a2);
/* GEANT_GELEX_TASK.exceptions */
extern T0* T285f33(T0* C);
/* GEANT_GELEX_TASK.log_messages */
extern void T285f48(T0* C, T0* a1);
/* GEANT_GELEX_TASK.dir_attribute_name */
extern T0* T285f32(T0* C);
/* GEANT_GELEX_TASK.file_system */
extern T0* T285f31(T0* C);
/* GEANT_GELEX_TASK.unix_file_system */
extern T0* T285f36(T0* C);
/* GEANT_GELEX_TASK.windows_file_system */
extern T0* T285f35(T0* C);
/* GEANT_GELEX_TASK.operating_system */
extern T0* T285f34(T0* C);
/* GEANT_GEXACE_TASK.execute */
extern void T283f44(T0* C);
/* GEANT_GEXACE_COMMAND.execute */
extern void T404f32(T0* C);
/* GEANT_GEXACE_COMMAND.execute_shell */
extern void T404f33(T0* C, T0* a1);
/* GEANT_GEXACE_COMMAND.unix_file_system */
extern T0* T404f20(T0* C);
/* GEANT_GEXACE_COMMAND.file_system */
extern T0* T404f19(T0* C);
/* GEANT_GEXACE_COMMAND.windows_file_system */
extern T0* T404f22(T0* C);
/* GEANT_GEXACE_COMMAND.operating_system */
extern T0* T404f21(T0* C);
/* GEANT_GEXACE_COMMAND.is_library_executable */
extern T1 T404f17(T0* C);
/* GEANT_GEXACE_COMMAND.is_system_executable */
extern T1 T404f16(T0* C);
/* GEANT_GEXACE_COMMAND.is_validate_executable */
extern T1 T404f15(T0* C);
/* GEANT_GEXACE_COMMAND.string_ */
extern T0* T404f18(T0* C);
/* GEANT_GEXACE_TASK.exit_application */
extern void T283f45(T0* C, T6 a1, T0* a2);
/* GEANT_GEXACE_TASK.exceptions */
extern T0* T283f31(T0* C);
/* GEANT_GEXACE_TASK.log_messages */
extern void T283f46(T0* C, T0* a1);
/* GEANT_GEXACE_TASK.dir_attribute_name */
extern T0* T283f30(T0* C);
/* GEANT_GEXACE_TASK.file_system */
extern T0* T283f29(T0* C);
/* GEANT_GEXACE_TASK.unix_file_system */
extern T0* T283f34(T0* C);
/* GEANT_GEXACE_TASK.windows_file_system */
extern T0* T283f33(T0* C);
/* GEANT_GEXACE_TASK.operating_system */
extern T0* T283f32(T0* C);
/* GEANT_UNSET_TASK.execute */
extern void T281f32(T0* C);
/* GEANT_UNSET_COMMAND.execute */
extern void T400f10(T0* C);
/* GEANT_PROJECT.unset_variable */
extern void T22f52(T0* C, T0* a1);
/* GEANT_UNSET_TASK.exit_application */
extern void T281f33(T0* C, T6 a1, T0* a2);
/* GEANT_UNSET_TASK.exceptions */
extern T0* T281f19(T0* C);
/* GEANT_UNSET_TASK.std */
extern T0* T281f18(T0* C);
/* GEANT_UNSET_TASK.log_messages */
extern void T281f34(T0* C, T0* a1);
/* GEANT_UNSET_TASK.dir_attribute_name */
extern T0* T281f17(T0* C);
/* GEANT_UNSET_TASK.file_system */
extern T0* T281f16(T0* C);
/* GEANT_UNSET_TASK.unix_file_system */
extern T0* T281f22(T0* C);
/* GEANT_UNSET_TASK.windows_file_system */
extern T0* T281f21(T0* C);
/* GEANT_UNSET_TASK.operating_system */
extern T0* T281f20(T0* C);
/* GEANT_SET_TASK.execute */
extern void T279f33(T0* C);
/* GEANT_SET_COMMAND.execute */
extern void T397f17(T0* C);
/* GEANT_SET_COMMAND.default_builtin_variables */
extern T0* T397f8(T0* C);
/* GEANT_SET_COMMAND.file_system */
extern T0* T397f10(T0* C);
/* GEANT_SET_COMMAND.unix_file_system */
extern T0* T397f12(T0* C);
/* GEANT_SET_COMMAND.windows_file_system */
extern T0* T397f11(T0* C);
/* GEANT_SET_COMMAND.operating_system */
extern T0* T397f9(T0* C);
/* GEANT_SET_TASK.exit_application */
extern void T279f34(T0* C, T6 a1, T0* a2);
/* GEANT_SET_TASK.exceptions */
extern T0* T279f20(T0* C);
/* GEANT_SET_TASK.std */
extern T0* T279f19(T0* C);
/* GEANT_SET_TASK.log_messages */
extern void T279f35(T0* C, T0* a1);
/* GEANT_SET_TASK.dir_attribute_name */
extern T0* T279f18(T0* C);
/* GEANT_SET_TASK.file_system */
extern T0* T279f17(T0* C);
/* GEANT_SET_TASK.unix_file_system */
extern T0* T279f23(T0* C);
/* GEANT_SET_TASK.windows_file_system */
extern T0* T279f22(T0* C);
/* GEANT_SET_TASK.operating_system */
extern T0* T279f21(T0* C);
/* GEANT_LCC_TASK.execute */
extern void T277f33(T0* C);
/* GEANT_LCC_COMMAND.execute */
extern void T394f17(T0* C);
/* GEANT_LCC_COMMAND.execute_shell */
extern void T394f18(T0* C, T0* a1);
/* GEANT_LCC_COMMAND.string_ */
extern T0* T394f10(T0* C);
/* GEANT_LCC_COMMAND.unix_file_system */
extern T0* T394f9(T0* C);
/* GEANT_LCC_COMMAND.file_system */
extern T0* T394f8(T0* C);
/* GEANT_LCC_COMMAND.windows_file_system */
extern T0* T394f12(T0* C);
/* GEANT_LCC_COMMAND.operating_system */
extern T0* T394f11(T0* C);
/* GEANT_LCC_TASK.exit_application */
extern void T277f34(T0* C, T6 a1, T0* a2);
/* GEANT_LCC_TASK.exceptions */
extern T0* T277f20(T0* C);
/* GEANT_LCC_TASK.std */
extern T0* T277f19(T0* C);
/* GEANT_LCC_TASK.log_messages */
extern void T277f35(T0* C, T0* a1);
/* GEANT_LCC_TASK.dir_attribute_name */
extern T0* T277f18(T0* C);
/* GEANT_LCC_TASK.file_system */
extern T0* T277f17(T0* C);
/* GEANT_LCC_TASK.unix_file_system */
extern T0* T277f23(T0* C);
/* GEANT_LCC_TASK.windows_file_system */
extern T0* T277f22(T0* C);
/* GEANT_LCC_TASK.operating_system */
extern T0* T277f21(T0* C);
/* GEANT_EXEC_TASK.execute */
extern void T275f32(T0* C);
/* GEANT_EXEC_COMMAND.execute */
extern void T386f16(T0* C);
/* GEANT_EXEC_COMMAND.project_variables_resolver */
extern T0* T386f11(T0* C);
/* GEANT_EXEC_COMMAND.execute_shell */
extern void T386f18(T0* C, T0* a1);
/* GEANT_EXEC_TASK.exit_application */
extern void T275f33(T0* C, T6 a1, T0* a2);
/* GEANT_EXEC_TASK.exceptions */
extern T0* T275f18(T0* C);
/* GEANT_EXEC_TASK.std */
extern T0* T275f17(T0* C);
/* GEANT_EXEC_TASK.log_messages */
extern void T275f34(T0* C, T0* a1);
/* GEANT_EXEC_TASK.project_variables_resolver */
extern T0* T275f11(T0* C);
/* GEANT_EXEC_TASK.dir_attribute_name */
extern T0* T275f16(T0* C);
/* GEANT_EXEC_TASK.file_system */
extern T0* T275f15(T0* C);
/* GEANT_EXEC_TASK.unix_file_system */
extern T0* T275f21(T0* C);
/* GEANT_EXEC_TASK.windows_file_system */
extern T0* T275f20(T0* C);
/* GEANT_EXEC_TASK.operating_system */
extern T0* T275f19(T0* C);
/* GEANT_ISE_TASK.execute */
extern void T273f42(T0* C);
/* GEANT_ISE_COMMAND.execute */
extern void T382f27(T0* C);
/* GEANT_ISE_COMMAND.execute_clean */
extern void T382f29(T0* C);
/* KL_WINDOWS_FILE_SYSTEM.delete_directory */
extern void T53f42(T0* C, T0* a1);
/* KL_DIRECTORY.delete */
extern void T490f51(T0* C);
/* KL_DIRECTORY.is_empty */
extern T1 T490f28(T0* C);
/* KL_DIRECTORY.tmp_directory */
extern unsigned char ge203os8943;
extern T0* ge203ov8943;
extern T0* T490f30(T0* C);
/* KL_UNIX_FILE_SYSTEM.delete_directory */
extern void T54f38(T0* C, T0* a1);
/* KL_WINDOWS_FILE_SYSTEM.is_directory_empty */
extern T1 T53f30(T0* C, T0* a1);
/* KL_UNIX_FILE_SYSTEM.is_directory_empty */
extern T1 T54f27(T0* C, T0* a1);
/* GEANT_ISE_COMMAND.file_system */
extern T0* T382f14(T0* C);
/* GEANT_ISE_COMMAND.unix_file_system */
extern T0* T382f15(T0* C);
/* GEANT_ISE_COMMAND.windows_file_system */
extern T0* T382f18(T0* C);
/* GEANT_ISE_COMMAND.operating_system */
extern T0* T382f17(T0* C);
/* GEANT_ISE_COMMAND.execute_compile */
extern void T382f28(T0* C);
/* KL_WINDOWS_FILE_SYSTEM.cd */
extern void T53f40(T0* C, T0* a1);
/* KL_UNIX_FILE_SYSTEM.cd */
extern void T54f36(T0* C, T0* a1);
/* GEANT_ISE_COMMAND.execute_shell */
extern void T382f30(T0* C, T0* a1);
/* GEANT_ISE_COMMAND.string_ */
extern T0* T382f16(T0* C);
/* GEANT_ISE_COMMAND.is_compilable */
extern T1 T382f12(T0* C);
/* GEANT_ISE_TASK.exit_application */
extern void T273f43(T0* C, T6 a1, T0* a2);
/* GEANT_ISE_TASK.exceptions */
extern T0* T273f29(T0* C);
/* GEANT_ISE_TASK.log_messages */
extern void T273f44(T0* C, T0* a1);
/* GEANT_ISE_TASK.dir_attribute_name */
extern T0* T273f28(T0* C);
/* GEANT_ISE_TASK.file_system */
extern T0* T273f27(T0* C);
/* GEANT_ISE_TASK.unix_file_system */
extern T0* T273f32(T0* C);
/* GEANT_ISE_TASK.windows_file_system */
extern T0* T273f31(T0* C);
/* GEANT_ISE_TASK.operating_system */
extern T0* T273f30(T0* C);
/* GEANT_GEC_TASK.execute */
extern void T266f46(T0* C);
/* GEANT_GEC_COMMAND.execute */
extern void T378f37(T0* C);
/* GEANT_GEC_COMMAND.execute_shell */
extern void T378f38(T0* C, T0* a1);
/* GEANT_GEC_COMMAND.new_ace_cmdline */
extern T0* T378f19(T0* C);
/* GEANT_GEC_COMMAND.string_ */
extern T0* T378f24(T0* C);
/* GEANT_GEC_COMMAND.unix_file_system */
extern T0* T378f22(T0* C);
/* KL_INTEGER_ROUTINES.append_decimal_integer */
extern void T210f5(T0* C, T6 a1, T0* a2);
/* GEANT_GEC_COMMAND.integer_ */
extern T0* T378f23(T0* C);
/* GEANT_GEC_COMMAND.is_ace_configuration */
extern T1 T378f16(T0* C);
/* GEANT_GEC_COMMAND.file_system */
extern T0* T378f18(T0* C);
/* GEANT_GEC_COMMAND.windows_file_system */
extern T0* T378f21(T0* C);
/* GEANT_GEC_COMMAND.operating_system */
extern T0* T378f20(T0* C);
/* GEANT_GEC_COMMAND.is_cleanable */
extern T1 T378f17(T0* C);
/* GEANT_GEC_TASK.exit_application */
extern void T266f47(T0* C, T6 a1, T0* a2);
/* GEANT_GEC_TASK.exceptions */
extern T0* T266f33(T0* C);
/* GEANT_GEC_TASK.log_messages */
extern void T266f48(T0* C, T0* a1);
/* GEANT_GEC_TASK.dir_attribute_name */
extern T0* T266f32(T0* C);
/* GEANT_GEC_TASK.file_system */
extern T0* T266f31(T0* C);
/* GEANT_GEC_TASK.unix_file_system */
extern T0* T266f36(T0* C);
/* GEANT_GEC_TASK.windows_file_system */
extern T0* T266f35(T0* C);
/* GEANT_GEC_TASK.operating_system */
extern T0* T266f34(T0* C);
/* XM_CHARACTER_DATA.node_set_parent */
extern void T359f4(T0* C, T0* a1);
/* XM_PROCESSING_INSTRUCTION.node_set_parent */
extern void T358f6(T0* C, T0* a1);
/* XM_COMMENT.node_set_parent */
extern void T357f5(T0* C, T0* a1);
/* XM_ATTRIBUTE.node_set_parent */
extern void T201f6(T0* C, T0* a1);
/* XM_ELEMENT.node_set_parent */
extern void T99f34(T0* C, T0* a1);
/* XM_CHARACTER_DATA.process */
extern void T359f5(T0* C, T0* a1);
/* XM_NODE_TYPER.process_character_data */
extern void T365f18(T0* C, T0* a1);
/* XM_NODE_TYPER.reset */
extern void T365f14(T0* C);
/* XM_PROCESSING_INSTRUCTION.process */
extern void T358f7(T0* C, T0* a1);
/* XM_NODE_TYPER.process_processing_instruction */
extern void T365f17(T0* C, T0* a1);
/* XM_COMMENT.process */
extern void T357f6(T0* C, T0* a1);
/* XM_NODE_TYPER.process_comment */
extern void T365f16(T0* C, T0* a1);
/* XM_ATTRIBUTE.process */
extern void T201f7(T0* C, T0* a1);
/* XM_NODE_TYPER.process_attribute */
extern void T365f15(T0* C, T0* a1);
/* XM_ELEMENT.process */
extern void T99f39(T0* C, T0* a1);
/* XM_NODE_TYPER.process_element */
extern void T365f12(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.set_input_stream */
extern void T177f234(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.set_input_buffer */
extern void T177f241(T0* C, T0* a1);
/* YY_FILE_BUFFER.name */
extern T0* T222f14(T0* C);
/* XM_EIFFEL_INPUT_STREAM.name */
extern T0* T209f26(T0* C);
/* KL_STRING_INPUT_STREAM.name */
extern unsigned char ge221os3991;
extern T0* ge221ov3991;
extern T0* T491f6(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.set_input_buffer */
extern void T177f241p1(T0* C, T0* a1);
/* YY_FILE_BUFFER.set_position */
extern void T222f19(T0* C, T6 a1, T6 a2, T6 a3);
/* YY_FILE_BUFFER.set_index */
extern void T222f18(T0* C, T6 a1);
/* XM_EIFFEL_PE_ENTITY_DEF.new_file_buffer */
extern T0* T177f71(T0* C, T0* a1);
/* YY_FILE_BUFFER.make */
extern T0* T222c17(T0* a1);
/* YY_FILE_BUFFER.make_with_size */
extern void T222f21(T0* C, T0* a1, T6 a2);
/* YY_FILE_BUFFER.set_file */
extern void T222f23(T0* C, T0* a1);
/* YY_FILE_BUFFER.flush */
extern void T222f25(T0* C);
/* YY_FILE_BUFFER.new_default_buffer */
extern T0* T222f16(T0* C, T6 a1);
/* YY_FILE_BUFFER.default_capacity */
extern unsigned char ge393os7577;
extern T6 ge393ov7577;
extern T6 T222f13(T0* C);
/* XM_EIFFEL_SCANNER_DTD.set_input_stream */
extern void T175f199(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.set_input_buffer */
extern void T175f208(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.set_input_buffer */
extern void T175f208p1(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.new_file_buffer */
extern T0* T175f54(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.set_input_stream */
extern void T171f230(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.set_input_buffer */
extern void T171f237(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.set_input_buffer */
extern void T171f237p1(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.new_file_buffer */
extern T0* T171f69(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.set_input_stream */
extern void T133f197(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.set_input_buffer */
extern void T133f205(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.set_input_buffer */
extern void T133f205p1(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.new_file_buffer */
extern T0* T133f46(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.read_token */
extern void T177f235(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.read_token */
extern void T177f235p1(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.read_token */
extern void T177f235p0(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_execute_action */
extern void T177f245(T0* C, T6 a1);
/* XM_EIFFEL_CHARACTER_ENTITY.from_hexadecimal */
extern void T220f10(T0* C, T0* a1);
/* KL_STRING_ROUTINES.hexadecimal_to_integer */
extern T6 T76f13(T0* C, T0* a1);
/* XM_EIFFEL_CHARACTER_ENTITY.string_ */
extern T0* T220f7(T0* C);
/* XM_EIFFEL_CHARACTER_ENTITY.to_utf8 */
extern T0* T220f3(T0* C);
/* XM_EIFFEL_CHARACTER_ENTITY.utf8 */
extern T0* T220f6(T0* C);
/* XM_EIFFEL_CHARACTER_ENTITY.is_ascii */
extern T1 T220f2(T0* C);
/* XM_EIFFEL_CHARACTER_ENTITY.is_valid */
extern T1 T220f5(T0* C);
/* UC_UNICODE_ROUTINES.valid_non_surrogate_code */
extern T1 T324f3(T0* C, T6 a1);
/* XM_EIFFEL_CHARACTER_ENTITY.unicode */
extern T0* T220f4(T0* C);
/* XM_EIFFEL_CHARACTER_ENTITY.from_decimal */
extern void T220f9(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.has_normalized_newline */
extern T1 T177f201(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.text_substring */
extern T0* T177f181(T0* C, T6 a1, T6 a2);
/* XM_EIFFEL_PE_ENTITY_DEF.text_count */
extern T6 T177f180(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.system_literal_text */
extern T0* T177f162(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.text_item */
extern T2 T177f207(T0* C, T6 a1);
/* XM_EIFFEL_PE_ENTITY_DEF.normalized_newline */
extern T0* T177f121(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.normalized_newline */
extern unsigned char ge1540os6224;
extern T0* ge1540ov6224;
extern T0* T177f121p1(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_set_line_column */
extern void T177f249(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.text */
extern T0* T177f105(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.pop_start_condition */
extern void T177f248(T0* C);
/* DS_LINKED_STACK [INTEGER_32].remove */
extern void T224f7(T0* C);
/* DS_LINKED_STACK [INTEGER_32].item */
extern T6 T224f4(T0* C);
/* DS_LINKED_STACK [INTEGER_32].is_empty */
extern T1 T224f3(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.push_start_condition */
extern void T177f246(T0* C, T6 a1);
/* DS_LINKED_STACK [INTEGER_32].force */
extern void T224f6(T0* C, T6 a1);
/* DS_LINKABLE [INTEGER_32].put_right */
extern void T340f4(T0* C, T0* a1);
/* DS_LINKABLE [INTEGER_32].make */
extern T0* T340c3(T6 a1);
/* XM_EIFFEL_PE_ENTITY_DEF.set_last_token */
extern void T177f247(T0* C, T6 a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_execute_eof_action */
extern void T177f244(T0* C, T6 a1);
/* XM_EIFFEL_PE_ENTITY_DEF.wrap */
extern T1 T177f99(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_refill_input_buffer */
extern void T177f243(T0* C);
/* YY_FILE_BUFFER.fill */
extern void T222f20(T0* C);
/* KL_CHARACTER_BUFFER.fill_from_stream */
extern T6 T369f4(T0* C, T0* a1, T6 a2, T6 a3);
/* XM_EIFFEL_INPUT_STREAM.read_to_string */
extern T6 T209f27(T0* C, T0* a1, T6 a2, T6 a3);
/* XM_EIFFEL_INPUT_STREAM.read_to_string */
extern T6 T209f27p1(T0* C, T0* a1, T6 a2, T6 a3);
/* KL_STRING_INPUT_STREAM.read_to_string */
extern T6 T491f8(T0* C, T0* a1, T6 a2, T6 a3);
/* YY_FILE_BUFFER.compact_left */
extern void T222f22(T0* C);
/* KL_CHARACTER_BUFFER.move_left */
extern void T369f9(T0* C, T6 a1, T6 a2, T6 a3);
/* YY_FILE_BUFFER.resize */
extern void T222f24(T0* C);
/* KL_CHARACTER_BUFFER.resize */
extern void T369f10(T0* C, T6 a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_null_trans_state */
extern T6 T177f98(T0* C, T6 a1);
/* XM_EIFFEL_PE_ENTITY_DEF.yy_previous_state */
extern T6 T177f97(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.terminate */
extern void T177f242(T0* C);
/* XM_EIFFEL_SCANNER_DTD.read_token */
extern void T175f200(T0* C);
/* XM_EIFFEL_SCANNER_DTD.read_token */
extern void T175f200p1(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_execute_action */
extern void T175f214(T0* C, T6 a1);
/* XM_EIFFEL_SCANNER_DTD.has_normalized_newline */
extern T1 T175f178(T0* C);
/* XM_EIFFEL_SCANNER_DTD.text_substring */
extern T0* T175f158(T0* C, T6 a1, T6 a2);
/* XM_EIFFEL_SCANNER_DTD.text_count */
extern T6 T175f157(T0* C);
/* XM_EIFFEL_SCANNER_DTD.system_literal_text */
extern T0* T175f139(T0* C);
/* XM_EIFFEL_SCANNER_DTD.text_item */
extern T2 T175f194(T0* C, T6 a1);
/* XM_EIFFEL_SCANNER_DTD.normalized_newline */
extern T0* T175f101(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_set_line_column */
extern void T175f220(T0* C);
/* XM_EIFFEL_SCANNER_DTD.text */
extern T0* T175f75(T0* C);
/* XM_EIFFEL_SCANNER_DTD.pop_start_condition */
extern void T175f219(T0* C);
/* XM_EIFFEL_SCANNER_DTD.push_start_condition */
extern void T175f215(T0* C, T6 a1);
/* XM_EIFFEL_SCANNER_DTD.yy_execute_eof_action */
extern void T175f213(T0* C, T6 a1);
/* XM_EIFFEL_SCANNER_DTD.wrap */
extern T1 T175f66(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_refill_input_buffer */
extern void T175f212(T0* C);
/* XM_EIFFEL_SCANNER_DTD.yy_null_trans_state */
extern T6 T175f65(T0* C, T6 a1);
/* XM_EIFFEL_SCANNER_DTD.yy_previous_state */
extern T6 T175f64(T0* C);
/* XM_EIFFEL_SCANNER_DTD.fatal_error */
extern void T175f211(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.terminate */
extern void T175f210(T0* C);
/* XM_EIFFEL_SCANNER_DTD.set_last_token */
extern void T175f209(T0* C, T6 a1);
/* XM_EIFFEL_ENTITY_DEF.read_token */
extern void T171f231(T0* C);
/* XM_EIFFEL_ENTITY_DEF.read_token */
extern void T171f231p1(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_execute_action */
extern void T171f240(T0* C, T6 a1);
/* XM_EIFFEL_ENTITY_DEF.has_normalized_newline */
extern T1 T171f198(T0* C);
/* XM_EIFFEL_ENTITY_DEF.text_substring */
extern T0* T171f178(T0* C, T6 a1, T6 a2);
/* XM_EIFFEL_ENTITY_DEF.text_count */
extern T6 T171f177(T0* C);
/* XM_EIFFEL_ENTITY_DEF.system_literal_text */
extern T0* T171f159(T0* C);
/* XM_EIFFEL_ENTITY_DEF.text_item */
extern T2 T171f205(T0* C, T6 a1);
/* XM_EIFFEL_ENTITY_DEF.normalized_newline */
extern T0* T171f118(T0* C);
/* XM_EIFFEL_ENTITY_DEF.normalized_newline */
extern T0* T171f118p1(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_set_line_column */
extern void T171f245(T0* C);
/* XM_EIFFEL_ENTITY_DEF.text */
extern T0* T171f102(T0* C);
/* XM_EIFFEL_ENTITY_DEF.pop_start_condition */
extern void T171f244(T0* C);
/* XM_EIFFEL_ENTITY_DEF.push_start_condition */
extern void T171f241(T0* C, T6 a1);
/* XM_EIFFEL_ENTITY_DEF.set_last_token */
extern void T171f243(T0* C, T6 a1);
/* XM_EIFFEL_ENTITY_DEF.yy_execute_eof_action */
extern void T171f239(T0* C, T6 a1);
/* XM_EIFFEL_ENTITY_DEF.terminate */
extern void T171f242(T0* C);
/* XM_EIFFEL_ENTITY_DEF.wrap */
extern T1 T171f96(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_refill_input_buffer */
extern void T171f238(T0* C);
/* XM_EIFFEL_ENTITY_DEF.yy_null_trans_state */
extern T6 T171f95(T0* C, T6 a1);
/* XM_EIFFEL_ENTITY_DEF.yy_previous_state */
extern T6 T171f94(T0* C);
/* XM_EIFFEL_SCANNER.read_token */
extern void T133f198(T0* C);
/* XM_EIFFEL_SCANNER.yy_execute_action */
extern void T133f209(T0* C, T6 a1);
/* XM_EIFFEL_SCANNER.has_normalized_newline */
extern T1 T133f176(T0* C);
/* XM_EIFFEL_SCANNER.text_substring */
extern T0* T133f156(T0* C, T6 a1, T6 a2);
/* XM_EIFFEL_SCANNER.text_count */
extern T6 T133f155(T0* C);
/* XM_EIFFEL_SCANNER.system_literal_text */
extern T0* T133f137(T0* C);
/* XM_EIFFEL_SCANNER.text_item */
extern T2 T133f192(T0* C, T6 a1);
/* XM_EIFFEL_SCANNER.normalized_newline */
extern T0* T133f96(T0* C);
/* XM_EIFFEL_SCANNER.yy_set_line_column */
extern void T133f217(T0* C);
/* XM_EIFFEL_SCANNER.text */
extern T0* T133f70(T0* C);
/* XM_EIFFEL_SCANNER.pop_start_condition */
extern void T133f216(T0* C);
/* XM_EIFFEL_SCANNER.set_start_condition */
extern void T133f218(T0* C, T6 a1);
/* XM_EIFFEL_SCANNER.push_start_condition */
extern void T133f210(T0* C, T6 a1);
/* XM_EIFFEL_SCANNER.set_last_token */
extern void T133f215(T0* C, T6 a1);
/* XM_EIFFEL_SCANNER.yy_execute_eof_action */
extern void T133f208(T0* C, T6 a1);
/* XM_EIFFEL_SCANNER.terminate */
extern void T133f214(T0* C);
/* XM_EIFFEL_SCANNER.wrap */
extern T1 T133f61(T0* C);
/* XM_EIFFEL_SCANNER.yy_refill_input_buffer */
extern void T133f207(T0* C);
/* XM_EIFFEL_SCANNER.yy_null_trans_state */
extern T6 T133f60(T0* C, T6 a1);
/* XM_EIFFEL_SCANNER.yy_previous_state */
extern T6 T133f59(T0* C);
/* XM_EIFFEL_SCANNER.fatal_error */
extern void T133f206(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.push_start_condition_dtd_ignore */
extern void T177f237(T0* C);
/* XM_EIFFEL_SCANNER_DTD.push_start_condition_dtd_ignore */
extern void T175f202(T0* C);
/* XM_EIFFEL_ENTITY_DEF.push_start_condition_dtd_ignore */
extern void T171f233(T0* C);
/* XM_EIFFEL_SCANNER.push_start_condition_dtd_ignore */
extern void T133f200(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.set_encoding */
extern void T177f238(T0* C, T0* a1);
/* XM_EIFFEL_INPUT_STREAM.set_encoding */
extern void T209f30(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.set_encoding */
extern void T175f203(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.set_encoding */
extern void T171f234(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.set_encoding */
extern void T133f201(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.set_input_from_resolver */
extern void T177f239(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.set_input_from_resolver */
extern void T175f204(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.set_input_from_resolver */
extern void T171f235(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.set_input_from_resolver */
extern void T133f202(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.close_input */
extern void T177f236(T0* C);
/* KL_STRING_INPUT_STREAM.close */
extern void T491f11(T0* C);
/* KL_STRING_INPUT_STREAM.is_closable */
extern T1 T491f7(T0* C);
/* KL_TEXT_INPUT_FILE.is_closable */
extern T1 T55f27(T0* C);
/* XM_EIFFEL_SCANNER_DTD.close_input */
extern void T175f201(T0* C);
/* XM_EIFFEL_ENTITY_DEF.close_input */
extern void T171f232(T0* C);
/* XM_EIFFEL_SCANNER.close_input */
extern void T133f199(T0* C);
/* XM_NAMESPACE_RESOLVER.on_start */
extern void T178f26(T0* C);
/* XM_NAMESPACE_RESOLVER.attributes_make */
extern void T178f36(T0* C);
/* XM_NAMESPACE_RESOLVER.new_string_queue */
extern T0* T178f12(T0* C);
/* DS_LINKED_QUEUE [STRING_8].make */
extern T0* T255c6(void);
/* XM_NAMESPACE_RESOLVER_CONTEXT.make */
extern T0* T253c10(void);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].make */
extern T0* T347c9(void);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].new_cursor */
extern T0* T347f7(T0* C);
/* DS_BILINKED_LIST_CURSOR [DS_HASH_TABLE [STRING_8, STRING_8]].make */
extern T0* T348c7(T0* a1);
/* XM_CALLBACKS_NULL.on_start */
extern void T138f2(T0* C);
/* XM_STOP_ON_ERROR_FILTER.on_start */
extern void T100f6(T0* C);
/* XM_STOP_ON_ERROR_FILTER.on_start */
extern void T100f6p1(T0* C);
/* XM_CALLBACKS_TO_TREE_FILTER.on_start */
extern void T97f12(T0* C);
/* DS_HASH_SET [XM_NAMESPACE].make_equal */
extern T0* T356c32(T6 a1);
/* KL_EQUALITY_TESTER [XM_NAMESPACE].default_create */
extern T0* T493c2(void);
/* DS_HASH_SET [XM_NAMESPACE].make */
extern void T356f35(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].new_cursor */
extern T0* T356f23(T0* C);
/* DS_HASH_SET_CURSOR [XM_NAMESPACE].make */
extern T0* T494c3(T0* a1);
/* DS_HASH_SET [XM_NAMESPACE].unset_found_item */
extern void T356f36(T0* C);
/* DS_HASH_SET [XM_NAMESPACE].make_slots */
extern void T356f44(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].special_integer_ */
extern T0* T356f29(T0* C);
/* DS_HASH_SET [XM_NAMESPACE].new_modulus */
extern T6 T356f20(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].make_clashes */
extern void T356f43(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].make_key_storage */
extern void T356f42(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].make_item_storage */
extern void T356f41(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [XM_NAMESPACE].make */
extern T0* T495f1(T0* C, T6 a1);
/* TO_SPECIAL [XM_NAMESPACE].make_area */
extern T0* T540c2(T6 a1);
/* SPECIAL [XM_NAMESPACE].make */
extern T0* T492c4(T6 a1);
/* KL_SPECIAL_ROUTINES [XM_NAMESPACE].default_create */
extern T0* T495c3(void);
/* XM_DOCUMENT.make */
extern T0* T98c15(void);
/* XM_DOCUMENT.make_with_root_named */
extern void T98f16(T0* C, T0* a1, T0* a2);
/* XM_DOCUMENT.force_last */
extern void T98f18(T0* C, T0* a1);
/* XM_DOCUMENT.force_last */
extern void T98f18p1(T0* C, T0* a1);
/* XM_DOCUMENT.is_empty */
extern T1 T98f11(T0* C);
/* XM_DOCUMENT.before_addition */
extern void T98f19(T0* C, T0* a1);
/* XM_ELEMENT.equality_delete */
extern void T99f38(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [XM_NODE].remove */
extern void T204f13(T0* C);
/* XM_DOCUMENT.remove_at_cursor */
extern void T98f26(T0* C, T0* a1);
/* XM_DOCUMENT.move_all_cursors */
extern void T98f33(T0* C, T0* a1, T0* a2);
/* DS_LINKED_LIST_CURSOR [XM_NODE].set_current_cell */
extern void T204f17(T0* C, T0* a1);
/* DS_LINKABLE [XM_NODE].put */
extern void T363f6(T0* C, T0* a1);
/* XM_DOCUMENT.set_last_cell */
extern void T98f32(T0* C, T0* a1);
/* DS_LINKABLE [XM_NODE].forget_right */
extern void T363f5(T0* C);
/* XM_DOCUMENT.remove_last */
extern void T98f31(T0* C);
/* XM_DOCUMENT.move_last_cursors_after */
extern void T98f36(T0* C);
/* XM_DOCUMENT.wipe_out */
extern void T98f34(T0* C);
/* XM_DOCUMENT.move_all_cursors_after */
extern void T98f37(T0* C);
/* DS_LINKED_LIST_CURSOR [XM_NODE].is_last */
extern T1 T204f7(T0* C);
/* XM_DOCUMENT.cursor_is_last */
extern T1 T98f14(T0* C, T0* a1);
/* XM_ELEMENT.cursor_is_last */
extern T1 T99f25(T0* C, T0* a1);
/* XM_DOCUMENT.remove_first */
extern void T98f30(T0* C);
/* XM_DOCUMENT.set_first_cell */
extern void T98f35(T0* C, T0* a1);
/* DS_LINKED_LIST_CURSOR [XM_NODE].is_first */
extern T1 T204f6(T0* C);
/* XM_DOCUMENT.cursor_is_first */
extern T1 T98f13(T0* C, T0* a1);
/* XM_ELEMENT.cursor_is_first */
extern T1 T99f24(T0* C, T0* a1);
/* XM_ELEMENT.remove_at_cursor */
extern void T99f43(T0* C, T0* a1);
/* XM_ELEMENT.move_all_cursors */
extern void T99f49(T0* C, T0* a1, T0* a2);
/* XM_ELEMENT.set_last_cell */
extern void T99f48(T0* C, T0* a1);
/* XM_ELEMENT.remove_last */
extern void T99f47(T0* C);
/* XM_ELEMENT.move_last_cursors_after */
extern void T99f52(T0* C);
/* XM_ELEMENT.wipe_out */
extern void T99f50(T0* C);
/* XM_ELEMENT.remove_first */
extern void T99f46(T0* C);
/* XM_ELEMENT.set_first_cell */
extern void T99f51(T0* C, T0* a1);
/* XM_DOCUMENT.equality_delete */
extern void T98f21(T0* C, T0* a1);
/* XM_DOCUMENT.new_cursor */
extern T0* T98f9(T0* C);
/* XM_DOCUMENT.list_make */
extern void T98f17(T0* C);
/* XM_ELEMENT.make */
extern T0* T99c33(T0* a1, T0* a2, T0* a3);
/* XM_ELEMENT.list_make */
extern void T99f35(T0* C);
/* XM_DOCUMENT.default_ns */
extern unsigned char ge1491os5675;
extern T0* ge1491ov5675;
extern T0* T98f7(T0* C);
/* XM_NAMESPACE.make_default */
extern T0* T360c8(void);
/* XM_NAMESPACE.make */
extern void T360f7(T0* C, T0* a1, T0* a2);
/* XM_NAMESPACE.make */
extern T0* T360c7(T0* a1, T0* a2);
/* XM_NAMESPACE_RESOLVER.on_finish */
extern void T178f27(T0* C);
/* XM_CALLBACKS_NULL.on_finish */
extern void T138f3(T0* C);
/* XM_STOP_ON_ERROR_FILTER.on_finish */
extern void T100f7(T0* C);
/* XM_STOP_ON_ERROR_FILTER.on_finish */
extern void T100f7p1(T0* C);
/* XM_CALLBACKS_TO_TREE_FILTER.on_finish */
extern void T97f13(T0* C);
/* XM_NAMESPACE_RESOLVER.on_comment */
extern void T178f28(T0* C, T0* a1);
/* XM_CALLBACKS_NULL.on_comment */
extern void T138f4(T0* C, T0* a1);
/* XM_STOP_ON_ERROR_FILTER.on_comment */
extern void T100f8(T0* C, T0* a1);
/* XM_STOP_ON_ERROR_FILTER.on_comment */
extern void T100f8p1(T0* C, T0* a1);
/* XM_CALLBACKS_TO_TREE_FILTER.on_comment */
extern void T97f14(T0* C, T0* a1);
/* XM_CALLBACKS_TO_TREE_FILTER.handle_position */
extern void T97f22(T0* C, T0* a1);
/* XM_POSITION_TABLE.put */
extern void T101f5(T0* C, T0* a1, T0* a2);
/* DS_LINKED_LIST [DS_PAIR [XM_POSITION, XM_NODE]].put_last */
extern void T181f12(T0* C, T0* a1);
/* DS_LINKABLE [DS_PAIR [XM_POSITION, XM_NODE]].put_right */
extern void T328f4(T0* C, T0* a1);
/* DS_LINKABLE [DS_PAIR [XM_POSITION, XM_NODE]].make */
extern T0* T328c3(T0* a1);
/* DS_LINKED_LIST [DS_PAIR [XM_POSITION, XM_NODE]].is_empty */
extern T1 T181f5(T0* C);
/* DS_PAIR [XM_POSITION, XM_NODE].make */
extern T0* T213c3(T0* a1, T0* a2);
/* XM_CALLBACKS_TO_TREE_FILTER.is_position_table_enabled */
extern T1 T97f8(T0* C);
/* XM_COMMENT.make_last */
extern T0* T357c4(T0* a1, T0* a2);
/* XM_ELEMENT.force_last */
extern void T99f36(T0* C, T0* a1);
/* XM_ELEMENT.force_last */
extern void T99f36p1(T0* C, T0* a1);
/* XM_ELEMENT.force_last */
extern void T99f36p0(T0* C, T0* a1);
/* XM_ELEMENT.before_addition */
extern void T99f37(T0* C, T0* a1);
/* XM_ELEMENT.last */
extern T0* T99f18(T0* C);
/* XM_COMMENT.make_last_in_document */
extern T0* T357c3(T0* a1, T0* a2);
/* XM_NAMESPACE_RESOLVER.on_processing_instruction */
extern void T178f29(T0* C, T0* a1, T0* a2);
/* XM_CALLBACKS_NULL.on_processing_instruction */
extern void T138f5(T0* C, T0* a1, T0* a2);
/* XM_STOP_ON_ERROR_FILTER.on_processing_instruction */
extern void T100f9(T0* C, T0* a1, T0* a2);
/* XM_STOP_ON_ERROR_FILTER.on_processing_instruction */
extern void T100f9p1(T0* C, T0* a1, T0* a2);
/* XM_CALLBACKS_TO_TREE_FILTER.on_processing_instruction */
extern void T97f15(T0* C, T0* a1, T0* a2);
/* XM_PROCESSING_INSTRUCTION.make_last */
extern T0* T358c5(T0* a1, T0* a2, T0* a3);
/* XM_PROCESSING_INSTRUCTION.make_last_in_document */
extern T0* T358c4(T0* a1, T0* a2, T0* a3);
/* XM_NAMESPACE_RESOLVER.on_content */
extern void T178f30(T0* C, T0* a1);
/* XM_CALLBACKS_NULL.on_content */
extern void T138f6(T0* C, T0* a1);
/* XM_STOP_ON_ERROR_FILTER.on_content */
extern void T100f10(T0* C, T0* a1);
/* XM_STOP_ON_ERROR_FILTER.on_content */
extern void T100f10p1(T0* C, T0* a1);
/* XM_CALLBACKS_TO_TREE_FILTER.on_content */
extern void T97f16(T0* C, T0* a1);
/* XM_CHARACTER_DATA.make_last */
extern T0* T359c3(T0* a1, T0* a2);
/* XM_NAMESPACE_RESOLVER.on_start_tag */
extern void T178f33(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_NAMESPACE_RESOLVER_CONTEXT.push */
extern void T253f12(T0* C);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].force_last */
extern void T347f11(T0* C, T0* a1);
/* DS_BILINKABLE [DS_HASH_TABLE [STRING_8, STRING_8]].put_right */
extern void T489f5(T0* C, T0* a1);
/* DS_BILINKABLE [DS_HASH_TABLE [STRING_8, STRING_8]].attach_left */
extern void T489f6(T0* C, T0* a1);
/* DS_BILINKABLE [DS_HASH_TABLE [STRING_8, STRING_8]].make */
extern T0* T489c4(T0* a1);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].is_empty */
extern T1 T347f6(T0* C);
/* XM_NAMESPACE_RESOLVER_CONTEXT.new_string_string_table */
extern T0* T253f8(T0* C);
/* DS_HASH_TABLE [STRING_8, STRING_8].set_equality_tester */
extern void T81f45(T0* C, T0* a1);
/* XM_NAMESPACE_RESOLVER_CONTEXT.string_equality_tester */
extern T0* T253f9(T0* C);
/* DS_HASH_TABLE [STRING_8, STRING_8].make_map_default */
extern T0* T81c43(void);
/* DS_HASH_TABLE [STRING_8, STRING_8].default_capacity */
extern T6 T81f33(T0* C);
/* XM_CALLBACKS_NULL.on_start_tag */
extern void T138f9(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_STOP_ON_ERROR_FILTER.on_start_tag */
extern void T100f11(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_STOP_ON_ERROR_FILTER.on_start_tag */
extern void T100f11p1(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_CALLBACKS_TO_TREE_FILTER.on_start_tag */
extern void T97f17(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_ELEMENT.make_last */
extern T0* T99c32(T0* a1, T0* a2, T0* a3);
/* XM_ELEMENT.make_root */
extern T0* T99c31(T0* a1, T0* a2, T0* a3);
/* XM_DOCUMENT.set_root_element */
extern void T98f20(T0* C, T0* a1);
/* XM_DOCUMENT.remove_previous_root_element */
extern void T98f27(T0* C);
/* XM_CALLBACKS_TO_TREE_FILTER.new_namespace */
extern T0* T97f7(T0* C, T0* a1, T0* a2);
/* DS_HASH_SET [XM_NAMESPACE].force_last */
extern void T356f33(T0* C, T0* a1);
/* DS_HASH_SET [XM_NAMESPACE].slots_put */
extern void T356f40(T0* C, T6 a1, T6 a2);
/* DS_HASH_SET [XM_NAMESPACE].clashes_put */
extern void T356f39(T0* C, T6 a1, T6 a2);
/* DS_HASH_SET [XM_NAMESPACE].slots_item */
extern T6 T356f26(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].hash_position */
extern T6 T356f22(T0* C, T0* a1);
/* XM_NAMESPACE.hash_code */
extern T6 T360f5(T0* C);
/* DS_HASH_SET [XM_NAMESPACE].resize */
extern void T356f38(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].clashes_resize */
extern void T356f48(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].key_storage_resize */
extern void T356f47(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].item_storage_resize */
extern void T356f46(T0* C, T6 a1);
/* KL_SPECIAL_ROUTINES [XM_NAMESPACE].resize */
extern T0* T495f2(T0* C, T0* a1, T6 a2);
/* SPECIAL [XM_NAMESPACE].aliased_resized_area */
extern T0* T492f3(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].key_storage_item */
extern T0* T356f18(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].item_storage_item */
extern T0* T356f30(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].clashes_item */
extern T6 T356f19(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].slots_resize */
extern void T356f45(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].new_capacity */
extern T6 T356f21(T0* C, T6 a1);
/* DS_HASH_SET [XM_NAMESPACE].item_storage_put */
extern void T356f37(T0* C, T0* a1, T6 a2);
/* DS_HASH_SET [XM_NAMESPACE].search_position */
extern void T356f34(T0* C, T0* a1);
/* KL_EQUALITY_TESTER [XM_NAMESPACE].test */
extern T1 T493f1(T0* C, T0* a1, T0* a2);
/* DS_HASH_SET [XM_NAMESPACE].key_equality_tester */
extern T0* T356f17(T0* C);
/* XM_NAMESPACE.same_prefix */
extern T1 T360f6(T0* C, T0* a1);
/* DS_HASH_SET [XM_NAMESPACE].item */
extern T0* T356f24(T0* C, T0* a1);
/* DS_HASH_SET [XM_NAMESPACE].has */
extern T1 T356f27(T0* C, T0* a1);
/* XM_NAMESPACE_RESOLVER.on_start_tag_finish */
extern void T178f31(T0* C);
/* XM_NAMESPACE_RESOLVER.on_start_tag_finish */
extern void T178f31p1(T0* C);
/* XM_NAMESPACE_RESOLVER_CONTEXT.resolve_default */
extern T0* T253f3(T0* C);
/* XM_NAMESPACE_RESOLVER_CONTEXT.default_pseudo_prefix */
extern unsigned char ge1465os7621;
extern T0* ge1465ov7621;
extern T0* T253f7(T0* C);
/* XM_NAMESPACE_RESOLVER.string_ */
extern T0* T178f11(T0* C);
/* XM_NAMESPACE_RESOLVER.on_delayed_attributes */
extern void T178f37(T0* C);
/* XM_NAMESPACE_RESOLVER.attributes_remove */
extern void T178f39(T0* C);
/* DS_LINKED_QUEUE [STRING_8].remove */
extern void T255f8(T0* C);
/* DS_LINKED_QUEUE [STRING_8].wipe_out */
extern void T255f9(T0* C);
/* XM_NAMESPACE_RESOLVER.unprefixed_attribute_namespace */
extern T0* T178f19(T0* C);
/* XM_NAMESPACE_RESOLVER.default_namespace */
extern unsigned char ge1432os6652;
extern T0* ge1432ov6652;
extern T0* T178f23(T0* C);
/* XM_NAMESPACE_RESOLVER.xmlns_namespace */
extern unsigned char ge1432os6660;
extern T0* ge1432ov6660;
extern T0* T178f18(T0* C);
/* XM_NAMESPACE_RESOLVER.is_xmlns */
extern T1 T178f14(T0* C, T0* a1);
/* XM_NAMESPACE_RESOLVER.same_string */
extern T1 T178f21(T0* C, T0* a1, T0* a2);
/* XM_NAMESPACE_RESOLVER.string_equality_tester */
extern T0* T178f24(T0* C);
/* XM_NAMESPACE_RESOLVER.xmlns */
extern unsigned char ge1432os6653;
extern T0* ge1432ov6653;
extern T0* T178f20(T0* C);
/* XM_NAMESPACE_RESOLVER.xml_prefix_namespace */
extern unsigned char ge1432os6659;
extern T0* ge1432ov6659;
extern T0* T178f17(T0* C);
/* XM_NAMESPACE_RESOLVER.is_xml */
extern T1 T178f16(T0* C, T0* a1);
/* XM_NAMESPACE_RESOLVER.xml_prefix */
extern unsigned char ge1432os6654;
extern T0* ge1432ov6654;
extern T0* T178f22(T0* C);
/* DS_LINKED_QUEUE [STRING_8].item */
extern T0* T255f5(T0* C);
/* XM_NAMESPACE_RESOLVER.attributes_is_empty */
extern T1 T178f15(T0* C);
/* DS_LINKED_QUEUE [STRING_8].is_empty */
extern T1 T255f4(T0* C);
/* XM_NAMESPACE_RESOLVER_CONTEXT.resolve */
extern T0* T253f2(T0* C, T0* a1);
/* DS_BILINKED_LIST_CURSOR [DS_HASH_TABLE [STRING_8, STRING_8]].back */
extern void T348f10(T0* C);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].cursor_back */
extern void T347f18(T0* C, T0* a1);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].add_traversing_cursor */
extern void T347f19(T0* C, T0* a1);
/* DS_BILINKED_LIST_CURSOR [DS_HASH_TABLE [STRING_8, STRING_8]].set_next_cursor */
extern void T348f12(T0* C, T0* a1);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].remove_traversing_cursor */
extern void T347f20(T0* C, T0* a1);
/* DS_BILINKED_LIST_CURSOR [DS_HASH_TABLE [STRING_8, STRING_8]].set */
extern void T348f13(T0* C, T0* a1, T1 a2, T1 a3);
/* DS_BILINKED_LIST_CURSOR [DS_HASH_TABLE [STRING_8, STRING_8]].go_before */
extern void T348f9(T0* C);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].cursor_go_before */
extern void T347f17(T0* C, T0* a1);
/* DS_BILINKED_LIST_CURSOR [DS_HASH_TABLE [STRING_8, STRING_8]].set_before */
extern void T348f14(T0* C);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].cursor_off */
extern T1 T347f8(T0* C, T0* a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].item */
extern T0* T81f23(T0* C, T0* a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].item_storage_item */
extern T0* T81f28(T0* C, T6 a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].has */
extern T1 T81f22(T0* C, T0* a1);
/* DS_BILINKED_LIST_CURSOR [DS_HASH_TABLE [STRING_8, STRING_8]].item */
extern T0* T348f6(T0* C);
/* DS_BILINKED_LIST_CURSOR [DS_HASH_TABLE [STRING_8, STRING_8]].finish */
extern void T348f8(T0* C);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].cursor_finish */
extern void T347f16(T0* C, T0* a1);
/* XM_NAMESPACE_RESOLVER_CONTEXT.default_namespace */
extern unsigned char ge1465os7622;
extern T0* ge1465ov7622;
extern T0* T253f6(T0* C);
/* XM_NAMESPACE_RESOLVER_CONTEXT.has */
extern T1 T253f5(T0* C, T0* a1);
/* XM_NAMESPACE_RESOLVER.has_prefix */
extern T1 T178f9(T0* C, T0* a1);
/* XM_CALLBACKS_NULL.on_start_tag_finish */
extern void T138f7(T0* C);
/* XM_STOP_ON_ERROR_FILTER.on_start_tag_finish */
extern void T100f12(T0* C);
/* XM_STOP_ON_ERROR_FILTER.on_start_tag_finish */
extern void T100f12p1(T0* C);
/* XM_CALLBACKS_TO_TREE_FILTER.on_start_tag_finish */
extern void T97f18(T0* C);
/* XM_NAMESPACE_RESOLVER.on_end_tag */
extern void T178f32(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_NAMESPACE_RESOLVER_CONTEXT.pop */
extern void T253f11(T0* C);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].remove_last */
extern void T347f10(T0* C);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].set_last_cell */
extern void T347f14(T0* C, T0* a1);
/* DS_BILINKABLE [DS_HASH_TABLE [STRING_8, STRING_8]].forget_right */
extern void T489f7(T0* C);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].move_last_cursors_after */
extern void T347f13(T0* C);
/* DS_BILINKED_LIST_CURSOR [DS_HASH_TABLE [STRING_8, STRING_8]].set_after */
extern void T348f11(T0* C);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].wipe_out */
extern void T347f12(T0* C);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].move_all_cursors_after */
extern void T347f15(T0* C);
/* XM_NAMESPACE_RESOLVER.on_end_tag */
extern void T178f32p1(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_CALLBACKS_NULL.on_end_tag */
extern void T138f8(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_STOP_ON_ERROR_FILTER.on_end_tag */
extern void T100f13(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_STOP_ON_ERROR_FILTER.on_end_tag */
extern void T100f13p1(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_CALLBACKS_TO_TREE_FILTER.on_end_tag */
extern void T97f19(T0* C, T0* a1, T0* a2, T0* a3);
/* XM_ELEMENT.parent_element */
extern T0* T99f19(T0* C);
/* XM_DOCUMENT.process */
extern void T98f22(T0* C, T0* a1);
/* XM_NODE_TYPER.process_document */
extern void T365f13(T0* C, T0* a1);
/* XM_ELEMENT.is_root_node */
extern T1 T99f22(T0* C);
/* XM_DOCUMENT.is_root_node */
extern T1 T98f10(T0* C);
/* XM_NAMESPACE_RESOLVER.on_error */
extern void T178f35(T0* C, T0* a1);
/* XM_CALLBACKS_NULL.on_error */
extern void T138f11(T0* C, T0* a1);
/* XM_STOP_ON_ERROR_FILTER.on_error */
extern void T100f14(T0* C, T0* a1);
/* XM_STOP_ON_ERROR_FILTER.on_error */
extern void T100f14p1(T0* C, T0* a1);
/* XM_CALLBACKS_TO_TREE_FILTER.on_error */
extern void T97f20(T0* C, T0* a1);
/* XM_NAMESPACE_RESOLVER.on_attribute */
extern void T178f34(T0* C, T0* a1, T0* a2, T0* a3, T0* a4);
/* XM_NAMESPACE_RESOLVER_CONTEXT.add */
extern void T253f14(T0* C, T0* a1, T0* a2);
/* DS_HASH_TABLE [STRING_8, STRING_8].force_new */
extern void T81f56(T0* C, T0* a1, T0* a2);
/* DS_BILINKED_LIST [DS_HASH_TABLE [STRING_8, STRING_8]].last */
extern T0* T347f5(T0* C);
/* XM_NAMESPACE_RESOLVER_CONTEXT.shallow_has */
extern T1 T253f4(T0* C, T0* a1);
/* XM_NAMESPACE_RESOLVER.attributes_force */
extern void T178f38(T0* C, T0* a1, T0* a2, T0* a3);
/* DS_LINKED_QUEUE [STRING_8].force */
extern void T255f7(T0* C, T0* a1);
/* XM_NAMESPACE_RESOLVER_CONTEXT.add_default */
extern void T253f13(T0* C, T0* a1);
/* XM_CALLBACKS_NULL.on_attribute */
extern void T138f10(T0* C, T0* a1, T0* a2, T0* a3, T0* a4);
/* XM_STOP_ON_ERROR_FILTER.on_attribute */
extern void T100f15(T0* C, T0* a1, T0* a2, T0* a3, T0* a4);
/* XM_STOP_ON_ERROR_FILTER.on_attribute */
extern void T100f15p1(T0* C, T0* a1, T0* a2, T0* a3, T0* a4);
/* XM_CALLBACKS_TO_TREE_FILTER.on_attribute */
extern void T97f21(T0* C, T0* a1, T0* a2, T0* a3, T0* a4);
/* XM_ATTRIBUTE.make_last */
extern T0* T201c5(T0* a1, T0* a2, T0* a3, T0* a4);
/* XM_NAMESPACE_RESOLVER.on_xml_declaration */
extern void T178f41(T0* C, T0* a1, T0* a2, T1 a3);
/* XM_CALLBACKS_NULL.on_xml_declaration */
extern void T138f12(T0* C, T0* a1, T0* a2, T1 a3);
/* XM_STOP_ON_ERROR_FILTER.on_xml_declaration */
extern void T100f16(T0* C, T0* a1, T0* a2, T1 a3);
/* XM_CALLBACKS_TO_TREE_FILTER.on_xml_declaration */
extern void T97f23(T0* C, T0* a1, T0* a2, T1 a3);
/* XM_NAMESPACE_RESOLVER.set_next */
extern void T178f40(T0* C, T0* a1);
/* XM_STOP_ON_ERROR_FILTER.set_next */
extern void T100f5(T0* C, T0* a1);
/* XM_CALLBACKS_TO_TREE_FILTER.set_next */
extern void T97f11(T0* C, T0* a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].cursor_start */
extern void T81f57(T0* C, T0* a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].add_traversing_cursor */
extern void T81f66(T0* C, T0* a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].remove_traversing_cursor */
extern void T81f65(T0* C, T0* a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].cursor_off */
extern T1 T81f39(T0* C, T0* a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].is_empty */
extern T1 T81f38(T0* C);
/* GEANT_ARGUMENT_VARIABLES.cursor_start */
extern void T34f71(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.add_traversing_cursor */
extern void T34f74(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.remove_traversing_cursor */
extern void T34f73(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.cursor_off */
extern T1 T34f43(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.is_empty */
extern T1 T34f42(T0* C);
/* GEANT_VARIABLES.cursor_start */
extern void T29f72(T0* C, T0* a1);
/* GEANT_VARIABLES.add_traversing_cursor */
extern void T29f75(T0* C, T0* a1);
/* GEANT_VARIABLES.remove_traversing_cursor */
extern void T29f74(T0* C, T0* a1);
/* GEANT_VARIABLES.cursor_off */
extern T1 T29f43(T0* C, T0* a1);
/* GEANT_VARIABLES.is_empty */
extern T1 T29f42(T0* C);
/* GEANT_PROJECT_VARIABLES.cursor_start */
extern void T25f82(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.add_traversing_cursor */
extern void T25f85(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.remove_traversing_cursor */
extern void T25f84(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.cursor_off */
extern T1 T25f52(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.is_empty */
extern T1 T25f51(T0* C);
/* DS_HASH_TABLE [STRING_8, STRING_8].cursor_forth */
extern void T81f58(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.cursor_forth */
extern void T34f72(T0* C, T0* a1);
/* GEANT_VARIABLES.cursor_forth */
extern void T29f73(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.cursor_forth */
extern void T25f83(T0* C, T0* a1);
/* AP_DISPLAY_HELP_FLAG.reset */
extern void T73f41(T0* C);
/* AP_STRING_OPTION.reset */
extern void T37f28(T0* C);
/* AP_FLAG.reset */
extern void T35f23(T0* C);
/* AP_DISPLAY_HELP_FLAG.record_occurrence */
extern void T73f42(T0* C, T0* a1);
/* AP_DISPLAY_HELP_FLAG.display_help */
extern void T73f43(T0* C, T0* a1);
/* AP_DISPLAY_HELP_FLAG.exceptions */
extern T0* T73f16(T0* C);
/* AP_ERROR_HANDLER.report_info_message */
extern void T45f11(T0* C, T0* a1);
/* AP_DISPLAY_HELP_FLAG.full_help_text */
extern T0* T73f15(T0* C, T0* a1);
/* AP_DISPLAY_HELP_FLAG.option_help_text */
extern T0* T73f24(T0* C, T0* a1, T6 a2);
/* STRING_8.make_filled */
extern T0* T17c52(T2 a1, T6 a2);
/* STRING_8.fill_character */
extern void T17f53(T0* C, T2 a1);
/* SPECIAL [CHARACTER_8].fill_with */
extern void T15f16(T0* C, T2 a1, T6 a2, T6 a3);
/* DS_QUICK_SORTER [AP_OPTION].sort */
extern void T352f3(T0* C, T0* a1);
/* DS_QUICK_SORTER [AP_OPTION].sort_with_comparator */
extern void T352f4(T0* C, T0* a1, T0* a2);
/* DS_QUICK_SORTER [AP_OPTION].subsort_with_comparator */
extern void T352f5(T0* C, T0* a1, T0* a2, T6 a3, T6 a4);
/* ARRAY [INTEGER_32].force */
extern void T205f13(T0* C, T6 a1, T6 a2);
/* ARRAY [INTEGER_32].auto_resize */
extern void T205f14(T0* C, T6 a1, T6 a2);
/* SPECIAL [INTEGER_32].fill_with_default */
extern void T63f10(T0* C, T6 a1, T6 a2);
/* ARRAY [INTEGER_32].capacity */
extern T6 T205f7(T0* C);
/* ARRAY [INTEGER_32].additional_space */
extern T6 T205f6(T0* C);
/* ARRAY [INTEGER_32].empty_area */
extern T1 T205f5(T0* C);
/* DS_ARRAYED_LIST [AP_OPTION].swap */
extern void T74f30(T0* C, T6 a1, T6 a2);
/* DS_ARRAYED_LIST [AP_OPTION].replace */
extern void T74f29(T0* C, T0* a1, T6 a2);
/* AP_OPTION_COMPARATOR.less_than */
extern T1 T351f1(T0* C, T0* a1, T0* a2);
/* KL_STRING_ROUTINES.three_way_comparison */
extern T6 T76f14(T0* C, T0* a1, T0* a2);
/* AP_OPTION_COMPARATOR.string_ */
extern T0* T351f2(T0* C);
/* ST_WORD_WRAPPER.wrapped_string */
extern T0* T354f5(T0* C, T0* a1);
/* ST_WORD_WRAPPER.canonify_whitespace */
extern void T354f12(T0* C, T0* a1);
/* UC_UTF8_STRING.put */
extern void T207f83(T0* C, T2 a1, T6 a2);
/* UC_UTF8_STRING.move_bytes_right */
extern void T207f84(T0* C, T6 a1, T6 a2);
/* ST_WORD_WRAPPER.is_space */
extern T1 T354f8(T0* C, T2 a1);
/* ST_WORD_WRAPPER.string_ */
extern T0* T354f4(T0* C);
/* ST_WORD_WRAPPER.set_new_line_indentation */
extern void T354f10(T0* C, T6 a1);
/* AP_DISPLAY_HELP_FLAG.wrapper */
extern unsigned char ge153os4738;
extern T0* ge153ov4738;
extern T0* T73f19(T0* C);
/* ST_WORD_WRAPPER.set_maximum_text_width */
extern void T354f11(T0* C, T6 a1);
/* ST_WORD_WRAPPER.make */
extern T0* T354c9(void);
/* AP_DISPLAY_HELP_FLAG.full_usage_instruction */
extern T0* T73f17(T0* C, T0* a1);
/* AP_DISPLAY_HELP_FLAG.alternative_usage_instruction */
extern T0* T73f26(T0* C, T0* a1, T0* a2);
/* AP_DISPLAY_HELP_FLAG.arguments */
extern T0* T73f30(T0* C);
/* AP_DISPLAY_HELP_FLAG.file_system */
extern T0* T73f29(T0* C);
/* AP_DISPLAY_HELP_FLAG.unix_file_system */
extern T0* T73f35(T0* C);
/* AP_DISPLAY_HELP_FLAG.windows_file_system */
extern T0* T73f34(T0* C);
/* AP_DISPLAY_HELP_FLAG.operating_system */
extern T0* T73f33(T0* C);
/* AP_DISPLAY_HELP_FLAG.usage_instruction */
extern T0* T73f25(T0* C, T0* a1);
/* DS_QUICK_SORTER [AP_OPTION].make */
extern T0* T352c2(T0* a1);
/* AP_OPTION_COMPARATOR.default_create */
extern T0* T351c3(void);
/* AP_STRING_OPTION.record_occurrence */
extern void T37f30(T0* C, T0* a1);
/* AP_FLAG.record_occurrence */
extern void T35f25(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.force_last */
extern void T34f69(T0* C, T0* a1, T0* a2);
/* GEANT_VARIABLES.force_last */
extern void T29f71(T0* C, T0* a1, T0* a2);
/* GEANT_PROJECT_VARIABLES.force_last */
extern void T25f93(T0* C, T0* a1, T0* a2);
/* GEANT_PROJECT_VARIABLES.resize */
extern void T25f68(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.clashes_resize */
extern void T25f76(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.key_storage_resize */
extern void T25f75(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.item_storage_resize */
extern void T25f74(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.slots_resize */
extern void T25f73(T0* C, T6 a1);
/* GEANT_PROJECT_VARIABLES.new_capacity */
extern T6 T25f32(T0* C, T6 a1);
/* GEANT_ARGUMENT_VARIABLES.search */
extern void T34f70(T0* C, T0* a1);
/* GEANT_VARIABLES.search */
extern void T29f70(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.search */
extern void T25f81(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.start */
extern void T34f78(T0* C);
/* GEANT_VARIABLES.start */
extern void T29f78(T0* C);
/* GEANT_PROJECT_VARIABLES.start */
extern void T25f95(T0* C);
/* GEANT_ARGUMENT_VARIABLES.forth */
extern void T34f79(T0* C);
/* GEANT_VARIABLES.forth */
extern void T29f79(T0* C);
/* GEANT_PROJECT_VARIABLES.forth */
extern void T25f96(T0* C);
/* GEANT_ARGUMENT_VARIABLES.set_variable_value */
extern void T34f76(T0* C, T0* a1, T0* a2);
/* GEANT_VARIABLES.set_variable_value */
extern void T29f49(T0* C, T0* a1, T0* a2);
/* GEANT_PROJECT_VARIABLES.set_variable_value */
extern void T25f60(T0* C, T0* a1, T0* a2);
/* GEANT_PROJECT_VARIABLES.force */
extern void T25f63(T0* C, T0* a1, T0* a2);
/* GEANT_ARGUMENT_VARIABLES.replace */
extern void T34f77(T0* C, T0* a1, T0* a2);
/* GEANT_VARIABLES.replace */
extern void T29f77(T0* C, T0* a1, T0* a2);
/* GEANT_PROJECT_VARIABLES.replace */
extern void T25f94(T0* C, T0* a1, T0* a2);
/* LX_SYMBOL_TRANSITION [LX_NFA_STATE].labeled */
extern T1 T630f3(T0* C, T6 a1);
/* LX_EPSILON_TRANSITION [LX_NFA_STATE].labeled */
extern T1 T628f2(T0* C, T6 a1);
/* LX_SYMBOL_CLASS_TRANSITION [LX_NFA_STATE].labeled */
extern T1 T626f3(T0* C, T6 a1);
/* GEANT_REPLACE_TASK.is_executable */
extern T1 T319f18(T0* C);
/* GEANT_REPLACE_COMMAND.is_executable */
extern T1 T463f14(T0* C);
/* KL_BOOLEAN_ROUTINES.nxor */
extern T1 T563f1(T0* C, T0* a1);
/* GEANT_REPLACE_COMMAND.is_fileset_to_directory_executable */
extern T1 T463f17(T0* C);
/* GEANT_REPLACE_COMMAND.boolean_ */
extern unsigned char ge172os4918;
extern T0* ge172ov4918;
extern T0* T463f15(T0* C);
/* KL_BOOLEAN_ROUTINES.default_create */
extern T0* T563c2(void);
/* GEANT_INPUT_TASK.is_executable */
extern T1 T317f20(T0* C);
/* GEANT_INPUT_COMMAND.is_executable */
extern T1 T460f11(T0* C);
/* GEANT_AVAILABLE_TASK.is_executable */
extern T1 T315f6(T0* C);
/* GEANT_AVAILABLE_COMMAND.is_executable */
extern T1 T457f13(T0* C);
/* GEANT_AVAILABLE_COMMAND.validate_condition */
extern void T457f20(T0* C, T1 a1, T0* a2, T0* a3);
/* GEANT_AVAILABLE_COMMAND.validation_messages */
extern T0* T457f16(T0* C);
/* DS_CELL [BOOLEAN].put */
extern void T561f3(T0* C, T1 a1);
/* DS_CELL [BOOLEAN].make */
extern T0* T561c2(T1 a1);
/* GEANT_PRECURSOR_TASK.is_executable */
extern T1 T313f17(T0* C);
/* GEANT_PRECURSOR_COMMAND.is_executable */
extern T1 T454f7(T0* C);
/* GEANT_EXIT_TASK.is_executable */
extern T1 T311f10(T0* C);
/* GEANT_EXIT_COMMAND.is_executable */
extern T1 T451f6(T0* C);
/* GEANT_OUTOFDATE_TASK.is_executable */
extern T1 T309f15(T0* C);
/* GEANT_OUTOFDATE_COMMAND.is_executable */
extern T1 T448f11(T0* C);
/* GEANT_OUTOFDATE_COMMAND.is_fileset_executable */
extern T1 T448f13(T0* C);
/* GEANT_XSLT_TASK.is_executable */
extern T1 T307f29(T0* C);
/* GEANT_XSLT_COMMAND.is_executable */
extern T1 T444f17(T0* C);
/* GEANT_SETENV_TASK.is_executable */
extern T1 T305f11(T0* C);
/* GEANT_SETENV_COMMAND.is_executable */
extern T1 T440f7(T0* C);
/* GEANT_MOVE_TASK.is_executable */
extern T1 T303f13(T0* C);
/* GEANT_MOVE_COMMAND.is_executable */
extern T1 T437f9(T0* C);
/* GEANT_MOVE_COMMAND.is_fileset_to_directory_executable */
extern T1 T437f12(T0* C);
/* GEANT_COPY_TASK.is_executable */
extern T1 T301f19(T0* C);
/* GEANT_COPY_COMMAND.is_executable */
extern T1 T434f10(T0* C);
/* GEANT_COPY_COMMAND.is_fileset_to_directory_executable */
extern T1 T434f14(T0* C);
/* GEANT_COPY_COMMAND.boolean_ */
extern T0* T434f11(T0* C);
/* GEANT_DELETE_TASK.is_executable */
extern T1 T299f13(T0* C);
/* GEANT_DELETE_COMMAND.is_executable */
extern T1 T430f9(T0* C);
/* GEANT_DELETE_COMMAND.boolean_ */
extern T0* T430f10(T0* C);
/* GEANT_MKDIR_TASK.is_executable */
extern T1 T297f6(T0* C);
/* GEANT_MKDIR_COMMAND.is_executable */
extern T1 T426f10(T0* C);
/* GEANT_MKDIR_COMMAND.validate_condition */
extern void T426f17(T0* C, T1 a1, T0* a2, T0* a3);
/* GEANT_MKDIR_COMMAND.validation_messages */
extern T0* T426f12(T0* C);
/* GEANT_ECHO_TASK.is_executable */
extern T1 T295f6(T0* C);
/* GEANT_ECHO_COMMAND.is_executable */
extern T1 T423f9(T0* C);
/* GEANT_ECHO_COMMAND.validate_condition */
extern void T423f17(T0* C, T1 a1, T0* a2, T0* a3);
/* GEANT_ECHO_COMMAND.validation_messages */
extern T0* T423f11(T0* C);
/* GEANT_GEANT_TASK.is_executable */
extern T1 T293f25(T0* C);
/* GEANT_GEANT_COMMAND.is_executable */
extern T1 T419f13(T0* C);
/* GEANT_GEANT_COMMAND.is_target_executable */
extern T1 T419f15(T0* C);
/* GEANT_GETEST_TASK.is_executable */
extern T1 T291f27(T0* C);
/* GEANT_GETEST_COMMAND.is_executable */
extern T1 T416f16(T0* C);
/* GEANT_GEPP_TASK.is_executable */
extern T1 T289f22(T0* C);
/* GEANT_GEPP_COMMAND.is_executable */
extern T1 T413f12(T0* C);
/* GEANT_GEPP_COMMAND.is_fileset_executable */
extern T1 T413f14(T0* C);
/* GEANT_GEYACC_TASK.is_executable */
extern T1 T287f22(T0* C);
/* GEANT_GEYACC_COMMAND.is_executable */
extern T1 T410f13(T0* C);
/* GEANT_GELEX_TASK.is_executable */
extern T1 T285f25(T0* C);
/* GEANT_GELEX_COMMAND.is_executable */
extern T1 T407f16(T0* C);
/* GEANT_GEXACE_TASK.is_executable */
extern T1 T283f23(T0* C);
/* GEANT_GEXACE_COMMAND.is_executable */
extern T1 T404f13(T0* C);
/* GEANT_GEXACE_COMMAND.boolean_ */
extern T0* T404f14(T0* C);
/* GEANT_UNSET_TASK.is_executable */
extern T1 T281f10(T0* C);
/* GEANT_UNSET_COMMAND.is_executable */
extern T1 T400f6(T0* C);
/* GEANT_SET_TASK.is_executable */
extern T1 T279f11(T0* C);
/* GEANT_SET_COMMAND.is_executable */
extern T1 T397f7(T0* C);
/* GEANT_LCC_TASK.is_executable */
extern T1 T277f11(T0* C);
/* GEANT_LCC_COMMAND.is_executable */
extern T1 T394f7(T0* C);
/* GEANT_EXEC_TASK.is_executable */
extern T1 T275f7(T0* C);
/* GEANT_EXEC_COMMAND.is_executable */
extern T1 T386f9(T0* C);
/* GEANT_EXEC_COMMAND.validate_condition */
extern void T386f17(T0* C, T1 a1, T0* a2, T0* a3);
/* GEANT_EXEC_COMMAND.validation_messages */
extern T0* T386f12(T0* C);
/* GEANT_ISE_TASK.is_executable */
extern T1 T273f21(T0* C);
/* GEANT_ISE_COMMAND.is_executable */
extern T1 T382f11(T0* C);
/* GEANT_ISE_COMMAND.is_cleanable */
extern T1 T382f13(T0* C);
/* GEANT_GEC_TASK.is_executable */
extern T1 T266f25(T0* C);
/* GEANT_GEC_COMMAND.is_executable */
extern T1 T378f15(T0* C);
/* GEANT_REPLACE_TASK.is_enabled */
extern T1 T319f19(T0* C);
/* GEANT_REPLACE_TASK.unless_attribute_name */
extern T0* T319f23(T0* C);
/* GEANT_REPLACE_TASK.if_attribute_name */
extern T0* T319f22(T0* C);
/* GEANT_INPUT_TASK.is_enabled */
extern T1 T317f21(T0* C);
/* GEANT_INPUT_TASK.unless_attribute_name */
extern T0* T317f25(T0* C);
/* GEANT_INPUT_TASK.if_attribute_name */
extern T0* T317f24(T0* C);
/* GEANT_AVAILABLE_TASK.is_enabled */
extern T1 T315f7(T0* C);
/* GEANT_AVAILABLE_TASK.unless_attribute_name */
extern T0* T315f13(T0* C);
/* GEANT_AVAILABLE_TASK.has_attribute */
extern T1 T315f12(T0* C, T0* a1);
/* GEANT_AVAILABLE_TASK.if_attribute_name */
extern T0* T315f11(T0* C);
/* GEANT_PRECURSOR_TASK.is_enabled */
extern T1 T313f18(T0* C);
/* GEANT_PRECURSOR_TASK.unless_attribute_name */
extern T0* T313f22(T0* C);
/* GEANT_PRECURSOR_TASK.if_attribute_name */
extern T0* T313f21(T0* C);
/* GEANT_EXIT_TASK.is_enabled */
extern T1 T311f11(T0* C);
/* GEANT_EXIT_TASK.unless_attribute_name */
extern T0* T311f15(T0* C);
/* GEANT_EXIT_TASK.if_attribute_name */
extern T0* T311f14(T0* C);
/* GEANT_OUTOFDATE_TASK.is_enabled */
extern T1 T309f16(T0* C);
/* GEANT_OUTOFDATE_TASK.unless_attribute_name */
extern T0* T309f20(T0* C);
/* GEANT_OUTOFDATE_TASK.if_attribute_name */
extern T0* T309f19(T0* C);
/* GEANT_XSLT_TASK.is_enabled */
extern T1 T307f30(T0* C);
/* GEANT_XSLT_TASK.unless_attribute_name */
extern T0* T307f34(T0* C);
/* GEANT_XSLT_TASK.if_attribute_name */
extern T0* T307f33(T0* C);
/* GEANT_SETENV_TASK.is_enabled */
extern T1 T305f12(T0* C);
/* GEANT_SETENV_TASK.unless_attribute_name */
extern T0* T305f16(T0* C);
/* GEANT_SETENV_TASK.if_attribute_name */
extern T0* T305f15(T0* C);
/* GEANT_MOVE_TASK.is_enabled */
extern T1 T303f14(T0* C);
/* GEANT_MOVE_TASK.unless_attribute_name */
extern T0* T303f18(T0* C);
/* GEANT_MOVE_TASK.if_attribute_name */
extern T0* T303f17(T0* C);
/* GEANT_COPY_TASK.is_enabled */
extern T1 T301f20(T0* C);
/* GEANT_COPY_TASK.unless_attribute_name */
extern T0* T301f24(T0* C);
/* GEANT_COPY_TASK.if_attribute_name */
extern T0* T301f23(T0* C);
/* GEANT_DELETE_TASK.is_enabled */
extern T1 T299f14(T0* C);
/* GEANT_DELETE_TASK.unless_attribute_name */
extern T0* T299f18(T0* C);
/* GEANT_DELETE_TASK.if_attribute_name */
extern T0* T299f17(T0* C);
/* GEANT_MKDIR_TASK.is_enabled */
extern T1 T297f7(T0* C);
/* GEANT_MKDIR_TASK.unless_attribute_name */
extern T0* T297f13(T0* C);
/* GEANT_MKDIR_TASK.has_attribute */
extern T1 T297f12(T0* C, T0* a1);
/* GEANT_MKDIR_TASK.if_attribute_name */
extern T0* T297f11(T0* C);
/* GEANT_ECHO_TASK.is_enabled */
extern T1 T295f7(T0* C);
/* GEANT_ECHO_TASK.unless_attribute_name */
extern T0* T295f13(T0* C);
/* GEANT_ECHO_TASK.has_attribute */
extern T1 T295f12(T0* C, T0* a1);
/* GEANT_ECHO_TASK.if_attribute_name */
extern T0* T295f11(T0* C);
/* GEANT_GEANT_TASK.is_enabled */
extern T1 T293f26(T0* C);
/* GEANT_GEANT_TASK.unless_attribute_name */
extern T0* T293f30(T0* C);
/* GEANT_GEANT_TASK.if_attribute_name */
extern T0* T293f29(T0* C);
/* GEANT_GETEST_TASK.is_enabled */
extern T1 T291f28(T0* C);
/* GEANT_GETEST_TASK.unless_attribute_name */
extern T0* T291f32(T0* C);
/* GEANT_GETEST_TASK.if_attribute_name */
extern T0* T291f31(T0* C);
/* GEANT_GEPP_TASK.is_enabled */
extern T1 T289f23(T0* C);
/* GEANT_GEPP_TASK.unless_attribute_name */
extern T0* T289f27(T0* C);
/* GEANT_GEPP_TASK.if_attribute_name */
extern T0* T289f26(T0* C);
/* GEANT_GEYACC_TASK.is_enabled */
extern T1 T287f23(T0* C);
/* GEANT_GEYACC_TASK.unless_attribute_name */
extern T0* T287f27(T0* C);
/* GEANT_GEYACC_TASK.if_attribute_name */
extern T0* T287f26(T0* C);
/* GEANT_GELEX_TASK.is_enabled */
extern T1 T285f26(T0* C);
/* GEANT_GELEX_TASK.unless_attribute_name */
extern T0* T285f30(T0* C);
/* GEANT_GELEX_TASK.if_attribute_name */
extern T0* T285f29(T0* C);
/* GEANT_GEXACE_TASK.is_enabled */
extern T1 T283f24(T0* C);
/* GEANT_GEXACE_TASK.unless_attribute_name */
extern T0* T283f28(T0* C);
/* GEANT_GEXACE_TASK.if_attribute_name */
extern T0* T283f27(T0* C);
/* GEANT_UNSET_TASK.is_enabled */
extern T1 T281f11(T0* C);
/* GEANT_UNSET_TASK.unless_attribute_name */
extern T0* T281f15(T0* C);
/* GEANT_UNSET_TASK.if_attribute_name */
extern T0* T281f14(T0* C);
/* GEANT_SET_TASK.is_enabled */
extern T1 T279f12(T0* C);
/* GEANT_SET_TASK.unless_attribute_name */
extern T0* T279f16(T0* C);
/* GEANT_SET_TASK.if_attribute_name */
extern T0* T279f15(T0* C);
/* GEANT_LCC_TASK.is_enabled */
extern T1 T277f12(T0* C);
/* GEANT_LCC_TASK.unless_attribute_name */
extern T0* T277f16(T0* C);
/* GEANT_LCC_TASK.if_attribute_name */
extern T0* T277f15(T0* C);
/* GEANT_EXEC_TASK.is_enabled */
extern T1 T275f8(T0* C);
/* GEANT_EXEC_TASK.unless_attribute_name */
extern T0* T275f14(T0* C);
/* GEANT_EXEC_TASK.has_attribute */
extern T1 T275f13(T0* C, T0* a1);
/* GEANT_EXEC_TASK.if_attribute_name */
extern T0* T275f12(T0* C);
/* GEANT_ISE_TASK.is_enabled */
extern T1 T273f22(T0* C);
/* GEANT_ISE_TASK.unless_attribute_name */
extern T0* T273f26(T0* C);
/* GEANT_ISE_TASK.if_attribute_name */
extern T0* T273f25(T0* C);
/* GEANT_GEC_TASK.is_enabled */
extern T1 T266f26(T0* C);
/* GEANT_GEC_TASK.unless_attribute_name */
extern T0* T266f30(T0* C);
/* GEANT_GEC_TASK.if_attribute_name */
extern T0* T266f29(T0* C);
/* GEANT_REPLACE_TASK.is_exit_command */
extern T1 T319f20(T0* C);
/* GEANT_REPLACE_COMMAND.is_exit_command */
extern T1 T463f13(T0* C);
/* GEANT_INPUT_TASK.is_exit_command */
extern T1 T317f22(T0* C);
/* GEANT_INPUT_COMMAND.is_exit_command */
extern T1 T460f10(T0* C);
/* GEANT_AVAILABLE_TASK.is_exit_command */
extern T1 T315f8(T0* C);
/* GEANT_AVAILABLE_COMMAND.is_exit_command */
extern T1 T457f14(T0* C);
/* GEANT_PRECURSOR_TASK.is_exit_command */
extern T1 T313f19(T0* C);
/* GEANT_PRECURSOR_COMMAND.is_exit_command */
extern T1 T454f6(T0* C);
/* GEANT_EXIT_TASK.is_exit_command */
extern T1 T311f12(T0* C);
/* GEANT_OUTOFDATE_TASK.is_exit_command */
extern T1 T309f17(T0* C);
/* GEANT_OUTOFDATE_COMMAND.is_exit_command */
extern T1 T448f16(T0* C);
/* GEANT_XSLT_TASK.is_exit_command */
extern T1 T307f31(T0* C);
/* GEANT_XSLT_COMMAND.is_exit_command */
extern T1 T444f18(T0* C);
/* GEANT_SETENV_TASK.is_exit_command */
extern T1 T305f13(T0* C);
/* GEANT_SETENV_COMMAND.is_exit_command */
extern T1 T440f6(T0* C);
/* GEANT_MOVE_TASK.is_exit_command */
extern T1 T303f15(T0* C);
/* GEANT_MOVE_COMMAND.is_exit_command */
extern T1 T437f8(T0* C);
/* GEANT_COPY_TASK.is_exit_command */
extern T1 T301f21(T0* C);
/* GEANT_COPY_COMMAND.is_exit_command */
extern T1 T434f9(T0* C);
/* GEANT_DELETE_TASK.is_exit_command */
extern T1 T299f15(T0* C);
/* GEANT_DELETE_COMMAND.is_exit_command */
extern T1 T430f8(T0* C);
/* GEANT_MKDIR_TASK.is_exit_command */
extern T1 T297f8(T0* C);
/* GEANT_MKDIR_COMMAND.is_exit_command */
extern T1 T426f11(T0* C);
/* GEANT_ECHO_TASK.is_exit_command */
extern T1 T295f8(T0* C);
/* GEANT_ECHO_COMMAND.is_exit_command */
extern T1 T423f10(T0* C);
/* GEANT_GEANT_TASK.is_exit_command */
extern T1 T293f27(T0* C);
/* GEANT_GEANT_COMMAND.is_exit_command */
extern T1 T419f12(T0* C);
/* GEANT_GETEST_TASK.is_exit_command */
extern T1 T291f29(T0* C);
/* GEANT_GETEST_COMMAND.is_exit_command */
extern T1 T416f15(T0* C);
/* GEANT_GEPP_TASK.is_exit_command */
extern T1 T289f24(T0* C);
/* GEANT_GEPP_COMMAND.is_exit_command */
extern T1 T413f11(T0* C);
/* GEANT_GEYACC_TASK.is_exit_command */
extern T1 T287f24(T0* C);
/* GEANT_GEYACC_COMMAND.is_exit_command */
extern T1 T410f12(T0* C);
/* GEANT_GELEX_TASK.is_exit_command */
extern T1 T285f27(T0* C);
/* GEANT_GELEX_COMMAND.is_exit_command */
extern T1 T407f15(T0* C);
/* GEANT_GEXACE_TASK.is_exit_command */
extern T1 T283f25(T0* C);
/* GEANT_GEXACE_COMMAND.is_exit_command */
extern T1 T404f12(T0* C);
/* GEANT_UNSET_TASK.is_exit_command */
extern T1 T281f12(T0* C);
/* GEANT_UNSET_COMMAND.is_exit_command */
extern T1 T400f5(T0* C);
/* GEANT_SET_TASK.is_exit_command */
extern T1 T279f13(T0* C);
/* GEANT_SET_COMMAND.is_exit_command */
extern T1 T397f6(T0* C);
/* GEANT_LCC_TASK.is_exit_command */
extern T1 T277f13(T0* C);
/* GEANT_LCC_COMMAND.is_exit_command */
extern T1 T394f6(T0* C);
/* GEANT_EXEC_TASK.is_exit_command */
extern T1 T275f9(T0* C);
/* GEANT_EXEC_COMMAND.is_exit_command */
extern T1 T386f10(T0* C);
/* GEANT_ISE_TASK.is_exit_command */
extern T1 T273f23(T0* C);
/* GEANT_ISE_COMMAND.is_exit_command */
extern T1 T382f10(T0* C);
/* GEANT_GEC_TASK.is_exit_command */
extern T1 T266f27(T0* C);
/* GEANT_GEC_COMMAND.is_exit_command */
extern T1 T378f14(T0* C);
/* GEANT_REPLACE_TASK.exit_code */
extern T6 T319f21(T0* C);
/* GEANT_INPUT_TASK.exit_code */
extern T6 T317f23(T0* C);
/* GEANT_AVAILABLE_TASK.exit_code */
extern T6 T315f9(T0* C);
/* GEANT_PRECURSOR_TASK.exit_code */
extern T6 T313f20(T0* C);
/* GEANT_EXIT_TASK.exit_code */
extern T6 T311f13(T0* C);
/* GEANT_OUTOFDATE_TASK.exit_code */
extern T6 T309f18(T0* C);
/* GEANT_XSLT_TASK.exit_code */
extern T6 T307f32(T0* C);
/* GEANT_SETENV_TASK.exit_code */
extern T6 T305f14(T0* C);
/* GEANT_MOVE_TASK.exit_code */
extern T6 T303f16(T0* C);
/* GEANT_COPY_TASK.exit_code */
extern T6 T301f22(T0* C);
/* GEANT_DELETE_TASK.exit_code */
extern T6 T299f16(T0* C);
/* GEANT_MKDIR_TASK.exit_code */
extern T6 T297f9(T0* C);
/* GEANT_ECHO_TASK.exit_code */
extern T6 T295f9(T0* C);
/* GEANT_GEANT_TASK.exit_code */
extern T6 T293f28(T0* C);
/* GEANT_GETEST_TASK.exit_code */
extern T6 T291f30(T0* C);
/* GEANT_GEPP_TASK.exit_code */
extern T6 T289f25(T0* C);
/* GEANT_GEYACC_TASK.exit_code */
extern T6 T287f25(T0* C);
/* GEANT_GELEX_TASK.exit_code */
extern T6 T285f28(T0* C);
/* GEANT_GEXACE_TASK.exit_code */
extern T6 T283f26(T0* C);
/* GEANT_UNSET_TASK.exit_code */
extern T6 T281f13(T0* C);
/* GEANT_SET_TASK.exit_code */
extern T6 T279f14(T0* C);
/* GEANT_LCC_TASK.exit_code */
extern T6 T277f14(T0* C);
/* GEANT_EXEC_TASK.exit_code */
extern T6 T275f10(T0* C);
/* GEANT_ISE_TASK.exit_code */
extern T6 T273f24(T0* C);
/* GEANT_GEC_TASK.exit_code */
extern T6 T266f28(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.error_position */
extern T0* T177f57(T0* C);
/* XM_DEFAULT_POSITION.make */
extern T0* T134c5(T0* a1, T6 a2, T6 a3, T6 a4);
/* XM_EIFFEL_SCANNER_DTD.error_position */
extern T0* T175f57(T0* C);
/* XM_EIFFEL_ENTITY_DEF.error_position */
extern T0* T171f56(T0* C);
/* XM_EIFFEL_SCANNER.error_position */
extern T0* T133f64(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.end_of_file */
extern T1 T177f60(T0* C);
/* XM_EIFFEL_SCANNER_DTD.end_of_file */
extern T1 T175f61(T0* C);
/* XM_EIFFEL_ENTITY_DEF.end_of_file */
extern T1 T171f59(T0* C);
/* XM_EIFFEL_SCANNER.end_of_file */
extern T1 T133f65(T0* C);
/* XM_EIFFEL_PE_ENTITY_DEF.is_applicable_encoding */
extern T1 T177f61(T0* C, T0* a1);
/* XM_EIFFEL_INPUT_STREAM.is_applicable_encoding */
extern T1 T209f16(T0* C, T0* a1);
/* XM_EIFFEL_INPUT_STREAM.is_valid_encoding */
extern T1 T209f9(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER_DTD.is_applicable_encoding */
extern T1 T175f48(T0* C, T0* a1);
/* XM_EIFFEL_ENTITY_DEF.is_applicable_encoding */
extern T1 T171f60(T0* C, T0* a1);
/* XM_EIFFEL_SCANNER.is_applicable_encoding */
extern T1 T133f182(T0* C, T0* a1);
/* XM_EIFFEL_PE_ENTITY_DEF.start_condition */
extern T6 T177f62(T0* C);
/* XM_EIFFEL_SCANNER_DTD.start_condition */
extern T6 T175f51(T0* C);
/* XM_EIFFEL_ENTITY_DEF.start_condition */
extern T6 T171f61(T0* C);
/* XM_EIFFEL_SCANNER.start_condition */
extern T6 T133f43(T0* C);
/* DS_HASH_TABLE [STRING_8, STRING_8].cursor_after */
extern T1 T81f25(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.cursor_after */
extern T1 T34f36(T0* C, T0* a1);
/* GEANT_VARIABLES.cursor_after */
extern T1 T29f38(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.cursor_after */
extern T1 T25f46(T0* C, T0* a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].cursor_item */
extern T0* T81f26(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.cursor_item */
extern T0* T34f37(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.item_storage_item */
extern T0* T34f41(T0* C, T6 a1);
/* GEANT_VARIABLES.cursor_item */
extern T0* T29f39(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.cursor_item */
extern T0* T25f47(T0* C, T0* a1);
/* DS_HASH_TABLE [STRING_8, STRING_8].cursor_key */
extern T0* T81f27(T0* C, T0* a1);
/* GEANT_ARGUMENT_VARIABLES.cursor_key */
extern T0* T34f38(T0* C, T0* a1);
/* GEANT_VARIABLES.cursor_key */
extern T0* T29f40(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.cursor_key */
extern T0* T25f48(T0* C, T0* a1);
/* FILE_NAME.area_lower */
extern T6 T659f8(T0* C);
/* UC_UTF8_STRING.area_lower */
extern T6 T207f12(T0* C);
/* STRING_8.area_lower */
extern T6 T17f7(T0* C);
/* DS_HASH_TABLE [STRING_8, STRING_8].new_cursor */
extern T0* T81f35(T0* C);
/* DS_HASH_TABLE_CURSOR [STRING_8, STRING_8].make */
extern T0* T64c7(T0* a1);
/* GEANT_ARGUMENT_VARIABLES.new_cursor */
extern T0* T34f30(T0* C);
/* GEANT_VARIABLES.new_cursor */
extern T0* T29f30(T0* C);
/* GEANT_PROJECT_VARIABLES.new_cursor */
extern T0* T25f35(T0* C);
/* LX_NEGATIVE_RANGE_IN_CHARACTER_CLASS_ERROR.default_message */
extern T0* T608f5(T0* C);
/* LX_NEGATIVE_RANGE_IN_CHARACTER_CLASS_ERROR.message */
extern T0* T608f3(T0* C, T0* a1);
/* LX_NEGATIVE_RANGE_IN_CHARACTER_CLASS_ERROR.arguments */
extern T0* T608f6(T0* C);
/* LX_NEGATIVE_RANGE_IN_CHARACTER_CLASS_ERROR.string_ */
extern T0* T608f4(T0* C);
/* LX_CHARACTER_OUT_OF_RANGE_ERROR.default_message */
extern T0* T595f5(T0* C);
/* LX_CHARACTER_OUT_OF_RANGE_ERROR.message */
extern T0* T595f3(T0* C, T0* a1);
/* LX_CHARACTER_OUT_OF_RANGE_ERROR.arguments */
extern T0* T595f6(T0* C);
/* LX_CHARACTER_OUT_OF_RANGE_ERROR.string_ */
extern T0* T595f4(T0* C);
/* LX_FULL_AND_VARIABLE_TRAILING_CONTEXT_ERROR.default_message */
extern T0* T594f5(T0* C);
/* LX_FULL_AND_VARIABLE_TRAILING_CONTEXT_ERROR.message */
extern T0* T594f3(T0* C, T0* a1);
/* LX_FULL_AND_VARIABLE_TRAILING_CONTEXT_ERROR.arguments */
extern T0* T594f6(T0* C);
/* LX_FULL_AND_VARIABLE_TRAILING_CONTEXT_ERROR.string_ */
extern T0* T594f4(T0* C);
/* LX_FULL_AND_REJECT_ERROR.default_message */
extern T0* T593f5(T0* C);
/* LX_FULL_AND_REJECT_ERROR.message */
extern T0* T593f3(T0* C, T0* a1);
/* LX_FULL_AND_REJECT_ERROR.arguments */
extern T0* T593f6(T0* C);
/* LX_FULL_AND_REJECT_ERROR.string_ */
extern T0* T593f4(T0* C);
/* LX_FULL_AND_META_ERROR.default_message */
extern T0* T592f5(T0* C);
/* LX_FULL_AND_META_ERROR.message */
extern T0* T592f3(T0* C, T0* a1);
/* LX_FULL_AND_META_ERROR.arguments */
extern T0* T592f6(T0* C);
/* LX_FULL_AND_META_ERROR.string_ */
extern T0* T592f4(T0* C);
/* LX_BAD_CHARACTER_ERROR.default_message */
extern T0* T591f5(T0* C);
/* LX_BAD_CHARACTER_ERROR.message */
extern T0* T591f3(T0* C, T0* a1);
/* LX_BAD_CHARACTER_ERROR.arguments */
extern T0* T591f6(T0* C);
/* LX_BAD_CHARACTER_ERROR.string_ */
extern T0* T591f4(T0* C);
/* LX_BAD_CHARACTER_CLASS_ERROR.default_message */
extern T0* T590f5(T0* C);
/* LX_BAD_CHARACTER_CLASS_ERROR.message */
extern T0* T590f3(T0* C, T0* a1);
/* LX_BAD_CHARACTER_CLASS_ERROR.arguments */
extern T0* T590f6(T0* C);
/* LX_BAD_CHARACTER_CLASS_ERROR.string_ */
extern T0* T590f4(T0* C);
/* LX_MISSING_QUOTE_ERROR.default_message */
extern T0* T589f5(T0* C);
/* LX_MISSING_QUOTE_ERROR.message */
extern T0* T589f3(T0* C, T0* a1);
/* LX_MISSING_QUOTE_ERROR.arguments */
extern T0* T589f6(T0* C);
/* LX_MISSING_QUOTE_ERROR.string_ */
extern T0* T589f4(T0* C);
/* LX_UNRECOGNIZED_RULE_ERROR.default_message */
extern T0* T588f5(T0* C);
/* LX_UNRECOGNIZED_RULE_ERROR.message */
extern T0* T588f3(T0* C, T0* a1);
/* LX_UNRECOGNIZED_RULE_ERROR.arguments */
extern T0* T588f6(T0* C);
/* LX_UNRECOGNIZED_RULE_ERROR.string_ */
extern T0* T588f4(T0* C);
/* UT_SYNTAX_ERROR.default_message */
extern T0* T586f5(T0* C);
/* UT_SYNTAX_ERROR.message */
extern T0* T586f3(T0* C, T0* a1);
/* UT_SYNTAX_ERROR.arguments */
extern T0* T586f6(T0* C);
/* UT_SYNTAX_ERROR.string_ */
extern T0* T586f4(T0* C);
/* UT_VERSION_NUMBER.default_message */
extern T0* T49f2(T0* C);
/* UT_VERSION_NUMBER.message */
extern T0* T49f4(T0* C, T0* a1);
/* UT_VERSION_NUMBER.arguments */
extern T0* T49f6(T0* C);
/* UT_VERSION_NUMBER.string_ */
extern T0* T49f5(T0* C);
/* AP_DISPLAY_HELP_FLAG.was_found */
extern T1 T73f11(T0* C);
/* AP_STRING_OPTION.was_found */
extern T1 T37f16(T0* C);
/* AP_FLAG.was_found */
extern T1 T35f9(T0* C);
/* AP_STRING_OPTION.occurrences */
extern T6 T37f18(T0* C);
/* AP_DISPLAY_HELP_FLAG.allows_parameter */
extern T1 T73f9(T0* C);
/* AP_STRING_OPTION.allows_parameter */
extern T1 T37f17(T0* C);
/* AP_FLAG.allows_parameter */
extern T1 T35f12(T0* C);
/* AP_DISPLAY_HELP_FLAG.needs_parameter */
extern T1 T73f12(T0* C);
/* AP_FLAG.needs_parameter */
extern T1 T35f11(T0* C);
/* AP_DISPLAY_HELP_FLAG.name */
extern T0* T73f22(T0* C);
/* AP_STRING_OPTION.name */
extern T0* T37f11(T0* C);
/* AP_FLAG.name */
extern T0* T35f15(T0* C);
/* AP_DISPLAY_HELP_FLAG.names */
extern T0* T73f23(T0* C);
/* AP_STRING_OPTION.names */
extern T0* T37f19(T0* C);
/* AP_STRING_OPTION.names */
extern T0* T37f19p1(T0* C);
/* AP_FLAG.names */
extern T0* T35f16(T0* C);
/* AP_DISPLAY_HELP_FLAG.example */
extern T0* T73f28(T0* C);
/* AP_STRING_OPTION.example */
extern T0* T37f20(T0* C);
/* AP_FLAG.example */
extern T0* T35f17(T0* C);
/* AP_DISPLAY_HELP_FLAG.has_long_form */
extern T1 T73f10(T0* C);
/* AP_STRING_OPTION.has_long_form */
extern T1 T37f12(T0* C);
/* AP_FLAG.has_long_form */
extern T1 T35f10(T0* C);
/* GEANT_ARGUMENT_VARIABLES.found */
extern T1 T34f34(T0* C);
/* GEANT_VARIABLES.found */
extern T1 T29f36(T0* C);
/* GEANT_PROJECT_VARIABLES.found */
extern T1 T25f44(T0* C);
/* GEANT_ARGUMENT_VARIABLES.found_item */
extern T0* T34f44(T0* C);
/* GEANT_VARIABLES.found_item */
extern T0* T29f44(T0* C);
/* GEANT_PROJECT_VARIABLES.found_item */
extern T0* T25f53(T0* C);
/* GEANT_ARGUMENT_VARIABLES.after */
extern T1 T34f45(T0* C);
/* GEANT_VARIABLES.after */
extern T1 T29f45(T0* C);
/* GEANT_PROJECT_VARIABLES.after */
extern T1 T25f56(T0* C);
/* GEANT_ARGUMENT_VARIABLES.key_for_iteration */
extern T0* T34f46(T0* C);
/* GEANT_VARIABLES.key_for_iteration */
extern T0* T29f46(T0* C);
/* GEANT_PROJECT_VARIABLES.key_for_iteration */
extern T0* T25f57(T0* C);
/* GEANT_ARGUMENT_VARIABLES.item_for_iteration */
extern T0* T34f47(T0* C);
/* GEANT_VARIABLES.item_for_iteration */
extern T0* T29f47(T0* C);
/* GEANT_PROJECT_VARIABLES.item_for_iteration */
extern T0* T25f58(T0* C);
/* GEANT_ARGUMENT_VARIABLES.has */
extern T1 T34f33(T0* C, T0* a1);
/* GEANT_VARIABLES.has */
extern T1 T29f32(T0* C, T0* a1);
/* GEANT_PROJECT_VARIABLES.has */
extern T1 T25f55(T0* C, T0* a1);
/* FILE_NAME.to_c */
extern T0* T659f6(T0* C);
/* UC_UTF8_STRING.to_c */
extern T0* T207f21(T0* C);
/* STRING_8.to_c */
extern T0* T17f12(T0* C);
extern T0* GE_ma33(T6 c, T6 n, ...);
extern T0* GE_ma205(T6 c, T6 n, ...);
extern T0* GE_ma180(T6 c, T6 n, ...);
extern T0* GE_ma615(T6 c, T6 n, ...);
extern T0* GE_ma564(T6 c, T6 n, ...);
extern T0* ge182ov4774;
extern T0* ge218ov2973;
extern T0* ge269ov6009;
extern T0* ge279ov7328;
extern T0* ge203ov8945;
extern T0* ge205ov3843;
extern T0* ge220ov2973;
extern T0* ge226ov3884;
extern T0* ge226ov3885;
extern T0* ge211ov4147;
extern T0* ge211ov4146;
extern T0* ge223ov3884;
extern T0* ge223ov3885;
extern T0* ge1526ov4902;
extern T0* ge1526ov4901;
extern T0* ge362ov9993;
extern T0* ge209ov2973;
extern T0* ge491ov9143;
extern T0* ge204ov4038;
extern T0* ge534ov8850;
extern T0* ge313ov2973;
extern T0* ge1533ov5343;
extern T0* ge1533ov5305;
extern T0* ge1533ov5303;
extern T0* ge1533ov5344;
extern T0* ge1533ov5316;
extern T0* ge1533ov5315;
extern T0* ge1533ov5326;
extern T0* ge1533ov5320;
extern T0* ge1533ov5319;
extern T0* ge1533ov5318;
extern T0* ge1533ov5324;
extern T0* ge1533ov5323;
extern T0* ge1533ov5325;
extern T0* ge1533ov5302;
extern T0* ge1533ov5328;
extern T0* ge1533ov5337;
extern T0* ge1536ov5038;
extern T0* ge1536ov5036;
extern T0* ge1536ov5037;
extern T0* ge1533ov5338;
extern T0* ge1533ov5339;
extern T0* ge1533ov5342;
extern T0* ge1533ov5340;
extern T0* ge1533ov5341;
extern T0* ge1533ov5335;
extern T0* ge1529ov6724;
extern T0* ge1529ov6725;
extern T0* ge1533ov5308;
extern T0* ge1533ov5331;
extern T0* ge1533ov5351;
extern T0* ge1533ov5352;
extern T0* ge1533ov5353;
extern T0* ge1533ov5346;
extern T0* ge1533ov5329;
extern T0* ge1533ov5330;
extern T0* ge1533ov5332;
extern T0* ge1533ov5336;
extern T0* ge226ov3895;
extern T0* ge223ov3895;
extern T0* ge152ov2602;
extern T0* ge155ov2941;
extern T0* ge155ov2948;
extern T0* ge240ov1742;
extern T0* ge155ov2944;
extern T0* ge155ov2951;
extern T0* ge155ov2942;
extern T0* ge155ov2949;
extern T0* ge155ov2943;
extern T0* ge155ov2950;
extern T0* ge155ov2945;
extern T0* ge155ov2952;
extern T0* ge155ov2946;
extern T0* ge155ov2953;
extern T0* ge152ov2597;
extern T0* ge152ov2596;
extern T0* ge152ov2604;
extern T0* ge152ov2603;
extern T0* ge495ov10528;
extern T0* ge495ov10565;
extern T0* ge495ov10550;
extern T0* ge495ov10543;
extern T0* ge495ov10553;
extern T0* ge495ov10546;
extern T0* ge495ov10554;
extern T0* ge495ov10563;
extern T0* ge495ov10556;
extern T0* ge495ov10552;
extern T0* ge495ov10540;
extern T0* ge495ov10541;
extern T0* ge495ov10555;
extern T0* ge495ov10542;
extern T0* ge495ov10529;
extern T0* ge495ov10530;
extern T0* ge495ov10531;
extern T0* ge495ov10537;
extern T0* ge495ov10539;
extern T0* ge495ov10534;
extern T0* ge495ov10559;
extern T0* ge495ov10558;
extern T0* ge495ov10535;
extern T0* ge495ov10536;
extern T0* ge495ov10533;
extern T0* ge495ov10532;
extern T0* ge91ov8398;
extern T0* ge206ov4018;
extern T0* ge204ov4040;
extern T0* ge203ov8944;
extern T0* ge1540ov6226;
extern T0* ge1540ov6227;
extern T0* ge1531ov7336;
extern T0* ge1531ov7338;
extern T0* ge1483ov5641;
extern T0* ge1464ov7048;
extern T0* ge1464ov7049;
extern T0* ge153ov4726;
extern T0* ge153ov4727;
extern T0* ge153ov4728;
extern T0* ge153ov4725;
extern T0* ge1531ov7335;
extern T0* ge1531ov7337;
extern T0* ge347ov2957;
extern T0* ge333ov2957;
extern T0* ge339ov2957;
extern T0* ge338ov2957;
extern T0* ge337ov2957;
extern T0* ge328ov2957;
extern T0* ge327ov2957;
extern T0* ge344ov2957;
extern T0* ge357ov2957;
extern T0* ge1384ov2957;
extern T0* ge1389ov2957;
extern void GE_const_init(void);
extern EIF_TYPE GE_types[];

#ifdef __cplusplus
}
#endif


/*
	description:

		"C functions used to implement class EXCEPTIONS"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2006-2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef EIF_EXCEPT_H
#define EIF_EXCEPT_H

#include <errno.h>

#ifdef __cplusplus
extern "C" {
#endif

extern void eraise(char* name, long code);
extern void esdie(int code);
extern EIF_REFERENCE eename(long except);
extern char* eeltag(void);
extern char* eelrout(void);
extern char* eelclass(void);
extern long eelcode(void);
extern EIF_REFERENCE stack_trace_string(void);
extern char* eeotag(void);
extern long eeocode(void);
extern char* eeorout(void);
extern char* eeoclass(void);
extern void eecatch(long code);
extern void eeignore(long code);
extern void eetrace(char b);

#ifdef EIF_WINDOWS
/* Needed to compile some code at AXAR */
extern void set_windows_exception_filter();
#endif

/* Raises an Eiffel exception of the given code with no associated tag. */
extern void xraise(int code);
/* Raise 'Operating system error' exception. */
extern void esys(void);
/* As a special case, an I/O error is raised when a system call which is I/O bound fails. */
extern void eise_io(char *tag);

/*
 * Predefined exception numbers. Value cannot start at 0 because this may need
 * a propagation via longjmp and USG implementations turn out a 0 to be 1.
 */
#define EN_VOID		1			/* Feature applied to void reference */
#define EN_MEM		2			/* No more memory */
#define EN_PRE		3			/* Pre-condition violated */
#define EN_POST		4			/* Post-condition violated */
#define EN_FLOAT	5			/* Floating point exception (signal SIGFPE) */
#define EN_CINV		6			/* Class invariant violated */
#define EN_CHECK	7			/* Assertion violated */
#define EN_FAIL		8			/* Routine failure */
#define EN_WHEN		9			/* Unmatched inspect value */
#define EN_VAR		10			/* Non-decreasing loop variant */
#define EN_LINV		11			/* Loop invariant violated */
#define EN_SIG		12			/* Operating system signal */
#define EN_BYE		13			/* Eiffel run-time panic */
#define EN_RESC		14			/* Exception in rescue clause */
#define EN_OMEM		15			/* Out of memory (cannot be ignored) */
#define EN_RES		16			/* Resumption failed (retry did not succeed) */
#define EN_CDEF		17			/* Create on deferred */
#define EN_EXT		18			/* External event */
#define EN_VEXP		19			/* Void assigned to expanded */
#define EN_HDLR		20			/* Exception in signal handler */
#define EN_IO		21			/* I/O error */
#define EN_SYS		22			/* Operating system error */
#define EN_RETR		23			/* Retrieval error */
#define EN_PROG		24			/* Developer exception */
#define EN_FATAL	25			/* Eiffel run-time fatal error */
#define EN_DOL		26			/* $ applied to melted feature */
#define EN_ISE_IO	27			/* I/O error raised by the ISE Eiffel runtime */
#define EN_COM		28			/* COM error raised by EiffelCOM runtime */
#define EN_RT_CHECK	29			/* Runtime check error such as out-of-bound array access */

#ifdef __cplusplus
}
#endif

#endif
/*
	description:

		"C functions used to implement class FILE"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2006-2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef EIF_FILE_H
#define EIF_FILE_H

#include <time.h>
#include <sys/stat.h>

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Create directory `dirname'.
 */
extern void file_mkdir(char* dirname);

/*
 * Rename file `from' into `to'.
 */
extern void file_rename(char* from, char* to);

/*
 * Link file `from' into `to'.
 */
extern void file_link(char *from, char *to);

/*
 * Delete file or directory `name'.
 */
extern void file_unlink(char *name);

/*
 * Open file `name' with the corresponding type `how'.
 */
extern EIF_POINTER file_open(char *name, int how);

/*
 * Open file `fd' with the corresponding type `how'.
 */
extern EIF_POINTER file_dopen(int fd, int how);

/*
 * Reopen file `name' with the corresponding type `how' and substitute that
 * to the old stream described by `old'. This is useful to redirect 'stdout'
 * to another place, for instance.
 */
extern EIF_POINTER file_reopen(char *name, int how, FILE *old);

/*
 * Close the file.
 */
extern void file_close(FILE *fp);

/*
 * Flush data held in stdio buffer.
 */
extern void file_flush(FILE *fp);

/*
 * Return the associated file descriptor.
 */
extern EIF_INTEGER file_fd(FILE *f);

/*
 * Get a character from `f'.
 */
extern EIF_CHARACTER file_gc(FILE *f);

/*
 * Get a string from `f' and fill it into `s' (at most `bound' characters),
 * with `start' being the amount of bytes already stored within s. This
 * means we really have to read (bound - start) characters.
 */
extern EIF_INTEGER file_gs(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start);

/*
 * Read min (bound, remaining bytes in file) characters into `s' and
 * return the number of characters read.
 */
extern EIF_INTEGER file_gss(FILE *f, char *s, EIF_INTEGER bound);

/*
 * Get a word from `f' and fill it into `s' (at most `bound' characters),
 * with `start' being the amount of bytes already stored within s. This
 * means we really have to read (bound - start) characters. Any leading
 * spaces are skipped.
 */
extern EIF_INTEGER file_gw(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start);

/*
 * Look ahead one character. If EOF, return 0.
 */
extern EIF_CHARACTER file_lh(FILE *f);

/*
 * Size of file `fp'.
 */
extern EIF_INTEGER eif_file_size(FILE *fp);

/*
 * Read upto next input line.
 */
extern void file_tnil(FILE *f);

/*
 * Current position within file.
 */
extern EIF_INTEGER file_tell(FILE *f);

/*
 * Touch file `name' by setting both access and modification time to the
 * current time stamp. This external function exists only because there
 * is no way within UNIX_FILE to get the current time stamp. Otherwise,
 * we could simply call file_utime.
 */
extern void file_touch(char *name);

/*
 * Modify the modification and/or the access time stored in the file's
 * inode. The 'how' parameter tells which attributes should be set.
 */
extern void file_utime(char *name, time_t stamp, int how);

/*
 * This is an encapsulation of the stat() system call. The routine either
 * succeeds and returns or fails and raises the appropriate exception.
 */
extern void file_stat(char *path, struct stat *buf);

/*
 * Change permissions of file `name', using an interface like chmod(1).
 * The flag is true if permissions are to be added, 0 to remove them.
 */
extern void file_perm(char *name, char *who, char *what, int flag);

/*
 * Change permission mode on file `path'.
 */
extern void file_chmod(char *path, int mode);

/*
 * Change the owner of the file to `uid'.
 */
extern void file_chown(char *name, int uid);

/*
 * Change the group of the file to `gid'.
 */
extern void file_chgrp(char *name, int gid);

/*
 * Put new_line onto `f'.
 */
extern void file_tnwl(FILE *f);

/*
 * Append a copy of `other' to `f'.
 */
extern void file_append(FILE *f, FILE *other, EIF_INTEGER l);

/*
 * Write string `str' on `f'.
 */
extern void file_ps(FILE *f, char *str, EIF_INTEGER len);

/*
 * Write character `c' on `f'.
 */
extern void file_pc(FILE *f, char c);

/*
 * Go to absolute position `pos' counted from start.
 */
extern void file_go(FILE *f, EIF_INTEGER pos);

/*
 * Go to absolute position `pos' counted from end.
 */
extern void file_recede(FILE *f, EIF_INTEGER pos);

/*
 * Go to absolute position `pos' counted from current position.
 */
extern void file_move(FILE *f, EIF_INTEGER pos);

/*
 * End of file.
 */
extern EIF_BOOLEAN file_feof(FILE *fp);

/*
 * Test whether file exists or not. If `name' represents a symbolic link,
 * it will check that pointed file does exist.
 */
extern EIF_BOOLEAN file_exists(char *name);

/*
 * Test whether file exists or not without following the symbolic link
 * if `name' represents one.
 */
extern EIF_BOOLEAN file_path_exists(char *name);

/*
 * Check whether access permission `op' are possible on file `name' using
 * real UID and real GID. This is probably only useful to setuid or setgid
 * programs.
 */
extern EIF_BOOLEAN file_access(char *name, EIF_INTEGER op);

/*
 * Check whether the file `path' may be created: we need write permissions
 * in the parent directory and there must not be any file bearing that name
 * with no write permissions...
 */
extern EIF_BOOLEAN file_creatable(char *path, EIF_INTEGER length);

/*
 * Get an integer from `f'.
 */
extern EIF_INTEGER file_gi(FILE *f);

/*
 * Get a real from `f'.
 */
extern EIF_REAL_32 file_gr(FILE *f);

/*
 * Get a double from `f'.
 */
extern EIF_REAL_64 file_gd(FILE *f);

/*
 * Write `number' on `f'.
 */
extern void file_pi(FILE *f, EIF_INTEGER number);

/*
 * Write `number' on `f'.
 */
extern void file_pr(FILE *f, EIF_REAL_32 number);

/*
 * Write double `val' onto `f'.
 */
extern void file_pd(FILE *f, EIF_REAL_64 val);

/*
 * Size of the stat structure. This is used by the Eiffel side to create
 * the area (special object) which will play the role of a stat buffer
 * structure.
 */
extern EIF_INTEGER stat_size(void);

/*
 * Check file permissions using effective UID and effective GID. The
 * current permission mode is held in the st_mode field of the stat()
 * buffer structure `buf'.
 */
extern EIF_BOOLEAN file_eaccess(struct stat *buf, int op);

/*
 * Perform the field dereferencing from the appropriate stat structure,
 * which Eiffel cannot do directly.
 */
extern EIF_INTEGER file_info(struct stat *buf, int op);

/*
 * Return the Eiffel string filled in with the name associated with `uid'
 * if found in /etc/passwd. Otherwise, return fill it in with the numeric
 * value.
 */
extern EIF_REFERENCE file_owner(int uid);

/*
 * Return the Eiffel string filled in with the name associated with `gid'
 * if found in /etc/group. Otherwise, return fill it in with the numeric
 * value.
 */
extern EIF_REFERENCE file_group(int gid);

/*
 * Get an integer from `f'.
 */
extern EIF_INTEGER file_gib(FILE* f);

/*
 * Get a real from `f'.
 */
extern EIF_REAL_32 file_grb(FILE* f);

/*
 * Get a double from `f'.
 */
extern EIF_REAL_64 file_gdb(FILE* f);

/*
 * Open file `name' with the corresponding type `how'.
 */
extern EIF_POINTER file_binary_open(char* name, int how);

/*
 * Open file `fd' with the corresponding type `how'.
 */
extern EIF_POINTER file_binary_dopen(int fd, int how);

/*
 * Reopen file `name' with the corresponding type `how' and substitute that
 * to the old stream described by `old'. This is useful to redirect 'stdout'
 * to another place, for instance.
 */
extern EIF_POINTER file_binary_reopen(char* name, int how, FILE* old);

/*
 * Write `number' on `f'.
 */
extern void file_pib(FILE* f, EIF_INTEGER number);

/*
 * Write `number' on `f'.
 */
extern void file_prb(FILE* f, EIF_REAL_32 number);

/*
 * Write double `val' onto `f'.
 */
extern void file_pdb(FILE* f, EIF_REAL_64 val);

#ifdef __cplusplus
}
#endif

#endif
/*
	description:

		"C functions used to implement class CONSOLE"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef EIF_CONSOLE_H
#define EIF_CONSOLE_H

#ifdef __cplusplus
extern "C" {
#endif

extern EIF_POINTER console_def(EIF_INTEGER file);
extern EIF_BOOLEAN console_eof(FILE* fp);
extern EIF_CHARACTER console_separator(FILE* f);
extern void console_ps(FILE* f, char* str, EIF_INTEGER len);
extern void console_pr(FILE* f, EIF_REAL_32 number);
extern void console_pc(FILE* f, EIF_CHARACTER c);
extern void console_pd(FILE* f, EIF_REAL_64 val);
extern void console_pi(FILE* f, EIF_INTEGER number);
extern void console_tnwl(FILE* f);
extern EIF_CHARACTER console_readchar(FILE* f);
extern EIF_REAL_32 console_readreal(FILE* f);
extern EIF_INTEGER console_readint(FILE* f);
extern EIF_REAL_64 console_readdouble(FILE* f);
extern EIF_INTEGER console_readword(FILE* f, char* s, EIF_INTEGER bound, EIF_INTEGER start);
extern EIF_INTEGER console_readline(FILE* f, char* s, EIF_INTEGER bound, EIF_INTEGER start);
extern void console_next_line(FILE* f);
extern EIF_INTEGER console_readstream(FILE* f, char* s, EIF_INTEGER bound);
extern void console_file_close (FILE* f);

#ifdef __cplusplus
}
#endif

#endif
/*
	description:

		"C functions used to implement class DIRECTORY"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef EIF_DIR_H
#define EIF_DIR_H

#ifdef __cplusplus
extern "C" {
#endif

extern void* dir_open (char* dirname);
extern EIF_REFERENCE dir_next (void* dir);
extern void dir_rewind (void* dir);
extern void dir_close (void* dir);
extern EIF_BOOLEAN eif_dir_exists (char* dirname);
extern EIF_BOOLEAN eif_dir_is_readable (char* dirname);
extern EIF_BOOLEAN eif_dir_is_writable (char* dirname);
extern EIF_BOOLEAN eif_dir_is_executable (char* dirname);
extern void eif_dir_delete (char* dirname);
extern EIF_CHARACTER eif_dir_separator(void);
extern EIF_REFERENCE dir_current(void);
extern EIF_INTEGER eif_chdir(char* path);

#ifdef __cplusplus
}
#endif

#endif
/*
	description:

		"C functions used to access DLLs"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef GE_DLL_H
#define GE_DLL_H

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_WINDOWS

#include <windows.h>

/* DLL declarations */
#define GE_load_dll(name) LoadLibraryA((LPCSTR)name)

#endif

#ifdef __cplusplus
}
#endif

#endif
/*
	description:

		"C functions used to implement class EXECUTION_ENVIRONMENT"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2006-2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef EIF_MISC_H
#define EIF_MISC_H

#ifdef __cplusplus
extern "C" {
#endif

extern EIF_INTEGER eif_system(char* s);
extern void eif_system_asynchronous(char* cmd);
extern void eif_sleep(EIF_INTEGER_64);

#ifdef EIF_WINDOWS
/* DLL declarations */
#define eif_load_dll(name) GE_load_dll(name)
#endif

#ifdef __cplusplus
}
#endif

#endif
/*
	description:

		"C functions used to implement class PATH_NAME"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef EIF_PATH_NAME_H
#define EIF_PATH_NAME_H

#ifdef __cplusplus
extern "C" {
#endif

extern EIF_BOOLEAN eif_is_volume_name_valid(EIF_CHARACTER* p);
extern EIF_BOOLEAN eif_is_directory_name_valid(EIF_CHARACTER* p);
extern void eif_append_directory(EIF_REFERENCE string, EIF_CHARACTER* p, EIF_CHARACTER* v);
extern void eif_set_directory(EIF_REFERENCE string, EIF_CHARACTER* p, EIF_CHARACTER* v);
extern EIF_BOOLEAN eif_path_name_compare(EIF_CHARACTER* s, EIF_CHARACTER* t, EIF_INTEGER length);
extern EIF_REFERENCE eif_volume_name(EIF_CHARACTER* p);
extern EIF_REFERENCE eif_extracted_paths(EIF_CHARACTER* p);
extern void eif_append_file_name(EIF_REFERENCE string, EIF_CHARACTER* p, EIF_CHARACTER* v);
extern EIF_BOOLEAN eif_is_file_name_valid(EIF_CHARACTER* p);
extern EIF_BOOLEAN eif_is_extension_valid(EIF_CHARACTER* p);
extern EIF_BOOLEAN eif_is_file_valid(EIF_CHARACTER* p);
extern EIF_BOOLEAN eif_is_directory_valid(EIF_CHARACTER* p);
extern EIF_BOOLEAN eif_home_dir_supported(void);
extern EIF_BOOLEAN eif_root_dir_supported(void);
extern EIF_BOOLEAN eif_case_sensitive_path_names(void);
extern EIF_REFERENCE eif_current_dir_representation(void);
extern EIF_REFERENCE eif_home_directory_name(void);
extern EIF_REFERENCE eif_root_directory_name(void);

#ifdef __cplusplus
}
#endif

#endif
/*
	description:

		"C functions used to implement the main function"

	system: "Gobo Eiffel Compiler"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
*/

#ifndef EIF_MAIN_H
#define EIF_MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_WINDOWS

#include <windows.h>

/*
	Used in WEL.
*/
extern HINSTANCE eif_hInstance;

#endif

/*
	Used by the ISE runtime to figure out whether the application
	was launched from EiffelStudio in workbench mode or not.
*/
extern int debug_mode;

#ifdef __cplusplus
}
#endif

#endif
#include <string.h>
#include <stdlib.h>
