indexing
	description: "Objects that represent an item in a GB_TYPE_SELECTOR."
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
		
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end
		
	GB_SHARED_HISTORY
		export
			{NONE} all
		end

		-- We only inherit this to get access to the parent.
		-- We could recursively find the tree containing `Current',
		-- and do a reverse assignment onto a GB_TYPE_SELECTOR.
		-- Which is better?
	GB_SHARED_TOOLS
		export
			{NONE} all
		end

	GB_CONSTANTS
		export
			{NONE} all
		end
		
	GB_SHARED_DIGIT_CHECKER
		export
			{NONE} all
		end
		
feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Create `Current', assign `a_text' to `text'
			-- and "EV_" + `a_text' to `type'.
		deferred
		end

feature -- Access

	item: EV_ABSTRACT_PICK_AND_DROPABLE
		-- Graphical representation of `Current' used in the type selector.

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
			primitive: GB_PRIMITIVE_OBJECT
			menu_bar: GB_MENU_BAR_OBJECT
			can_drop: BOOLEAN
		do
			--| Note that the checks in this feature check for the state that we do not want
			--| and then if this is not the case, perform an action. It is simpler to do it this
			--| way, as there are so many other cases that we would allow.
			
				-- Reset the drop actions.
			item.drop_actions.wipe_out
			
			current_type := dynamic_type_from_string (type)	
			can_drop := True
			container ?= object
				-- We may only replace an EV_CONTAINER with a primitive if the container is empty.
			if container /= Void and container.object.count > 0 and
				type_conforms_to (current_type, dynamic_type_from_string (Ev_primitive_string)) then
				can_drop := False
			end
			
			primitive ?= object
			if primitive /= Void  then
					-- We cannot directly query the count of a primitive
					-- as only some primitives support items. Checking the count
					-- of the layout item achieves this in a general way.
				if primitive.children.count > 0 then
					can_drop := False
				end
			end
			
			
			cell ?= object
			if cell /= Void then
					-- We may only replace an EV_CELL with an EV_PRIMITIVE if the cell is empty.
				if type_conforms_to (current_type, dynamic_type_from_string (Ev_primitive_string)) and (cell.object.count = 1) then
					can_drop := False
				end
			end
			
			container ?= object
			if container /= Void then
						-- We may only replace an EV_CONTAINER with an EV_SPLIT_AREA if the container
						-- holds no more than two items.
					if type_conforms_to (current_type, dynamic_type_from_string (ev_split_area_string)) then
						if container.object.count <= 2 then
							can_drop := True
						else
							can_drop := False
						end
						-- We may only replace an EV_CONTAINER with an EV_CELL if the container
						-- holds no more than one item.
					elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_cell_string)) then
						if container.object.count <= 1 then
							can_drop := True
						else
							can_drop := False
						end		
					elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_primitive_string)) then
						if container.object.is_empty then
							can_drop := True
						else
							can_drop := False
						end
						
					end
				end
				
				-- Special case for menu bar.
				-- Menu bars are not widgets, or items, and can only
				-- be replaced by other menu bars.
			if type_conforms_to (current_type, dynamic_type_from_string (Ev_menu_bar_string)) then
				menu_bar ?= object
				if menu_bar = Void then
					can_drop := False
				end
			end	
				
			check
				parent_of_object_not_void: object.parent_object /= Void
			end
			
			if not object.parent_object.accepts_child (type) then
				can_drop := False
			end

				-- We must override if the type represented by `object' is a window
				-- or `Current' represents a window, as nothing may be replaced by a window.
				-- Currently, windows are fixed and may not be replaced.
				
			if object.type.is_equal (Ev_window_string) or object.type.is_equal (Ev_titled_window_string) or object.type.is_equal (Ev_dialog_string) or
				type.is_equal (Ev_window_string) or type.is_equal (Ev_titled_window_string) or type.is_equal (Ev_dialog_string) then
				can_drop := False
			end
			
				-- This prevents the type of an object being changed if it is a representation
				-- of a top level object.
			if object.is_instance_of_top_level_object then
				can_drop := False
			end

			if can_drop then
				item.drop_actions.extend (agent replace_layout_item (?))	
			end
		end

feature {GB_OBJECT_HANDLER} -- Implementation

	generate_transportable: GB_OBJECT is
			-- `Result' is a GB_OBJECT matching `text' of `Current'.
		do
				-- Firstly, wipe out all drop actions for the type_selector
				-- as they must now be empty, as we are picking a new type,
				-- not an object.
			type_selector.update_drop_actions_for_all_children (Void)
			
			process_number_key
			
				-- Note that this generates a new id, so if the pnd is cancelled, we
				-- will have used an other id, although this should not be a problem.
				-- As the ids will be compacted when the project is next loaded.
			Result := object_handler.build_object_from_string_and_assign_id (type)
		ensure
			Result_not_void: Result /= Void
		end
		
	process_number_key is
			-- Begin processing by `digit_checker', so that
			-- it can be determined if a digit key is held down.
		deferred
		end
		
	replace_layout_item (an_object: GB_OBJECT) is
			-- Replace `an_object' with a new object of
			-- type `text'.
		local
			command: GB_COMMAND_CHANGE_TYPE
		do	
			create command.make (an_object, an_object.type, type)
			command.execute
		end

invariant
	type_not_void: type /= Void
	item_not_void: item /= Void
		
end -- class GB_TYPE_SELECTOR_ITEM
