indexing

	description:
		"AST structure in Lace file for hide%
		%option for hiding precompiled classes.";
	date: "$Date$";
	revision: "$Revision $"

class HIDE_SD

inherit

	OPTION_SD

feature -- Properties

	option_name: STRING is
		once
			Result := "hide"
		end;

feature -- Update

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			error_raised, is_hidden: BOOLEAN;
			class_name: STRING;
		do
			if System.is_precompiling then
				if value /= Void then
					if (value.is_yes or else value.is_all) then
						is_hidden := True;
					elseif not value.is_no then
						error_raised := True;
						error (value);
					end;
				else
					is_hidden := True;
				end;
				if not error_raised then
					if list = Void then
						from
							classes.start;
						until
							classes.after
						loop
							classes.item_for_iteration.set_hide_level (is_hidden);
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
							classes.item (class_name).set_hide_level (is_hidden);
							list.forth;
						end;
					end
				end;
			end;
		end;

end -- class HIDE_SD
