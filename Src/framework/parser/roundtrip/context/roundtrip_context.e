note
	description: "Object that stores formatted Eiffel code"
	legal: "See notice at end of class."
	status: "See notice at end of class."

deferred class
	ROUNDTRIP_CONTEXT

feature	-- Operation

	add_string (s: STRING)
			-- Add `s' into this context.
		require
			s_not_void: s /= Void
		deferred
		ensure
			count_set: count = old count + s.count
		end

	clear
		-- Clear this context.
		deferred
		ensure
			count_set: count = 0
			string_representation_is_empty: string_representation.is_empty
		end

	string_representation: STRING
			-- String representation of this context
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	count: INTEGER
			-- Number of characters in current context.
		deferred
		end

note
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
