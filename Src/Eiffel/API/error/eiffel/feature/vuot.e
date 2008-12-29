note
	description: "Error in Object-Test Local declaration."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class VUOT

inherit
	FEATURE_ERROR
		undefine
			subcode
		redefine
			build_explain
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- Error properties

	code: STRING = "VUOT"
			-- Error code

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			a_text_formatter.add ("Object-Test Local: ")
			a_text_formatter.add (local_name)
			a_text_formatter.add_new_line
		end

feature {NONE} -- Access

	local_name: STRING
			-- Object-Test Local name

feature {NONE} -- Modification

	set_local_name (id: INTEGER)
			-- Assign name extracted from name ID `id' to `local_name'.
		require
			valid_id: id >= 1
		do
			local_name := Names_heap.item (id)
		end

note
	copyright:	"Copyright (c) 2007, Eiffel Software"
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
