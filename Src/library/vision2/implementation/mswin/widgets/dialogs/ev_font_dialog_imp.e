indexing 
	description: "EiffelVision font selection dialog, mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_DIALOG_IMP

inherit
	EV_FONT_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface
		end

	WEL_CHOOSE_FONT_DIALOG
		rename
			make as wel_make,
			set_parent as wel_set_parent
		end

creation
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
			is_initialized := True
		end

feature -- Access
	
	font: EV_FONT is
			-- Font currently selected in `Current'.
		local
			wel_font: WEL_FONT
			ev_font: EV_FONT
			font_imp: EV_FONT_IMP
		do
			create wel_font.make_indirect (log_font)
			create ev_font
			font_imp ?= ev_font.implementation
			font_imp.set_by_wel_font (wel_font)
			Result := ev_font
		end

	title: STRING is "Font"
			-- Title of `Current'.

feature -- Element change

	set_title (new_title: STRING) is
			-- Assign `new_title' to `title'.
		do
			--|FIXME
		end

	set_font (a_font: EV_FONT) is
			-- Set the initial font to `a_font'
		local
			font_imp: EV_FONT_IMP
			wel_font: WEL_LOG_FONT
			f_name: STRING
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
		end

feature {EV_ANY_I}

	interface: EV_FONT_DIALOG

end -- class EV_FONT_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

