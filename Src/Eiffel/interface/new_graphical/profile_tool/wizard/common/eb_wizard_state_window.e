indexing
	description	: "Sub-Window which displays user entries needed in order to proceed"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Pascal FREUND, Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_WIZARD_STATE_WINDOW

inherit
	EB_WIZARD_STATE_MANAGER

feature {NONE} -- Initialization

	make (an_info: like wizard_information) is
			-- Create current object with information
			-- relative to current state 'an_info'.
			-- Should be redefined when needed.
		require
			info_exists: an_info /= Void
		do
			wizard_information := an_info
		ensure
			information_set: wizard_information /= Void
		end

feature -- Basic Operations

	clean_screen is
			-- Clean Current screen, in order to display only
			-- the current sub-window.
		do
			main_box.wipe_out
		ensure
			done: main_box.count=0
		end

	display is
			-- Display Current
		require
			clean_screen: main_box.count=0
		deferred
		ensure
			at_least_one_entry_asked_to_the_user: main_box.count>0
		end

	display_state_text is
			-- Display texts about current state
		require
			texts_exists: title /= Void and message /= Void
		deferred
		ensure
			texts_written: title.text /= Void
		end

	proceed_with_current_info is
			-- Process user entries, and
			-- perform actions accordingly.
			-- This is executed when user press 'Next'.
		deferred
		end

	update_state_information is
			-- Check User entries.
		do
		end

	cancel is
			-- Action performed by Current when the user
			-- exits the wizard ( he presses "Cancel") .
		do
		end

	build is
			-- Build widgets
		deferred
		ensure
			main_box_has_at_least_one_element: main_box.count > 0
		end

feature -- Access

	message: EV_LABEL
			-- Page message

	title: EV_LABEL
			-- Page title.

	subtitle: EV_LABEL
			-- Page subtitle

	is_final_state: BOOLEAN is
			-- Is this state a final state? (False by default)
		do
		end

feature {NONE} -- Implementation

	wizard_information: EB_WIZARD_INFORMATION;
			-- State relative to Current State.

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

end -- class WIZARD_STATE_WINDOW
