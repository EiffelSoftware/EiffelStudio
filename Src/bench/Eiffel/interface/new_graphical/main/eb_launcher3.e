indexing

	description:
		"Put your description here."
	date: "$Date$"
	revision: "$Revision$"

class EB_LAUNCHER3

inherit
	WINDOWS
	ISE_COMMAND

	INTERFACE_NAMES

creation
	make

feature {NONE} -- Initalization

	make (a_window: like about_window) is
			-- Initialize command with `a_category'.
		do
		end


feature {NONE} -- Execution

	work (arg: ANY) is
		local
			gtk_kernel: EB_KERNEL3
		do
			create gtk_kernel.make
		end

feature -- Properties

	about_window: EB_ABOUT_WINDOW
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

invariant

	valid_category: category /= Void

end -- class EB_LAUNCHER3
