
class EWB_FLAT 

inherit

	EWB_CMD
		rename
			name as flat_cmd_name,
			help_message as flat_help,
			abbreviation as flat_abb
		redefine
			loop_execute
		end

creation

	make, null

feature -- Creation

	make (cn, fn: STRING) is
		do
			class_name := cn;
			class_name.to_lower;
			filter_name := fn
		end;

	class_name: STRING;

	filter_name: STRING;
			-- Name of the filter to be used (if any)

feature

	loop_execute is
		do
			get_class_name;
			class_name := last_input;
			filter_name := Void;
			check_arguments_and_execute;
		end;

	execute is
		local
			class_c: CLASS_C;
			ctxt: FORMAT_CONTEXT;
			class_i: CLASS_I;
			text_filter: TEXT_FILTER
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
					class_i := Universe.unique_class (class_name);
					if class_i /= Void then
						class_c := class_i.compiled_class;
						if class_c = Void then
							io.error.putstring (class_name);
							io.error.putstring (" is not in the system%N");
						else
							!!ctxt.make (class_c);
							ctxt.execute;
							if filter_name /= Void then
								!!text_filter.make (filter_name);
								text_filter.process_text (ctxt.text);
								output_window.put_string (text_filter.image)
							else
								output_window.put_string (ctxt.text.image)
							end
						end;
					else
						io.error.putstring (class_name);
						io.error.putstring (" is not in the universe%N");
					end
				end;
			end;
		end;

end
