indexing
	description	: "Byte code for conditional alternative."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class ELSIF_B 

inherit
	BYTE_NODE
		redefine
			analyze, generate, enlarge_tree,
			find_assign_result, last_all_in_result,
			assigns_to, is_unsafe,
			optimized_byte_node, calls_special_features,
			size, pre_inlined_code, inlined_byte_code,
			line_number, set_line_number
		end

	VOID_REGISTER
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_elsif_b (Current)
		end

feature -- Access

	line_number : INTEGER
			-- Line number in the text file.

	expr: EXPR_B
			-- Conditional expression

	compound: BYTE_LIST [BYTE_NODE]
			-- Compound {list of INSTR_B}

feature -- Status setting

	set_line_number (lnr : INTEGER) is
			-- Set `line_number' to `lnr'.
		do
			line_number := lnr
		ensure then
			line_number_set: line_number = lnr
		end

	set_expr (e: EXPR_B) is
			-- Assign `e' to `expr'.
		do
			expr := e
		end

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c
		end

feature -- Basic Operations

	enlarge_tree is
			-- Enlarge the elsif construct
		do
			expr := expr.enlarged
			if compound /= Void then
				compound.enlarge_tree
			end
		end

	find_assign_result is
			-- Find all terminal assignments made to Result
		do
			if compound /= Void then
				compound.finish
				compound.item.find_assign_result
			end
		end

	last_all_in_result: BOOLEAN is
			-- Are all the exit points in the function assignments
			-- in a Result entity ?
		do
			if compound /= Void then
				compound.finish
				Result := compound.item.last_all_in_result
			end
		end

	analyze is
			-- Builds a proper context (for C code).
		do
			context.init_propagation
			expr.propagate (No_register)
			expr.analyze
			expr.free_register
			if compound /= Void then
				compound.analyze
			end
		end

	generate is
			-- Generate C code in `buffer'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			generate_line_info
			buf.put_string (" else {")
			buf.put_new_line
			buf.indent
				-- Generate a hook for the evaluation/test of the condition.
			generate_frozen_debugger_hook
			expr.generate
			buf.exdent
			buf.put_string (gc_if_l_paran)
			expr.print_register
			buf.put_string (") {")
			buf.put_new_line
			if compound /= Void then
				buf.indent
				compound.generate
				buf.exdent
			end
			buf.put_character ('}')
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := compound /= Void and then compound.assigns_to (i)
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := (compound /= Void and then
							compound.calls_special_features (array_desc))
				or else expr.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := (compound /= Void and then compound.is_unsafe)
				or else expr.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current;
			if compound /= Void then
				compound := compound.optimized_byte_node
			end
			expr := expr.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := expr.size + 1
			if compound /= Void then
				Result := Result + compound.size
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			expr := expr.pre_inlined_code
			if compound /= Void then
				compound := compound.pre_inlined_code
			end
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			expr := expr.inlined_byte_code
			if compound /= Void then
				compound := compound.inlined_byte_code
			end
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
