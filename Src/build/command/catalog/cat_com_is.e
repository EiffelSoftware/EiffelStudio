
class CAT_COM_IS 

inherit

	COM_ICON_STONE;
	HOLE
		rename
			target as source
		redefine
			process_command
		end;
	REMOVABLE

creation

	make
		
feature 

	page: COMMAND_PAGE;

feature 

	make (p: like page) is
			-- Create an command icon stone with `p' as `page'.
		do
			page := p;	
			register;
		end; -- Create

	
feature {NONE}

	process_command (dropped: CMD_STONE) is
		do
			page.insert_after (data, dropped.data);
		end;

	remove_yourself is
		local
			user_cmd: USER_CMD;
			remove_command: CAT_CUT_COMMAND
		do
			user_cmd ?= data;
			if user_cmd /= Void then
				page.remove_command (user_cmd)
			end;
		end;

end
