indexing

	description:	
		"Command to display help.";
	date: "$Date$";
	revision: "$Revision$"

class HELP_COMMAND 

inherit

	ISE_COMMAND;
	EB_CONSTANTS

feature -- Access

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
			Result := Interface_names.a_Help
		end;

feature -- Execution

	work (argument: ANY) is
			-- Popup the help window.
		local
			req: EXTERNAL_COMMAND_EXECUTOR;
			acrobat_reader: STRING
		do
			acrobat_reader := General_resources.acrobat_reader.value;
			!! req;
			req.execute (acrobat_reader)
		end;

end -- class HELP_COMMAND
