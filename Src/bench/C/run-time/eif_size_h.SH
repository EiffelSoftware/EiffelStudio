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

  ####      #    ######  ######          #    #
 #          #        #   #               #    #
  ####      #       #    #####           ######
      #     #      #     #        ###    #    #
 #    #     #     #      #        ###    #    #
  ####      #    ######  ######   ###    #    #

	Size of basic types and access macros.
*/

#ifndef _size_h_
#define _size_h_

#include "eif_portable.h"

/* Basic sizes */
#define ALIGN	$alignbytes		/* Alignment restrictions */
#define DBLSIZ	$doublesize		/* Size of double */
#define I64SIZ	$integer_64_size	/* Size of integer 64 bits */
#define FLTSIZ	$floatsize		/* Size of float */
#define REFSIZ	$ptrsize		/* Size of char * */
#define LNGSIZ	$longsize		/* Size of long */
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
#define FLTPAD(n) (((((n)*FLTSIZ)/ALIGN)+((((n)*FLTSIZ)%ALIGN)?1:0))*ALIGN)
#define I64PAD(n) (((((n)*I64SIZ)/ALIGN)+((((n)*I64SIZ)%ALIGN)?1:0))*ALIGN)
#define DBLPAD(n) (((((n)*DBLSIZ)/ALIGN)+((((n)*DBLSIZ)%ALIGN)?1:0))*ALIGN)
#define PTRPAD(n) (((((n)*PTRSIZ)/ALIGN)+((((n)*PTRSIZ)%ALIGN)?1:0))*ALIGN)

	/* Macros used to access fields in the object */
#define REFACS(n) ((n)*REFSIZ)
#define CHRACS(n) ((n)*CHRSIZ)
#define I16ACS(n) ((n)*I16SIZ)
#define LNGACS(n) ((n)*LNGSIZ)
#define FLTACS(n) ((n)*FLTSIZ)
#define I64ACS(n) ((n)*I64SIZ)
#define DBLACS(n) ((n)*DBLSIZ)
#define PTRACS(n) ((n)*PTRSIZ)

#endif
!NO!SUBS!
chmod 755 eif_size.h
$eunicefix eif_size.h
