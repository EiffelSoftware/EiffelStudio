note
	description: "[
		A base for all code template declarations.
	]"
	doc: "wiki://Code Templates:Code Template Declarations"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	CODE_DECLARATION

inherit
	CODE_SUB_NODE [CODE_DECLARATION_COLLECTION]
		rename
			make as make_sub_node
		end

feature {NONE} -- Initialization

	make (a_id: READABLE_STRING_GENERAL; a_parent: like parent)
			-- Initializes a code declaration node.
			--
			-- `a_id': A declaration identifier.
			-- `a_parent': Parent code node.
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
			a_parent_attached: a_parent /= Void
		do
			set_id (a_id.as_string_8)
			make_sub_node (a_parent)
		ensure
			id_set: id ~ a_id
			parent_set: parent = a_parent
			is_initialized: is_initialized
		end

	initialize_nodes (a_factory: like code_factory)
			-- <Precursor>
		do
			create description.make_empty
		end

feature -- Access

	id: STRING assign set_id
			-- Declaration identifier

	description: STRING_32 assign set_description
			-- Description of the identifier for user interface cues.

feature -- Element change

	set_id (a_id: like id)
			-- Sets a declaration identifier.
			--
			-- `a_id': A declaration identifier.
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		do
			create id.make_from_string (a_id)
		ensure
			id_set: id ~ a_id
		end

	set_description (a_description: like description)
			-- Set a declaration's description for UI cues.
			--
			-- `a_description': A description of the identifier for UI replacement cues.
		require
			a_description_attached: a_description /= Void
		do
			create description.make_from_string (a_description)
		ensure
			description_set: description ~ a_description
		end

feature -- Status report

	is_built_in: BOOLEAN
			-- Is the code declaration a built-in declaration.
			-- Note: Built-in declarations are not to be emitted in code template files.
		do
			Result := False
		end

invariant
	id_attached: id /= Void
	not_id_is_empty: is_initialized implies not id.is_empty
	description_attached: description /= Void

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
