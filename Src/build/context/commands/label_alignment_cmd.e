
class LABEL_ALIGNMENT_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			L_abel_alignment_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result :=  label_text_form_number
		end;

	context: LABEL_TEXT_C;

	old_left_alignment: BOOLEAN;

	context_work is
		do
			old_left_alignment := context.left_alignment;
		end;

	context_undo is
		local
			new_left_align: BOOLEAN;
		do
			new_left_align := context.left_alignment;
			context.set_left_alignment (old_left_alignment);
			old_left_alignment := new_left_align;
		end;

end
