indexing
	description: "Optimize option in Ace";
	date: "$Date$";
	revision: "$Revision$"

class OPTIMIZE_SD

inherit
	OPTION_SD
		redefine
			is_optimize
		end

	SHARED_OPTIMIZE_LEVEL

feature -- Properties

	option_name: STRING is "optimize"

	is_optimize: BOOLEAN is True
			-- is the option an optimize one ?

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD;
			classes:HASH_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			v: OPTIMIZE_I;
			class_name: STRING
		do
			if value /= Void then
				if value.is_no then
					v := No_optimize;
				elseif value.is_yes then
					v := Yes_optimize;
				elseif value.is_all then
					v := All_optimize;
				else
					error (value);
				end;
			else
				v := No_optimize;
			end;
			if v /= Void then
				if list = Void then
					from
						classes.start;
					until
						classes.after
					loop
						classes.item_for_iteration.set_optimize_level (v);
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
						classes.item (class_name).set_optimize_level (v);
						list.forth;
					end;
				end;
			end;
		end;

end -- class OPTIMIZE_SD
