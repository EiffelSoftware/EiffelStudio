note
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GUI_IRON_SERVICE

inherit
	ES_IRON_SERVICE
		redefine
			launch_iron_command
		end

	EVS_HELPERS

feature -- Element change

	set_associated_widget (w: detachable EV_WIDGET)
		do
			associated_widget := w
		end

feature -- Access

	associated_widget: detachable EV_WIDGET

feature {NONE} -- Package management

	launch_iron_command (a_title: READABLE_STRING_32; a_args: ITERABLE [READABLE_STRING_GENERAL])
			-- Execute externally iron command with argument `args'.
		local
			l_prc_factory: PROCESS_FACTORY
			l_prc_launcher: PROCESS
			l_dialog: IRON_OUTPUT_DIALOG
			l_done_handler: ROUTINE
			args: ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			last_launch_iron_command_succeed := False
			create args.make (3)
			across
				a_args as ic
			loop
				args.force (ic)
			end
			create l_prc_factory

				-- Launch the iron command in `eiffel_layout.bin_path' (i.e $ISE_EIFFEL/studio/soec/$ISE_PLATFORM/bin)
				-- to have access to the required DLLs on Windows (libcurl,...).
			l_prc_launcher := l_prc_factory.process_launcher (eiffel_layout.iron_command_name.name, args, eiffel_layout.bin_path.name)
			l_prc_launcher.set_separate_console (False)
			l_prc_launcher.set_hidden (True)
			create l_dialog
			l_dialog.set_process (l_prc_launcher)
			l_dialog.set_title (a_title)
			l_prc_launcher.redirect_input_to_stream
			l_prc_launcher.redirect_output_to_agent (agent l_dialog.append_in_gui_thread)
			l_prc_launcher.redirect_error_to_same_as_output

			l_done_handler := agent  (ia_dlg: IRON_OUTPUT_DIALOG; ia_prc_launcher: PROCESS)
					do
						if ia_prc_launcher.exit_code = 0 then
							ia_dlg.close_in_gui_thread
						else
								-- error occured!
						end
					end(l_dialog, l_prc_launcher)

			l_prc_launcher.set_on_exit_handler (l_done_handler)
			l_prc_launcher.set_on_terminate_handler (l_done_handler)
			l_prc_launcher.set_on_fail_launch_handler (l_done_handler)
			l_prc_launcher.launch
			if l_prc_launcher.launched then
				if attached associated_widget as w and then attached widget_top_level_window (w) as win then
					l_dialog.show_modal_to_window (win)
				else
					l_dialog.show
				end
				last_launch_iron_command_succeed := l_prc_launcher.exit_code = 0
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
