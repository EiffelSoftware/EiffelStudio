
deferred class EWB_FEATURE 

inherit

	EWB_CMD

feature -- Creation

	make (cn, fn: STRING) is
		do
			class_name := cn;
			class_name.to_lower;
			feature_name := fn;
			feature_name.to_lower;
		end;

	class_name, feature_name: STRING;

feature

	loop_execute is
		do
			get_class_name;
			class_name := last_input;
			class_name.to_lower;
			get_feature_name;
			feature_name := last_input;
			feature_name.to_lower;
			execute;
		end;

	execute is
		local
			class_c: CLASS_C;
			feature_i: FEATURE_I;
			class_i: CLASS_I
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
					class_i := Universe.unique_class (class_name);
					if class_i /= Void then
						class_c := class_i.compiled_class;
					end;

					if class_c = Void then
						io.error.putstring (class_name);
						io.error.putstring (" is not in the system%N");
					else
						feature_i := class_c.feature_table.item (feature_name);
						if feature_i = Void then
							io.error.putstring (feature_name);
							io.error.putstring (" is not a feature of ");
							io.error.putstring (class_name);
							io.error.new_line
						else
							display (feature_i, class_c);
						end;
					end;
				end;
			end;
		end;

	display (feature_i: FEATURE_I; class_c: CLASS_C) is
		deferred
		end;

end
