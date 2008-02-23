indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Access to Result

class RESULT_B

inherit

	ACCESS_B
		redefine
			enlarged, read_only, is_result, is_creatable,
			register_name,
			assign_code, expanded_assign_code, reverse_code,
			assigns_to, pre_inlined_code,
			is_fast_as_local, is_predefined
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_result_b (Current)
		end

feature

	read_only: BOOLEAN is False;
			-- Is Result a read-only entity ?

	type: TYPE_A is
			-- Result type
		do
			Result := context.byte_code.result_type;
		end;

	is_predefined: BOOLEAN is True
			-- Predefined as results is store in a register.

	is_result: BOOLEAN is
			-- Access is result
		do
			Result := True
		end

	is_creatable: BOOLEAN is true;
			-- Can an access to Result be a target for a creation ?

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			result_b: RESULT_B;
		do
			result_b ?= other;
			Result := result_b /= Void
		end;

	enlarged: RESULT_B is
			-- Enlarges the result node
		do
			create {RESULT_BL} Result.make (type);
		end;

	register_name: STRING is
			-- The "Result" string
		do
			Result := "Result";
		end;

feature -- IL code generation

	is_fast_as_local: BOOLEAN is true
			-- Is expression calculation as fast as loading a local?
			-- (This is not true for once functions, but there is not enough information to figure it out.)

feature -- Byte code generation

	assign_code: CHARACTER is
			-- Assignment code
		once
			Result := {BYTE_CONST}.bc_rassign
		end

	expanded_assign_code: CHARACTER is
			-- Expanded assignment code
		once
			Result := {BYTE_CONST}.bc_rexp_assign
		end

	reverse_code: CHARACTER is
			-- Reverse assignment code
		once
			Result := {BYTE_CONST}.bc_rreverse
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := i = 0
		end;

feature -- Inlining

	pre_inlined_code: INLINED_RESULT_B is
		do
			create Result
			Result.set_parent (parent)
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
