-- Build a filtered version (troff, ..) of the class text.

class EWB_FILTER 

inherit

	EWB_CMD
		rename
			name as filter_cmd_name,
			help_message as filter_help,
			abbreviation as filter_abb
		end

creation

	make

feature -- Creation

	make (cn, fn: STRING) is
		require
			cn_not_void: cn /= Void;
			fn_not_void: fn /= Void
		do
			class_name := cn;
			class_name.to_lower;
			filter_name := fn
		end;

	class_name: STRING;

	filter_name: STRING;
			-- Name of the filter to be used

	set_filter_name (fn: STRING) is
			-- Assign `fn' to `filter_name'.
		require
			fn_not_void: fn /= Void
		do
			filter_name := fn
		end;

feature

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
							ctxt.set_current_class_only;
							ctxt.set_order_same_as_text;
							ctxt.execute;
							!!text_filter.make (filter_name);
							text_filter.process_text (ctxt.text);
							output_window.put_string (text_filter.image)
						end;
					else
						io.error.putstring (class_name);
						io.error.putstring (" is not in the universe%N");
					end
				end;
			end;
		end;

invariant

	filter_name_not_void: filter_name /= Void

end -- class EWB_FILTER
