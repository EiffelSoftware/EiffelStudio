indexing
	description: "Objects that represent an item in a GB_TYPE_SELECTOR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_TYPE_SELECTOR_ITEM

inherit
	INTERNAL
		export
			{NONE} all
		end

	GB_CONSTANTS
		export
			{NONE} all
		end

	ANY

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_text (a_text: STRING; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current', assign `a_text' to `text'
			-- , "EV_" + `a_text' to `type' and `a_components' to `components'.
		require
			a_text_not_void_or_empty: a_text /= Void or not a_text.is_empty
			a_components_not_void: a_components /= Void
		deferred
		ensure
			components_set: components = a_components
		end

feature -- Access

	item: EV_ABSTRACT_PICK_AND_DROPABLE
		-- Graphical representation of `Current' used in the type selector.

	type: STRING
		-- The real type represented by `Current'.
		-- i.e. "EV_BUTTON"

	can_drop_object (object_stone: GB_STANDARD_OBJECT_STONE): BOOLEAN is
			-- Can `object' be dropped on `Current'?
			-- Used as  a veto function to prevent an invalid type from being changed.
		require
			object_stone_not_void: object_stone /= Void
		local
			current_type: INTEGER
			container: GB_CONTAINER_OBJECT
			cell: GB_CELL_OBJECT
			primitive: GB_PRIMITIVE_OBJECT
			menu_bar: GB_MENU_BAR_OBJECT
			object: GB_OBJECT
		do
			--| Note that the checks in this feature check for the state that we do not want
			--| and then if this is not the case, perform an action. It is simpler to do it this
			--| way, as there are so many other cases that we would allow.
			object ?= object_stone.object

			current_type := dynamic_type_from_string (type)
			Result := True

			Result := object.object /= Void
				-- This check ensures that we do nothing if we have just picked an object from
				-- the type selector as it may not be replaced.
			if result then

				container ?= object
					-- We may only replace an EV_CONTAINER with a primitive if the container is empty.
				if container /= Void and container.object.count > 0 and
					type_conforms_to (current_type, dynamic_type_from_string (Ev_primitive_string)) then
					Result := False
				end

				primitive ?= object
				if primitive /= Void  then
						-- We cannot directly query the count of a primitive
						-- as only some primitives support items. Checking the count
						-- of the layout item achieves this in a general way.
					if primitive.children.count > 0 then
						Result := False
					end
				end


				cell ?= object
				if cell /= Void then
						-- We may only replace an EV_CELL with an EV_PRIMITIVE if the cell is empty.
					if type_conforms_to (current_type, dynamic_type_from_string (Ev_primitive_string)) and (cell.object.count = 1) then
						Result := False
					end
				end

				container ?= object
				if container /= Void then
						-- We may only replace an EV_CONTAINER with an EV_SPLIT_AREA if the container
						-- holds no more than two items.
					if type_conforms_to (current_type, dynamic_type_from_string (ev_split_area_string)) then
						if container.object.count <= 2 then
							Result := True
						else
							Result := False
						end
						-- We may only replace an EV_CONTAINER with an EV_CELL if the container
						-- holds no more than one item.
					elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_cell_string)) then
						if container.object.count <= 1 then
							Result := True
						else
							Result := False
						end
					elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_primitive_string)) then
						if container.object.is_empty then
							Result := True
						else
							Result := False
						end

					end
				end

					-- Special case for menu bar.
					-- Menu bars are not widgets, or items, and can only
					-- be replaced by other menu bars.
				if type_conforms_to (current_type, dynamic_type_from_string (Ev_menu_bar_string)) then
					menu_bar ?= object
					if menu_bar = Void then
						Result := False
					end
				end

				if object.parent_object = Void then
						-- This prevents top level objects from being replaced.
					Result := False
				elseif not object.parent_object.accepts_child (type) then
					Result := False
				end

					-- We must override if the type represented by `object' is a window
					-- or `Current' represents a window, as nothing may be replaced by a window.
					-- Currently, windows are fixed and may not be replaced.

				if object.type.is_equal (Ev_window_string) or object.type.is_equal (Ev_titled_window_string) or object.type.is_equal (Ev_dialog_string) or
					type.is_equal (Ev_window_string) or type.is_equal (Ev_titled_window_string) or type.is_equal (Ev_dialog_string) then
					Result := False
				end

					-- This prevents the type of an object being changed if it is a representation
					-- of a top level object.
				if object.is_instance_of_top_level_object then
					Result := False
				end
			end
		end

feature {GB_OBJECT_HANDLER} -- Implementation

	generate_transportable: GB_OBJECT_STONE is
			-- `Result' is a GB_OBJECT matching `text' of `Current'.
		do
				-- Note that this generates a new id, so if the pnd is cancelled, we
				-- will have used an other id, although this should not be a problem.
				-- As the ids will be compacted when the project is next loaded.
			Result := create {GB_STANDARD_OBJECT_STONE}.make_with_object (components.object_handler.build_object_from_string_and_assign_id (type))
		ensure
			Result_not_void: Result /= Void
		end

	replace_layout_item (object_stone: GB_STANDARD_OBJECT_STONE) is
			-- Replace `an_object' with a new object of
			-- type `text'.
		require
			object_stone_not_void: object_stone /= Void
		local
			command: GB_COMMAND_CHANGE_TYPE
		do
			create command.make (object_stone.object, object_stone.object.type, type, components)
			command.execute
		end

invariant
	type_not_void: type /= Void
	item_not_void: item /= Void

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


end -- class GB_TYPE_SELECTOR_ITEM
