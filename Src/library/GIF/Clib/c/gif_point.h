#include <gd.h>

#define c_get_width(_ptr_) ((EIF_INTEGER) ((gdImagePtr)_ptr_)->sx)
#define c_get_height(_ptr_) ((EIF_INTEGER) ((gdImagePtr)_ptr_)->sy)
#define c_point_get_y(_ptr_) ((EIF_INTEGER) ((gdPointPtr)_ptr_)->y)
#define c_point_get_x(_ptr_) ((EIF_INTEGER) ((gdPointPtr)_ptr_)->x)
#define c_point_set_y(_ptr_,_i_) ((((gdPointPtr)_ptr_)->y)=(int)_i_)
#define c_point_set_x(_ptr_,_i_) ((((gdPointPtr)_ptr_)->x)=(int)_i_)

