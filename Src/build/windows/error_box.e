
class ERROR_BOX 

inherit

	ERROR_D
		rename
			popup as old_popup,
			make as error_d_create
		end;

	COMMAND
		export
			{NONE} all
		end


creation

	make

	
feature {NONE}

	caller: ERROR_POPUPER;
	
feature 

	popup (c: ERROR_POPUPER; s: STRING) is
		do
			caller := c;
			set_message (s);
			old_popup
		end;

	make (a_name: STRING; a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			error_d_create (a_name, a_parent);
			hide_help_button;
			hide_cancel_button;
			set_exclusive_grab;
			add_ok_action (Current, Nothing)
		end;

	
feature {NONE}

	execute (argument: ANY) is
		do
			popdown;
			caller.continue_after_popdown (Current, True)		
		end

end

