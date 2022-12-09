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

inherit
	COMPARABLE

	DEBUG_OUTPUT
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_path: PATH; a_original_location: READABLE_STRING_32)
			-- Create current view from real path `a_path',
			-- and `a_original_location'.
		do
			original_location := a_original_location
			path := a_path
			create info_items.make (0)
			analyze
		end

feature -- Access

	original_location: READABLE_STRING_32
			-- Original location, before any environment variable evaluation.
			-- (i.e: keep $ISE_LIBRARY for instance).

	path: PATH
			-- Path associated with related configuration file.

	system_name: READABLE_STRING_32
			-- System name

	title: detachable READABLE_STRING_32
			-- Optional title.

	library_target_name: READABLE_STRING_32
			-- Library target name is any.

	description: detachable READABLE_STRING_32
			-- Library target or System description.

	conf_option: detachable CONF_OPTION
			-- Eventual configuration options.

	info_items: STRING_TABLE [READABLE_STRING_32]
			-- Additional information.

	info (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Eventual additional information associated with key `k'.
		do
			Result := info_items.item (k)
		end

feature -- Status report

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := system_name < other.system_name
		end

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make (25)
			Result.append (system_name)
			Result.append (" (")
			Result.append (path.name)
			Result.append (")")
		end

feature -- Query

	system: detachable CONF_SYSTEM
			-- Full system object.
			-- note: it parses the associated `path' file to build the result.
			-- Also set `is_redirection`...
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
				is_redirection := l_loader.last_redirection /= Void
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

	is_redirection: BOOLEAN
			-- Is it a redirection ?

feature -- Basic operation

	analyze
			-- Analyze the configuration file located at `path'.
		local
			l_system_name: detachable READABLE_STRING_32
			l_target_name: detachable READABLE_STRING_32
			l_description: detachable READABLE_STRING_32
		do
			has_library_target := False
			if attached system as l_system then
				if is_redirection then
						-- TODO: exclude redirection!
				end
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

	set_title (a_title: detachable READABLE_STRING_32)
		do
			title := a_title
		end

	set_description (a_desc: detachable READABLE_STRING_32)
		do
			description := a_desc
		end

	set_info (a_value: READABLE_STRING_32; a_name: READABLE_STRING_GENERAL)
		do
			info_items.force (a_value, a_name)
		end

	unset_info (a_name: READABLE_STRING_GENERAL)
		do
			info_items.remove (a_name)
		end

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
