

class COM_INST_IS 

inherit

	ICON_STONE
		undefine
			stone_cursor, stone
		redefine
			data, set_widget_default
		end;
	CMD_INST_STONE;

feature 

	set_widget_default is
		do
			initialize_transport
		end;
			
	data: CMD_INSTANCE;

	associated_command: CMD is
		do
			Result := data.associated_command
		end

end
