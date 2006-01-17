indexing
	description: "AST representation of an external structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_LANG_AS

inherit
	AST_EIFFEL
		undefine
			text
		redefine
			is_equivalent
		end

	LEAF_AS

create
	initialize

feature {AST_FACTORY} -- Initialization

	initialize (l: like language_name) is
			-- Create a new EXTERNAL_LANGUAGE AST node.
		require
			l_not_void: l /= Void
		do
			language_name := l
			parse
		ensure
			language_name_set: language_name = l
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_external_lang_as (Current)
		end

feature -- Attributes

	language_name: STRING_AS;
			-- Language name
			-- might be replaced by external_declaration or external_definition

	extension: EXTERNAL_EXTENSION_AS
			-- Parsed external extension

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- FIXME: is_equivalent should be done on EXTERNAL_EXTENSION_AS
			Result := language_name.is_equivalent (other.language_name)
		end

feature {NONE} -- Implementation

	parse is
			-- Parse external declaration
		do
			-- do nothing
		end

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

end -- class EXTERNAL_LANG_AS
