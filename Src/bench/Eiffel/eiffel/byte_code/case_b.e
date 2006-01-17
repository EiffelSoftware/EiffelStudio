indexing
	description	: "Byte code for 'when...then' construct in multi-branch instruction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class CASE_B

inherit
	BYTE_NODE
		redefine
			analyze, generate, enlarge_tree,
			assigns_to, is_unsafe, optimized_byte_node,
			calls_special_features, size, pre_inlined_code,
			inlined_byte_code, line_number, set_line_number
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_case_b (Current)
		end

feature -- Access

	line_number : INTEGER

feature -- Line number setting

	set_line_number (lnr : INTEGER) is
		do
			line_number := lnr
		ensure then
			line_number_set: line_number = lnr
		end

feature  -- Status Report

	interval: BYTE_LIST [INTERVAL_B]
			-- Case interval {list of INTERVAL_B}: can be Void
			-- in situations such as 5..3

	compound: BYTE_LIST [BYTE_NODE]
			-- Associated compound {list of INSTR_B}: can be Void

	set_interval (i: like interval) is
			-- Assign `i' to `interval'.
		do
			interval := i
		end

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c
		end

	enlarge_tree is
			-- Enlarge the when construct
		do
			interval.enlarge_tree
			if compound /= Void then
				compound.enlarge_tree
			end
		end

	analyze is
			-- Builds a proper context (for C code).
		do
				-- Values are constants (need not be analyzed)
			if compound /= Void then
				compound.analyze
			end
		end

feature -- C generation

	generate is
			-- Generate C code in `buffer'.
		local
			buf: GENERATION_BUFFER
		do
			generate_line_info
			interval.generate
			buf := buffer
			buf.indent
			if compound /= Void then
				compound.generate
			end
			buf.put_string ("break;")
			buf.put_new_line
			buf.exdent
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := compound /= Void and then compound.assigns_to (i)
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := compound /= Void and then
						compound.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := compound /= Void and then compound.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			if compound /= Void then
				compound := compound.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := 1
			if compound /= Void then
				Result := Result + compound.size
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			if compound /= Void then
				compound := compound.pre_inlined_code
			end
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			if compound /= Void then
				compound := compound.inlined_byte_code
			end
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

end
