
// Memory related macros

#define ewg_reference_of(arg) &(arg)

#define ewg_contents_of(arg) *(arg)

#define ewg_read_pointer(a_pointer,a_pos) *(void**)((int)a_pointer + a_pos)

#define ewg_put_pointer(a_pointer,a_value,a_pos) *(void**)((int)a_pointer + a_pos) = a_value
