indexing
	description: "Trace option in Ace";
	date: "$Date$";
	revision: "$Revision$"

class TRACE_SD

inherit

	OPTION_SD
		redefine
			is_trace
		end

	SHARED_OPTION_LEVEL

feature -- Properties

	option_name: STRING is "trace"

	is_trace: BOOLEAN is True
			-- Is the option a trace one ?

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			v: OPTION_I;
			class_name: STRING;
		do
			if value /= Void then
				if value.is_no then
					v := No_option;
				elseif value.is_yes or value.is_all then
					v := All_option;
					Lace.ace_options.set_has_trace (True)
				else
					error (value);
				end;
			else
				v := No_option;
			end;
			if v /= Void then
				if list = Void then
					from
						classes.start;
					until
						classes.after
					loop
						classes.item_for_iteration.set_trace_level (v);
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
						classes.item (class_name).set_trace_level (v);
						list.forth;
					end;
				end;
			end;
		end;

end -- class TRACE_SD
