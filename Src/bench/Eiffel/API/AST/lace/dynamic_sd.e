indexing

	description:
		"AST structure in Lace file for dynamic%
		%option for DLE.";
	date: "$Date$";
	revision: "$Revision $"

class DYNAMIC_SD

inherit

	OPTION_SD;
	SHARED_DYNAMIC_CALLS

feature -- Properties

	option_name: STRING is "dynamic"

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD;
			classes:HASH_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
			-- Adapt dynamic option
		require else
			is_valid
		local
			dynamic_feat: DYNAMIC_FEAT_I;
			v: DYNAMIC_I;
			feat_name, class_name: STRING
		do
			if value /= Void then
				if value.is_all then
					v := All_dynamic
				elseif value.is_name then
					feat_name := clone (value.value);
					feat_name.to_lower;
					!! dynamic_feat.make;
					dynamic_feat.extend (feat_name);
					v := dynamic_feat
				else
					error (value)
				end
			else
				v := No_dynamic
			end;
			if v /= Void then
				if list = Void then
					from
						classes.start
					until
						classes.after
					loop
						classes.item_for_iteration.set_dynamic_calls (v);
						classes.forth
					end
				else
					from
						list.start
					until
						list.after
					loop
						class_name := clone (list.item);
						class_name.to_lower;
						classes.item (class_name).set_dynamic_calls (v);
						list.forth
					end
				end
			end
		end;

end -- class DYNAMIC_SD 
