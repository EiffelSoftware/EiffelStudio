class TEXT_FIELD_FORM 

inherit

	CONTEXT_CMDS;
	EDITOR_FORM
		redefine
			context
		end

creation

	make

feature

	maximum_size: INTEGER_TEXT_FIELD;

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, text_field_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			size_l: LABEL_G;
		do
			initialize (Text_field_form_name, a_parent);

			!!maximum_size.make (M_aximum_size, Current, text_field_cmd, a_parent);
			!!size_l.make (M_aximum_size, Current);
			maximum_size.set_width (50);

			attach_left (size_l, 10);
			attach_left (maximum_size, 200);
			attach_right (maximum_size, 10);

			attach_top (size_l, 15);
			attach_top (maximum_size, 10);
			detach_bottom (maximum_size);
			detach_bottom (size_l);
		end;

	context: TEXT_FIELD_C;

	reset is
			-- reset the content of the form
		do
			maximum_size.set_int_value (context.maximum_size);
		end;

	apply is
			-- update the context according to the content of the form
		do
			context.set_maximum_size (maximum_size.int_value)
		end;

end
