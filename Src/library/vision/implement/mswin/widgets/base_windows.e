indexing
	description: "This class represents a MS_WINDOWS base window";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"
 
class
	BASE_WINDOWS

inherit
	BASE_I

	TOP_WINDOWS 
		redefine
			make,
			class_name
		end

creation
	make

feature -- Initialization

	make (a_base: BASE) is
			-- Make a base.
		do
			!! private_attributes
			private_title := a_base.identifier
			a_base.set_wm_imp (Current)
			set_managed (True)
			private_attributes.set_x (default_x)
			private_attributes.set_y (default_y)
			shell_width :=  2 * window_frame_width
			shell_height := title_bar_height + window_border_height + 2 * window_frame_height
			private_attributes.set_width (minimal_width)
			private_attributes.set_height (minimal_height)
			oui_top := a_base
		end

feature {NONE} -- Implementation

	class_name: STRING is
		once
			Result := "EvisionBase"
		end

end -- class BASE_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
