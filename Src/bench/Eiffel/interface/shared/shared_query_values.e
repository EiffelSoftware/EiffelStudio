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

end -- class SHARED_QUERY_VALUES
