class TRACE_SD

inherit

	OPTION_SD
		redefine
			is_trace
		end;
	SHARED_TRACE_LEVEL

feature

	option_name: STRING is
		once
			Result := "trace"
		end;

	is_trace: BOOLEAN is
			-- Is the option a trace one ?
		do
			Result := True;
		end;

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			v: TRACE_I;
			class_name: STRING;
		do
			if value /= Void then
				if value.is_no then
					v := No_trace;
				elseif value.is_yes then
					v := All_trace;
				elseif value.is_all then
					v := All_trace;
				else
					error (value);
				end;
			else
				v := No_trace;
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
						class_name := list.item.duplicate;
						class_name.to_lower;
						classes.item (class_name).set_trace_level (v);
						list.forth;
					end;
				end;
			end;
		end;

end
