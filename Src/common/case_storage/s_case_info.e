class S_CASE_INFO

feature

	directory_number (an_id: INTEGER): INTEGER is
			-- Directory number based on
			-- `an_id'
		do
			Result := an_id // 100 + 1
		end;

end
