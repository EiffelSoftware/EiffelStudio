
class TRANSPORT 

inherit

	LICENCE_COMMAND
		redefine
			context_data_useful
		end;
	WINDOWS
	
feature 

	context_data_useful: BOOLEAN is
		do
			Result := True;
		end;


	work (argument: ANY) is
		local
			button_p_data: BTPRESS_DATA;
			drag_source: DRAG_SOURCE
		do
			button_p_data ?= context_data;
			drag_source ?= argument;
			if drag_source.transportable then
				drag_source.update_before_transport;
				main_panel.base.transport (drag_source.stone, 
					button_p_data.absolute_x, 
					button_p_data.absolute_y)
			end
		end;

end
