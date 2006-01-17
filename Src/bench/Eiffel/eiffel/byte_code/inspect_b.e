indexing
	description	: "Byte code for multi-branch instruction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class INSPECT_B

inherit
	INSTR_B
		redefine
			analyze, generate, enlarge_tree,
			assigns_to, is_unsafe,
			optimized_byte_node, calls_special_features,
			size, inlined_byte_code, pre_inlined_code
		end

	VOID_REGISTER
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_inspect_b (Current)
		end

feature -- Access

	switch: EXPR_B
			-- Expression to inspect

	case_list: BYTE_LIST [BYTE_NODE]
			-- Alternaltives {list of CASE_B}: can be Void

	else_part: BYTE_LIST [BYTE_NODE]
			-- Default compound {list of INSTR_B}: can be Void

	end_location: LOCATION_AS
			-- Line number where `end' keyword is located

feature -- Status setting

	set_switch (s: like switch) is
			-- Assign `s' to `switch'.
		do
			switch := s
		end

	set_case_list (c: like case_list) is
			-- Assign `c' to `case_list'.
		do
			case_list := c
		end

	set_else_part (e: like else_part) is
			-- Assign `e' to `else_part'.
		do
			else_part := e
		end

	set_end_location (e: like end_location) is
			-- Set `end_location' with `e'.
		require
			e_not_void: e /= Void
		do
			end_location := e
		ensure
			end_location_set: end_location = e
		end

feature -- Basic operations

	enlarge_tree is
			-- Enlarge the inspect statement
		do
			switch := switch.enlarged
			if case_list /= Void then
				case_list.enlarge_tree
			end
			if else_part /= Void then
				else_part.enlarge_tree
			end
		end

	analyze is
			-- Builds a proper context (for C code).
		do
			context.init_propagation
			switch.propagate (No_register)
			switch.analyze
			switch.free_register
			if case_list /= Void then
				case_list.analyze
			end
			if else_part /= Void then
				else_part.analyze
			end
		end

feature -- C code generation

	generate is
			-- Generate C code in `buffer'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			generate_line_info
			buf.put_new_line
			generate_frozen_debugger_hook
			switch.generate
			buf.put_string ("switch (")
			switch.print_register
			buf.put_string (") {")
			buf.put_new_line
			buf.indent
			if case_list /= Void then
				case_list.generate
			end
			if else_part = Void or else not else_part.is_empty then
				buf.put_string ("default:")
				buf.put_new_line
				buf.indent
				if else_part = Void then
						-- Raise an exception
					buf.put_string ("RTEC(EN_WHEN);")
				else
					else_part.generate
					buf.put_string ("break;")
				end
				buf.put_new_line
				buf.exdent
			end
			buf.exdent
			buf.put_character ('}')
			buf.put_new_line
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := (case_list /= Void and then case_list.assigns_to (i)) or else
				(else_part /= Void and then else_part.assigns_to (i))
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := (case_list /= Void and then case_list.calls_special_features (array_desc))
				or else (else_part /= Void and then else_part.calls_special_features (array_desc))
				or else switch.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := (case_list /= Void and then case_list.is_unsafe)
				or else (else_part /= Void and then else_part.is_unsafe)
				or else switch.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			switch := switch.optimized_byte_node
			if case_list /= Void then
				case_list := case_list.optimized_byte_node
			end
			if else_part /= Void then
				else_part := else_part.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := 1 + switch.size
			if case_list /= Void then
				Result := Result + case_list.size
			end
			if else_part /= Void then
				Result := Result + else_part.size
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			if case_list /= Void then
				case_list := case_list.pre_inlined_code
			end
			if else_part /= Void then
				else_part := else_part.pre_inlined_code
			end
			switch := switch.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			if case_list /= Void then
				case_list := case_list.inlined_byte_code
			end
			if else_part /= Void then
				else_part := else_part.inlined_byte_code
			end
			switch := switch.inlined_byte_code
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
