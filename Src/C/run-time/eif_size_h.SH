case $CONFIG in
'')
	if test ! -f config.sh; then
		ln ../config.sh . || \
		ln ../../config.sh . || \
		ln ../../../config.sh . || \
		(echo "Can't find config.sh."; exit 1)
	fi 2>/dev/null
	. config.sh
	;;
esac
case "$0" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
echo "Extracting src/run-time/eif_size.h (with variable substitutions)"
$spitshell >eif_size.h <<!GROK!THIS!
/*
	description: "Platform specific sizes of basic elements."
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

#ifndef _size_h_
#define _size_h_

#include "eif_portable.h"

/* Basic sizes */
#define ALIGN	$alignbytes		/* Alignment restrictions */
#define R64SIZ	$doublesize		/* Size of double */
#define I64SIZ	$integer_64_size	/* Size of integer 64 bits */
#define R32SIZ	$floatsize		/* Size of float */
#define REFSIZ	$ptrsize		/* Size of char * */
/* Should be \$longsize but for now it is 32 bits only. */
#define LNGSIZ	$integer_32_size	/* Size of long */
#define I16SIZ	$integer_16_size	/* Size of integer 16 bits */
#define CHRSIZ	$charsize		/* Size of char */
#define PTRSIZ	$ptrsize		/* Size of a function pointer: FIXME */
#define BYTSIZ	$bitpbyte		/* Size of a byte, in bits */
#define BITLONG (BYTSIZ * LNGSIZ) /* Number of bits in a long */
#define LNGPAD_2 $lngpad_2	/* equivalent to LNGPAD(2) */
!GROK!THIS!

: In the following dollars and backticks do not need the extra backslash.
$spitshell >>eif_size.h <<'!NO!SUBS!'

/* Bits are stored in unsigned 32 bits integer, and padding occurs if needed.
 * This means some garbage bits may be found at the end of the bit field.
 * BIT_NBPACK computes the number of 'uint32' fields (bit units) needed to
 * store a given amount of bits.
 */
#define BIT_PACKSIZE    sizeof(uint32)	/* Size of a bit unit in bytes */
#define BIT_UNIT		(sizeof(uint32) * BYTSIZ)		/* Size of a bit unit in bits */
#define BIT_NBPACK(s)	(((s) / BIT_UNIT) + (((s) % BIT_UNIT) ? 1 : 0))
#define BITACS(n)		((1 + BIT_NBPACK((n)))*BIT_PACKSIZE)
#define BITOFF(n)		(((BITACS(n)/ALIGN)+((BITACS(n)%ALIGN)?1:0))*ALIGN)

#define REFPAD(n) (((((n)*REFSIZ)/ALIGN)+((((n)*REFSIZ)%ALIGN)?1:0))*ALIGN)
#define CHRPAD(n) (((((n)*CHRSIZ)/ALIGN)+((((n)*CHRSIZ)%ALIGN)?1:0))*ALIGN)
#define I16PAD(n) (((((n)*I16SIZ)/ALIGN)+((((n)*I16SIZ)%ALIGN)?1:0))*ALIGN)
#define LNGPAD(n) (((((n)*LNGSIZ)/ALIGN)+((((n)*LNGSIZ)%ALIGN)?1:0))*ALIGN)
#define R32PAD(n) (((((n)*R32SIZ)/ALIGN)+((((n)*R32SIZ)%ALIGN)?1:0))*ALIGN)
#define I64PAD(n) (((((n)*I64SIZ)/ALIGN)+((((n)*I64SIZ)%ALIGN)?1:0))*ALIGN)
#define R64PAD(n) (((((n)*R64SIZ)/ALIGN)+((((n)*R64SIZ)%ALIGN)?1:0))*ALIGN)
#define PTRPAD(n) (((((n)*PTRSIZ)/ALIGN)+((((n)*PTRSIZ)%ALIGN)?1:0))*ALIGN)

	/* Macros used to access fields in the object */
#define REFACS(n) ((n)*REFSIZ)
#define CHRACS(n) ((n)*CHRSIZ)
#define I16ACS(n) ((n)*I16SIZ)
#define LNGACS(n) ((n)*LNGSIZ)
#define R32ACS(n) ((n)*R32SIZ)
#define I64ACS(n) ((n)*I64SIZ)
#define R64ACS(n) ((n)*R64SIZ)
#define PTRACS(n) ((n)*PTRSIZ)

#endif
!NO!SUBS!
chmod 755 eif_size.h
$eunicefix eif_size.h
