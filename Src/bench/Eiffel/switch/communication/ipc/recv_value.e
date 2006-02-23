indexing
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

	SK_CONST

feature	{} -- Initialization of the C/Eiffel interface

	init_recv_c is
			-- Pass routine addresses to C.
		once
			c_pass_recv_routines ($set_nat8, $set_nat16, $set_nat32, $set_nat64,
				$set_int8, $set_int16, $set_int32, $set_int64, $set_bool,
				$set_char, $set_wchar, $set_real,
				$set_double, $set_ref, $set_point,
				$set_bits, $set_error, $set_void)
		end

	set_error is
			-- An error occurred.
		do
			error := True
		end

	set_nat8 (v: NATURAL_8) is
			-- Receive an integer value.
		do
			create {DEBUG_VALUE [NATURAL_8]} item.make (sk_uint8, v)
		end

	set_nat16 (v: NATURAL_16) is
			-- Receive an integer value.
		do
			create {DEBUG_VALUE [NATURAL_16]} item.make (sk_uint16, v)
		end

	set_nat32 (v: NATURAL_32) is
			-- Receive an integer value.
		do
			create {DEBUG_VALUE [NATURAL_32]} item.make (sk_uint32, v)
		end

	set_nat64 (v: NATURAL_64) is
			-- Receive an integer value.
		do
			create {DEBUG_VALUE [NATURAL_64]} item.make (sk_uint64, v)
		end

	set_int8 (v: INTEGER_8) is
			-- Receive an integer value.
		do
			create {DEBUG_VALUE [INTEGER_8]} item.make (sk_int8, v)
		end

	set_int16 (v: INTEGER_16) is
			-- Receive an integer value.
		do
			create {DEBUG_VALUE [INTEGER_16]} item.make (sk_int16, v)
		end

	set_int32 (v: INTEGER) is
			-- Receive an integer value.
		do
			create {DEBUG_VALUE [INTEGER]} item.make (sk_int32, v)
		end

	set_int64 (v: INTEGER_64) is
			-- Receive an integer value.
		do
			create {DEBUG_VALUE [INTEGER_64]} item.make (sk_int64, v)
		end

	set_bool (v: BOOLEAN) is
			-- Receive a boolean value.
		do
			create {DEBUG_VALUE [BOOLEAN]} item.make (sk_bool, v)
		end

	set_char (v: CHARACTER) is
			-- Receive a character value.
		do
			create {CHARACTER_VALUE} item.make (sk_char, v)
		end

	set_wchar (v: WIDE_CHARACTER) is
			-- Receive a character value.
		do
			create {DEBUG_VALUE [WIDE_CHARACTER]} item.make (sk_wchar, v)
		end

	set_real (v: REAL) is
			-- Receive a real value.
		do
			create {DEBUG_VALUE [REAL]} item.make (sk_real32 , v)
		end

	set_double (v: DOUBLE) is
			-- Receive a double value.
		do
			create {DEBUG_VALUE [DOUBLE]} item.make (sk_real64, v)
		end

	set_ref (ref: POINTER; type: INTEGER) is
			-- Receive a reference value.
		local
			cl: CLASS_C
		do
			fixme ("[
				Maybe we should modified the runtime, to add the 'SPECIAL' case
				and send at the same time the capacity.
				For now, this looks like a hack, but this is working.
				]")

			if Eiffel_system.valid_dynamic_id (type + 1) then
				cl := Eiffel_system.class_of_dynamic_id (type + 1)
				if
					cl /= Void
					and then cl.is_special
				then
					create {SPECIAL_VALUE} item.make_set_ref (ref, type + 1)
				else
					create {REFERENCE_VALUE} item.make (ref, type + 1)
				end
			else
				check False end
				create {REFERENCE_VALUE} item.make (ref, type + 1)
			end
		end

	set_point (v: POINTER) is
			-- Receive a pointer value.
		do
			create {DEBUG_VALUE [POINTER]} item.make (sk_pointer ,v)
		end

	set_bits (ref: POINTER; size: INTEGER)  is
			-- Receive a bit value.
		do
			create {BITS_VALUE} item.make (ref, size)
		end

	set_void is
			-- Set `item' to Void.
		do
			item := Void
		end

	clear_item is
		do
			item := Void
		end

feature -- Status report

	error: BOOLEAN
			-- Did an error occurr?

feature {NONE} -- internal

	item: ABSTRACT_DEBUG_VALUE
			-- Last received value

feature {NONE} -- External routines

	c_recv_value (c: like Current) is
		external
			"C"
		end

	c_pass_recv_routines (
			d_nat8, d_nat16, d_nat32, d_nat64,
			d_int8, d_int16, d_int32, d_int64, d_bool, d_char, d_wchar, d_real, d_double,
			d_ref, d_point, d_bits, d_error, d_void: POINTER)
		is
		external
			"C"
		end

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

end -- class RECV_VALUE
