/* externals from buffer.e */
#include "eiffel.h"

extern EIF_POINTER MICO_buffer_init (EIF_INTEGER);
extern void        MICO_buffer_delete (EIF_POINTER);
extern void        MICO_reset (EIF_POINTER, EIF_INTEGER);
extern EIF_BOOLEAN MICO_resize (EIF_POINTER, EIF_INTEGER);
extern EIF_BOOLEAN MICO_ralign (EIF_POINTER, EIF_INTEGER);
extern void        MICO_walign (EIF_POINTER, EIF_INTEGER);
extern void        MICO_set_ralign_base (EIF_POINTER, EIF_INTEGER);
extern void        MICO_set_walign_base (EIF_POINTER, EIF_INTEGER);
extern void        MICO_replace_one_octet (EIF_POINTER, EIF_INTEGER);
extern void        MICO_put_short (EIF_POINTER, EIF_INTEGER);
extern void        MICO_put_ushort (EIF_POINTER, EIF_INTEGER);
extern void        MICO_put_long (EIF_POINTER, EIF_INTEGER);
extern void        MICO_put_ulong (EIF_POINTER, EIF_INTEGER);
extern void        MICO_put_float (EIF_POINTER, EIF_DOUBLE);
extern void        MICO_put_double (EIF_POINTER, EIF_DOUBLE);
extern void        MICO_put_char (EIF_POINTER, EIF_CHARACTER);
extern void        MICO_put_wchar (EIF_POINTER, EIF_CHARACTER);
extern void        MICO_put_boolean (EIF_POINTER, EIF_BOOLEAN);
extern void        MICO_put_string (EIF_POINTER, EIF_POINTER, EIF_INTEGER);
extern void        MICO_put_one_octet (EIF_POINTER, EIF_INTEGER);
extern EIF_INTEGER MICO_peek (EIF_POINTER, EIF_POINTER, EIF_INTEGER);
extern EIF_BOOLEAN MICO_peek_one_octet (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get_short (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get_ushort (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get_long (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get_ulong (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get_float (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get_double (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get_char (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get_wchar (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get_boolean (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get_string (EIF_POINTER, EIF_POINTER, EIF_INTEGER);
extern EIF_BOOLEAN MICO_get2 (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get4 (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get8 (EIF_POINTER, EIF_POINTER);
extern EIF_BOOLEAN MICO_get16 (EIF_POINTER, EIF_POINTER);
extern void        MICO_replace (EIF_POINTER, EIF_POINTER, EIF_INTEGER);
extern void        MICO_put1 (EIF_POINTER, EIF_POINTER);
extern void        MICO_put2 (EIF_POINTER, EIF_POINTER);
extern void        MICO_put4 (EIF_POINTER, EIF_POINTER);
extern void        MICO_put8 (EIF_POINTER, EIF_POINTER);
extern void        MICO_put16 (EIF_POINTER, EIF_POINTER);
extern void        MICO_free_charbuf (void);
extern EIF_INTEGER MICO_length_unread (EIF_POINTER);
extern EIF_INTEGER MICO_rpos (EIF_POINTER);
extern EIF_INTEGER MICO_wpos (EIF_POINTER);
extern EIF_INTEGER MICO_ralign_base (EIF_POINTER);
extern EIF_INTEGER MICO_walign_base (EIF_POINTER);
extern EIF_BOOLEAN MICO_rseek_beg (EIF_POINTER, EIF_INTEGER);
extern EIF_BOOLEAN MICO_rseek_rel (EIF_POINTER, EIF_INTEGER);
extern void        MICO_wseek_beg (EIF_POINTER, EIF_INTEGER);
extern void        MICO_wseek_rel (EIF_POINTER, EIF_INTEGER);

/********* Needed by Encoder, Decoder, Typecode, IOR  **********************************/

extern EIF_INTEGER   CORBA_byteorder (void);
extern EIF_CHARACTER CORBA_int2character (EIF_INTEGER);

extern EIF_INTEGER MICO_int2char (EIF_INTEGER);
extern EIF_POINTER MICO_to_hex (EIF_INTEGER);
extern EIF_POINTER MICO_to_octal (EIF_INTEGER);
extern EIF_INTEGER MICO_from_hex (EIF_CHARACTER, EIF_CHARACTER);
extern EIF_INTEGER MICO_sizeof_long (void);
extern EIF_INTEGER MICO_sizeof_ulong (void);
extern EIF_INTEGER MICO_swap2 (EIF_INTEGER);
extern EIF_INTEGER MICO_swap4 (EIF_INTEGER);
extern EIF_INTEGER MICO_swap8 (EIF_INTEGER);
extern EIF_INTEGER MICO_swap16 (EIF_INTEGER);
extern EIF_BOOLEAN MICO_have_ieee_fp (void);
extern EIF_DOUBLE  MICO_swap4_fp (EIF_DOUBLE);
extern EIF_DOUBLE  MICO_swap8_fp (EIF_DOUBLE);

/************************ Needed by transport.c **************/

extern char* BUFFER_inbuf (EIF_POINTER);
extern char* BUFFER_outbuf (EIF_POINTER);



