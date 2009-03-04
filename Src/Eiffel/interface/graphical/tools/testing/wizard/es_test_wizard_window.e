note
	description: "Summary description for {ES_TEST_WIZARD_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TEST_WIZARD_WINDOW

inherit
	EB_WIZARD_STATE_WINDOW
		redefine
			wizard_information
		end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE}
		end

	ES_SHARED_TEST_SERVICE
		export
			{NONE}
		end

	SHARED_SERVER
		export
			{NONE}
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE}
		end

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make_window (a_development_window: like development_window; a_wizard_info: like wizard_information)
			-- Initialize `Current'.
		require
			wizard_info_valid: has_valid_conf (a_wizard_info)
		do
			development_window := a_development_window
			make (a_wizard_info)
		ensure
			wizard_information_set: wizard_information = a_wizard_info
		end

	initialize_container (a_container: EV_VERTICAL_BOX): EV_BOX
			-- Initialize container to add widgets for wizard window
			--
			-- Note: apparently the wizard windows look better when using the parents of `choice_box'
			--       directly, however this design need to be changed.
		require
			a_container_not_void: a_container /= Void
			a_container_has_parent: a_container.parent /= Void
			a_container_has_grand_parent: a_container.parent.parent /= Void
		do
			if attached {EV_BOX} a_container.parent.parent as l_box then
				Result := l_box
				Result.wipe_out
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Access

	wizard_information: ES_TEST_WIZARD_INFORMATION
			-- <Precursor>

	conf: TEST_CREATOR_CONF
			-- Configuration applicable to current wizard window
		require
			has_valid_conf: has_valid_conf (wizard_information)
		do
			Result := wizard_information.current_conf
		ensure
			result_attached: Result /= Void
		end

	development_window: EB_DEVELOPMENT_WINDOW
			-- Window `Current' is attached to.

	current_window: attached EV_WINDOW
			-- <Precursor>
		local
			l_window: EV_WINDOW
		do
			l_window := development_window.window
			check l_window /= Void end
			Result := l_window
		end

	pixmap_factory: EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
			-- Pixmap factory
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	t_title: attached STRING
			-- Window title
		deferred
		end

	t_subtitle: attached STRING
			-- Window subtitle
		deferred
		end

feature {NONE} -- Status report

	is_valid: BOOLEAN
			-- Is `wizard_information' in a state where we can continue?
		deferred
		end

	has_valid_conf (a_wizard_info: like wizard_information): BOOLEAN
			-- Does `wizard_information' contain a valid configuration for `Current'?
		do
			Result := a_wizard_info.has_current_conf
		ensure
			result_implies_has_conf: Result implies a_wizard_info.has_current_conf
		end

feature {NONE} -- Status setting

	update_next_button_status
			-- Update status of next button.
		do
			if is_valid then
				first_window.enable_next_button
			else
				first_window.disable_next_button
			end
		end

	display_state_text
			-- <Precursor>
		do
			title.set_text (locale_formatter.translation (t_title))
			if attached {ES_TEST_WIZARD_INITIAL_WINDOW} Current as l_init then
				message.set_text (locale_formatter.translation (t_subtitle))
			else
				subtitle.set_text (locale_formatter.translation (t_subtitle))
			end
		end

feature {NONE} -- Events

	on_valid_state_changed (a_state: BOOLEAN)
			-- Called when state of `is_valid' could have changed.
		do
			update_next_button_status
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
