indexing
	description: "[
		A literal declaration for replacement in a selected template.
	]"
	doc: "wiki://Code Templates:Literal Declarations"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_LITERAL_DECLARATION

inherit
	CODE_DECLARATION
		redefine
			initialize_nodes
		end

create
	make

feature {NONE} -- Initialization

	initialize_nodes (a_factory: like code_factory)
			-- Initializes the default nodes for Current.
			--
			-- `a_factory': Factory used for creating nodes.
		do
			create default_value.make_empty
			is_editable := True

			Precursor (a_factory)
		end

feature -- Access

	default_value: !STRING_32 assign set_default_value
			-- A default value for the declaration to show for in-place UI editions.

feature -- Element change

	set_default_value (a_value: like default_value)
			-- Sets the default value of a literal.
			--
			-- `a_value': A literal default value to show for in-place UI editions.
		do
			default_value ?= a_value.twin
		ensure
			default_value_set: default_value.is_equal (a_value)
		end

feature -- Status report

	is_editable: BOOLEAN assign set_is_editable
			-- Is the declaration is editable, editable in the UI?

feature -- Status setting

	set_is_editable (a_editable: like is_editable)
			-- Sets the editable state of the declaration.
			--
			-- `a_editable': True to enable editable state of the declaration; False to make read-only.
		do
			is_editable := a_editable
		ensure
			is_editable_set: is_editable = a_editable
		end

feature -- Visitor

	process (a_visitor: !CODE_TEMPLATE_VISITOR_I)
			-- <Precursor>
		do
			a_visitor.process_code_literal_declaration (({!CODE_LITERAL_DECLARATION}) #? Current)
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
