
class EWB_EXTERNALS 

inherit

	EWB_FORMAT
		rename
			name as externals_cmd_name,
			help_message as externals_help,
			abbreviation as externals_abb
		end

creation

	make, null

feature

	criterium (f: FEATURE_I): BOOLEAN is
		do
			Result := any_criterium (f);
			Result := Result and f.is_external
		end

end
