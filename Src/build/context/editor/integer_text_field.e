
class INTEGER_TEXT_FIELD 

inherit

	TEXT_FIELD
		rename
			make as text_field_create
		end


creation

	make

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE; cmd: COMMAND; editor: CONTEXT_EDITOR) is
		do
			text_field_create (a_name, a_parent);
			add_activate_action (cmd, editor);
		end;

	set_int_value (value: INTEGER) is
		local
			temp: STRING
		do
			if not text.empty then
				set_text ("");
			end;
			!!temp.make (0);
			temp.append_integer (value);
			set_text (temp)
		end;
	
	same_value (value: INTEGER): BOOLEAN is
		local
			temp: STRING
		do
			!!temp.make (0);
			temp.append_integer (value);
			Result := text.is_equal (temp)
		end;

	int_value: INTEGER is
		do
			Result := text.to_integer
		end;

end
