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
			class_name,
			child_has_resized
		end

creation
	make

feature -- Initialization

	make (a_top_shell: TOP_SHELL) is
			-- Make a top shell.
		do
			!! private_attributes
			private_title := a_top_shell.identifier
			if private_title.is_integer then
				!! class_icon.make_by_id (private_title.to_integer)
				if not class_icon.exists then	
					class_icon := null_class_icon
				end
			else
				class_icon := null_class_icon
			end
			a_top_shell.set_wm_imp (Current)
			set_managed (True)
			private_attributes.set_x (default_x)
			private_attributes.set_y (default_y)
			private_attributes.set_width (minimal_width)
			private_attributes.set_height (minimal_height)
			shell_width :=  2 * window_frame_width
			shell_height := title_bar_height + window_border_height + 2 * window_frame_height
			oui_top := a_top_shell
		end

feature {NONE} -- Implementation

	child_has_resized is
			-- Size shell children
		do
			if not realizing_children then
				resize_shell_children (width, height)
			end
		end

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
