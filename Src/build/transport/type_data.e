deferred class TYPE_DATA

inherit
	
	DATA

feature

	type: CONTEXT_TYPE is
			-- Context type 
		deferred
		end;

	help_file_name: STRING is
			-- Help file name for data type
		do
			Result := type.eiffel_type
		end;

end
