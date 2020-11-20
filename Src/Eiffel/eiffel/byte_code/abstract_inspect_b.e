note
	description: "Byte code for a multi-branch construct."

deferred class ABSTRACT_INSPECT_B [C -> ABSTRACT_CASE_B [P], P -> detachable BYTE_NODE]

inherit
	BYTE_NODE
		redefine
			analyze, generate, enlarge_tree,
			assigns_to, is_unsafe,
			optimized_byte_node, calls_special_features,
			size, inlined_byte_code, pre_inlined_code
		end
	REGISTRABLE

feature -- Access

	switch: EXPR_B
			-- Expression to inspect

	case_list: detachable BYTE_LIST [C]
			-- Alternaltives {list of CASE_B}: can be Void.

	else_part: detachable P
			-- Default construct: can be Void.

	end_location: LOCATION_AS
			-- Line number where `end' keyword is located.

feature -- Status report

	has_else_code: BOOLEAN
			-- Does `else_part` have any code?
		deferred
		end

	is_expression: BOOLEAN
			-- Is Current a multi-branch expression?
		deferred
		end

feature -- Modification

	set_switch (s: like switch)
			-- Assign `s' to `switch'.
		do
			switch := s
		end

	set_case_list (c: like case_list)
			-- Assign `c' to `case_list'.
		do
			case_list := c
		end

	set_else_part (e: like else_part)
			-- Assign `e' to `else_part'.
		do
			else_part := e
		end

	set_end_location (e: like end_location)
			-- Set `end_location' with `e'.
		require
			e_not_void: e /= Void
		do
			end_location := e
		ensure
			end_location_set: end_location = e
		end

feature -- Basic operations

	enlarge_tree
			-- Enlarge the inspect statement
		do
			switch := switch.enlarged
			if attached case_list as c then
				c.enlarge_tree
			end
			if attached else_part as p then
				p.enlarge_tree
			end
		end

	analyze
			-- Builds a proper context (for C code).
		do
			context.init_propagation
			switch.propagate (No_register)
			switch.analyze
			switch.free_register
			if attached case_list as c then
				c.analyze
			end
			if attached else_part as p then
				p.analyze
			end
		end

feature -- C code generation

	generate
			-- Generate C code in `buffer'.
		local
			buf: GENERATION_BUFFER
			start_interval: PROCEDURE
			stop_interval: PROCEDURE
			generate_interval: PROCEDURE [INTERVAL_B]
			start_block: PROCEDURE
			stop_block: PROCEDURE
			else_string: STRING_8
			is_switch: BOOLEAN
			t: TYPE_A
			base_class: CLASS_C
			creators: ARRAY [FEATURE_I]
		do
			buf := buffer
			generate_line_info
			if is_expression then
				generate_frozen_debugger_hook_nested
			else
				generate_frozen_debugger_hook
			end
			switch.generate
			buffer.put_new_line
			t := real_type (switch.type)
			if t.c_type.is_basic then
				is_switch := True
				buf.put_string ("switch (")
				switch.print_register
				buf.put_string (") {")
				buf.indent
				start_interval := agent do_nothing
				stop_interval := agent do_nothing
				generate_interval := agent {INTERVAL_B}.generate
				start_block := agent buf.indent
				stop_block := agent (b: like buffer)
					do
						b.put_new_line
						b.put_string ("break;")
						b.exdent
					end (buffer)
				else_string := "default:"
			else
					-- Build a table of creation procedures indexed by creation ID.
				base_class := t.base_class
				create creators.make_empty
				across base_class.creators as c loop
					if attached base_class.feature_of_name_id (c.key) as f then
						creators.force_and_fill (f, f.creator_position)
					end
				end
				buf.put_string ("if (0) {")
				buf.put_new_line
				buf.put_character ('}')
				start_interval := agent (b: like buffer)
					do
							-- Make sure the expression is not Void.
						b.put_string (" else if (")
						switch.print_register
						b.put_string (" && (0")
					end (buf)
				stop_interval := agent buf.put_three_character (')', ')', ' ')
				generate_interval := agent {INTERVAL_B}.generate_once (switch, creators)
				start_block := agent buf.generate_construct_block_open
				stop_block := agent buf.generate_block_close
				else_string := "else "
			end
			if attached case_list as when_parts then
				across
					when_parts is w
				loop
					w.generate_line_info
					across
						w.interval as i
					loop
						start_interval.call
						generate_interval (i.item)
						stop_interval.call
					end
					start_block.call
					generate_effect (w.content)
					stop_block.call
				end
			end
			if attached else_part as p implies has_else_code then
				buf.put_new_line
				buf.put_string (else_string)
				start_block.call
				if attached else_part as p then
					generate_effect (p)
				else
						-- Raise an exception.
					buf.put_new_line
					buf.put_string ("RTEC(EN_WHEN);")
				end
				stop_block.call
			end
			if is_switch then
				buf.exdent
				buf.put_new_line
				buf.put_character ('}')
			end
		end

feature {ABSTRACT_CASE_B} -- Code generation: C

	generate_effect (c: P)
			-- Generate code for Then_part or Else_part `c`.
		deferred
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN
		do
			Result := (attached case_list as c and then c.assigns_to (i)) or else
				(attached else_part as p and then p.assigns_to (i))
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			Result := (attached case_list as c and then c.calls_special_features (array_desc))
				or else (attached else_part as p and then p.calls_special_features (array_desc))
				or else switch.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN
		do
			Result := (attached case_list as c and then c.is_unsafe)
				or else (attached else_part as p and then p.is_unsafe)
				or else switch.is_unsafe
		end

	optimized_byte_node: like Current
		do
			Result := Current
			switch := switch.optimized_byte_node
			if attached case_list as c then
				case_list := c.optimized_byte_node
			end
			if attached else_part as p then
				else_part := p.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER
		do
			Result := 1 + switch.size
			if attached case_list as c then
				Result := Result + c.size
			end
			if attached else_part as p then
				Result := Result + p.size
			end
		end

	pre_inlined_code: like Current
		do
			Result := Current
			if attached case_list as c then
				case_list := c.pre_inlined_code
			end
			if attached else_part as p then
				else_part := p.pre_inlined_code
			end
			switch := switch.pre_inlined_code
		end

	inlined_byte_code: like Current
		do
			Result := Current
			if attached case_list as c then
				case_list := c.inlined_byte_code
			end
			if attached else_part as p then
				else_part := p.inlined_byte_code
			end
			switch := switch.inlined_byte_code
		end

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
