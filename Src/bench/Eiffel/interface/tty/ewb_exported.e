-- Exported features of a class.

class EWB_EXPORTED 

inherit

	EWB_FORMAT
		rename
			name as exported_cmd_name,
			help_message as exported_help,
			abbreviation as exported_abb
		end

creation

	make, null

feature

	criterium (f: FEATURE_I): BOOLEAN is
		local
			any_class: CLASS_C
		do
			any_class := System.any_class.compiled_class;
			if any_class /= Void then
				Result := any_criterium (f) and f.is_exported_for (any_class)
			end
		end

end
