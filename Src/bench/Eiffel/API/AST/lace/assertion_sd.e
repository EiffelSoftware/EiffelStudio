indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class ASSERTION_SD

inherit

	OPTION_SD
		redefine
			is_assertion
		end;
	SHARED_ASSERTION_LEVEL

feature -- Properties

	option_name: STRING is "assertion"

	is_assertion: BOOLEAN is True
			-- Is the option an assertion one ?

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			v: ASSERTION_I;
			class_name: STRING;
		do
			if value /= Void then
				if value.is_no then
					v := No_level;
				else
					if value.is_require then
						v := Require_level;
					elseif value.is_ensure then
						v := Ensure_level;
					elseif value.is_invariant then
						v := Invariant_level;
					elseif value.is_loop then
						v := Loop_level;
					elseif value.is_check then
						v := Check_level;
					elseif value.is_all then
						v := Check_level;
					else
						error (value);
					end;
						-- If an error occured, the assertion level
						-- will be reset later on.
					Lace.ace_options.set_has_assertion (True)
				end
			else
				v := Require_level;
			end;
			if v /= Void then
				if list = Void then
					from
						classes.start;
					until
						classes.after
					loop
						classes.item_for_iteration.set_assertion_level (v);
						classes.forth;
					end;
				else
					from
						list.start;
					until
						list.after
					loop
						class_name := clone (list.item)
						class_name.to_lower;
						classes.item (class_name).set_assertion_level (v);
						list.forth;
					end;
				end;
			end;
		end;

end -- class ASSERTION_SD
