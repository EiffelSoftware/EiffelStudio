
class EB_TEXT_FIELD 

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

end
