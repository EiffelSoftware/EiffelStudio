#include "xpm.h"

/*
 * Constants used to code errors when allocating colors.
 */

#define BAD_SCREEN_REFERENCE	-1
#define BAD_COLOR_NAME			-2
#define NO_FREE_CELL_AVAILABLE  -3

/*
 * Variable used to store error status
 */

extern EIF_INTEGER last_color_alloc_status;

/*
 * Macros to access/set values in XpmAttributes structures.
 */
#define set_xpm_attributes_valuemask(_ptr_, _valuemask_) \
		(((XpmAttributes *)_ptr_)->valuemask = _valuemask_)

#define set_xpm_attributes_alloc_close_colors(_ptr_, _cmode_) \
		(((XpmAttributes *)_ptr_)->alloc_close_colors = (Bool) (_cmode_!=0))
	
#define set_xpm_attributes_colors_closeness(_ptr_, _degree_) \
		(((XpmAttributes *)_ptr_)->closeness = _degree_)

#define set_xpm_attributes_red_closeness(_ptr_, _degree_) \
		(((XpmAttributes *)_ptr_)->red_closeness = _degree_) 
	
#define set_xpm_attributes_blue_closeness(_ptr_, _degree_) \
		(((XpmAttributes *)_ptr_)->blue_closeness = _degree_) 

#define set_xpm_attributes_green_closeness(_ptr_, _degree_) \
		(((XpmAttributes *)_ptr_)->green_closeness = _degree_) 

#define set_xpm_attributes_exactcolors(_ptr_, _cmode_) \
		(((XpmAttributes *)_ptr_)->exactColors = (Bool) (_cmode_!=0))
	
#define xpm_attributes_value_mask(_ptr_) (_ptr_)->valuemask
#define xpm_attributes_height(_ptr_) (_ptr_)->height
#define xpm_attributes_width(_ptr_) (_ptr_)->width
#define xpm_attributes_x_hotspot(_ptr_) (_ptr_)->x_hotspot
#define xpm_attributes_y_hotspot(_ptr_) (_ptr_)->y_hotspot
#define xpm_attributes_colormap(_ptr_) (_ptr_)->colormap
#define xpm_attributes_ncolors(_ptr_) (_ptr_)->ncolors
#define xpm_attributes_red_closeness(_ptr_) (_ptr_)->red_closeness
#define xpm_attributes_blue_closeness(_ptr_) (_ptr_)->blue_closeness
#define xpm_attributes_green_closeness(_ptr_) (_ptr_)->green_closeness
#define xpm_attributes_alloc_close_colors(_ptr_) (Bool) ((_ptr_)->alloc_close_colors) == True ? 1 : 0
	


