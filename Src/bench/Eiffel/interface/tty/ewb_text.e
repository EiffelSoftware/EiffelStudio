indexing

	description: 
		"Displays class text in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_TEXT 

inherit

	EWB_FILTER_CLASS
		rename
			name as text_cmd_name,
			help_message as text_help,
			abbreviation as text_abb
		redefine
			process_uncompiled_class, process_compiled_class,
			want_compiled_class
		end

creation

	make, do_nothing

feature {NONE} -- Implementation

	associated_cmd: E_CLASS_CMD is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			check
				not_be_called: false
			end
		end;

feature {NONE} -- Execution

	want_compiled_class (class_i: CLASS_I): BOOLEAN is
			-- Does Current want `class_i' to be compiled?
			--| If the class is in the system: True
			--| else: False.
		do
			Result := class_i.compiled_class /= Void
		end;

	process_compiled_class (e_class: CLASS_C) is
			-- Display the (may be) filtered text of `e_class'.
		local
			ctxt: CLASS_TEXT_FORMATTER;
			filter: TEXT_FILTER
		do
			if e_class.lace_class.hide_implementation then
				output_window.put_string 
					("Not able to show precompiled text (implementation is hidden)");
				output_window.new_line;
			else
				!! ctxt;
				ctxt.set_one_class_only;
				ctxt.set_order_same_as_text;
				ctxt.format (e_class);
				if filter = Void or else filter_name.is_empty then
					output_window.put_string (ctxt.text.image);
				else
					!! filter.make (filter_name);
					filter.process_text (ctxt.text);
					output_window.put_string (filter.image);
				end;
				output_window.new_line;
			end
		end;

	process_uncompiled_class (class_i: CLASS_I) is
			-- Display the class text.
		local
			text: STRING
		do
			if class_i.file_name /= Void then
				text := class_i.text
			end;
			if text /= Void then
				output_window.put_string (text);
				output_window.new_line;
			else
				output_window.put_string ("Cannot open ");
				output_window.put_string (class_i.file_name);
				output_window.new_line;
			end;
		end;

end -- class EWB_TEXT
