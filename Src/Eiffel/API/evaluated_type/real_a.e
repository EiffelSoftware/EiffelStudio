note
	description: "Actual type for real type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class REAL_A

inherit
	BASIC_A
		rename
			make as cl_make
		redefine
			is_real_32, is_real_64, associated_class, same_as, is_numeric,
			process, heaviest
		end

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER)
			-- Create instance of INTEGER_A represented by `n' bits.
		require
			valid_n: n = 32 or n = 64
		do
			size := n.to_integer_8
			cl_make (associated_class.class_id)
		ensure
			size_set: size = n
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_real_a (Current)
		end

feature -- Property

	is_real_32: BOOLEAN
			-- Is the current type a real 32-bit type?
		do
			Result := size = 32
		end

	is_real_64: BOOLEAN
			-- Is the current type a real 64-bit type?
		do
			Result := size = 64
		end

feature -- Access

	associated_class: CLASS_C
			-- Class REAL
		do
			if size = 32 then
				Result := System.real_32_class.compiled_class
			else
				Result := System.real_64_class.compiled_class
			end
		end

	size: INTEGER_8
			-- Current is stored on `size' bits.

feature -- IL code generation

	heaviest (other: TYPE_A): TYPE_A
			-- `other' if `other' is heavier than Current,
			-- Current otherwise.
		do
			if other.is_real_64 then
				Result := other
			else
				Result := Current
			end
		end

feature {COMPILER_EXPORTER}

	is_numeric: BOOLEAN = True
			-- Is the current type a numeric type ?

	c_type: TYPE_C
			-- C type
		do
			if size = 32 then
				Result := real32_c_type
			else
				Result := real64_c_type
			end
		end

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		do
			Result := attached {REAL_A} other as r and then size = r.size
		end

invariant
	correct_size: size = 32 or size = 64

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class REAL_32_A
