indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class SHARED_QUERY_VALUES

feature -- Access

	output_names : ARRAY [STRING] is
		once
			create Result.make(1, 0)
			Result.compare_objects
		end

	filenames : ARRAY [STRING] is	
		once
			create Result.make(1, 0)
			Result.compare_objects
		end

	language_names: ARRAY [STRING] is
		once
			create Result.make (1, 0)
			Result.compare_objects
		end

	column_names : ARRAY [STRING] is
		once
			create Result.make(1, 0)
			Result.compare_objects
		end

	binary_operators : ARRAY [STRING] is
		once
			create Result.make(1, 0)
			Result.compare_objects
		end

	values : ARRAY [STRING] is
		once
			create Result.make(1, 0)
			Result.compare_objects
		end

	boolean_operators : ARRAY [STRING] is
		once
			create Result.make(1, 0)
			Result.compare_objects
		end

	subqueries: LINKED_LIST [SUBQUERY] is
		once
			create Result.make
		end

	subquery_operators: LINKED_LIST [SUBQUERY_OPERATOR] is
		once
			create Result.make
		end

feature -- Element change

	clear_values is
			-- Remove all old values, to be able to
			-- reset values to their defaults.
		local
			empty_array: ARRAY [STRING]
		do
			create empty_array.make (1, 0)
			empty_array.compare_objects
			output_names.copy (empty_array)
			filenames.copy (empty_array)
			language_names.copy (empty_array)
			column_names.copy (empty_array)
			binary_operators.copy (empty_array)
			values.copy (empty_array)
			boolean_operators.copy (empty_array)
			subqueries.wipe_out
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

end -- class SHARED_QUERY_VALUES
