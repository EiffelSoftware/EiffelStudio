-- Error list for constraint genericity validity rule

class SHARED_CONSTRAINT_ERROR
	
feature {NONE}

	Constraint_error_list: LINKED_LIST [CONSTRAINT_INFO] is
			-- List of error info for constraint genericity
		once
			!!Result.make;
		end;

end
