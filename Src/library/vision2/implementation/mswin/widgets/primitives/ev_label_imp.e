indexing
	description: "EiffelVision label widget. Displays a single line of text.%
		%Mswindows implementation";
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LABEL_IMP

inherit
	EV_LABEL_I
		redefine
			interface
		select
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			set_default_minimum_size,
			interface,
			initialize
		end

	EV_INTERNALLY_PROCESSED_TEXTABLE_IMP
		undefine
			set_default_minimum_size
		redefine
			align_text_center,
			align_text_left,
			align_text_right,
			interface,
			set_text,
			remove_text
		end

	EV_FONTABLE_IMP
		rename
			interface as ev_fontable_imp_interface
		redefine
			set_font
		end

	EV_WEL_STATIC_OWNERDRAW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			shown as is_displayed,
			set_font as wel_set_font,
			destroy as wel_destroy,
			width as wel_width,
			height as wel_height,
			enabled as is_sensitive,
			item as wel_item,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			text as wel_text,
			set_text as wel_set_text,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_key_up,
			on_key_down,
			on_set_cursor,
			on_char,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			wel_background_color,
			wel_foreground_color,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			default_style
		end
		
	WEL_ODS_CONSTANTS
		export
			{NONE} all
		end

	WEL_DT_CONSTANTS
		export
			{NONE} all
		end
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
			text_alignment := text_alignment_center
		end

	initialize is
			-- Initialize `Current'.
		do
			set_default_font
			Precursor {EV_PRIMITIVE_IMP}
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			accomodate_text (a_text)
			Precursor {EV_INTERNALLY_PROCESSED_TEXTABLE_IMP} (a_text)
			invalidate
		end

	set_font (ft: EV_FONT) is
			-- Make `ft' new font of `Current'.
		do
			Precursor {EV_FONTABLE_IMP} (ft)
			if text /= Void then
				accomodate_text (text)
			end
			invalidate
		end

	remove_text is
			-- Make `text' `Void'.
		do
			set_default_minimum_size
			Precursor {EV_INTERNALLY_PROCESSED_TEXTABLE_IMP}
			invalidate
		end

feature -- Status setting

	align_text_center is
			-- Set text alignment of current label to center.
		do
			Precursor {EV_INTERNALLY_PROCESSED_TEXTABLE_IMP}
			invalidate
		end

	align_text_right is
			-- Set text alignment of current label to right.
		do
			Precursor {EV_INTERNALLY_PROCESSED_TEXTABLE_IMP}
			invalidate
		end

	align_text_left is
			-- Set text alignment of current label to left.
		do
			Precursor {EV_INTERNALLY_PROCESSED_TEXTABLE_IMP}
			invalidate
		end

feature {EV_ANY_I} -- Initialization

	set_default_minimum_size is
			-- Resize to a default size.
		do
			accomodate_text (" ")
		end

	accomodate_text (a_text: STRING) is
			-- Change internal minimum size to make `a_text' fit.
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		local
			t: TUPLE [INTEGER, INTEGER]
		do
			if private_font /= Void then
				t := private_font.string_size (a_text)
			else
				t := private_wel_font.string_size (a_text)
			end
			text_height := t.integer_item (2)
			ev_set_minimum_size (t.integer_item (1), text_height)
		end

feature {NONE} -- WEL Implementation

   	default_style: INTEGER is
   			-- Default style used to create `Current'.
   		do
 			Result := Ws_visible + Ws_child + Ss_notify + Ss_ownerdraw
 		end
 		
feature {EV_CONTAINER_IMP} -- WEL Implementation

	on_draw_item (draw_item_struct: WEL_DRAW_ITEM_STRUCT) is
			-- Process `Wm_drawitem' message.
		local
			draw_dc: WEL_CLIENT_DC
			draw_flags: INTEGER
			draw_rect: WEL_RECT
			draw_item_struct_rect: WEL_RECT
			draw_font: WEL_FONT
			font_imp: EV_FONT_IMP
		do
				-- Assign local variable for faster access
			draw_dc := draw_item_struct.dc
			draw_item_struct_rect := draw_item_struct.rect_item
			
			if internal_text /= Void then
					-- Retrieve the font used to draw the text
				draw_font := private_wel_font
				if draw_font = Void then
					font_imp ?= font.implementation
					draw_font := font_imp.wel_font
				end
					-- Set the flag for the forthcoming call to
					-- `draw_text'.
				inspect text_alignment
				when text_alignment_center then
					draw_flags := Dt_center
				when text_alignment_left then
					draw_flags := Dt_left
				when text_alignment_right then
					draw_flags := Dt_right
				else
					check
						Unexpected_alignment: False
					end
				end
				draw_flags := draw_flags | Dt_expandtabs
	
					-- Compute the bounding rectangle where the text need
					-- to be displayed.
				check
					text_height_ok: (not internal_text.is_empty) implies 
						text_height = draw_font.string_height (internal_text)
				end
				create draw_rect.make (
					draw_item_struct_rect.left, draw_item_struct_rect.top + 
						(draw_item_struct_rect.height - text_height) // 2,
					draw_item_struct_rect.right, draw_item_struct_rect.bottom)

					-- Erase the background
				erase_background (draw_dc, draw_item_struct_rect)
			
					-- Draw the text
				draw_dc.select_font (draw_font)
				if draw_item_struct.item_state = Ods_disabled then
					-- Label is disabled
					draw_dc.draw_disabled_text (internal_text, draw_rect, 
						draw_flags)
				else
					-- Label is NOT disabled
					draw_dc.draw_text (internal_text, draw_rect,
						draw_flags)
				end
				draw_dc.unselect_font
			else
					-- No text, just erase the background
				erase_background (draw_dc, draw_item_struct_rect)
			end
		end
		
feature {NONE} -- Implementation

	erase_background (a_dc: WEL_DC; a_rect: WEL_RECT) is
			-- Erase the background for the rectangle `a_rect' using the
			-- Device context `a_dc'.
		local
			a_background_brush: WEL_BRUSH
		do
			create a_background_brush.make_solid (wel_background_color)
			a_dc.fill_rect (a_rect, a_background_brush)
			a_background_brush.delete
		end
	
	text_height: INTEGER
			-- Height in pixels of the current text.

feature {NONE} -- Feature that should be directly implemented by externals.

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Never_called: False
			end
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Never_called: False
			end
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

feature {EV_ANY_I}

	interface: EV_LABEL

end -- class EV_LABEL_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.45  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.44  2001/06/07 23:08:16  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.28.4.35  2001/05/29 20:54:26  pichery
--| Fixed check
--|
--| Revision 1.28.4.34  2001/05/28 16:40:40  pichery
--| Fixed bug. We were using the wrong font when `private_wel_font' was
--| Void.
--|
--| Revision 1.28.4.33  2001/05/28 15:46:04  pichery
--| - Fixed bug in `set_text', `remove_text', ... where the label was still displaying
--|   the old text (because `Invalidate' must be called and was not)
--| - Optimized `on_draw_item' and fixed "ferature call on void target" because
--|   `private_wel_font' can be Void.
--|
--| Revision 1.28.4.32  2001/05/27 20:39:40  pichery
--| The problem was that text was not vertically aligned as it is on GTK.
--| The text was drawn on the top of the space.
--|
--| I first though that adding the flag SS_CENTERIMAGE was enough
--| to fix this behaviour. Unfortunately, this is not the case.
--| SS_CENTERIMAGE vertically aligns the text but include the
--| flag SS_SINGLELINE. As a consequence, texts containing carriage
--| returns were not displayed correctly: "line one%Nline two" was
--| displayed as "line one#line to" instead of
--| "line one
--| line two".
--|
--| I thourougly checked in MSDN a workaround and posted a message
--| in microsoft.public.win32.programer.gdi. The conclusion is that
--| it cannot be done easily... one has to use the flag SS_OWNERDRAW
--| and manually draw the text.
--|
--| --> implemented EV_LABEL_IMP.on_draw_item so that it  correctly draws
--|      the text vertically centered.
--|
--| Revision 1.28.4.31  2001/05/26 16:59:40  pichery
--| Removed flag `Ss_centerimage' which is not compatible with multi-lines
--| labels.
--|
--| Revision 1.28.4.30  2001/05/24 18:16:08  pichery
--| If a label need less space than the size it actually has, it appears on
--| the top under Windows, and is vertically centered under GTK.
--| Updated the Windows part to have the same behaviour on both platform.
--|
--| Revision 1.28.4.29  2001/04/24 16:02:25  rogers
--| Changed inheritence from ev_textable_imp to
--| ev_internally_processed_textable and modified all precursor statements
--| accordingly.
--|
--| Revision 1.28.4.28  2001/02/19 16:30:08  manus
--| Changed implementation of `set_default_minimum_size' so that it is equivalent to
--| the size of what would take a `space'. Doing so avoid useless resizing because the
--| height with a text and without a text was different. Now it would be the same.
--|
--| Revision 1.28.4.27  2001/01/26 23:23:38  rogers
--| Undefined on_sys_key_down inherited from WEL.
--|
--| Revision 1.28.4.26  2001/01/22 19:38:16  rogers
--| Align_text_center, align_text_right and align_text_left now all include
--| the style `Ss_notify' to ensure that `Current' will still generate
--| events after a call to one of these features.
--|
--| Revision 1.28.4.25  2001/01/22 19:24:22  rogers
--| Removed align_text_middle as it is redundent.
--|
--| Revision 1.28.4.23  2001/01/09 19:19:45  rogers
--| Redefined default_process_message from WEL.
--|
--| Revision 1.28.4.22  2000/12/08 02:51:23  manus
--| Optimization on accessing `string_size' on the `private_font' object
--| instead of the `font' object that was anyway returning the `private_font'
--| object.
--|
--| Revision 1.28.4.21  2000/12/02 01:40:05  rogers
--| Modified call to wel_make so it is created with "" instead of " ". Now
--| check that there is text before calling accomodate_text in set_font.
--|
--| Revision 1.28.4.20  2000/11/30 19:54:07  rogers
--| Added ss_notify style so that events can be triggered.
--|
--| Revision 1.28.4.19  2000/11/29 00:38:59  rogers
--| Changed empty to is_empty.
--|
--| Revision 1.28.4.18  2000/11/14 18:36:39  rogers
--| Renamed has_capture inherited from WEL as wel_has_capture.
--|
--| Revision 1.28.4.17  2000/11/06 17:58:55  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.28.4.16  2000/10/28 01:10:26  manus
--| Use of `private_font' instead of `font' to avoid creation of an EV_FONT object for nothing.
--| If it is Void we can simply use the `private_wel_font' field.
--|
--| Revision 1.28.4.15  2000/10/27 02:41:06  manus
--| Removed definition of `wel_background_color' and `wel_foreground_color' and use the one inherited
--|
--| Revision 1.28.4.14  2000/10/11 00:00:28  raphaels
--| Added `on_desactivate' to list of undefined features from WEL_WINDOW.
--|
--| Revision 1.28.4.13  2000/09/29 02:03:54  manus
--| Added `align_text_middle' in preparation of future addition in interface of EV_LABEL.
--| First implementation that is not meaningful but will give the hint on how to implement it.
--|
--| Revision 1.28.4.12  2000/09/25 01:42:06  manus
--| Redefined `set_font' so that minimum_size is recomputed.
--|
--| Revision 1.28.4.11  2000/09/13 15:51:51  manus
--| Removed calls to `set_font (font)' in initialize and replace it by the less resource consuming
--| `set_default_font' which set the font the default GUI one.
--|
--| Revision 1.28.4.10  2000/08/24 21:51:57  rogers
--| Align_text_center, align_text_right and align_text_left all now call precursor.
--|
--| Revision 1.28.4.9  2000/08/11 18:47:55  rogers
--| Fixed copyright clauses. Now use ! instead of |.
--|
--| Revision 1.28.4.8  2000/08/08 02:35:34  manus
--| Updated inheritance with new WEL messages handling
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--|
--| Revision 1.28.4.7  2000/07/12 16:10:52  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.28.4.6  2000/06/25 18:03:25  brendel
--| Optimized to use `string_size'.
--|
--| Revision 1.28.4.5  2000/06/19 18:52:10  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.28.4.4  2000/06/15 03:43:35  pichery
--| Removed compiler workaround.
--|
--| Revision 1.28.4.3  2000/06/13 18:36:53  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.28.4.2  2000/05/03 22:35:04  brendel
--| Fixed resize_actions.
--|
--| Revision 1.28.4.1  2000/05/03 19:09:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.42  2000/04/18 23:47:44  brendel
--| Corrected error in accomodate_text.
--|
--| Revision 1.41  2000/04/18 23:46:41  brendel
--| Last revision did not really change anything.
--| Widget is now resized *before* the text is passed to WEL.
--|
--| Revision 1.39  2000/03/29 20:31:45  brendel
--| Added compiler workaround. See code.
--|
--| Revision 1.38  2000/03/28 16:35:18  rogers
--| Now use wel_text in set_default_minimum_size.
--|
--| Revision 1.37  2000/03/28 00:17:00  brendel
--| Revised `text' related features as specified by new EV_TEXTABLE_IMP.
--|
--| Revision 1.36  2000/03/14 03:02:56  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.35.2.2  2000/03/11 00:19:20  brendel
--| Renamed move to wel_move.
--| Renamed resize to wel_resize.
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.35.2.1  2000/03/09 21:39:48  brendel
--| Replaced x with x_position and y with y_position.
--| Before, both were available.
--|
--| Revision 1.35  2000/03/09 16:27:26  brendel
--| Improved initialization.
--|
--| Revision 1.34  2000/03/03 20:08:20  brendel
--| Default: align_text_center.
--| Formatted for 80 columns.
--|
--| Revision 1.33  2000/03/03 01:40:35  brendel
--| Fixed bug in minimum size calculation.
--|
--| Revision 1.32  2000/03/03 00:57:19  brendel
--| Changed set_minimum_size to use new features of EV_FONT_IMP.
--|
--| Revision 1.31  2000/02/22 01:12:58  rogers
--| Changed wel_make to take a space instead of an empty string in make.
--|
--| Revision 1.30  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.29  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.28.6.6  2000/02/01 03:34:57  brendel
--| Removed undefine of set_default_minimum_size.
--|
--| Revision 1.28.6.5  2000/01/27 19:30:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.28.6.4  2000/01/19 23:55:54  rogers
--| renamed interface inherited from EV_FONTABLE_IMP as ev_fontable_interface,
--| and selected interface from EV_LABEL_I.
--|
--| Revision 1.28.6.3  2000/01/11 23:33:48  rogers
--| Modified to comply with the major Vision2 changes. See diff for
--| re-definitions. renamed set_******_alignment to align_text_******.
--|
--| Revision 1.28.6.2  1999/12/17 00:39:19  rogers
--| Altered to fit in with the review branch. Basic alterations, make now
--| takes an interface.
--|
--| Revision 1.28.6.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.28.2.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
