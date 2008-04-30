indexing
	description: "Objects that represent an EV_TABLE within Build."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TABLE_OBJECT

inherit
	GB_CONTAINER_OBJECT
		redefine
			object, add_child_object
		end

	DOUBLE_MATH
		undefine
			copy
		end

create
	make_with_type,
	make_with_type_and_object

feature -- Access

	object: EV_TABLE

feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_TYPE_SELECTOR_ITEM, GB_COMMAND_ADD_OBJECT} -- Basic operation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position representing `position'
			-- in the layout tree.
		local
			widget: EV_WIDGET
			table: EV_TABLE
		do
			widget ?= an_object.object
			check
				object_is_a_widget: widget /= Void
			end
			object.extend (widget)

			widget ?= an_object.display_object
			check
				display_object_is_a_widget: widget /= Void
			end
			table ?= display_object.child
			check
				child_is_a_table: table /= Void
			end
			table.extend (widget)
			if layout_item.data = Void then
				layout_item.go_i_th (position)
				layout_item.put_left (an_object.layout_item)
			end
			add_child (an_object, position)
		end

feature {GB_OBJECT_HANDLER} -- Implementation

	resize_to_accomodate (children_count: INTEGER) is
			-- Resize `display_object' and `object' of `object' to
			-- smallest square dimensions that will accomodate `children_count'
			-- children.
		local
			temp_table: EV_TABLE
			new_dimension: INTEGER
			double: DOUBLE
		do
			double := children_count
			new_dimension := (sqrt (double)).ceiling
			object.resize (new_dimension, new_dimension)
			temp_table ?= display_object.child
			check
				temp_table /= Void
			end
			temp_table.resize (new_dimension, new_dimension)
		ensure
			may_accomodate_children: object.rows * object.columns >= children_count
			-- and display_object.rows * display_object.columns >= children_count
			-- Not possible to check this right now.
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


end -- class GB_TABLE_OBJECT
