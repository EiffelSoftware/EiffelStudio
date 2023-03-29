note
	description: "Objects that represents a remote object's address"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_ADDRESS

inherit
	HEXADECIMAL_STRING_CONVERTER
		export
			{NONE} all
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

	PLATFORM
		redefine
			out, is_equal
		end

create
	make_from_address,
	make_void,
	make_from_string,
	make_from_pointer,
	make_from_natural_64

--| Keep it during refactorying.	
--convert
--	make_from_string ({STRING_8}),
--	make_from_pointer ({POINTER}),
--	make_from_integer ({INTEGER}),
--	as_string: {STRING_8},
--	as_pointer: {POINTER},
--	as_integer_64: {INTEGER_64}

feature {NONE} -- Initialization

	make_from_address (a_add: detachable like Current)
			-- Create address based on `a_add'
		do
			if a_add /= Void then
				value := a_add.value
				offset := a_add.offset
			else
				make_void
			end
		end

	make_void
			-- Create address representing Void
		do
			is_void := True
		ensure
			is_void: is_void
		end

	make_from_string (s: READABLE_STRING_GENERAL)
			-- Create address from string `s'
			--| FIXME: does not handle offset
		local
			p: INTEGER
		do
			if s /= Void then
				p := s.last_index_of ('+', s.count)
				if p > 0 then
					value := hex_to_pointer (s.substring (1, p - 1))
					if
						attached s.substring (p + 1, s.count) as s_offset and then
						s_offset.is_integer
					then
						offset := s_offset.to_integer
					else
						--| Erroneous value ...
						is_void := True
						check should_not_occur: False end
					end
				else
					value := hex_to_pointer (s)
				end
				if value = Default_pointer then
					is_void := True
				end
			else
				is_void := True
			end
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

--Unused for now.
--	make_from_integer_64 (i64: INTEGER_64)
--			-- Create address from integer 64 `i64'
--			--| FIXME: does not handle offset			
--		local
--			p: POINTER
--			i32: INTEGER_32
--		do
--			if i64 = 0 then
--				is_void := True
--			else
--				if Pointer_bytes = Integer_64_bytes then
--					($p).memory_copy ($i64, Pointer_bytes)
--				else
--					i32 := i64.to_integer_32;
--					($p).memory_copy ($i32, Pointer_bytes)
--				end
--				make_from_pointer (p)
--			end
--		end

	make_from_natural_64 (n64: NATURAL_64)
			-- Create address from narual 64 `n64'
			--| FIXME: does not handle offset
		local
			p: POINTER
			n32: NATURAL_32
		do
			if n64 = 0 then
				is_void := True
			else
				if Pointer_bytes = Natural_64_bytes then
					($p).memory_copy ($n64, Pointer_bytes)
				else
					n32 := n64.to_natural_32;
					($p).memory_copy ($n32, Pointer_bytes)
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
				Result := as_string
			end
		ensure
			output_not_value: output /= as_string
		end

	out: STRING
			-- <Precursor>
		do
			Result := as_string
			if Result = Void then
				create Result.make_empty
			end
		end

	as_string: STRING_8
			-- Current as STRING_8 value
		do
			Result := value.out
			if has_offset then
				Result.append_character ('+')
				Result.append_integer (offset)
			end
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

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			if is_void and other.is_void then
				Result := True
			elseif is_void then
				check other_is_not_void: not other.is_void end
				Result := False
			else
				Result := value ~ other.value and offset = other.offset
			end
		end

	hash_code: INTEGER
			-- <Precursor>
		do
			if not is_void then
				Result := value.hash_code
			end
		end

	is_hashable: BOOLEAN
			-- <Precursor>
		do
			Result := not is_void
		end

	has_offset: BOOLEAN
			-- Has offset?
		do
			Result := offset > 0
		end

feature -- Access

	offset: INTEGER
			-- In case of SPECIAL[Expanded]
			-- we access the item by Address of Special + `offset'
			-- Then Current's pointer indicates the container's reference

feature -- Basic operation

	set_offset (n: like offset)
			-- Set `offset' to `n'
		require
			valid_offset: n > 0
		do
			offset := n
		end

feature {DBG_ADDRESS} -- Implementation

	value: POINTER
			-- Object address internal representation

feature -- Debug

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := output
		end

invariant
	default_value_if_is_void: is_void implies value = Default_pointer
	not_default_value_implies_not_is_void: value /= Default_pointer implies not is_void

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
