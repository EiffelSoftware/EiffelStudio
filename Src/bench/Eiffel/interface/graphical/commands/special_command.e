class SPECIAL_COMMAND 

inherit

	ICONED_COMMAND

creation

	make
	
feature 

	special_w: SPECIAL_W;

	make (c: COMPOSITE; t_w: TEXT_WINDOW) is
		do
			init (c, t_w);
			!!special_w.make (c);
		end;

feature {NONE}

	work (argument: ANY) is
		do
			special_w.call
		end;
	
feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Default 
		end;
 
	command_name: STRING is do Result := "Special options" end;

end
