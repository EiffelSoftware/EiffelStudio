indexing
	description: "Page which deals with the different location entries."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_GENERATION_LOCATION


inherit
	WIZARD_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info
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
		local
			browse1_b,browse2_b: EV_BUTTON
			h1,h2: EV_HORIZONTAL_BOX
		do 
			Create location.make("Sources Location",wizard_information.location,10,30,Current)
			Create project_location.make("Project Location",wizard_information.project_location,10,30,Current)
			Create browse1_b.make_with_text("Browse ...")
			browse1_b.press_actions.extend(~browse(FALSE))
			Create browse2_b.make_with_text("Browse ...")
			Create h1
			Create h2
			browse2_b.press_actions.extend(~browse(TRUE))
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(h1)
			h1.extend(location)
			h1.extend(browse1_b)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(h2)
			h2.extend(project_location)
			h2.extend(browse2_b)
			h1.disable_child_expand(browse1_b)
			h2.disable_child_expand(browse2_b)
			main_box.disable_child_expand(h1)
			main_box.disable_child_expand(h2)
			main_box.extend(Create {EV_HORIZONTAL_BOX})

			set_updatable_entries(<<browse2_b.press_actions,
									browse1_b.press_actions,
									location.change_actions,
									project_location.change_actions>>)
		end

	proceed_with_current_info is 
			-- Process user entries
		local
			next_step: DB_FINISH
			message: EV_ERROR_DIALOG
		do 
			if location.text.count =0 then
				Create message.make_with_text("Please provide a location.")
				entries_checked := FALSE
				entries_changed := TRUE
				message.show_modal
			else
				precursor
				proceed_with_new_state(Create {DB_FINISH}.make(wizard_information))
			end
		end

	update_state_information is
			-- Check user entries
		do
			wizard_information.set_locations(location.text,project_location.text)
			precursor
		end

	browse(is_for_project: BOOLEAN) is
			-- Launch a computer directory Browser.
		local
			dir_selector: EV_DIRECTORY_DIALOG	
		do
			Create dir_selector
			dir_selector.ok_actions.extend(~directory_selected(dir_selector,is_for_project))
			dir_selector.show_modal
		end

	directory_selected (dir_selector: EV_DIRECTORY_DIALOG; is_for_project: BOOLEAN) is
			-- The user selected a directory from the browser. 
			-- It updates the text fields accordingly.
		require
			selector_exists: dir_selector /= Void
		do
			if is_for_project then
				project_location.set_text(dir_selector.directory)
			else	
				location.set_text(dir_selector.directory)
			end
		end

feature -- Implementation

	location,project_location: WIZARD_SMART_TEXT_FIELD

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
end -- class DB_GENERATION_LOCATION
