
class EB_TOGGLE_B 

inherit

	TOGGLE_B
		rename
			make as toggle_create
		end


creation

	make

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE; cmd: COMMAND; editor: CONTEXT_EDITOR) is
		do
			toggle_create (a_name, a_parent);
			add_release_action (cmd, editor);
		end;

	set_state (a_state: BOOLEAN) is
		do
			if a_state then
				arm
			else
				disarm
			end;
		end;

end
