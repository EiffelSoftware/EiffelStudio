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
			check_validity, history_name, feature_name
		end 

creation 		
	make

feature {NONE} -- Initialization

	make (f_name: STRING; ec: CLASS_C) is
		require
			valid_f_name: f_name /= Void
		local
			f: FEATURE_I
		do
			e_class := ec
			feature_name := f_name
			f := ec.feature_named (f_name)
				-- If `f' is `Void' the stone won't be valid.
			if f /= void then
				e_feature := f.e_feature
			end
			internal_start_position := -1
			internal_end_position := -1
		end

feature -- Properties

	feature_name: STRING
			-- Feature name

	history_name: STRING is
			-- Name used in the history list
		do
			create Result.make (0)
			Result.append (feature_name)
			Result.append (" from ")
			Result.append (e_class.name_in_upper)
		end

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
					if e_class.feature_table /= Void then
							-- System has been completely compiled and has all its
							-- feature tables.
						feat := e_class.feature_with_name (feature_name)
						if feat /= Void then
							e_feature := feat
							if start_position = -1 then
									-- calculate positions
								{FEATURE_STONE} Precursor	
							end
						end
					end
				end
			end
		end

end -- class FEATURE_NAME_STONE
