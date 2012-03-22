/*
 *
 * These are macros for retrieving values of the callback structures.
 *
 */ 

#include "mel.h"

	/*
	 * Allows or forbids the cursor to move or the text to be modified
	 * during a `motion' or a `modify' action.
	 */
#define c_text_set_do_it(b, _ptr_) ((b) ? \
			(((XmTextVerifyCallbackStruct *) _ptr_)->doit = True) : \
			(((XmTextVerifyCallbackStruct *) _ptr_)->doit = False))
#define c_text_wcs_set_do_it(b, _ptr_) ((b) ? \
			(((XmTextVerifyCallbackStructWcs *) _ptr_)->doit = True) : \
			(((XmTextVerifyCallbackStructWcs *) _ptr_)->doit = False))

	/* General */

#define c_reason(_ptr_) (_ptr_)->reason
#define c_event(_ptr_) (_ptr_)->event

	/* XmArrowButtonCallbackStruct */
	/* XmPushButtonCallbackStruct */
	/* XmDrawnButtonCallbackStruct */

#define c_click_count(_ptr_) (_ptr_)->click_count

	/* XmDrawnButtonCallbackStruct */
	/* XmDrawingAreaCallbackStruct */

#define c_window(_ptr_) (_ptr_)->window

	/* XmCommandCallbackStruct */
	/* XmFileSelectionBoxCallbackStruct */
	/* XmScaleCallbackStruct */
	/* XmScrollBarCallbackStruct */
	/* XmSelectionBoxCallbackStruct */

#define c_value(_ptr_) (_ptr_)->value

	/* XmCommandCallbackStruct */
	/* XmFileSelectionBoxCallbackStruct */
	/* XmSelectionBoxCallbackStruct */

#define c_length(_ptr_) (_ptr_)->length

	/* XmFileSelectionBoxCallbackStruct */

#define c_mask(_ptr_) (_ptr_)->mask
#define c_mask_length(_ptr_) (_ptr_)->mask_length
#define c_dir(_ptr_) (_ptr_)->dir
#define c_dir_length(_ptr_) (_ptr_)->dir_length
#define c_pattern(_ptr_) (_ptr_)->pattern
#define c_pattern_length(_ptr_) (_ptr_)->pattern_length

	/* XmListCallbackStruct */

#define c_item(_ptr_) (_ptr_)->item
#define c_item_length(_ptr_) (_ptr_)->item_length
#define c_item_position(_ptr_) (_ptr_)->item_position
#define c_selected_items(_ptr_) (_ptr_)->selected_items
#define c_selected_item_count(_ptr_) (_ptr_)->selected_item_count
#define c_selected_item_positions(_ptr_) (_ptr_)->selected_item_positions
#define c_selection_type(_ptr_) (_ptr_)->selection_type

	/* XmRowColumnCallbackStruct */

#define c_widget(_ptr_) (_ptr_)->widget
#define c_mdata(_ptr_) (_ptr_)->data
#define c_callback_struct(_ptr_) (_ptr_)->callbackstruct

	/* XmScrollBarCallbackStruct */

#define c_pixel(_ptr_) (_ptr_)->pixel


	/* XmTraverseObscuredCallbackStruct */

#define c_traversal_destination(_ptr_) (_ptr_)->traversal_destination
#define c_direction(_ptr_) (_ptr_)->direction

	/* XmTextVerifyCallbackStruct */
	/* XmTextVerifyCallbackStructWcs */

#define c_doit(_ptr_) (_ptr_)->doit
#define c_current_insert(_ptr_) (_ptr_)->currInsert
#define c_new_insert(_ptr_) (_ptr_)->newInsert
#define c_start_pos(_ptr_) (_ptr_)->startPos
#define c_end_pos(_ptr_) (_ptr_)->endPos
#define c_text(_ptr_) (_ptr_)->text
#define c_text_length(_ptr_) (_ptr_)->length
#define c_text_ptr(_ptr_) (_ptr_)->ptr
#define c_text_wcsptr(_ptr_) (_ptr_)->wcsptr

	/* XmToggleButtonCallbackStruct */

#define c_set(_ptr_) (_ptr_)->set
