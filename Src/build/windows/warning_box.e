indexing
	description: "A warning box with only the warning message %
				% and one `OK' button."
	date: "$Date$"
	id: "$Id: "
	revision: "$Revision$"

class

	WARNING_BOX

inherit

	WARNING_D
		redefine
			make
		end
		
	COMMAND

	CURSORS

creation

	make

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Initialize
		do
			{WARNING_D} Precursor (a_name, a_parent)
			hide_cancel_button
			hide_help_button
			show_ok_button
			add_ok_action (Current, Void)
			add_button_press_action (1, Current, Void)
--			grab (cursor)
		end

feature -- Execute

	execute (arg: ANY) is
			-- Popdown Current.
		do
			ungrab
			destroy
		end

end -- class WARNING_BOX
