indexing
	description: "Objects that allow modification of attributes. For%
		% insertion into a GB_OBJECT_EDITOR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_EDITOR_ITEM

inherit
	EV_VERTICAL_BOX

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

feature -- Access

	update_for_child_addition: BOOLEAN
		-- must `Current be updated when a child
		-- has been added?

	type_represented: STRING
		-- Type of object represented and
		-- modifyable by `Current'.
		-- i.e. EV_SENSITIVE, EV_BUTTON etc.

	creating_class: GB_EV_ANY
		-- `Result' is class that created `Current'.

feature -- Status Setting

	enable_update_for_child_addition is
			-- Assign `True' to `update_for_child_addition'.
		do
			update_for_child_addition := True
		end

	set_type_represented (a_type: STRING) is
			-- Assign `a_type' to `type'.
		require
			type_not_void: a_type /= Void
		do
			type_represented := a_type
		ensure
			type_represented.is_equal (a_type)
		end

	set_creating_class (a_class: GB_EV_ANY) is
			-- Assign `a_class' to `creating_class'.
		do
			creating_class := a_class
		end


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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


end -- class GB_OBJECT_EDITOR_ITEM
