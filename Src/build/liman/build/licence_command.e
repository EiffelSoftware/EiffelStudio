
deferred class LICENCE_COMMAND

inherit

	COMMAND;

	LICENCED_COMMAND
		rename
			execute_licenced as execute
		end;

	WARN_POPUPER
		undefine
			continue_after_popdown
		end;

feature {NONE} -- License manager

	lost_licence_warning is
		local
			msg: STRING;
		do
-- debug			cancel_request (argument);
			!!msg.make (0);
			msg.append ("YOU HAVE LOST YOUR LICENCE!%N");
			msg.append ("you can only save once after you have lost your licence.%N");
			msg.append ("After saving you can exit or keep trying until you get your licence back");
			warning_box.popup (Current, msg);

			-- ADD CALLBACK on Current with Void argument
			-- => DISPLAY users when licence is lost

		end;

	license_window: LICENSE_WINDOW is
		once
			!!Result.make (Void, Void);
		end;

feature

	cancel_request (arg: ANY) is
		do
		end;

	warning_box: WARNING_BOX is
		deferred
		end;

	continue_after_popdown (box: MESSAGE_D; ok: BOOLEAN) is
		deferred
		end;

end
		
