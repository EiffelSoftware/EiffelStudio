
class TRANSPORT 

inherit

	LICENCE_COMMAND;

	WINDOWS
		export
			{NONE} all
		end
	
feature 

	work (argument: STONE) is
		do
			if argument.transportable  then
				argument.update_before_transport;
				main_panel.base.transport (argument)
			end
		end;

	continue_after_popdown (box: MESSAGE_D; ok: BOOLEAN) is
		do 
		end;

end
