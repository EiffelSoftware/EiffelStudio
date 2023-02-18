note
	description: "Shared feature between editing an attribute and editing a local variable"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDIT_ITEM

inherit
	SHARED_DEBUGGER_MANAGER
	IPC_SHARED
	DEBUG_EXT
	HEXADECIMAL_STRING_CONVERTER

feature {EDIT_ITEM} -- Private attributes

	status: APPLICATION_STATUS
		-- Current application's status.

	item_list: LIST [ABSTRACT_DEBUG_VALUE]
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

	work
		do
				-- initialize attributes
			status := debugger_manager.application.status
			item_list := Void
			item := Void
			item_name := Void
			waiting_for_object := False

			if debugger_manager.application.is_running and then status /= Void and then status.is_stopped then
					-- start the modification
				start_feature

				if item_list /= Void then
						-- display the item_list
					from
						item_list.start
					until
						item_list.after
					loop
						io.put_string_32 (item_list.item_for_iteration.name + ": ")
						if item_list.item_for_iteration.dynamic_class /= Void then
							io.put_string(item_list.item_for_iteration.dynamic_class.name_in_upper+"%N")
						else
							io.put_string("NONE%N")
						end
						item_list.forth
					end

						-- ask for the name of the item to edit
					io.put_string("Enter the name of the item you want to edit: ")
					io.readline
					item_name := io.last_string.twin

						-- search the item by name
					from
						item_list.start
					until
						item_list.after or
						item_list.item_for_iteration.name.is_equal(item_name)
					loop
						item_list.forth
					end

						-- get item location
					if item_list.after then
						io.put_string("item not found !!%N")
					else
						io.put_string("item found...%N")
							-- item found...
						item := item_list.item_for_iteration
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

	go_on(new_value: DBG_ADDRESS)
			-- Set `dest_stone' to `new_value': Record the
			-- object that will be used as new value when
			-- modifying the item.
		require
			waiting_for_object
		do
			modified := True
			waiting_for_object := False
			generic_modify_item
			send_ref_value (new_value.as_pointer)
			receive_ack

			update_display
		end

feature {NONE} -- Implementation

	modify_item
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
			l_dyn_class: detachable CLASS_C
		do
			l_dyn_class := item.dynamic_class

			modified := True	-- by default, we will succeed

			if attached {INTEGER_B} l_dyn_class as type_integer then
				io.put_string("Enter an INTEGER value: ")
				io.readline
				value_integer := io.last_string.to_integer
				generic_modify_item
				send_integer_value(value_integer)
				receive_ack

			elseif attached {BOOLEAN_B} l_dyn_class as type_bool then
				io.put_string("Enter a BOOLEAN value (i.e. 'True' or 'False'): ")
				io.readline
				value_bool := io.last_string.to_boolean
				generic_modify_item
				send_bool_value(value_bool)
				receive_ack

			elseif attached {REAL_32_B} l_dyn_class as type_real then
				io.put_string("Enter a REAL value: ")
				io.readline
				value_real := io.last_string.to_real
				generic_modify_item
				send_real_value(value_real)
				receive_ack

			elseif attached {REAL_64_B} l_dyn_class as type_double then
				io.put_string("Enter a DOUBLE value: ")
				io.readline
				value_double := io.last_string.to_double
				generic_modify_item
				send_double_value(value_double)
				receive_ack

			elseif attached {CHARACTER_B} l_dyn_class as type_char then
				io.put_string("Enter a CHARACTER value: ")
				io.readline
				value_char := io.last_string [1]
				generic_modify_item
				send_char_value(value_char)
				receive_ack

			elseif attached {POINTER_B} l_dyn_class as type_ptr then -- Pointer
				io.put_string("Enter an hexadecimal POINTER value: ")
				io.readline
				value_ptr := default_pointer + hex_to_integer_32 (io.last_string)
				generic_modify_item
				send_ptr_value(value_ptr)
				receive_ack

			elseif l_dyn_class /= Void and then item.dynamic_class.name_in_upper.is_equal ("STRING") then
				-- this is a String
				io.put_string("Enter a STRING: ")
				io.readline
				value_string := io.last_string.twin
				generic_modify_item
				value_string_c := value_string.to_c
				send_string_value ($value_string_c, value_string.count)
				receive_ack

			else	-- classic reference
				modified := False
				io.put_string("Drop the object you want to assign in the 'edit_object' hole%N")
				waiting_for_object := True
			end
		end

	receive_ack
		local
			error_code: INTEGER
		do
			if not recv_ack then
				modified := False
				error_code := 0
				display_error_message(error_code)
			end
		end

	display_error_message(error_code: INTEGER)
		do
			io.put_string("The item was not modified due to an error or a wrong permission%N")
			io.put_string("(modifying expanded attributes is not authorized)%N%N")
		end

feature {EDIT_ITEM} -- Deferred features

	generic_modify_item
			-- Send the 1st part of the 'modify-item' request.
		deferred
		end

	start_feature
			-- What to do to initialize the modification of an item.
		deferred
		end

	update_display
			-- update windows which content may be out-of-date.
		deferred
		end

feature {NONE} -- Implementation: to be implemented

	send_integer_value (a_value: INTEGER)
		do

		end

	send_real_value (a_value: REAL)
		do

		end

	send_double_value (a_value: DOUBLE)
		do

		end

	send_char_value (a_value: CHARACTER)
		do

		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
