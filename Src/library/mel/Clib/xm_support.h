#include <Xm/Text.h>
#include <Xm/List.h>
#include <Xm/Protocols.h>
#include "mel.h"

/*
 * Xm functions for Text
 */	

extern EIF_INTEGER xm_text_get_begin_of_selection (EIF_POINTER w);
extern EIF_INTEGER xm_text_get_end_of_selection (EIF_POINTER w);
extern EIF_BOOLEAN xm_text_is_selection_active (EIF_POINTER w);
extern EIF_INTEGER xm_text_x_coord (EIF_POINTER widget, EIF_INTEGER pos);
extern EIF_INTEGER xm_text_y_coord (EIF_POINTER widget, EIF_INTEGER pos);
EIF_INTEGER xm_text_find_string (EIF_POINTER widget, EIF_INTEGER pos, char *pattern);


/*
 * Xm functions for List
 */	

extern void free_xm_string_table (EIF_POINTER list, EIF_INTEGER count);
extern EIF_POINTER get_xm_string_table (EIF_POINTER w, char *res);
extern EIF_POINTER create_xm_string_table (EIF_INTEGER count);
extern void xm_list_put (EIF_POINTER xm_string_table, EIF_POINTER xm_string, EIF_INTEGER i);
extern EIF_INTEGER xm_list_index_of (EIF_POINTER list, EIF_POINTER xm_string, EIF_INTEGER pos);
extern EIF_POINTER xm_list_get_selected_pos (EIF_POINTER w);
extern EIF_INTEGER xm_list_get_i_int_table (EIF_POINTER table, EIF_INTEGER num);
extern EIF_INTEGER xm_list_item_pos_from (EIF_POINTER list, EIF_POINTER xm_string, EIF_INTEGER pos);


/*
 * Xm protocols
 */	

extern void xm_add_wm_protocol (EIF_POINTER shell, EIF_POINTER an_atom);
extern void xm_font_list_entry_free (EIF_POINTER an_entry);
extern void c_xm_set_focus (EIF_POINTER my_widget);
