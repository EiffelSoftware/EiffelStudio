note
	description: "[
			This class is a view of {CONF_SYSTEM_VIEW}
			mainly used to library dialog data
			and allow to store safely and with small size.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_SYSTEM_VIEW

create
	make,
	make_from_path

feature {NONE} -- Initialization

	make (a_loc: CONF_LOCATION)
			-- Create current view from location `a_loc'.
		do
			make_from_path (a_loc.evaluated_path)
		end

	make_from_path (a_path: PATH)
			-- Create current view from location path `a_path'.
		do
			path := a_path
			analyze
		end

feature -- Access

	path: PATH
			-- Path associated with related configuration file.

	system_name: READABLE_STRING_32
			-- System name

	library_target_name: READABLE_STRING_32
			-- Library target name is any.

	description: detachable READABLE_STRING_32
			-- Library target or System description.

	conf_option: detachable CONF_OPTION
			-- Eventual configuration options.

feature -- Query

	system: detachable CONF_SYSTEM
			-- Full system object.
			-- note: it parses the associated `path' file to build the result.
		local
			l_factory: CONF_PARSE_FACTORY
			l_loader: CONF_LOAD
		do
			has_library_target := False
			create l_factory
			create l_loader.make (l_factory)
			l_loader.retrieve_configuration (path.name)
			if
				not l_loader.is_error and then
				attached l_loader.last_system as l_system
			then
				Result := l_system
			end
		end

	library_target: detachable CONF_TARGET
			-- If any, return the library target object.
		do
			if attached system as sys then
				Result := sys.library_target
			end
		end

feature -- Status report

	has_library_target: BOOLEAN
			-- Has a library target ?

feature -- Basic operation

	analyze
			-- Analyze the configuration file located at `path'.
		local
			l_system_name: READABLE_STRING_32
			l_target_name: READABLE_STRING_32
			l_description: detachable READABLE_STRING_32
		do
			has_library_target := False
			if attached system as l_system then
				l_system_name := l_system.name
				l_description := l_system.description
				if l_description /= Void and then l_description.is_empty then
					l_description := Void
				end
				if attached l_system.library_target as l_target then
					has_library_target := True
					conf_option := l_target.options
					l_target_name := l_target.name
					if
						attached l_target.description as l_target_description and then
						not l_target_description.is_empty
					then
						l_description := l_target_description
					end
				end
			end
			if l_system_name = Void then
				l_system_name := ""
			end
			if l_target_name = Void then
				l_target_name := ""
			end

			system_name := l_system_name
			library_target_name := l_target_name
			description := l_description
		end


;note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
