indexing 
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"
 
class
	TOP_SHELL_IMP

inherit
	TOP_SHELL_I

	TOP_IMP
		redefine
			class_name,
			child_has_resized
		end

create
	make

feature -- Initialization

	make (a_top_shell: TOP_SHELL) is
			-- Make a top shell.
		do
			create private_attributes
			private_title := a_top_shell.identifier
			if private_title.is_integer then
				create class_icon.make_by_id (private_title.to_integer)
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
			max_width := maximal_width
			max_height := maximal_height
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

end -- TOP_SHELL_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

