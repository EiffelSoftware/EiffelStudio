indexing
	description: 
		"Stone based on feature name."
	date: "$Date$"
	revision: "$Revision $"

class
	FEATURE_NAME_STONE

inherit
	FEATURE_STONE
		rename
			make as old_make
		redefine
			update, feature_name, stone_signature
		end 

create 		
	make

feature {NONE} -- Initialization

	make (f_name: STRING; ec: CLASS_C) is
		require
			valid_f_name: f_name /= Void
			ec_not_void: ec /= Void
		do
			e_class := ec
			feature_name := f_name
			e_feature := ec.feature_with_name (f_name)
			internal_start_position := -1
			internal_end_position := -1
		end

feature -- Properties

	feature_name: STRING
			-- Feature name
			
	stone_signature: STRING is
			-- Signature of Current feature
		do
			Result := feature_name.twin
		end

feature -- Update

	update is
			-- Update current feature stone.
		local
			retried: BOOLEAN
		do
			if not retried then
				if internal_start_position = -1 or else e_feature = Void then
						-- Means check has been done and is invalid
						-- Find e_feature from feature_name.
					if e_class.has_feature_table then
							-- System has been completely compiled and has all its
							-- feature tables.
						e_feature := e_class.feature_with_name (feature_name)
						if e_feature /= Void then
							Precursor {FEATURE_STONE}	
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

end -- class FEATURE_NAME_STONE
