
class EWB_ROUTINES 

inherit

	EWB_FORMAT
		rename
			name as routines_cmd_name,
			help_message as routines_help,
			abbreviation as routines_abb
		end

creation

	make, null

feature

	criterium (f: FEATURE_I): BOOLEAN is
		do
			Result := any_criterium (f);
			Result := Result and (not f.is_attribute);
			Result := Result and (not f.is_constant)
		end

end
