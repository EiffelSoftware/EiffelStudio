indexing

	description: 
		"Stone based on feature name.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_NAME_STONE

inherit

	FEATURE_STONE
		rename
			make as old_make,
			check_validity as old_check_validity
		end;
	FEATURE_STONE
		rename
			make as old_make
		redefine
			check_validity
		select
			check_validity 
		end 

creation 
		
	make

feature -- Initialization

	make (f_name: STRING; ec: E_CLASS) is
		require
			valid_f_name: f_name /= Void;
		do
			e_class := ec;
			feature_name := f_name;
			start_position := -1;
			end_position := -1;
		end;

feature -- Properties

	feature_name: STRING;
			-- Feature name

feature -- Update

	check_validity is
			-- Check the validity of the stone.
		local
			feat: E_FEATURE
		do
			if start_position /= 0 then
				-- Means check has been done and is
				-- invalid
				if e_class /= Void then
						-- Find e_feature from feature_name.
					feat := e_class.feature_with_name (feature_name);
					if feat /= Void then
						e_feature := feat;
						if start_position = -1 then
								-- calculate positions
							old_check_validity	
						end
					end
				end
			end
		end;

end -- class FEATURE_NAME_STONE
