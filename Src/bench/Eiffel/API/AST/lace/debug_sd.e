class DEBUG_SD

inherit

	OPTION_SD
		redefine
			is_debug
		end;
	SHARED_DEBUG_LEVEL

feature

	option_name: STRING is
		once
			Result := "debug"
		end;

	is_debug: BOOLEAN is
			-- Is the option a debug one ?
		do
			Result := True;
		end;

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			debug_tag: DEBUG_TAG_I;
			tag_value: STRING;
			v: DEBUG_I;
			class_name: STRING;
		do
			if value /= Void then
				if value.is_no then
					v := No_debug;
				elseif value.is_yes then
					v := Yes_debug;
				elseif value.is_all then
					v := Yes_debug;
				elseif value.is_name then
					tag_value := value.value.duplicate;
					tag_value.to_lower;
					!!debug_tag.make;
					debug_tag.tags.put (tag_value);
					v := debug_tag;
				else
					error (value);
				end;
			else
				v := No_debug;
			end;
			if v /= Void then
				if list = Void then
					from
						classes.start;
					until
						classes.after
					loop
						classes.item_for_iteration.set_debug_level (v);
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
						classes.item (class_name).set_debug_level (v);
						list.forth;
					end;
				end;
			end;
		end;

end
