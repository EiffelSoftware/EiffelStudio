
class EWB_FS 

inherit

	EWB_CMD
		redefine
			loop_execute
		end

creation

	make, null

feature -- Creation

	make (cn: STRING; t, b: BOOLEAN; f: like filter_name) is
		do
			class_name := cn;
			class_name.to_lower;
			troffed := t;
			only_current_class := b;
			filter_name := f
		end;

	class_name: STRING;

	troffed: BOOLEAN;

	only_current_class: BOOLEAN;
		-- Only do short for current class

	filter_name: STRING;
			-- Name of the filter to be used (if any)

feature

	name: STRING is
		do
			Result := flatshort_cmd_name;
		end;

	help_message: STRING is
		do
			Result := flatshort_help
		end;

	abbreviation: CHARACTER is
		do
			Result := flatshort_abb
		end;

	loop_execute is
		do
			get_class_name;
			class_name := last_input;
			troffed := False;
			only_current_class := False;
			filter_name := Void;
			check_arguments_and_execute;
		end;

	execute is
		local
			class_c: CLASS_C;
			class_i: CLASS_I;
			ctxt: FORMAT_CONTEXT;
			troffer: TROFF_FORMATTER;
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
							if troffed then
								ctxt.set_troff_format;
							end;
							ctxt.set_is_short;
							if only_current_class then
								ctxt.set_current_class_only
							end;
							ctxt.execute;
							if troffed then
								!! troffer.make;
								troffer.process_text (ctxt.text);
								output_window.put_string (troffer.image)
							elseif filter_name /= Void then
								!!text_filter.make (filter_name);
								text_filter.process_text (ctxt.text);
								output_window.put_string (text_filter.image)
							else
								output_window.put_string (ctxt.text.image)
							end
						end
					else
						io.error.putstring (class_name);
						io.error.putstring (" is not in the universe%N");
					end;
				end;
			end;
		end;

end
