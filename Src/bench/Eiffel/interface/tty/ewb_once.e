
class EWB_ONCE 

inherit

	EWB_FORMAT
		rename
			name as once_cmd_name,
			help_message as once_help,
			abbreviation as once_abb
		redefine
			display_feature
		end

creation

	make, null

feature

	criterium (f: FEATURE_I): BOOLEAN is
		do
			Result := any_criterium (f);
			Result := Result and then (f.is_once or else
							f.is_constant)
		end;

	display_feature (f: FEATURE_I; c: CLASS_C) is
		local
			const: CONSTANT_I
		do
			f.append_clickable_signature (output_window, c);
			if f.is_constant then
				output_window.put_string (" is ");
				const ?= f;	--| Cannot fail
				if const.is_unique then
					output_window.put_string ("unique (");
					const.value.append_clickable_signature (output_window);
					output_window.put_char (')')
				else
					const.value.append_clickable_signature (output_window);
				end
			end
		end;

end
