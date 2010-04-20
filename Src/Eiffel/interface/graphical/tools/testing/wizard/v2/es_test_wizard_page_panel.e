note
	description: "Summary description for {ES_TEST_WIZARD_PAGE_PANEL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TEST_WIZARD_PAGE_PANEL

inherit
	ES_WIDGET [EV_VERTICAL_BOX]
		rename
			make as make_widget
		redefine
			on_after_initialized
		end

	EV_LAYOUT_CONSTANTS

	EB_VISION2_FACILITIES
		rename
			interface_names as eb_interface_names,
			interface_messages as eb_interface_messages
		end

	ES_SHARED_TEST_SERVICE

feature {NONE} -- Initialization

	make  (a_composition: like composition)
			-- Initialize `Current'.
		do
			composition := a_composition
			make_widget
		end

	frozen on_after_initialized
			-- <Precursor>
		do
			if session_manager.is_service_available then
				initialize_with_session (session_manager.service)
			else
					-- TODO: show info dialog and disable input fields
			end
		end

	initialize_with_session (a_service: SESSION_MANAGER_S)
			-- Initialize `Current' with service data.
		require
			a_service_usable: a_service.is_interface_usable
		deferred
		end

feature -- Access

	composition: ES_TEST_WIZARD_COMPOSITION
			-- Wizard window displaying `Current'.

feature -- Status report

	is_valid: BOOLEAN
			-- Is the current user input valid to be used in a test session?
		deferred
		end

feature {ES_TEST_WIZARD_PAGE} -- Basic operations

	store
			-- Store current state to session manager.
		require
			valid: is_valid
		do
			if session_manager.is_service_available then
				store_to_session (session_manager.service)
			end
		end

feature {NONE} -- Basic operations

	store_to_session (a_service: SESSION_MANAGER_S)
			-- Store current state to session.
		require
			valid: is_valid
			a_service_usable: a_service.is_interface_usable
		deferred
		end

	on_valid_state_change
			-- Called when `is_valid' has possibly changed.
		do
			composition.on_valid_state_change
		end

feature {NONE} -- Events

	on_valid_state_changed (a_state: BOOLEAN)
			-- Called when valid state changes.
		do
			on_valid_state_change
		end

feature {NONE} -- Factory

	create_widget: like widget
			-- <Precursor>
		do
			create Result
			Result.set_padding (dialog_unit_to_pixels (18))
			Result.set_border_width (dialog_unit_to_pixels (15))
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
