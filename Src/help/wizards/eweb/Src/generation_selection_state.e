indexing
	description: "The user selects which generation he would like to see performed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATION_SELECTION_STATE

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

creation
	make

feature -- basic Operations

	build is 
			-- Build entries.
		local
			v1: EV_VERTICAL_BOX
		do 
				Create new_project_b.make_with_text (" Create a new EiffelWeb Project.")
				Create existing_project_b.make_with_text (" Add new forms to an existing project.")

				choice_box.extend(Create {EV_HORIZONTAL_BOX})
				choice_box.extend(new_project_b)
--				choice_box.extend(Create {EV_HORIZONTAL_BOX})
				choice_box.extend(existing_project_b)
				choice_box.extend(Create {EV_HORIZONTAL_BOX})
				set_updatable_entries(<<new_project_b.select_actions, existing_project_b.select_actions>>)
		end

	proceed_with_current_info is 
			-- Proceed, load the next state.
		do
			Precursor
			proceed_with_new_state(Create {DIRECTORY_SELECTION_STATE}.make(wizard_information))
		end

	update_state_information is
			-- Check User Entries
		do
			if new_project_b.is_selected then
				wizard_information.set_new_project
			end
			Precursor
		end

feature -- Implementation

	new_project_b, existing_project_b: EV_RADIO_BUTTON

	display_state_text is
		do
			message.set_text ("The wizard can either build a project from scratch or%N%
						%help you to add classes to an existing project. ")
			title.set_text ("Generation Type")
		end

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
end -- class GENERATION_SELECTION_STATE
