
class TRANSPORT 

inherit

	COMMAND;

	WINDOWS
		export
			{NONE} all
		end
	
feature 

	execute (argument: STONE) is
		do
			if argument.transportable then
				argument.update_before_transport;
				main_panel.base.transport (argument)
			end
		end;

end
