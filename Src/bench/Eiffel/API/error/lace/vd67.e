indexing
	description: "Error when trying to intialize alternative specified assembly metadata cache path."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VD67

inherit
	LACE_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_path: STRING) is
			-- Initialize new VD67 error instance.
		require
			a_path_not_void: a_path /= Void
			a_path_not_empty: not a_path.is_empty
		do
			path := a_path
		ensure
			path_set: path = a_path
		end
		
feature -- Access

	path: STRING
			-- Path to metadata cache.

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Print out error message.
		do
			a_text_formatter.add ("Path `")
			a_text_formatter.add (path)
			a_text_formatter.add ("' does not exist or you do not have the correct permissions.")
			a_text_formatter.add_new_line
		end

invariant
	path_valid: path /= Void and then not path.is_empty

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

end -- class VD67
