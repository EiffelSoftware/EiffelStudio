
deferred class EWB_CLASS 

inherit

	EWB_CMD

feature -- Creation

	make (cn: STRING) is
		do
			class_name := cn;
			class_name.to_lower;
		end;

	class_name: STRING;

feature

	loop_execute is
		do
			get_class_name;
			class_name := last_input;
			class_name.to_lower;
			execute;
		end;

	current_class: CLASS_C;

	execute is
		local
			class_i: CLASS_I
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
					class_i := Universe.unique_class (class_name);
					if class_i /= Void then
						current_class := class_i.compiled_class;
					end;

					if current_class = Void then
						io.error.putstring (class_name);
						io.error.putstring (" is not in the system%N");
					else
						display (current_class);
					end;
				end;
			end;
		end;

	display (class_c: CLASS_C) is
		deferred
		end;

end
