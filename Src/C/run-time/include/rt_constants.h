/*
	description: "Constants used in global variable definitions."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _rt_constants_h_
#define _rt_constants_h_

#include <signal.h>

#ifdef __cplusplus
extern "C" {
#endif

	/*----------------*/
	/*  eif_memory.h  */
	/*----------------*/
#define CLSC_PER	20

/*
 * Garbage collector's statistics
 */
#define GST_NBR		2				/* Number of distinct algorithms */
#define GST_PART	0				/* Index for partial collection stats
*/
#define GST_GEN		1				/* Index for generation collection
stats */
#define	EIF_REFERENCE_BITS	2		/* To divide by sizeof(EIF_REFERENCE). 
								     * Do >> EIF_REFERENCE_BITS instead. 
									 * FIXME: is 3 in 64 bits platforms. */

#define AGE_BITS	4		/* Number of bits to represents the age. */
#define TENURE_MAX	(1<<AGE_BITS)	/* Non reached age */


	/*---------*/
	/* debug.c */
	/*---------*/
#ifdef WORKBENCH
#define BP_TABLE_SIZE 1024 /* size of the hash table used to store enabled breakpoints */
#endif

	/*--------*/
	/* file.c */
	/*--------*/
#define FILE_TYPE_MAX 4		/* max size of fopen type string (like "a+b") */


#ifdef __cplusplus
}
#endif

#endif	/* _eif_constants_h_ */
