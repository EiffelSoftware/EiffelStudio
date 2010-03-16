/*
 *
 * These are macros for retrieving values of the font structures.
 *
 */ 

#include "mel.h"

#define mel_font_descent(_ptr_) (_ptr_)->descent
#define mel_font_ascent(_ptr_) (_ptr_)->ascent
#define mel_font_id(_ptr_) (_ptr_)->fid
#define mel_font_list_name(_ptr_, pos) (*(_ptr_ + (pos - 1)))

extern EIF_POINTER x_build_font_from_set (EIF_POINTER);
