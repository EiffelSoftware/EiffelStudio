indexing
	description: "[
		Interface for all reg2wix options.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	IREG2WIX_OPTIONS

feature -- Access

	reg_files: !LINEAR [!STRING] is
			-- List of registry files to process
		require
			can_query_options: can_query_options
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
			not_result_items_is_empty: Result.for_all (agent (a_item: !STRING): BOOLEAN do Result := not a_item.is_empty end)
			result_items_exists: Result.for_all (agent (a_item: !STRING): BOOLEAN do Result := (create {RAW_FILE}.make (a_item)).exists end)
		end

	output_file_name: !STRING is
			-- Optional output file name
		require
			can_query_options: can_query_options
			use_output_file_name: use_output_file_name
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Status report

	can_query_options: BOOLEAN is
			-- Determines if options are readable
		deferred
		end

	use_output_file_name: BOOLEAN is
			-- Indicate if `output_file_name' should be used
		require
			can_query_options: can_query_options
		deferred
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
