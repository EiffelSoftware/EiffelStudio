indexing
	description: "EiffelVision push button. Mswindows implementation."
	status: "See notice at end of class"
	note: "On windows, you can only display a text or a pixmap.%N%
	%if you set both the pixmap and the text, only the%N%
	%pixmap will be displayed. On gtk, everything works%N%
	%like it is suppose to be, you have both text and%N%
	%pixmap visible."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BUTTON_IMP

inherit
	EV_BUTTON_I
		redefine
			interface
		select
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			set_default_minimum_size
		redefine
			on_key_down,
			initialize,
			interface
		end
   
	EV_INTERNALLY_PROCESSED_TEXTABLE_IMP
		redefine
			set_default_minimum_size,
			align_text_center,
			align_text_left,
			align_text_right,
			interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			set_pixmap,
			remove_pixmap,
			interface
		end

	EV_FONTABLE_IMP
		rename
			interface as ev_fontable_interface
		end

	WEL_BS_CONSTANTS
		export
			{NONE} all
		end

	WEL_BM_CONSTANTS
		export
			{NONE} all
		end

	WEL_BITMAP_BUTTON
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			shown as is_displayed,
			set_font as wel_set_font,
			destroy as wel_destroy,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			text as wel_text,
			set_text as wel_set_text,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
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
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			on_size,
			show,
			hide,
			x_position,
			y_position,
			wel_background_color,
			wel_foreground_color,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			default_style,
			on_bn_clicked,
			wel_set_text
		end

	EV_BUTTON_ACTION_SEQUENCES_IMP

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
			extra_width := 20
			text_alignment := Text_alignment_left
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_PRIMITIVE_IMP}
			set_default_font
		end

feature -- Access

	extra_width: INTEGER
			-- Extra width on the size.

	is_default_push_button: BOOLEAN
			-- Is this button currently a default push button 
			-- for a particular container?

feature -- Status setting

	set_default_minimum_size is
		-- Reset `Current' to its default minimum size.
		local
			fw: EV_FONT_IMP
			w,h: INTEGER
		do
			if pixmap_imp /= Void then
				w := pixmap_imp.width + 8
				h := pixmap_imp.height + 8
			elseif text /= Void and then not text.is_empty then
				if private_font /= Void then
					fw ?= private_font.implementation
					check
						font_not_void: fw /= Void
					end
					w := extra_width + fw.string_width (wel_text)
					h := 19 * fw.height // 9
				else
					w := extra_width + private_wel_font.string_width (wel_text)
					h := 19 * private_wel_font.height // 9
				end
			else
				w := extra_width
				h := 7
			end

				-- Finaly, we set the minimum values.
			ev_set_minimum_size (w, h)
		end

	align_text_left is
			-- Display `text' with alignment to left of `Current'.
		local
			new_style: INTEGER
		do
			new_style := clear_flag (style, Bs_center)
			new_style := clear_flag (new_style, Bs_right)
			new_style := set_flag (new_style, Bs_left)
			set_style (new_style)

			text_alignment := Text_alignment_left
			invalidate
		end

	align_text_right is
			-- Display `text' with alignment to right of `Current'.
		local
			new_style: INTEGER
		do
			new_style := clear_flag (style, Bs_center)
			new_style := clear_flag (new_style, Bs_left)
			new_style := set_flag (new_style, Bs_right)
			set_style (new_style)

			text_alignment := Text_alignment_right
			invalidate
		end

	align_text_center is
			-- -- Display `text' with alignment in center of `Current'.
		local
			new_style: INTEGER
		do
			new_style := clear_flag (style, Bs_right)
			new_style := clear_flag (new_style, Bs_left)
			new_style := set_flag (new_style, Bs_center)
			set_style (new_style)

			text_alignment := Text_alignment_center
			invalidate
		end

	enable_default_push_button is
			-- Set the default style of `Current'.
		local
			new_style: INTEGER
		do
			new_style := set_flag (style, Bs_defpushbutton)
			set_style (new_style)

			is_default_push_button := True
			invalidate
		end

	disable_default_push_button is
			-- Remove the style default style of `Current'. 
		local
			new_style: INTEGER
		do
			new_style := clear_flag (style, Bs_defpushbutton)
			set_style (new_style)

			is_default_push_button := False
			invalidate
		end

	enable_can_default is
			--| Implementation only needed for GTK
		do
			--| Do nothing as this is the default on Win32.
		end

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the pixmap of `Current'.
		local
			wel_icon: WEL_ICON
			a_wel_bitmap: WEL_BITMAP
		do
			if pix /= private_pixmap then
				Precursor {EV_PIXMAPABLE_IMP} (pix)
				wel_icon := pixmap_imp.icon
				if wel_icon /= Void then
					set_icon (pixmap_imp.icon)
				else
					a_wel_bitmap := pixmap_imp.get_bitmap
					set_bitmap (a_wel_bitmap)
					a_wel_bitmap.decrement_reference
				end
				set_default_minimum_size
			end
		end

	remove_pixmap is
			-- Remove `pixmap' from `Current'.
		do
			Precursor {EV_PIXMAPABLE_IMP}
			unset_bitmap
			set_default_minimum_size
		end

	wel_set_text (txt: STRING) is
			-- Assign `txt' to `text' of `Current'.
		do
			Precursor {WEL_BITMAP_BUTTON} (txt)
			set_default_minimum_size
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Default style used to create `Current'.
		do
			Result := ws_visible + ws_child + ws_group + ws_tabstop
		end

	on_bn_clicked is
			-- `Current' has been pressed.
		do
			if select_actions_internal /= Void then
				select_actions_internal.call ([])
			end
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed.
		local
			a_dialog_imp: EV_DIALOG_IMP
		do
				-- Process Enter and Escape Key to process Default
				-- push button and default cancel button
			if virtual_key = Vk_escape or virtual_key = Vk_return then
				a_dialog_imp ?= top_level_window_imp
				if a_dialog_imp /= Void then
					a_dialog_imp.on_dialog_key_down (virtual_key)
				end
			end
				
			process_tab_key (virtual_key)
			Precursor {EV_PRIMITIVE_IMP} (virtual_key, key_data)
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem.
		do
			Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normally, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normally, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

feature {EV_ANY_I}

	interface: EV_BUTTON

end -- class EV_BUTTON_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.55  2001/06/11 22:11:19  pichery
--| Process Enter and Escape Key for EV_DIALOG_IMP (contrary to
--| EV_DIALOG_IMP_MODAL/MODELESS we cannot use on_wm_command
--| since EV_DIALOG_IMP is nothing more than a simple titled window)
--|
--| Revision 1.54  2001/06/07 23:08:16  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.35.8.33  2001/04/24 16:01:59  rogers
--| Changed inheritence from ev_textable_imp to
--| ev_internally_processed_textable.
--|
--| Revision 1.35.8.32  2001/03/04 22:36:52  pichery
--| - Fixed FIXME
--| - Renammed `bitmap' into `get_bitmap'
--|
--| Revision 1.35.8.31  2001/02/23 23:44:04  pichery
--| Added tight reference tracking for wel_bitmaps.
--|
--| Revision 1.35.8.30  2001/02/02 00:52:17  rogers
--| On_key_down now calls process_tab_key before Precursor. This ensures that
--| any tab movement we do in our implementation can be overriden by the user
--| with key_press_actions.
--|
--| Revision 1.35.8.29  2001/01/26 23:24:28  rogers
--| Undefined on_sys_key_down inherited from WEL.
--|
--| Revision 1.35.8.28  2001/01/09 19:32:44  rogers
--| Undefined default_process_message from WEL.
--|
--| Revision 1.35.8.27  2000/11/29 00:39:46  rogers
--| Changed empty to is_empty.
--|
--| Revision 1.35.8.26  2000/11/14 18:33:24  rogers
--| Renamed has_capture inherited from WEL as wel_has_capture.
--|
--| Revision 1.35.8.25  2000/11/09 18:34:10  manus
--| Not all pixmap are icons, so we need to take that into consideration into `set_pixmap'.
--|
--| Revision 1.35.8.24  2000/11/06 18:00:03  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.35.8.23  2000/11/04 01:57:08  manus
--| Setting a pixmap to a button will now call `set_icon' instead of `set_bitmap' because
--| on Windows most of the time we will have .ico which handles transparency correctly.
--|
--| Revision 1.35.8.22  2000/10/28 01:11:29  manus
--| Use of `private_font' when it is not Void, otherwise we can use `private_wel_font' for
--| the same purpose.
--|
--| Revision 1.35.8.21  2000/10/27 02:34:59  manus
--| Removed definition of `wel_background_color' and `wel_foreground_color' and use the one inherited
--| from EV_WIDGET_IMP.
--|
--| Revision 1.35.8.20  2000/10/11 00:00:28  raphaels
--| Added `on_desactivate' to list of undefined features from WEL_WINDOW.
--|
--| Revision 1.35.8.19  2000/10/06 18:48:14  rogers
--| Formatting to 80 columns.
--|
--| Revision 1.35.8.18  2000/09/13 22:10:54  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.35.8.17  2000/09/13 15:51:51  manus
--| Removed calls to `set_font (font)' in initialize and replace it by the less
--| resource consuming `set_default_font' which set the font tothe default
--| GUI one.
--|
--| Revision 1.35.8.16  2000/08/24 21:53:19  rogers
--| Removed text_alignment and corresponding constants as now redundent.
--|
--| Revision 1.35.8.15  2000/08/11 16:53:26  rogers
--| Changed copyright clause to use ! instead of |.
--|
--| Revision 1.35.8.14  2000/08/08 02:28:21  manus
--| Updated inheritance with new WEL messages handling.
--| Updating sizing with call to `ev_' instead of `internal_'
--| Added definition of `wel_foreground_color' and `wel_background_color' since
--| a WEL_BUTTON is now colorizable.
--|
--| Revision 1.35.8.13  2000/08/04 20:25:24  rogers
--| All action sequence calls through the interface have been replaced with
--| calls to the internal action sequences.
--|
--| Revision 1.35.8.12  2000/07/24 23:48:54  rogers
--| Now inherits EV_BUTTON_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.35.8.11  2000/07/13 22:31:25  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.35.8.10  2000/07/12 16:11:32  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.35.8.9  2000/06/19 21:45:55  manus
--| Now `pixmap' of `EV_PIXMAPABLE_IMP' returns a copy of the internal pixmap
--| to satisfy the Vision2 interface behavior.
--|
--| Revision 1.35.8.8  2000/06/13 18:37:39  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.35.8.7  2000/06/09 20:57:18  manus
--| Cosmetics for CVS logs
--|
--| Revision 1.35.8.6  2000/06/05 20:56:35  manus
--| In `set_default_minimum_size' we have a fixed space of 4 pixels around a
--| pixmap instead of a proportional distance.
--| `set_pixmap' does set the pixmap only if it is different from the previous
--| one.
--|
--| Revision 1.35.8.5  2000/05/07 03:41:56  manus
--| Cosmetics.
--| Fixed a bug because `text /= ""' was used, instead it should have been
--| `text /= Void and then not text.empty'
--|
--| Revision 1.35.8.4  2000/05/05 22:31:16  pichery
--| Changed `extra_width' value
--|
--| Revision 1.35.8.3  2000/05/04 00:18:26  king
--| Added dummy enable_can_default
--|
--| Revision 1.35.8.2  2000/05/03 22:35:04  brendel
--| Fixed resize_actions.
--|
--| Revision 1.35.8.1  2000/05/03 19:09:49  oconnor
--| mergred from HEAD
--|
--| Revision 1.49  2000/05/03 00:35:39  pichery
--| Changed the implementation of some
--| `set_style' features. The new implementation
--| is safer.
--|
--| Revision 1.48  2000/05/01 17:04:44  manus
--| Use of `wel_parent' directly without the hack of renaming into
--| `wel_window_parent'.
--|
--| Revision 1.47  2000/04/29 03:32:54  pichery
--| Improved buttons: new default size,
--| new feature (default_push_button).
--|
--| Revision 1.46  2000/04/25 00:32:53  rogers
--| Removed wel_window_parent hack.
--|
--| Revision 1.45  2000/03/28 16:35:47  rogers
--| Now use wel_text in set_default_minimum_size.
--|
--| Revision 1.44  2000/03/28 00:17:00  brendel
--| Revised `text' related features as specified by new EV_TEXTABLE_IMP.
--|
--| Revision 1.43  2000/03/23 18:20:53  brendel
--| replaced obsolete call.
--|
--| Revision 1.42  2000/03/14 03:02:56  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.41.2.2  2000/03/11 00:19:19  brendel
--| Renamed move to wel_move.
--| Renamed resize to wel_resize.
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.41.2.1  2000/03/09 21:39:48  brendel
--| Replaced x with x_position and y with y_position.
--| Before, both were available.
--|
--| Revision 1.41  2000/03/07 17:41:21  rogers
--| Redefined on_size from WEL_BITMAP_BUTTON so the re-size actions can be
--| called.
--|
--| Revision 1.40  2000/03/03 00:55:56  brendel
--| Changed `text' to `safe_text'.
--|
--| Revision 1.39  2000/02/23 20:23:41  rogers
--| Added wel parenting compiler hack. Removed old command association.
--|
--| Revision 1.38  2000/02/19 05:58:51  oconnor
--| removed old command stuff
--|
--| Revision 1.37  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.36  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.35.10.12  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.35.10.11  2000/01/27 19:30:25  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.35.10.10  2000/01/19 23:54:49  rogers
--| renamed interface inherited from EV_FONTABLE_IMP as ev_fontable_interface,
--| and selected interface from EV_BUTTON_I.
--|
--| Revision 1.35.10.9  2000/01/19 21:46:09  king
--| Tidied up comments, removed untabbed spacing
--|
--| Revision 1.35.10.8  2000/01/18 23:03:32  rogers
--| Redefined text from WEL_BITMAP_BUTTON to wel_text, and re-implemented text.
--|
--| Revision 1.35.10.7  2000/01/14 18:09:46  oconnor
--| added comment
--|
--| Revision 1.35.10.6  2000/01/10 19:21:44  king
--| Changed set_*_alignment to align_text_*.
--|
--| Revision 1.35.10.5  1999/12/30 18:42:13  king
--| Commented out pixmap-size related functions.
--|
--| Revision 1.35.10.4  1999/12/22 18:56:41  rogers
--| pixmap_size_ok has been removed, maximium_pixmap_width and
--| maximum_pixmap_height have been implemented. unset_pixmap has been renamed
--| to remove_pixmap.
--|
--| Revision 1.35.10.3  1999/12/22 17:51:56  rogers
--| Removed the old command call when a button is clicked.
--|
--| Revision 1.35.10.2  1999/12/17 00:43:04  rogers
--| Altered to fit in with the review branch. Some redefinitions required,
--| make now takes an interface.
--|
--| Revision 1.35.10.1  1999/11/24 17:30:31  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.35.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
