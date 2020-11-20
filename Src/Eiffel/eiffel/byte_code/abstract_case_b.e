note
	description	: "Byte code for 'when...then' construct in multi-branch construct."

deferred class ABSTRACT_CASE_B [G -> BYTE_NODE]

inherit
	BYTE_NODE
		redefine
			analyze, generate, enlarge_tree,
			assigns_to, is_unsafe, optimized_byte_node,
			calls_special_features, size, pre_inlined_code,
			inlined_byte_code, line_number, set_line_number
		end

feature {NONE} -- Creation

	make (i: like interval; c: like content)
			-- Initialize the node with interval `i` and content `c`.
		do
			interval := i
			content := c
		ensure
			interval_set: interval = i
			content_set: content = c
		end

feature -- Access

	line_number : INTEGER

	interval: BYTE_LIST [INTERVAL_B]
			-- Case interval {list of INTERVAL_B}: can be Void
			-- in situations such as 5..3

	content: G
			-- Associated content.

feature -- Status Report

	has_content: BOOLEAN
			-- Is there non-empty content associated with the case?
		deferred
		end

feature -- Modification

	set_line_number (lnr : INTEGER)
		do
			line_number := lnr
		ensure then
			line_number_set: line_number = lnr
		end

	set_interval (i: like interval)
			-- Assign `i' to `interval'.
		do
			interval := i
		end

	set_content (c: like content)
			-- Set `content` to `c`.
		do
			content := c
		end

feature -- Code generation: C

	enlarge_tree
			-- Enlarge the when construct
		do
			interval.enlarge_tree
			if attached content as c then
				c.enlarge_tree
			end
		end

	analyze
			-- Builds a proper context (for C code).
		do
				-- Values are constants (need not be analyzed)
			if attached content as c then
				c.analyze
			end
		end

	generate
			-- Generate C code in `buffer'.
		local
			buf: GENERATION_BUFFER
		do
			generate_line_info
			interval.generate
			buf := buffer
			buf.indent
			if attached content as c then
				c.generate
			end
			buf.put_new_line
			buf.put_string ("break;")
			buf.exdent
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN
		do
			Result := attached content as c and then c.assigns_to (i)
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			Result := attached content as c and then c.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN
		do
			Result := attached content as c and then c.is_unsafe
		end

	optimized_byte_node: like Current
		do
			Result := Current
			if attached content as c then
				content := c.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER
		do
			Result := 1
			if attached content as c then
				Result := Result + c.size
			end
		end

	pre_inlined_code: like Current
		do
			Result := Current
			if attached content as c then
				content := c.pre_inlined_code
			end
		end

	inlined_byte_code: like Current
		do
			Result := Current
			if attached content as c then
				content := c.inlined_byte_code
			end
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
