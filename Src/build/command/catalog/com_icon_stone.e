
class COM_ICON_STONE 

inherit

	ICON_STONE
		undefine
			stone_cursor, stone
		redefine
			data, set_widget_default
		end;
	CMD_STONE
	
feature 

	set_widget_default is
		do
			initialize_transport
		end;
			
	data: CMD;

end
