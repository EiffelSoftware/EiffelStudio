
class D_ASSERT_I 

inherit

	REQUIRE_I
		redefine
			check_precond, has_checking
		end;
	SHARED_BYTE_CONTEXT
	
feature 

	has_checking: BOOLEAN is
			-- Is there any assertion checking?
		do
			Result := False
		end;

	check_precond: BOOLEAN is
			-- Must preconditions be checked ?
			-- No by default in final mode.
			-- Yes by default in workbench mode
		do
			Result := not context.final_mode
		end;

end
