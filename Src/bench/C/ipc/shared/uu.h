/*
	UU.H - uuencode_str and uudecode_str prototypes.
*/

#ifndef uu_h_
#define uu_h_

extern int uuencode_buffer_size (int);
extern char *uuencode_str (char *, int);
extern char *uudecode_str (char*);

void eraise (char*, long);

#endif
