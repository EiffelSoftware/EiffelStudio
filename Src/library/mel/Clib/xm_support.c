#include <Xm/Text.h>
#include <Xm/List.h>
#include <Xm/Protocols.h>
#include "mel.h"

/*
 * Xm functions for Text
 */	

EIF_INTEGER xm_text_get_begin_of_selection (w)
EIF_POINTER w;
{
	XmTextPosition begin, end;

	XmTextGetSelectionPosition ((Widget) w, &begin, &end);
 	return (EIF_INTEGER) begin;
}

EIF_INTEGER xm_text_get_end_of_selection (w)
EIF_POINTER w;
{
	XmTextPosition begin, end;

	XmTextGetSelectionPosition ((Widget) w, &begin, &end);
 	return (EIF_INTEGER) end;
}

EIF_BOOLEAN xm_text_is_selection_active (w)
EIF_POINTER w;
{
	XmTextPosition begin, end;
	Boolean state;

	state = XmTextGetSelectionPosition ((Widget) w, &begin, &end);
	return (EIF_BOOLEAN) ((state == True) && (begin < end));
}

EIF_INTEGER xm_text_x_coord (widget, pos)
EIF_POINTER widget;
EIF_INTEGER pos;
{
	/* X coordinate relative to the upper left corner
	 * of the text widget
	 */
	Position x0, y0;

	XmTextPosToXY ((Widget) widget, (XmTextPosition) pos, &x0, &y0);
	return (EIF_INTEGER) x0;
}

EIF_INTEGER xm_text_y_coord (widget, pos)
EIF_POINTER widget;
EIF_INTEGER pos;
{
	/* Y coordinate relative to the upper left corner
	 * of the text widget
	 */

	Position x0, y0;

	XmTextPosToXY ((Widget) widget, (XmTextPosition) pos, &x0, &y0);
	return (EIF_INTEGER) y0;
}

/*
 * Xm functions for List
 */	

void free_xm_string_table (list, count)
EIF_POINTER list;
EIF_INTEGER count;
{
	/* 
	 * Frees the XmStringTable and its contents
	 */

	int i;

	for (i = 0; i < (int) count; i++)
		XmStringFree (((XmString *)list) [i]);
	XtFree ((char *) list);
}

EIF_POINTER get_xm_string_table (w, res)
EIF_POINTER w;
char *res;
{
	/* 
	 * Retrieve the XmStringTable.
	 * Remember it is a pointer to the structure thus
	 * its contents should not be freed.
	 */

	XmStringTable a_string_table;

	XtVaGetValues ((Widget) w,(String) res, &a_string_table, NULL);
	return (EIF_POINTER) a_string_table;
}

EIF_POINTER create_xm_string_table (count)
EIF_INTEGER count;
{
	/*
	 * Create a XmStringTable with size `count'
	 */
	return (EIF_POINTER) cmalloc ((int) count*sizeof (XmString));
}

void xm_list_put (xm_string_table, xm_string, i)
EIF_POINTER xm_string_table;
EIF_POINTER xm_string;
EIF_INTEGER i;
{
	/*
	 * Add a motif string at position `i'.
	 */
	((XmString *) xm_string_table) [(int) i-1] = (XmString) xm_string;
}

EIF_INTEGER xm_list_index_of (list, xm_string, pos)
EIF_POINTER list;
EIF_POINTER xm_string;
EIF_INTEGER pos;
{
	int *position_list;
	int position_count;
	int result = 0;

	if (XmListGetMatchPos ((Widget) list, (XmString) xm_string, 
			&position_list, &position_count)) {
		if (position_count >= (int) pos) 
			result = *(position_list += ((int) pos-1));
		XtFree ((char *) position_list);
		}
	return (EIF_INTEGER) result;
}

EIF_POINTER xm_list_get_selected_pos (w)
EIF_POINTER w;
{
		/*
		 * Return a table of integers of positions
		 */

	int *table;
	int count;
	int temp;

	XmListGetSelectedPos ((Widget) w, &table, &count);
	temp = (int) table [0];
	return (EIF_POINTER) table;
}

EIF_INTEGER xm_list_get_i_int_table (table, num)
EIF_POINTER table;
EIF_INTEGER num;
{
		/*
		 * Get the `num' entry in integer `table'
		 */
	int temp;
	temp = (int) ((int *) table)[((int) num)-1];
	return (EIF_INTEGER) (((int *) table) [((int) num)-1]);
}

EIF_INTEGER xm_list_item_pos_from (list, xm_string, pos)
EIF_POINTER list;
EIF_POINTER xm_string;
EIF_INTEGER pos;
{
	EIF_INTEGER result = 0;
	int *position_list;
	int position_count;

	if (XmListGetMatchPos ((Widget) list, (XmString) xm_string, 
			&position_list, &position_count)) {
		for (; (*position_list < (int) pos) && (position_count>0);
			position_list++, position_count--);
		if (position_count) result = *position_list;
	}
	return (EIF_INTEGER) result;
}


/*
 * Xm protocols
 */	

void xm_add_wm_protocol (shell, an_atom)
EIF_POINTER shell;
EIF_POINTER an_atom;
{
		/*
		 * Add protocol atom `an_atom'
		 */
	Atom atom = (Atom) an_atom;
	XmAddWMProtocols ((Widget) shell, &atom, 1);
}

void xm_text_set_do_it (event_ptr, b)
EIF_POINTER event_ptr;
EIF_BOOLEAN b;
{
	/*
	 * Allows or forbids the cursor to move or the text to be modified
	 * during a `motion' or a `modify' action.
	*/
	if (b) 
		((XmTextVerifyCallbackStruct *) event_ptr)->doit = True;
	else ((XmTextVerifyCallbackStruct *) event_ptr)->doit = False;
}

void xm_text_wcs_set_do_it (event_ptr, b)
EIF_POINTER event_ptr;
EIF_BOOLEAN b;
{
	/*
	 * Allows or forbids the cursor to move or the text to be modified
	 * during a `motion' or a `modify' action.
	 */
	if (b) 
		((XmTextVerifyCallbackStructWcs *) event_ptr)->doit = True;
	else ((XmTextVerifyCallbackStructWcs *) event_ptr)->doit = False;
}

void xm_font_list_entry_free (an_entry)
EIF_POINTER an_entry;
{
	/*
	 * Free the address of font list entry
	 */

	XmFontListEntry xm_entry = (XmFontListEntry) an_entry;
	XmFontListEntryFree (&xm_entry);
}
