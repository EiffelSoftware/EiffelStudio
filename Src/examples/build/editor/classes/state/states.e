class STATES


feature 

	exit_from_application: INTEGER is -2;
	
	return_to_previous: INTEGER is -1;
	
	basic: INTEGER is 1;
			-- BASIC
	
	viewing: INTEGER is 2;
			-- VIEWING
	
	editing: INTEGER is 3;
			-- EDITING
	
end -- class STATES
