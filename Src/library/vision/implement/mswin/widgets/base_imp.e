indexing
	description: "This class represents a MS_IMPbase window";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"
 
class
	BASE_IMP

inherit
	BASE_I

	TOP_IMP
		redefine
			class_name
		end

create
	make

feature -- Initialization

	make (a_base: BASE) is
			-- Make a base.
		do
			create private_attributes
			private_title := a_base.identifier
			if private_title.is_integer then
				create class_icon.make_by_id (private_title.to_integer)
				if not class_icon.exists then	
					class_icon := null_class_icon
				end
			else
				class_icon := null_class_icon
			end
			a_base.set_wm_imp (Current)
			set_managed (True)
			private_attributes.set_x (default_x)
			private_attributes.set_y (default_y)
			shell_width :=  2 * window_frame_width
			shell_height := title_bar_height + window_border_height + 2 * window_frame_height
			private_attributes.set_width (minimal_width)
			private_attributes.set_height (minimal_height)
			max_width := maximal_width
			max_height := maximal_height 
			oui_top := a_base
		end

feature {NONE} -- Implementation

	class_name: STRING is
		once
			Result := "EvisionBase"
		end

end -- class BASE_IMP

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

