indexing 
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"
 
class
	TOP_SHELL_WINDOWS

inherit
	TOP_SHELL_I

	TOP_WINDOWS
		redefine
			make,
			class_name
		end

creation
	make

feature -- Initialization

	make (a_top_shell: TOP_SHELL) is
			-- Make a top shell.
		do
			!! private_attributes
			private_title := a_top_shell.identifier
			a_top_shell.set_wm_imp (Current)
			set_managed (True)
			private_attributes.set_x (default_x)
			private_attributes.set_y (default_y)
			private_attributes.set_width (0)
			private_attributes.set_height (0)
			shell_width :=  2 * window_frame_width
			shell_height := title_bar_height + window_border_height + 2 * window_frame_height
			oui_top := a_top_shell
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionTopShell"
		end

end -- TOP_SHELL_WINDOWS
 
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
