indexing

	description:
		"AST structure in Lace file for profiling eiffel classes.";
	date: "$Date$";
	revision: "$Revision $"

class PROFILE_SD

inherit

	OPTION_SD
	SHARED_OPTION_LEVEL

feature -- Properties

	option_name: STRING is
		once
			Result := "profile"
		end;

feature {COMPILER_EXPORTER} -- Update

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			error_raised, to_be_profiled: BOOLEAN;
			class_name: STRING;
			v: OPTION_I
		do
			if value /= Void then
				if value.is_no then
					v := No_option;
				elseif value.is_yes then
					v := All_option;
				elseif value.is_all then
					v := All_option;
				else
					error (value);
				end;
			else
				v := No_option
			end;
			if not error_raised then
				if list = Void then
					from
						classes.start;
					until
						classes.after
					loop
						classes.item_for_iteration.set_profile_level (v);
						classes.forth;
					end;
				else
					from
						list.start;
					until
						list.after
					loop
						class_name := clone (list.item);
						class_name.to_lower;
						classes.item (class_name).set_profile_level (v);
						list.forth;
					end;
				end
			end;
		end;

end -- class PROFILE_SD 
