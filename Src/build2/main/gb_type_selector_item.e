indexing
	description: "Objects that represent an item in a GB_TYPE_SELECTOR."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TYPE_SELECTOR_ITEM

inherit
	
	EV_TREE_ITEM
		redefine
			make_with_text,
			initialize
		end
		
	INTERNAL
		undefine
			default_create, is_equal, copy
		end
		
	GB_ACCESSIBLE_OBJECT_HANDLER
		undefine
			default_create, is_equal, copy
		end
		
	GB_ACCESSIBLE_HISTORY
		undefine
			default_create, is_equal, copy
		end

		-- We only inherit this to get access to the parent.
		-- We could recursively find the tree containing `Current',
		-- and do a reverse assignment onto a GB_TYPE_SELECTOR.
		-- Which is better?
	GB_ACCESSIBLE
		undefine
			default_create, is_equal, copy
		end

	GB_CONSTANTS

create
	make_with_text

feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Create `Current', assign `a_text' to `text'
			-- and "EV_" + `a_text' to `type'.
		do
			Precursor {EV_TREE_ITEM} (a_text)
			type := a_text
		end

	initialize is
			-- Initialize `Current' and initialize pick and drop transport.
		local
			last_generated_object: GB_OBJECT
		do
			Precursor {EV_TREE_ITEM}
			set_pebble_function (agent generate_transportable)
		end

feature -- Access

	type: STRING
		-- The real type represented by `Current'.
		-- i.e. "EV_BUTTON"

	generate_drop_actions (object: GB_OBJECT) is
			-- Initialize drop actions depending on
			-- the type held in `text'
			-- This must be called when a pick
			-- starts from an object.
		local
			current_type: INTEGER
			container: GB_CONTAINER_OBJECT
			cell: GB_CELL_OBJECT
			can_drop: BOOLEAN
			constructor_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			constructor_item ?= object.layout_item
			check
				constructor_item_not_void: constructor_item /= Void
			end
			
			--| Note that the checks in this feature check for the state that we do not want
			--| and then if this is not the case, perform an action. It is simpler to do it this
			--| way, as there are so many other cases that we would allow.
			
				-- Reset the drop actions.
			drop_actions.wipe_out
			
			current_type := dynamic_type_from_string (type)	
			can_drop := True
			container ?= constructor_item.object
				-- We may only replace an EV_CONTAINER with a primitive if the container is empty.
			if container /= Void and container.object.count > 0 and
				type_conforms_to (current_type, dynamic_type_from_string ("EV_PRIMITIVE"))then
				can_drop := False
			end
			
			
			
			cell ?= constructor_item.object
			if cell /= Void then
					-- We may only replace an EV_CELL with an EV_PRIMITIVE if the cell is empty.
				if type_conforms_to (current_type, dynamic_type_from_string ("EV_PRIMITIVE")) and (cell.object.count = 1) then
					can_drop := False
				end
			end
			
			container ?= constructor_item.object
			if container /= Void then
						-- We may only replace an EV_CONTAINER with an EV_SPLIT_AREA if the container
						-- holds no more than two items.
					if type_conforms_to (current_type, dynamic_type_from_string ("EV_SPLIT_AREA")) then
						if container.object.count <= 2 then
							can_drop := True
						else
							can_drop := False
						end
						-- We may only replace an EV_CONTAINER with an EV_CELL if the container
						-- holds no more than one item.
					elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_CELL")) then
						if container.object.count <= 1 then
							can_drop := True
						else
							can_drop := False
						end		
					elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_PRIMITIVE")) then
						if container.object.is_empty then
							can_drop := True
						else
							can_drop := False
						end
						
					end
				end

				--| We must override if the type represented by `object' is a window.
				--| Currently, windows are fixed and may not be replaced.
				
			if object.type.is_equal (Ev_window_string) or object.type.is_equal (Ev_titled_window_string) then
				can_drop := False
			end

			if can_drop then
				drop_actions.extend (agent replace_layout_item (?))	
			end
		end

feature {GB_OBJECT_HANDLER} -- Implementation

	generate_transportable: GB_OBJECT is
			-- `Result' is a GB_OBJECT matching `text' of `Current'.
		do
			Result := object_handler.build_object_from_string (type)
		ensure
			Result_not_void: Result /= Void
		end
		
	replace_layout_item (an_object: GB_OBJECT) is
			-- Replace `an_object' with a new object of
			-- type `text'.
		local
			command: GB_COMMAND_CHANGE_TYPE
		do	
			create command.make (an_object, an_object.type, type)
			history.cut_off_at_current_position
			command.execute
		end
		
end -- class GB_TYPE_SELECTOR_ITEM
