indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_NEW_PROJECT_STATE

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info
		end

create
	make

feature -- Basic Operation

	display is 
			-- Display user entries
		do
			build
		end

	build is 
			-- Build entries.
		local
			browse_b: EV_BUTTON
			h1: EV_HORIZONTAL_BOX
		do 
			Create h1
			Create location.make("Choose a Directory",
							 wizard_information.project_location, 10, 30, Current)
			Create browse_b.make_with_text("Browse...")
			browse_b.press_actions.extend(~Browse)

			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(h1)
			h1.extend (location)
--			h1.extend (Create {EV_VERTICAL_BOX})
			h1.extend (browse_b)
			main_box.extend(Create {EV_HORIZONTAL_BOX})	

			h1.disable_child_expand(browse_b)
			main_box.disable_child_expand(h1)

			set_updatable_entries(<<browse_b.press_actions, location.change_actions>>)
		end

	proceed_with_current_info is 
		local
			dir: DIRECTORY
		do
			Precursor
			if not wizard_information.project_location.is_equal("") then
				Create dir.make (wizard_information.project_location)
				if dir.exists then
--					proceed_with_new_state(Create {WIZARD_ADD_FORM_STATE}.make(wizard_information))
				else
--					proceed_with_new_state(Create {WIZARD_ERROR_LOCATION_STATE}.make(wizard_information))
				end
			else
--				proceed_with_new_state(Create {WIZARD_ERROR_LOCATION_STATE}.make(wizard_information))
			end			
		end

	update_state_information is
			-- Check User Entries
		do
			wizard_information.set_project_location (location.text)
			Precursor
		end

	browse is
			-- Launch a computer directory Browser.
		local
			dir_selector: EV_DIRECTORY_DIALOG	
		do
			Create dir_selector
			dir_selector.ok_actions.extend(~directory_selected(dir_selector))
			dir_selector.show_modal
		end

	directory_selected (dir_selector: EV_DIRECTORY_DIALOG) is
			-- The user selected a directory from the browser. 
			-- It updates the text fields accordingly.
		require
			selector_exists: dir_selector /= Void
		do
			location.set_text(dir_selector.directory)
		end


feature {NONE} -- Implementation

	location: WIZARD_SMART_TEXT_FIELD

	pixmap_location: STRING is "small_essai.bmp";


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
end -- class WIZARD_NEW_PROJECT_STATE
