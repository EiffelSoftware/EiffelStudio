
class EWB_DEFERRED 

inherit

	EWB_FORMAT
		rename
			name as deferred_cmd_name,
			help_message as deferred_help,
			abbreviation as deferred_abb
		end

creation

	make, null

feature

	criterium (f: FEATURE_I): BOOLEAN is
		do
			Result := any_criterium (f);
			Result := Result and f.is_deferred
		end

end
