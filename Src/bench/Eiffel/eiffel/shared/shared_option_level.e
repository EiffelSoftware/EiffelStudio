class SHARED_OPTION_LEVEL
	
feature {NONE}

	No_option: OPTION_I is
		once
			create Result;
		end;

	All_option: OPTION_ALL_I is
		once
			create Result;
		end;

end -- class SHARED_OPTION_LEVEL
