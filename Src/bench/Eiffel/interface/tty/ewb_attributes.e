
class EWB_ATTRIBUTES 

inherit

	EWB_FORMAT
		rename
			name as attributes_cmd_name,
			help_message as attributes_help,
			abbreviation as attributes_abb
		end

creation

	make, null


feature

	criterium (f: FEATURE_I): BOOLEAN is
		do
			Result := any_criterium (f);
			Result := Result and f.is_attribute
		end
	
end
