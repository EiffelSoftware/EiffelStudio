indexing
	description: "Stone based on exported feature name.";
	date: "$Date$";
	revision: "$Revision$"

class
	EXPORTED_FEATURE_NAME_STONE

inherit
	FEATURE_NAME_STONE
		rename
			make as feature_make
		export
			{NONE} feature_make
		end 

creation 
	make

feature {NONE} -- Initialization

	make (f_name: STRING; ec: CLASS_C; real_name: STRING) is
		require
			valid_f_name: f_name /= Void;
		do
			feature_make (f_name, ec)
			alias_name := real_name
		end

feature -- Access

	alias_name: STRING
			-- Real name of the exported feature at the C level.

end -- class EXPORTED_FEATURE_NAME_STONE
