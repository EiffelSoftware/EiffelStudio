class S_CASE_INFO

feature

	directory_number (an_id: INTEGER): INTEGER is
			-- Directory number based on
			-- `an_id'
		do
			Result := an_id // 150 + 1
		end;

	System_name: STRING is "system";

	System_id_name: STRING is ".idfile";

	EiffelCase_project_type: STRING is "ISE.EiffelCase.3.3";

end
