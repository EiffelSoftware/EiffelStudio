note
	date: "$Date$"
	revision: "$Revision$"

class
	ES_IRON_SERVICE

inherit
	EIFFEL_LAYOUT

	CONF_INTERFACE_CONSTANTS

feature -- Package management

	install_package (p: IRON_PACKAGE; cb: detachable PROCEDURE [TUPLE [succeed: BOOLEAN]])
		local
			l_id: READABLE_STRING_32
		do
			refresh
			if
				not installation_api.is_package_installed (p)
			then
				if installation_api.conflicting_available_package (p) /= Void then
					l_id := p.location.string
				else
					l_id := p.identifier
				end
				launch_iron_command (conf_interface_names.iron_box_package_installation_title (l_id),
						 <<{STRING_32} "install", {STRING_32} "--batch", l_id>>
					)

				if last_launch_iron_command_succeed then
						-- The client should notify the change,
						-- but for now, let's notify it twice.
					installation_api.notify_change
				end
				if cb /= Void then
					cb.call ([last_launch_iron_command_succeed])
				end
			end
		end

	uninstall_package (p: IRON_PACKAGE; cb: detachable PROCEDURE [TUPLE [succeed: BOOLEAN]])
		local
			l_id: READABLE_STRING_32

		do
			refresh
			if
				installation_api.is_package_installed (p)
			then
				if installation_api.conflicting_available_package (p) /= Void then
					l_id := p.location.string
				else
					l_id := p.identifier
				end
				launch_iron_command (conf_interface_names.iron_box_package_uninstallation_title (l_id),
						<<{STRING_32} "remove", {STRING_32} "--batch", l_id>>
					)

				if last_launch_iron_command_succeed then
						-- The client should notify the change,
						-- but for now, let's notify it twice.
					installation_api.notify_change
				end
				if cb /= Void then
					cb.call ([last_launch_iron_command_succeed])
				end
			end
		end

	update_iron (cb: detachable PROCEDURE [TUPLE [succeed: BOOLEAN]])
			-- Update iron data and call associated callback `cb'.
		do
			launch_iron_command (conf_interface_names.iron_box_updating_title,
					<<{STRING_32} "update", {STRING_32} "--batch">>
				)
			if last_launch_iron_command_succeed then
					-- The client should notify the change,
					-- but for now, let's notify it twice.
				installation_api.notify_change
			end
			if cb /= Void then
				cb.call ([last_launch_iron_command_succeed])
			end
		end

feature {NONE} -- Package management		

	launch_iron_command (a_title: READABLE_STRING_32; a_args: ITERABLE [READABLE_STRING_GENERAL])
			-- Execute externally iron command with argument `args'.
		local
			l_prc_factory: PROCESS_FACTORY
			l_prc_launcher: PROCESS
			args: ARRAYED_LIST [READABLE_STRING_GENERAL]
			l_output: STRING
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

			l_prc_launcher.redirect_input_to_stream
			create l_output.make (100)
			l_prc_launcher.redirect_output_to_agent (agent (s: STRING; buf: STRING) do buf.append (s) end(?, l_output))
			l_prc_launcher.redirect_error_to_same_as_output

			l_prc_launcher.launch
			if l_prc_launcher.launched then
				last_launch_iron_command_succeed := l_prc_launcher.exit_code = 0
			end
		end

	last_launch_iron_command_succeed: BOOLEAN
			-- Did last `launch_iron_command (..)' succeed?

feature -- Basic operations

	refresh
		do
			installation_api.refresh
		end

	refresh_installed_packages
		do
			installation_api.refresh_installed_packages
		end

	refresh_available_packages
		do
			installation_api.refresh_available_packages
		end

feature -- Access: Api

	installation_api: IRON_INSTALLATION_API
		local
			fac: CONF_IRON_INSTALLATION_API_FACTORY
			l_iron_layout: IRON_LAYOUT
			l_api: like internal_installation_api
		do
			l_api := internal_installation_api
			if l_api /= Void and then not l_api.is_up_to_date then
				l_api := Void
			end
			if l_api = Void then
				create l_iron_layout.make_with_path (eiffel_layout.iron_path, eiffel_layout.installation_iron_path)
				create fac
				l_api := fac.iron_installation_api (l_iron_layout, create {IRON_URL_BUILDER})
				internal_installation_api := l_api
			end
			Result := l_api
		end

	internal_installation_api: detachable IRON_INSTALLATION_API

;note
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
