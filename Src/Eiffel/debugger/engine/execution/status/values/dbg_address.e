indexing
	description: "Objects that represents a remote object's address"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_ADDRESS

inherit
	HEXADECIMAL_STRING_CONVERTER
		redefine
			out, is_equal
		end

	DEBUG_OUTPUT
		redefine
			out, is_equal
		end

	HASHABLE
		redefine
			out, is_equal,
			is_hashable
		end

create
	make_void,
	make_from_string,
	make_from_pointer,
	make_from_integer_64

--| Keep it during refactorying.	
--convert
--	make_from_string ({STRING_8}),
--	make_from_pointer ({POINTER}),
--	make_from_integer ({INTEGER}),
--	as_string: {STRING_8},
--	as_pointer: {POINTER},
--	as_integer_64: {INTEGER_64}

feature {NONE} -- Initialization

	make_void
			-- Create address representing Void
		do
			is_void := True
		ensure
			is_void: is_void
		end

	make_from_string (s: STRING_8)
			-- Create address from string `s'
		do
			if s /= Void then
				value := hex_to_pointer (s)
				if value = Default_pointer then
					is_void := True
				end
			else
				is_void := True
			end
		ensure
			new_string: value /= Default_pointer implies value /= s
		end

	make_from_pointer (p: POINTER)
			-- Create address from pointer `p'
		do
			if p = Default_pointer then
				is_void := True
			else
				value := p
			end
		end

	make_from_integer_64 (i64: INTEGER_64)
			-- Create address from integer 64 `i64'
		local
			p: POINTER
			i32: INTEGER_32
		do
			if i64 = 0 then
				is_void := True
			else
				if Pointer_bytes = Integer_64_bytes then
					($p).memory_copy ($i64, Pointer_bytes)
				else
					i32 := i64.to_integer_32;
					($p).memory_copy ($i32, Pointer_bytes)
				end
				make_from_pointer (p)
			end
		end

feature -- Access

	output: STRING
			-- Output representation
		do
			if is_void then
				create Result.make_from_string ("Void")
			else
				create Result.make_from_string (as_string)
			end
		ensure
			output_not_value: output /= value
		end

	out: STRING
			-- <Precursor>
		do
			Result := as_string
			if Result = Void then
				create Result.make_empty
			else
				Result := Result.twin
			end
		end

	as_string: STRING_8
			-- Current as STRING_8 value
		do
			Result := value.out
		ensure
			Result_attached_if_not_void: (not is_void) implies (Result /= Void and then not Result.is_empty)
		end

	as_pointer: POINTER
			-- Current as POINTER value
		do
			if not is_void then
				Result := value
			end
		ensure
			Result_attached_if_not_void: (not is_void) implies (Result /= Default_pointer)
		end

	as_integer_64: INTEGER_64
			-- Current as INTEGER value
		do
			if not is_void then
				Result := hex_to_integer_64 (value.out)
			end
		ensure
			Result_attached_if_not_void: (not is_void) implies (Result /= 0)
		end

feature -- Status report

	is_void: BOOLEAN
			-- Current represents Void value

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			if is_void and other.is_void then
				Result := True
			elseif is_void then
				check other_is_not_void: not other.is_void end
				Result := False
			else
				Result := value.is_equal (other.value)
			end
		end

	hash_code: INTEGER
			-- <Precursor>
		do
			if not is_void then
				Result := value.hash_code
			end
		end

	is_hashable: BOOLEAN is
			-- <Precursor>
		do
			Result := not is_void
		end

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := output
		end

feature {DBG_ADDRESS} -- Implementation

	value: POINTER
			-- Object address internal representation

invariant
	default_value_if_is_void: is_void implies value = Default_pointer
	not_default_value_implies_not_is_void: value /= Default_pointer implies not is_void

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

end
