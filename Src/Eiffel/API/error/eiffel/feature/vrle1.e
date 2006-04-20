indexing
	description: "Error when a local variable name is a feature name also."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VRLE1

inherit
	FEATURE_ERROR
		redefine
			build_explain, subcode
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- Properties

	local_name: STRING
			-- Local variable name in conflict

	code: STRING is "VRLE"
			-- Error code

	subcode: INTEGER is
		do
			Result := 1
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.add ("Local entity name: ")
			a_text_formatter.add (local_name)
			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER}

	set_local_name (s_id: INTEGER) is
			-- Assign name extracted from name ID `s_id' to `local_name'.
		require
			valid_s_id: s_id >= 1
		do
			local_name := Names_heap.item (s_id)
		end

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

end -- class VRLE1
