indexing

	description: "Constants common between Eiffel products.";
	date: "$Date$";
	revision: "$Revision $"

class S_CASE_INFO

feature {NONE} -- Implementation

	directory_number (an_id: INTEGER): INTEGER is
			-- Directory number based on
			-- `an_id'
		do
			Result := an_id // 150 + 1
		end;

	System_name: STRING is "system";
			-- File name for saved system

	System_id_name: STRING is "idfile";
			-- File name for identifying eiffelcase projects

	EiffelCase_project_type: STRING is "ISE.EiffelCase.4.3";
			-- Idfile contains this

	Tmp_file_name_ext: STRING is "TMP";
			-- Extension temporary name

end -- class S_CASE_INFO
