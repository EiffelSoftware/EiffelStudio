note
	description: "Template for the last state of a wizard for EiffelStudio"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [aranud@mail.dotcom.fr]", "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BENCH_WIZARD_FINAL_STATE_WINDOW

inherit
	WIZARD_FINAL_STATE_WINDOW
		redefine
			cancel, proceed_with_current_info, wizard_information
		end

	BENCH_WIZARD_SHARED
	BENCH_WIZARD_CONSTANTS

feature -- Access

	wizard_information: WIZARD_INFORMATION
			-- Information about current state.

feature -- Basic operations

	proceed_with_current_info
		local
			d: EV_ERROR_DIALOG
		do
			project_generator.generate_code
			if attached project_generator.error as e then
				create d.make_with_text (e.message)
				d.set_title (e.title)
				d.set_buttons (<<bench_interface_names.b_ok>>)
				d.set_default_cancel_button (d.default_push_button)
				d.show_modal_to_window (first_window)
			else
				write_bench_notification_ok (wizard_information)
				Precursor
			end
		end

	cancel
			-- User has pressed the cancel button
		do
			write_bench_notification_cancel
		end

feature {NONE} -- Implementation

	project_generator: WIZARD_PROJECT_GENERATOR
			-- Project generator
		once
			create Result.make (wizard_information)
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

