note
	description: "An extension to initialize more command-line services in addiion to standard services of the compiler."

class
	SERVICE_INITIALIZER_EXTENSION

inherit
	SERVICE_INITIALIZER
		redefine
			add_core_services
		end

feature -- Services

	add_core_services (c: SERVICE_CONTAINER_S)
			-- <Precursor>
		do
			Precursor (c)
			c.register_with_activator ({COMMAND_LINE_OPTION_EXTENSION_S}, agent new_command_line_option_service, False)
		end

feature {NONE} -- Factory

	new_command_line_option_service: COMMAND_LINE_OPTION_EXTENSION_S
			-- New command-line option service.
		do
			create {EC_COMMAND_LINE_OPTION_EXTENSION} Result
		ensure
			is_interface_usable: attached Result implies Result.is_interface_usable
		end

note
	date: "$Date$";
	revision: "$Revision$"
	copyright: "Copyright (c) 2021-2022 Schaffhausen Institute of Technology"
	author: "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
