indexing

	description: 
		"This has the data as an attribute instead as%
		%a function. (EXP stands for expanded). This means%
		%that the Current stone has an associated feature data.";
	date: "$Date$";
	revision: "$Revision $"

class EXP_FEATURE_STONE

inherit
		
	FEATURE_STONE

creation

	make

feature -- Initialization

	make (a_data: like data) is
			-- Set data to `a_data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end;

feature -- Property

	data: FEATURE_DATA;
			-- Feature data of Current stone

end -- class EXP_FEATURE_STONE
