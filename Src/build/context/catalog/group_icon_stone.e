

class GROUP_ICON_STONE 

inherit

	ICON_STONE
		undefine
			stone_cursor, stone
		redefine
			data, set_widget_default
		end;
	TYPE_STONE;
	REMOVABLE
	
feature 

	remove_yourself is
		local
			cut_command: CUT_GROUP_CMD
		do
			!!cut_command;
			cut_command.execute (data)
		end;

	set_widget_default is
		do
			initialize_transport;
		end;
			
	data: CONTEXT_GROUP_TYPE;

end
