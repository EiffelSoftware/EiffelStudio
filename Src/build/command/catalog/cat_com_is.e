
class CAT_COM_IS 

inherit

	COM_ICON_STONE
		undefine
			init_toolkit
		redefine
			make
		end;
	HOLE
		rename
			target as source
		export
			{NONE} all
		redefine
			stone, compatible
		end;
	REMOVABLE
		export
			{NONE} all
		end;
	NAMABLE
		export
			{NONE} all
		end

creation

	make
	
feature {NONE}

	visual_name: STRING is
		local
			uc: USER_CMD	
		do
			uc ?= original_stone;
			if not (uc = Void) then
				Result := uc.visual_name
			end;
		end;

	set_visual_name (s: STRING) is
		local
			uc: USER_CMD	
		do
			uc ?= original_stone;
			if not (uc = Void) then
				uc.set_visual_name (s);
				set_label (uc.label);
			end;
		end;

	
feature 

	page: COMMAND_PAGE;

	
feature {NONE}

	stone: like Current;

	compatible (s: like Current): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

feature 

	make (p: like page) is
			-- Create an command icon stone with `p' as `page'.
		do
			page := p;	
			register;
		end; -- Create

	
feature {NONE}

	process_stone is
		do
			page.parent.unmanage;
			page.insert_after (original_stone, stone.original_stone);
			page.parent.manage;
		end;

	remove_yourself is
		local
			user_cmd: USER_CMD;
			remove_command: CAT_CUT_COMMAND
		do
			user_cmd ?= original_stone;
			if
				not (user_cmd = Void)
			then
				page.remove_command (user_cmd)
			end;
		end;

end
