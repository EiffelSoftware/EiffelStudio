

class CON_ICON_STONE 

inherit

	CONTEXT_DRAG_SOURCE;
	ICON_STONE
		export
			{ANY} realized
		undefine
			stone_cursor, stone, initialize_transport
		redefine
			data, set_widget_default
		end;
	CONTEXT_STONE
	
feature 

	set_widget_default is
		do
			initialize_transport
		end;
			
	data: CONTEXT;

end
