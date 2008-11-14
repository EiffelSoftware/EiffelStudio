indexing
	description: "[
		A object declaration for replacement in a selected template, like a literal ({CODE_LITERAL_DECLARATION}) but uses type conformance.
	]"
	doc: "wiki://Code Templates:Literal Declarations"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_OBJECT_DECLARATION

inherit
	CODE_LITERAL_DECLARATION
		redefine
			initialize_nodes,
			process
		end

create
	make

feature {NONE} -- Initialization

	initialize_nodes (a_factory: like code_factory)
			-- Initializes the default nodes for Current.
			--
			-- `a_factory': Factory used for creating nodes.
		do
			create must_conform_to.make_from_string ("ANY")
			Precursor (a_factory)
		end

feature -- Access

	must_conform_to: !STRING_32 assign set_must_conform_to
			-- A object value conformance type.

feature -- Element change

	set_must_conform_to (a_type: like must_conform_to)
			-- Set the object value conformance type.
			--
			-- `a_type': The type the object literal must conform to.
		require
			not_a_type_is_empty: not a_type.is_empty
		do
			must_conform_to := a_type.twin
		ensure
			must_conform_to_set: must_conform_to.is_equal (a_type)
		end

feature -- Visitor

	process (a_visitor: !CODE_TEMPLATE_VISITOR_I)
			-- <Precursor>
		do
			a_visitor.process_code_object_declaration (Current)
		end

invariant
	not_must_conform_to_is_empty: is_initialized implies not must_conform_to.is_empty

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
