indexing
	description: "Information about C patterns"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	C_PATTERN_INFO 

inherit
	HASHABLE
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (p: like pattern) is
		require
			p_not_void: p /= Void
		do
			pattern := p
		ensure
			pattern_set: pattern = p
		end

feature -- Access

	pattern: C_PATTERN
			-- Pattern

	c_pattern_id: INTEGER
			-- Pattern id

	hash_code: INTEGER is
			-- Hash code
		do
			Result := pattern.hash_code
		end

feature -- Settings

	set_c_pattern_id (i: INTEGER) is
			-- Assign `i' to `c_pattern_id'.
		do
			c_pattern_id := i
		ensure
			c_pattern_id_set: c_pattern_id = i
		end

	set_pattern (p: C_PATTERN) is
		require
			p_not_void: p /= Void
		do
			pattern := p
		ensure
			pattern_set: pattern = p
		end

feature -- Comparison

	is_equal (other: C_PATTERN_INFO): BOOLEAN is
            -- Is `other' equal to Current ?
        do
            Result := pattern.is_equal (other.pattern)
        end

feature -- Code generation

	generate_pattern (buffer: GENERATION_BUFFER) is
			-- Generate pattern for interface between C generated code
			-- and the interpreter
		require
			buffer_not_void: buffer /= Void
		do
			pattern.generate_pattern (c_pattern_id, buffer)
		end

feature -- Debug

	trace is
		do
			io.error.put_integer (c_pattern_id)
			io.error.put_new_line
			pattern.trace
		end

invariant
	pattern_exists: pattern /= Void

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
