indexing

	description:	
		"Command to display help.";
	date: "$Date$";
	revision: "$Revision$"

class HELP_COMMAND 

inherit

	ISE_COMMAND;
	EB_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (a_helpable: like helpable) is
			-- Set `a_helpable' to `helpable'
		require
			valid_arg: a_helpable /= Void
		do
			helpable := a_helpable
		end

feature -- Access

	helpable: HELPABLE
			-- Associated helpable object

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Help
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Help
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

feature -- Execution

	work (argument: ANY) is
			-- Popup the help window.
		do
			helpable.invoke_help
		end;

end -- class HELP_COMMAND
