class SHARED_QUERY_VALUES

feature

	output_names : ARRAY [ STRING ] is
		once
			!!Result.make(1,0);
			Result.compare_objects;
		end;

	filenames : ARRAY [ STRING ] is	
		once
			!!Result.make(1,0);
			Result.compare_objects;
		end;

	language_names: ARRAY [STRING] is
		once
			!! Result.make (1,0);
			Result.compare_objects;
		end;

	column_names : ARRAY [ STRING ] is
		once
			!!Result.make(1,0);
			Result.compare_objects;
		end;

	binary_operators : ARRAY [ STRING ] is
		once
			!!Result.make(1,0);
			Result.compare_objects;
		end;

	values : ARRAY [ STRING ] is
		once
			!!Result.make(1,0);
			Result.compare_objects;
		end;

	boolean_operators : ARRAY [ STRING ] is
		once
			!!Result.make(1,0);
			Result.compare_objects;
		end;

	subqueries: LINKED_LIST [EWB_SUBQUERY] is
		once
			!! Result.make;
		end;

	subquery_operators: LINKED_LIST [EWB_SUBQUERY_OPERATOR] is
		once
			!! Result.make;
		end;

end -- class SHARED_QUERY_VALUES
