
class TEMP_WIND 


inherit

	EB_BULLETIN_D

creation

	make
	
feature -- Not to be put in ebuild library in delivery
	
	set_parent_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
		do
			dialog_command_target;
			set_action (a_translation, a_command, argument);
			widget_command_target;
		end;

	remove_parent_action (a_translation: STRING) is
		do
			dialog_command_target;
			remove_action (a_translation);
			widget_command_target;
		end;

end

