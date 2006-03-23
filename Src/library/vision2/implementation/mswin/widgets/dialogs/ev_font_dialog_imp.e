indexing
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
		end

create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make
		end

	initialize is
			-- Initialize `Current'.
		do
				-- We must set the style of `Current'.
				-- Modifying the flags changes the appearence.
			set_flags (Cf_screenfonts + Cf_inittologfontstruct + Cf_noscriptsel)
			set_is_initialized (True)
		end

feature -- Access

	font: EV_FONT is
			-- Font currently selected in `Current'.
		local
			wel_font: WEL_FONT
			ev_font: EV_FONT
			font_imp: EV_FONT_IMP
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
				font_imp.set_by_wel_font (wel_font)
				Result := ev_font
			else
				create Result
			end
		end

	title: STRING_32 is
			-- Title of `Current'.
		do
			Result := "Font"
		end

feature -- Element change

	set_title (new_title: STRING_GENERAL) is
			-- Assign `new_title' to `title'.
		do
			--|FIXME
		end

	set_font (a_font: EV_FONT) is
			-- Set the initial font to `a_font'
		local
			font_imp: EV_FONT_IMP
			wel_font: WEL_LOG_FONT
			f_name: STRING_32
		do
			font_imp ?= a_font.implementation
			wel_font := font_imp.wel_log_font
			f_name := wel_font.face_name
			if f_name.is_empty and then not font_imp.preferred_families.is_empty  then
				wel_font.set_face_name (font_imp.preferred_families @ 1)
			end
			set_log_font (wel_font)
		end

feature -- Element change

	--| FIXME These features are all required by EV_POSITIONED and
	--| EV_POSITIONABLE. Is there a way to implement these?

	set_x_position (a: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_y_position (a: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_height (a: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_width (a: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_size (a, b: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	x_position: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	y_position: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	screen_x: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	screen_y: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	width: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_position (a, b: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	height: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	minimum_width: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	minimum_height: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end


feature {NONE} -- Implementation

	destroy is
			-- Destroy `Current'.
		do
			destroy_item
			set_is_destroyed (True)
		end

feature {EV_ANY_I}

	interface: EV_FONT_DIALOG;

indexing
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

