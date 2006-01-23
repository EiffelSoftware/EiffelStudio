indexing
	description: "A GB_OBJECT representing an EV_SPLIT_AREA"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SPLIT_AREA_OBJECT

inherit
	GB_CONTAINER_OBJECT
		redefine
			object,
			add_child_object,
			display_object
		end

create
	make_with_type,
	make_with_type_and_object

feature -- Access

	object: EV_SPLIT_AREA
		-- The vision2 object that `Current' represents.
		-- This is used in the display window.
	
	display_object: GB_SPLIT_AREA_DISPLAY_OBJECT
		-- The representation of `object' used in `build_window'.
		-- This is used in the builder window.

feature -- Basic operation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
		local
			widget: EV_WIDGET
			widget2: EV_WIDGET
			moved_object: GB_OBJECT
			constructor: GB_LAYOUT_CONSTRUCTOR_ITEM
			temp_widget: EV_WIDGET
		do
			widget ?= an_object.object
			check
				object_not_void: widget /= Void
			end
			widget2 ?= an_object.display_object
			check
				display_object_not_void: widget2 /= Void
			end
			
				-- We need to put in the first position if
				-- there is currently a second position.
			if position = 1 or (position = 2 and object.second /=  Void) then
					-- If we are trying to insert before the first item with a shift pick, then
					-- we must first move the first item to the second position.
				if (position = 1) and (not layout_item.is_empty and then layout_item.first /= Void) then
					constructor ?= layout_item.first
					moved_object ?= constructor.object
						-- If we are doing a type change, we will have already unparented this, so we
						-- must not do it again. There is no nice way to know whether we are currently
						-- in a type change.
					temp_widget ?= moved_object.object
					if temp_widget.parent /= Void then
						remove_child (moved_object)
						add_child_object (moved_object, 2)
					end
				end
				object.set_first (widget)
				display_object.child.set_first (widget2)
				if layout_item.data = Void then
					layout_item.go_i_th (1)
					layout_item.put_left (an_object.layout_item)
				end
				add_child (an_object, 1)
			else
				object.set_second (widget)
				display_object.child.set_second (widget2)
					-- Special case when moving the first item to the
					-- second position.
				if layout_item.data = Void then
					if position = 2 and (layout_item.is_empty) then
						layout_item.extend (an_object.layout_item)
					else
						layout_item.go_i_th (2)
						layout_item.put_left (an_object.layout_item)
					end
				end
				add_child (an_object, 2)
			end
		end
		
invariant
	has_no_more_than_two_children: children.count <= 2

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


end -- class GB_SPLIT_AREA_OBJECT