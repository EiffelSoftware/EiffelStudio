
class D_ASSERT_I 

inherit

	REQUIRE_I
		redefine
			check_precond
		end;
	SHARED_BYTE_CONTEXT
	
feature 

	check_precond: BOOLEAN is
			-- Must preconditions be checked ?
			-- No by default in final mode.
			-- Yes by default in workbench mode
		do
			Result := not context.final_mode
		end;

end
