indexing
	description: "Undoable command to add elements to commands."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

deferred class CMD_ADD 

inherit
	CMD_COMMAND

feature 

	set_element (s: PND_DATA) is
		do
			element := s
		end

	undo is
		do
			edited_command.save_old_template
			list.finish
			list.remove
			update_information
		end

	update_information is
		do
			edited_command.update_text
		end

feature {NONE} -- Private attributes

	element: PND_DATA

	list: LINKED_LIST [PND_DATA] is
		deferred
		end 

feature {NONE} -- Implementation

	command_work is
		do
			edited_command.save_old_template
			list.extend (element)
			update_information
		end 

	worked_on: STRING is
		do
			create Result.make (0)
			if element /= Void then
					Result.append (element.label)
			end
		end

end -- class CMD_ADD

