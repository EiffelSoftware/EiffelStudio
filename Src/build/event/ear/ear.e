
class EAR 

inherit

	COMMAND
		redefine
			context_data_useful
		end;

feature

	pcb: PICT_COLOR_B;
	tf: TEXT_FIELD;
	form: FORM;

	build is
		do
			pcb.add_key_press_action (Current, Void)
		end;

	context_data_useful: BOOLEAN is True;

	execute (argument: ANY) is
		local
			cd: KYPRESS_DATA;
			temp: STRING;
			kb: KEYBOARD
		do
			cd ?= context_data;
			temp.Create (0);
			kb := cd.keyboard;
			if kb.lock_pressed then
				temp.append ("<Alt>")
			end;	
			if kb.control_pressed then
				temp.append ("<Ctrl>")
			end;	
			if kb.shift_pressed then
				temp.append ("<Shift>")
			end;	
			if not cd.string.Void then
				temp.append (cd.string);
			end;
			tf.clear;
			tf.set_text (temp)
		end

end
