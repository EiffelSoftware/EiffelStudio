indexing

	description: "Command to display about."
	date: "$Date$"
	revision: "$Revision$"

class ABOUT_COMMAND 

inherit

	ISE_COMMAND
	EB_CONSTANTS
	SYSTEM_CONSTANTS


creation
	make

feature {NONE} -- Initialization

	make (a_about: like about_tool) is
			-- Set `a_helpable' to `helpable'
		require
			valid_arg: a_about /= Void
		do
			about_tool := a_about
		end

feature -- Access

	about_tool: ABOUT_W
			-- Associated helpable object

	name: STRING is
			-- Name of the command.
		do
			Result := clone(Interface_names.f_About)
			Result.append(" ")
			Result.append(version_number)
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := clone(Interface_names.m_About)
			Result.append(" ")
			Result.append(version_number)
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

feature -- Execution

	work (argument: ANY) is
			-- Popup the help window.
		do
			if about_tool.realized then
				about_tool.show
				about_tool.set_normal_state
				about_tool.raise
			else
				about_tool.realize
			end
		end

end -- class ABOUT_COMMAND
