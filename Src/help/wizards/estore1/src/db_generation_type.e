indexing
	description: "Generation Type Page"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_GENERATION_TYPE

inherit
	WIZARD_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			change_entries
		end

creation
	make

feature -- basic Operations

	display is 
			-- Display user entries
		do
			build
		end

	build is 
			-- Build user entries.
		do 
			Create generate_facade_b.make_with_text("Generate Facade")
			Create new_project_b.make_with_text("Generate as a new Project")
			Create example_b.make_with_text("Generate example")
			Create current_project_b.make_with_text("Integrate within existing Project")
			if wizard_information.generate_facade then
				generate_facade_b.enable_select
			else
				generate_facade_b.disable_select
			end
			if wizard_information.new_project then
				new_project_b.enable_select
			else
				current_project_b.enable_select
			end
			if wizard_information.example then
				example_b.enable_select
			else
				example_b.disable_select
			end		

			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(new_project_b)
			main_box.extend(current_project_b)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(example_b)
			main_box.extend(generate_facade_b)
			main_box.extend(Create {EV_HORIZONTAL_BOX})

			set_updatable_entries(<<generate_facade_b.press_actions,
									new_project_b.press_actions,
									current_project_b.press_actions,
									example_b.press_actions>>)
		end

	proceed_with_current_info is 
			-- Process user entries
		do 
			precursor
			proceed_with_new_state(Create {DB_GENERATION_LOCATION}.make(wizard_information))
		end

	update_state_information is
			-- Check user entries
		do
			wizard_information.set_generation_type(generate_facade_b.is_selected,
							new_project_b.is_selected)
			precursor
		end

	change_entries is
			-- The user pressed a button.
		do
			precursor
			if current_project_b /= Void then
				if current_project_b.is_selected then
					example_b.disable_select
					example_b.disable_sensitive
				else
					example_b.enable_sensitive
				end
			end
		end

feature -- Implementation

	example_b,generate_facade_b: EV_CHECK_BUTTON

	new_project_b,current_project_b: EV_RADIO_BUTTON

	pixmap_location: STRING is "essai.bmp";
			-- Pixmap location


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
end -- class DB_GENERATION_TYPE
