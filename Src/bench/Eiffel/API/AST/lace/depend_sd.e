indexing
	description: "Depend clause in Ace file"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DEPEND_SD

inherit
	AST_LACE
	
create
	initialize

feature {NONE} -- Initialization

	initialize (d: like depend_on; s: like script) is
			-- Create a new TWO_NAME AST node.
		require
			d_not_void: d /= Void
			s_not_void: s /= Void
		do
			depend_on := d
			script := s
		ensure
			depend_on_set: depend_on = d
			script_set: script = s
		end

feature -- Properties

	depend_on: LACE_LIST [ID_SD]
			-- Name of file to depend on.
	
	script: ID_SD
			-- Script to run when file changes.

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object.
		do
			create Result.initialize (depend_on.duplicate, script.duplicate)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then depend_on.same_as (other.depend_on)
					and then script.same_as (other.script)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			depend_on.save (st)
			st.put_string (": ")
			script.save (st)
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

end -- class DEPEND_SD
