note
	description: "[
		Facilities to receive DEBUG_VALUEs from application.
		Those volues might be arguments, local entities or once function result.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	version: "$Version: $"

class RECV_VALUE

inherit
	DEBUG_VALUE_EXPORTER

	REFACTORING_HELPER

	SHARED_EIFFEL_PROJECT

	COMPILER_EXPORTER

	IPC_SHARED

	SK_CONST

feature	{NONE} -- Initialization of the C/Eiffel interface

	init_recv_c
			-- Pass routine addresses to C.
		once
			c_pass_recv_routines ($set_nat8, $set_nat16, $set_nat32, $set_nat64,
				$set_int8, $set_int16, $set_int32, $set_int64, $set_bool,
				$set_char, $set_wchar, $set_real,
				$set_double, $set_ref, $set_point,
				$set_error, $set_exception_ref, $set_void)
		end

	set_error
			-- An error occurred.
		do
			error := True
		end

	set_nat8 (v: NATURAL_8)
			-- Receive an integer value.
		do
			create {DEBUG_BASIC_VALUE [NATURAL_8]} item.make (sk_uint8, v)
		end

	set_nat16 (v: NATURAL_16)
			-- Receive an integer value.
		do
			create {DEBUG_BASIC_VALUE [NATURAL_16]} item.make (sk_uint16, v)
		end

	set_nat32 (v: NATURAL_32)
			-- Receive an integer value.
		do
			create {DEBUG_BASIC_VALUE [NATURAL_32]} item.make (sk_uint32, v)
		end

	set_nat64 (v: NATURAL_64)
			-- Receive an integer value.
		do
			create {DEBUG_BASIC_VALUE [NATURAL_64]} item.make (sk_uint64, v)
		end

	set_int8 (v: INTEGER_8)
			-- Receive an integer value.
		do
			create {DEBUG_BASIC_VALUE [INTEGER_8]} item.make (sk_int8, v)
		end

	set_int16 (v: INTEGER_16)
			-- Receive an integer value.
		do
			create {DEBUG_BASIC_VALUE [INTEGER_16]} item.make (sk_int16, v)
		end

	set_int32 (v: INTEGER)
			-- Receive an integer value.
		do
			create {DEBUG_BASIC_VALUE [INTEGER]} item.make (sk_int32, v)
		end

	set_int64 (v: INTEGER_64)
			-- Receive an integer value.
		do
			create {DEBUG_BASIC_VALUE [INTEGER_64]} item.make (sk_int64, v)
		end

	set_bool (v: BOOLEAN)
			-- Receive a boolean value.
		do
			create {DEBUG_BASIC_VALUE [BOOLEAN]} item.make (sk_bool, v)
		end

	set_char (v: CHARACTER)
			-- Receive a character value.
		do
			create {CHARACTER_VALUE} item.make (sk_char8, v)
		end

	set_wchar (v: WIDE_CHARACTER)
			-- Receive a character value.
		do
			create {CHARACTER_32_VALUE} item.make (sk_char32, v)
		end

	set_real (v: REAL)
			-- Receive a real value.
		do
			create {DEBUG_BASIC_VALUE [REAL]} item.make (sk_real32 , v)
		end

	set_double (v: DOUBLE)
			-- Receive a double value.
		do
			create {DEBUG_BASIC_VALUE [DOUBLE]} item.make (sk_real64, v)
		end

	set_ref (ref: POINTER; type: INTEGER; scp_pid: NATURAL_16)
			-- Receive a reference value.
		local
			cl: CLASS_C
			add: attached DBG_ADDRESS
			l_type_id: INTEGER
			spe: SPECIAL_VALUE
			ref_value: REFERENCE_VALUE
		do
			debug ("refactor_fixme")
				fixme ("[
					Maybe we should modified the runtime, to add the 'SPECIAL' case
					and send at the same time the capacity.
					For now, this looks like a hack, but this is working.
					]")
			end
			create add.make_from_pointer (ref)
			l_type_id := type + 1
			if Eiffel_system.valid_dynamic_id (l_type_id) then
				cl := Eiffel_system.class_of_dynamic_id (l_type_id, False)
				if cl /= Void and then cl.is_special then
					create spe.make_set_ref (add, l_type_id, scp_pid)
					item := spe
				else
					create ref_value.make (add, l_type_id, scp_pid)
					item := ref_value
				end
			else
					--| The runtime is sending the debugger a wrong id ...
					--| then let's handle such case
				create {DUMMY_MESSAGE_DEBUG_VALUE} item.make_with_details (add.output, "Invalid type id: " + l_type_id.out, 0)
			end
		end

	set_exception_ref (ref: POINTER; type: INTEGER; scp_pid: NATURAL_16)
			-- Receive a exception reference value.
		local
			rf: REFERENCE_VALUE
			add: attached DBG_ADDRESS
		do
			is_exception := True

			check Eiffel_system.valid_dynamic_id (type + 1) end
			create add.make_from_pointer (ref)
			create rf.make (add, type + 1, scp_pid)
			create {EXCEPTION_DEBUG_VALUE} item.make_with_value (rf)
		end

	set_point (v: POINTER)
			-- Receive a pointer value.
		do
			create {DEBUG_BASIC_VALUE [POINTER]} item.make (sk_pointer ,v)
		end

	set_void
			-- Set `item' to Void.
		do
			item := Void
		end

feature -- Reset

	reset_recv_value
		do
			item := Void
			error := False
			is_exception := False
		end

feature -- Status report

	error: BOOLEAN
			-- Did an error occurred ?

	is_exception: BOOLEAN
			-- Is current `item' an Exception ?

feature -- internal

	item: ABSTRACT_DEBUG_VALUE
			-- Last received value.

	exception_item: EXCEPTION_DEBUG_VALUE
			-- Last received exception value.
		require
			is_exception: is_exception
		do
			Result ?= item
		ensure
			item_is_exception_value: (item /= Void) implies (Result /= Void)
		end

	recv_value (c: like Current)
		require
			c_not_void: c /= Void
		do
			c.reset_recv_value
			c_recv_value (c)
		end

feature {NONE} -- External routines

	c_recv_value (c: like Current)
				-- Check: C/ipc/ewb/ewb_dumped.c	
		external
			"C"
		end

	c_pass_recv_routines (
			d_nat8, d_nat16, d_nat32, d_nat64,
			d_int8, d_int16, d_int32, d_int64, d_bool, d_char, d_wchar, d_real, d_double,
			d_ref, d_point, d_error, d_exception_ref, d_void: POINTER)

				-- Check: C/ipc/ewb/ewb_dumped.c
		external
			"C"
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- class RECV_VALUE
