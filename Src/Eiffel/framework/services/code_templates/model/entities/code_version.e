indexing
	description: "[
		Represents a code model version, for template versioning.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_VERSION

inherit
	COMPARABLE
		redefine
			is_equal,
			out
		end

	DEBUG_OUTPUT
		redefine
			is_equal,
			out
		end

create
	make

feature {NONE} -- Initialization

	make (a_version: like version)
			-- Initializes a version using a raw version string.
			--
			-- `a_version': A raw version string.
		require
			a_version: is_valid_version (a_version)
		do
			create version.make_from_string (deafult_version)
			set_version (a_version)
		ensure
			version_set: version = a_version
		end

feature -- Access

	version: !STRING_32 assign set_version
			-- Raw version string

feature -- Element change

	set_version (a_version: like version)
			-- Sets raw version string.
			--
			-- `a_version': Raw version string.
		require
			a_version: is_valid_version (a_version)
		local
			l_version: like version
		do
			if not a_version.is_equal (version) then
				l_version := version
				version := a_version
				on_version_changed (l_version)
			end
		ensure
			version_assigned: version = a_version
		end

feature -- Query

	is_valid_version (a_version: like version): BOOLEAN
			-- Determines if a raw version number is a valid version number for Current
		do
			Result := not a_version.is_empty
		ensure
			not_a_version_is_empty: Result implies not a_version.is_empty
		end

	is_compatible_with (a_other: !CODE_VERSION): BOOLEAN
			-- Determines if the Current version is compatible with another version
			--
			-- `a_other': The other version to check compatibilty with.
			-- `Result': True if Current is compatable with the supplied version
		do
			Result := Current.version.is_case_insensitive_equal (a_other.version)
		end

feature -- Visitor

	process (a_visitor: !CODE_TEMPLATE_VISITOR_I)
			-- <Precursor>
		do
		end

feature {NONE} -- Actions handlers

	on_version_changed (a_old: like version)
			-- Called when the version changes.
			-- Note: `version' will contain the new version number when called.
			--
			-- `a_old': The version number prior to the change.
		require
			a_old_is_valid_version: is_valid_version (a_old)
		do
		end

feature -- Comparison

	infix "<" (other: CODE_VERSION): BOOLEAN is
			-- <Precursor>
		do
			Result := False
		end

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := version.is_case_insensitive_equal (other.version)
		end

feature -- Output

	out: STRING_8
			-- <Precursor>
		do
			Result := version.as_string_8
		end

	debug_output: STRING_8
			-- <Precursor>
		do
			Result := out
		end

feature -- Constants

	deafult_version: STRING_8 = "0.0.0.0"
			-- Default version string

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
