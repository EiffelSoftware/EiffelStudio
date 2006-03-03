indexing
	description: "Description of a language name in Ace"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class LANGUAGE_NAME_SD

inherit

	AST_LACE

create
	initialize

feature {NONE} -- Initialization

	initialize (ln: like language_name) is
			-- Create a new LANGUAGE_NAME AST node.
		require
			ln_not_void: ln /= Void
		do
			language_name := ln
			language_name.to_lower
		ensure
			language_name_set: language_name = ln
		end

feature -- Properties

	language_name: ID_SD
			-- Language name

	is_c: BOOLEAN is
			-- Is the language "C"?
		do
			Result := c_name.is_equal (language_name)
		end

	is_make: BOOLEAN is
			-- Is the language "Make"?
		do
			Result := make_name.is_equal (language_name)
		end

	is_object: BOOLEAN is
			-- Is the language "Object"?
		do
			Result := object_name.is_equal (language_name)
		end

	is_include_path: BOOLEAN is
			-- Is the language "Include_path"?
		do
			Result := include_name.is_equal (language_name)
		end

	is_assembly: BOOLEAN is
			-- Is the language "Assembly"?
		do
			Result := assembly_name.is_equal (language_name)
		end

	is_dotnet_resource: BOOLEAN is
			-- Is the language "dotnet_resource"?
		do
			Result := dotnet_resource_name.is_equal (language_name)
		end

feature {NONE} -- Constants

	c_name: STRING is "c"
			-- C language name.

	make_name: STRING is "make"
			-- Make language name.

	object_name: STRING is "object"
			-- Object language name.

	include_name: STRING is "include_path"
			-- Include path specification.

	assembly_name: STRING is "assembly"
			-- Assembly name.

	dotnet_resource_name: STRING is "dotnet_resource";
			-- Dotnet resource name.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class LANGUAGE_NAME_SD
