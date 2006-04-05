indexing
	description: "Dialog box with a progress bar showing the progression of the deserialization"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	DESERIALIZATION_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end

create
	default_create

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor --{EV_DIALOG}
			
				-- Create all widgets.
			create l_vertical_box_1
			create l_label_1
			create l_progress_bar
			
				-- Build_widget_structure.
			extend (l_vertical_box_1)
			l_vertical_box_1.extend (l_label_1)
			l_vertical_box_1.extend (l_progress_bar)
			
				-- Initialize properties of all widgets.
			set_title ("Deserialization")
			set_width (Dialog_width)
			set_height (Dialog_height)
			l_label_1.set_text ("Deserialization processing...")			
		end
		
feature -- Status Setting

	set_progress_bar (value: INTEGER) is
			-- Set `l_progress_bar' with `value'.
		require 
			correct_value: value >= 0 and value <= 100
		do
			l_progress_bar.set_proportion (value / 100)
		ensure
--			progress_bar_set: l_progress_bar.proportion = value/100
		end
		
feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	l_vertical_box_1: EV_VERTICAL_BOX
	l_label_1: EV_LABEL
	l_progress_bar: EV_HORIZONTAL_PROGRESS_BAR
	
	Dialog_width: INTEGER is 300
			-- width of the dialog box

	Dialog_height: INTEGER is 80;
			-- height of the dialog box

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class DESERIALIZATION_DIALOG
