indexing
	description: "Shared feature between editing an attribute and editing a local variable"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDIT_ITEM

inherit
	SHARED_APPLICATION_EXECUTION
	IPC_SHARED
	DEBUG_EXT
	BEURK_HEXER

feature {EDIT_ITEM} -- Private attributes
		
	status: APPLICATION_STATUS
		-- Current application's status.

	item_list: LIST[ABSTRACT_DEBUG_VALUE]
		-- list of all known items (locals, arguments, object attributes, ...).

	item: ABSTRACT_DEBUG_VALUE
		-- item we will modify
	
	item_name: STRING
		-- name of the item we will modify
	
	project_tool: PROJECT_W
		-- Current project tool

feature -- Status

	waiting_for_object: BOOLEAN
		-- Are we waiting for a second object?

	modified: BOOLEAN
		-- has the last call to modify_item been successful ?
		
feature -- Commands

	work(given_project_tool: PROJECT_W) is
		do
				-- initialize attributes
			status := Application.status
			item_list := Void
			item := Void
			item_name := Void
			project_tool := given_project_tool
			waiting_for_object := False

			if Application.is_running and then status /= Void and then status.is_stopped then
					-- start the modification
				start_feature

				if item_list /= Void then
						-- display the item_list
					from
						item_list.start
					until
						item_list.after
					loop
						io.putstring(item_list.item.name+": ")
						if item_list.item.dynamic_class /= Void then
							io.putstring(item_list.item.dynamic_class.name_in_upper+"%N")
						else
							io.putstring("NONE%N")
						end
						item_list.forth
					end

						-- ask for the name of the item to edit
					io.put_string("Enter the name of the item you want to edit: ")
					io.readline
					item_name := clone(io.last_string)

						-- search the item by name
					from
						item_list.start
					until
						item_list.after or
						item_list.item.name.is_equal(item_name)
					loop
						item_list.forth
					end

						-- get item location
					if item_list.after then
						io.putstring("item not found !!%N")
					else
						io.putstring("item found...%N")
							-- item found...
						item := item_list.item
					end
				end

					-- modify the item
				if item /= Void then -- NB: `item' may have initialized in `start_feature'
					modify_item
					if modified then
						update_display
					end
				end
			end
		end

	go_on(new_value: OBJECT_STONE) is
			-- Set `dest_stone' to `new_value': Record the
			-- object that will be used as new value when
			-- modifying the item.
		require
			waiting_for_object
		do
			modified := True
			waiting_for_object := False
			generic_modify_item
			send_ref_value(hex_to_integer(new_value.object_address))
			receive_ack

			update_display
		end

feature {NONE} -- Implementation

	modify_item is
			-- modify the item `item'
			-- (2nd part of the request)
		local
			value_real: REAL
			value_ptr: POINTER
			value_integer: INTEGER
			value_double: DOUBLE
			value_char: CHARACTER
			value_bool: BOOLEAN
			value_string: STRING
			value_string_c: ANY

			type_real: REAL_B
			type_ptr: POINTER_B
			type_integer: INTEGER_B
			type_double: DOUBLE_B
			type_char: CHARACTER_B
			type_bool: BOOLEAN_B
		do
			type_real ?= item.dynamic_class
			type_ptr ?= item.dynamic_class
			type_integer ?= item.dynamic_class
			type_double ?= item.dynamic_class
			type_char ?= item.dynamic_class
			type_bool ?= item.dynamic_class

			modified := True	-- by default, we will succeed

			if type_integer /= Void then
				io.putstring("Enter an INTEGER value: ")
				io.readline
				value_integer := io.last_string.to_integer
				generic_modify_item
				send_integer_value(value_integer)
				receive_ack

			elseif type_bool /= Void then
				io.putstring("Enter a BOOLEAN value (i.e. 'True' or 'False'): ")
				io.readline
				value_bool := io.last_string.to_boolean
				generic_modify_item
				send_bool_value(value_bool)
				receive_ack

			elseif type_real /= Void then
				io.putstring("Enter a REAL value: ")
				io.readline
				value_real := io.last_string.to_real
				generic_modify_item
				send_real_value(value_real)
				receive_ack

			elseif type_double /= Void then
				io.putstring("Enter a DOUBLE value: ")
				io.readline
				value_double := io.last_string.to_double
				generic_modify_item
				send_double_value(value_double)
				receive_ack

			elseif type_char /= Void then
				io.putstring("Enter a CHARACTER value: ")
				io.readline
				value_char := io.last_string @ 1
				generic_modify_item
				send_char_value(value_char)
				receive_ack

			elseif type_ptr /= Void then -- Pointer
				io.putstring("Enter an hexadecimal POINTER value: ")
				io.readline
				value_ptr := default_pointer + hex_to_integer(io.last_string)
				generic_modify_item
				send_ptr_value(value_ptr)
				receive_ack

			elseif item.dynamic_class /= Void and then item.dynamic_class.name_in_upper.is_equal("STRING") then
				-- this is a String
				io.putstring("Enter a STRING: ")
				io.readline
				value_string := clone(io.last_string)
				generic_modify_item
				value_string_c := value_string.to_c
				send_string_value($value_string_c)
				receive_ack

			else	-- classic reference
				modified := False
				io.putstring("Drop the object you want to assign in the 'edit_object' hole%N")
				waiting_for_object := True
			end
		end

	receive_ack is
		local
			error_code: INTEGER
		do
			if not recv_ack then
				modified := False
				error_code := 0
				display_error_message(error_code)
			end
		end

	display_error_message(error_code: INTEGER) is
		do
			io.putstring("The item was not modified due to an error or a wrong permission%N")
			io.putstring("(modifying expanded attributes is not authorized)%N%N")
		end

feature {EDIT_ITEM} -- Deferred features

	generic_modify_item is
			-- Send the 1st part of the 'modify-item' request.
		deferred
		end

	start_feature is
			-- What to do to initialize the modification of an item.
		deferred
		end

	update_display is
			-- update windows which content may be out-of-date.
		deferred
		end

end -- class EDIT_ITEM
