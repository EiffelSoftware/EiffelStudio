indexing
	description: "List of instructions that can be used as an instruction.%
		%Only used when optimizing code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INSTR_LIST_B

inherit
	INSTR_B
		redefine
			analyze, generate, size, pre_inlined_code, inlined_byte_code,
			assigns_to, calls_special_features, is_unsafe,
			optimized_byte_node, enlarge_tree
		end

create
	make

feature {NONE} -- Initialization

	make (l: like compound) is
			-- Create current with `l' as new compound.
		require
			l_not_void: l /= Void
		do
			compound := l
		ensure
			compound_set: compound = l
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_instr_list_b (Current)
		end

feature -- Access

	compound: BYTE_LIST [BYTE_NODE]
			-- List of instruction making Current.
			-- Usually content is made of INSTR_B.

feature -- Code analyzis

	analyze is
			-- Loop over `list' and analyze each item
		do
			compound.analyze
		end

feature -- C generation

	generate is
			-- Loop over `list' and generate each item
		do
			compound.generate
		end

feature -- Tree enlargment

	enlarge_tree is
			-- Loop ovet `list' and enlarges each item
		do
			compound.enlarge_tree
		end

feature -- Array optimization

	assigns_to (n: INTEGER): BOOLEAN is
		do
			Result := compound.assigns_to (n)
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := compound.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := compound.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			create Result.make (compound.optimized_byte_node)
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := compound.size
		end

	pre_inlined_code: like Current is
		do
			create Result.make (compound.pre_inlined_code)
		end

	inlined_byte_code: like Current is
		do
			create Result.make (compound.inlined_byte_code)
		end

invariant
	compound_not_void: compound /= Void
	in_final_mode: context.final_mode

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

end -- class INSTR_LIST_B
