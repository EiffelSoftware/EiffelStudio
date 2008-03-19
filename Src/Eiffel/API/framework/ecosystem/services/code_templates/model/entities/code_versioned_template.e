indexing
	description: "[
		Represents an actual code template tokenized code template, bound to a minimum version of the Eiffel compiler.
	]"
	doc: "wiki://Code Templates:Versioned Code Templates"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_VERSIONED_TEMPLATE

inherit
	CODE_TEMPLATE
		rename
			make as make_template
		end

create
	make

feature {NONE} -- Initialization

	make (a_version: like version; a_parent: like parent)
			-- Initialize a code template for a minimum version of the compiler
			--
			-- `a_version': The minimum version of the compiler the code template will compile with.
			-- `a_parent': Parent code node.
		do
			version := a_version
			make_template (a_parent)
		ensure
			version_set: version = a_version
		end

feature -- Access

	version: !CODE_VERSION
			-- Minumum compiled version for the template

feature -- Query

	is_compatible_with (a_version: !CODE_VERSION): BOOLEAN
			-- Determines if the Current template is compatible with the specificed version
			--
			-- `a_version': The other version to check compatibilty with.
			-- `Result': True if Current is compatable with the supplied version
		do
			Result := version.is_compatible_with (a_version)
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
