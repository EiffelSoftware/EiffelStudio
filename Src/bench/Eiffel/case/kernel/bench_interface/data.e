indexing

	description: 
		"Abstraction of undelying data information of Eiffelcase.";
	date: "$Date$";
	revision: "$Revision $"

deferred class DATA

inherit
 
	ONCES
	CONSTANTS

feature -- Properties

	stone_type: INTEGER is
			-- Stone type of Current
		deferred
		end;

	has_elements: BOOLEAN  is
			-- Does Current contain other elements?
		do
		end;

feature -- Output

	focus: STRING is
		deferred
		end;

	name_for_command: STRING is
			-- Name used in undoable commands.
			-- Name is generated from the dynamic value of object 
			-- (minus the  _DATA) so it is very important to name
			-- data as <name_of_data>_DATA.
		do
			!! Result.make (0);
			Result.append (generator);
			Result.to_lower;
			Result := Result.substring (1, Result.count - 5);
		end;

feature -- Debug

	trace is
		do
			--io.error.putstring (focus);
			io.error.new_line;
		end;

feature -- Update

	update_display (a_data: DATA) is
		require
			has_elements: has_elements;
			valid_data: a_data /= Void
		do
		end;

feature -- Convenience

	free_information is
			-- Free class information (invariants,
			-- features and chart information);
		do
			-- Do nothing
		end;

	request_for_information is
			-- Request for class information (invariants,
			-- features and chart information);
		do
		end;

	is_in_class_content: BOOLEAN is
			-- Is Current in class content?
		do
		end;

end -- class DATA
