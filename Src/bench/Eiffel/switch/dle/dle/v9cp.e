-- Error for creation procedure of  dynamic classes.
-- Each class descendant of DYNAMIC in the DC-set must have at least one
-- creation procedure, one of them named `make' with exactly one argument
-- of type ANY.

class V9CP 

inherit

	EIFFEL_ERROR

feature 

	code: STRING is "V9CP";
			-- Error code

end 
