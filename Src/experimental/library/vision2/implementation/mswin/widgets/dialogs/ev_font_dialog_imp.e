note
	description: "EiffelVision font selection dialog, mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_DIALOG_IMP

inherit
	EV_FONT_DIALOG_I
		undefine
			copy, is_equal
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		undefine
			copy, is_equal
		redefine
			interface
		end

	WEL_CHOOSE_FONT_DIALOG
		rename
			make as wel_make,
			set_parent as wel_set_parent
		redefine
			activate
		end

	WEL_STANDARD_DIALOG_DISPATCHER
		rename
			standard_dialog_procedure as font_dialog_procedure
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Implementation

	old_make (an_interface: like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			wel_make
				-- We must set the style of `Current'.
				-- Modifying the flags changes the appearence.
			cwel_choose_font_set_lpfnhook (item, wel_standard_dialog_procedure)
			set_flags (Cf_screenfonts + Cf_inittologfontstruct + Cf_noscriptsel + cf_enablehook)
			set_is_initialized (True)
		end

feature -- Access

	font: EV_FONT
			-- Font currently selected in `Current'.
		local
			wel_font: WEL_FONT
			ev_font: EV_FONT
			font_imp: detachable EV_FONT_IMP
			dc: WEL_MEMORY_DC
			text_metric: WEL_TEXT_METRIC
		do
				--| FIXME we return a default EV_FONT if the
				--| user cancells the dialog, but we should make this,
				--| and other standard dialogs all return the previously
				--| set value. Julian 10/23/02.
			if selected then
				create wel_font.make_indirect (log_font)
					-- As `Current' is created with the flag Cf_noscriptsel, the log font returned
					-- does not have the char set attribute filled correctly. To determine the
					-- actual char set from the face name, we must select the font into a DC,
					-- and query the DC directly. The new font we create now has the correct char set.
				create dc.make
				dc.select_font (wel_font)
				create text_metric.make (dc)
				log_font.set_char_set (text_metric.character_set)
				dc.unselect_all
				dc.release

				create wel_font.make_indirect (log_font)
				create ev_font
				font_imp ?= ev_font.implementation
				check font_imp /= Void end
				font_imp.set_by_wel_font (wel_font)
				Result := ev_font
			else
				create Result
			end
		end

	title: STRING_32
			-- Title of `Current'.
		local
			l_result: detachable STRING_32
		do
			l_result := internal_title
			if l_result = Void then
				l_result := "Font"
			end
			check l_result /= Void end
			Result := l_result
		end

feature -- Element change

	set_title (new_title: STRING_GENERAL)
			-- Assign `new_title' to `title'.
		do
			internal_title := new_title.twin
		ensure then
			title_set: title.is_equal (new_title)
		end

	set_font (a_font: EV_FONT)
			-- Set the initial font to `a_font'
		local
			font_imp: detachable EV_FONT_IMP
		do
			font_imp ?= a_font.implementation
			check font_imp /= Void end
			font_imp.update_preferred_faces ("")
			set_log_font (font_imp.wel_log_font)
		end

feature -- Element change

	--| FIXME These features are all required by EV_POSITIONED and
	--| EV_POSITIONABLE. Is there a way to implement these?

	set_x_position (a: INTEGER)
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_y_position (a: INTEGER)
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_height (a: INTEGER)
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_width (a: INTEGER)
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_size (a, b: INTEGER)
		do
			check
				to_be_implemented: FALSE
			end
		end

	x_position: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	y_position: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	screen_x: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	screen_y: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	width: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_position (a, b: INTEGER)
		do
			check
				to_be_implemented: FALSE
			end
		end

	height: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	minimum_width: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	minimum_height: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

feature {NONE} -- Implementation

	destroy
			-- Destroy `Current'.
		do
			destroy_item
			set_is_destroyed (True)
		end

	internal_title: detachable STRING_32
			-- Storage for `title'.

	activate (a_parent: WEL_COMPOSITE_WINDOW)
			-- Activate current dialog
		do
			begin_activate
			Precursor {WEL_CHOOSE_FONT_DIALOG} (a_parent)
			end_activate
		end

	font_dialog_procedure (hdlg: POINTER; msg: INTEGER_32; wparam, lparam: POINTER): POINTER
			-- Hook for handling messages of the font dialog.
		local
			l_str: WEL_STRING
		do
			inspect msg
			when {WEL_WM_CONSTANTS}.wm_initdialog then
					-- Initialize the title of dialog properly.
				if attached internal_title as l_internal_title then
					create l_str.make (l_internal_title)
					{WEL_API}.set_window_text (hdlg, l_str.item)
				end
			else
			end
		end

feature {EV_ANY_I}

	interface: detachable EV_FONT_DIALOG note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_FONT_DIALOG_IMP








