
deferred class LICENCE_COMMAND

	inherit

		COMMAND;

		BUILD_LIC;

		WARN_POPUPER
			undefine
				continue_after_popdown
			end;


feature

	execute (argument: ANY) is
		local
			msg: STRING;
		do
			if licence_checked then
				work (argument);
			else
				if licence.daemon_alive and then try_reconnect then
					work (argument);
				else
					cancel_request (argument);
					!!msg.make (0);
					msg.append ("YOU HAVE LOST YOUR LICENCE!%N");
					msg.append ("you can only save once after you have lost your licence.%N");
					msg.append ("After saving you can exit or keep trying until you get your licence back");
					warning_box.popup (Current, msg);
				end;
			end;
		end;

	cancel_request (arg: ANY) is
		do
		end;

	warning_box: WARNING_BOX is
		deferred
		end;
	
	continue_after_popdown (box: MESSAGE_D; ok: BOOLEAN) is
		deferred
		end;

	try_reconnect: BOOLEAN is
		do
			licence.register;
			if licence.registered then
				licence.open_licence;
				Result := licence.licenced and then licence_checked;
			end;
		end;				

	licence_checked: BOOLEAN is
		do
			licence.alive;
			Result := licence.is_alive;
		end;

	work (argument: ANY) is
		deferred
		end;

end
		
