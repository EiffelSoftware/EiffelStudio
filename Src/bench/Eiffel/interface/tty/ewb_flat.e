
class EWB_FLAT 

inherit

	EWB_CMD
		rename
			name as flat_cmd_name,
			help_message as flat_help,
			abbreviation as flat_abb
		end

creation

	make, null

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

	execute is
		local
			class_c: CLASS_C;
			ctxt: FORMAT_CONTEXT;
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
						!!ctxt.make (class_c);
						ctxt.execute;
						output_window.put_string (ctxt.text.image)
					end;
				end;
			end;
		end;

end
