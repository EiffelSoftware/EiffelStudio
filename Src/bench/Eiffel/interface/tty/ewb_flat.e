indexing

	description: 
		"Displays class flat in output_window."
	date: "$Date$"
	revision: "$Revision $"

class EWB_FLAT 

inherit
	EWB_COMPILED_CLASS
		rename
			make as compiled_class_make
		redefine
			name, help_message, abbreviation
		end
	
	EB_SHARED_PREFERENCES

create
	make, default_create

feature -- Initialization

	make (cn, fn: STRING) is
			-- Initialization
		require
			cn_not_void: cn /= Void
			fn_not_void: fn /= Void
		do
			class_make (cn)
			init (fn)
		ensure
			filter_name_set: filter_name = fn
			class_name_set: class_name = cn
		end

feature -- Properties

	name: STRING is
		do
			Result := flat_cmd_name
		end

	help_message: STRING is
		do
			Result := flat_help
		end

	abbreviation: CHARACTER is
		do
			Result := flat_abb
		end

feature {NONE} -- Execution

	associated_cmd: E_SHOW_FLAT is
		do
			create Result
			Result.set_feature_clause_order (preferences.flat_short_data.feature_clause_order)
		end

end -- class EWB_FLAT
