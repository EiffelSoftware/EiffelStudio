indexing
	description: "Info about access to a local variable of a feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LOCAL_B

inherit
	ACCESS_B
		redefine
			enlarged, read_only, is_local, is_creatable,
			register_name,
			print_register,
			assign_code, expanded_assign_code, reverse_code,
			bit_assign_code, assigns_to, array_descriptor,
			pre_inlined_code,
			is_fast_as_local, is_predefined
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_local_b (Current)
		end

feature

	position: INTEGER
			-- Position of the local in the list `locals' of the root
			-- byte code

	read_only: BOOLEAN is false
			-- Is the access only a read-only one ?

	type: TYPE_I is
			-- Local type
		do
			Result := context.byte_code.locals.item (position)
		end

	is_predefined: BOOLEAN is True
			-- Is Current a predefined entity ?

	is_local: BOOLEAN is
			-- Is Current an access to a local variable ?
		do
			Result := True
		end

	is_creatable: BOOLEAN is True
			-- Can an access to a local variable be the target for
			-- a creation ?

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			local_b: LOCAL_B
		do
			local_b ?= other
			if local_b /= Void then
				Result := position = local_b.position
			end
		end

	enlarged: LOCAL_B is
			-- Enlarge current node
		local
			loc_bl: LOCAL_BL
		do
			create loc_bl
			loc_bl.fill_from (Current)
			Result := loc_bl
		end

	register_name: STRING is
			-- The "loc<num>" string
		do
			create Result.make (10)
			Result.append ("loc")
			Result.append (position.out)
		end

	print_register is
			-- Print local
		do
			buffer.put_string (register_name)
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN is true
			-- Is expression calculation as fast as loading a local?

feature -- Byte code generation

	bit_assign_code: CHARACTER is
			-- Bits assignment code
		do
			Result := {BYTE_CONST}.bc_lbit_assign
		end

	assign_code: CHARACTER is
			-- Simple assignment code
		do
			Result := {BYTE_CONST}.bc_lassign
		end

	expanded_assign_code: CHARACTER is
			-- Expanded assignment code
		do
			Result := {BYTE_CONST}.bc_lexp_assign
		end

	reverse_code: CHARACTER is
			-- Reverse assignment code
		do
			Result := {BYTE_CONST}.bc_lreverse
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := position = - i
		end

	array_descriptor: INTEGER is
		do
			Result := -position
		end

feature -- Inlining

	pre_inlined_code: INLINED_LOCAL_B is
		do
			create Result
			Result.fill_from (Current)
		end

feature -- Setting

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		require
			valid_index: i > 0
		do
			position := i
		ensure
			position_set: position = i
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

end
