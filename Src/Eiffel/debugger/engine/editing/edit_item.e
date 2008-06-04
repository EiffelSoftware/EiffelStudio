indexing
	description: "Shared feature between editing an attribute and editing a local variable"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDIT_ITEM

inherit
--	SHARED_APPLICATION_EXECUTION
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

feature -- Status

	waiting_for_object: BOOLEAN
		-- Are we waiting for a second object?

	modified: BOOLEAN
		-- has the last call to modify_item been successful ?

feature -- Commands

	work is
		do
				-- initialize attributes
			status := Application.status
			item_list := Void
			item := Void
			item_name := Void
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
						io.put_string(item_list.item.name+": ")
						if item_list.item.dynamic_class /= Void then
							io.put_string(item_list.item.dynamic_class.name_in_upper+"%N")
						else
							io.put_string("NONE%N")
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
						io.put_string("item not found !!%N")
					else
						io.put_string("item found...%N")
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

			type_real: REAL_32_B
			type_ptr: POINTER_B
			type_integer: INTEGER_B
			type_double: REAL_64_B
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
				io.put_string("Enter an INTEGER value: ")
				io.readline
				value_integer := io.last_string.to_integer
				generic_modify_item
				send_integer_value(value_integer)
				receive_ack

			elseif type_bool /= Void then
				io.put_string("Enter a BOOLEAN value (i.e. 'True' or 'False'): ")
				io.readline
				value_bool := io.last_string.to_boolean
				generic_modify_item
				send_bool_value(value_bool)
				receive_ack

			elseif type_real /= Void then
				io.put_string("Enter a REAL value: ")
				io.readline
				value_real := io.last_string.to_real
				generic_modify_item
				send_real_value(value_real)
				receive_ack

			elseif type_double /= Void then
				io.put_string("Enter a DOUBLE value: ")
				io.readline
				value_double := io.last_string.to_double
				generic_modify_item
				send_double_value(value_double)
				receive_ack

			elseif type_char /= Void then
				io.put_string("Enter a CHARACTER value: ")
				io.readline
				value_char := io.last_string @ 1
				generic_modify_item
				send_char_value(value_char)
				receive_ack

			elseif type_ptr /= Void then -- Pointer
				io.put_string("Enter an hexadecimal POINTER value: ")
				io.readline
				value_ptr := default_pointer + hex_to_integer(io.last_string)
				generic_modify_item
				send_ptr_value(value_ptr)
				receive_ack

			elseif item.dynamic_class /= Void and then item.dynamic_class.name_in_upper.is_equal("STRING") then
				-- this is a String
				io.put_string("Enter a STRING: ")
				io.readline
				value_string := clone(io.last_string)
				generic_modify_item
				value_string_c := value_string.to_c
				send_string_value($value_string_c)
				receive_ack

			else	-- classic reference
				modified := False
				io.put_string("Drop the object you want to assign in the 'edit_object' hole%N")
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
			io.put_string("The item was not modified due to an error or a wrong permission%N")
			io.put_string("(modifying expanded attributes is not authorized)%N%N")
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

end -- class EDIT_ITEM
