
deferred class EWB_FEATURE 

inherit

	EWB_CMD
		redefine
			loop_execute
		end

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
			if not no_more_arguments then
				get_class_name;
				class_name := last_input;
				if not no_more_arguments then
					get_feature_name;
					feature_name := last_input
				end;
			end;
			check_arguments_and_execute
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
					if class_name = Void then
						get_class_name;
						class_name := last_input;
					end;
					if not abort then
						class_i := Universe.unique_class (class_name);
						if class_i /= Void then
							class_c := class_i.compiled_class;
							if class_c = Void then
							io.error.putstring (class_name);
								io.error.putstring (" is not in the system%N");
							else
								if feature_name = Void then
									get_feature_name;
									feature_name := last_input;
								end;
								if not abort then
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
						else
							io.error.putstring (class_name);
							io.error.putstring (" is not in the universe%N");
						end;
					end;
				end;
			end;
			class_name := Void;
			feature_name := Void;
			abort := False;
		end;

	display (feature_i: FEATURE_I; class_c: CLASS_C) is
		deferred
		end;

end
