
class TRANSPORT 

inherit

	LICENCE_COMMAND
		redefine
			context_data_useful
		end;

	WINDOWS
		export
			{NONE} all
		end
	
feature 

	context_data_useful: BOOLEAN is
		do
			Result := True;
		end;


	work (argument: STONE) is
		local
			button_p_data: BTPRESS_DATA;
		do
			if argument.transportable  then
				argument.update_before_transport;
				button_p_data ?= context_data;
				main_panel.base.transport (argument, button_p_data.absolute_x, button_p_data.absolute_y)
			end
		end;

end
