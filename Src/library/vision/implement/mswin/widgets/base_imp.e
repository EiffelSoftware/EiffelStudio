indexing
	description: "This class represents a MS_IMPbase window"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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




end -- class BASE_IMP

