indexing
	description: "Undoable command to remove elements to commands."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

deferred class CMD_CUT 

inherit
	CMD_COMMAND

feature -- Access

	set_index (i: INTEGER) is
		do
			index := i
		end

	undo is
		do
			edited_command.save_old_template
			if
				index = 1 and list.empty
			then
				list.extend (element)
			else
				list.go_i_th (index - 1)
				list.put_right (element)
			end
			update
		end

feature {NONE} -- Implementation

	update is
		do
			edited_command.update_text
		end

	command_work is
		do
			edited_command.save_old_template
			list.go_i_th (index)
			element := list.item
			list.remove
			update
		end 

	worked_on: STRING is
		do
			create Result.make (0)
			if element /= Void then
					Result.append (element.label)
			end
		end

feature {NONE} -- Private attributes

	index: INTEGER
			-- Index of the removed element

	element: PND_DATA 

	list: LINKED_LIST [PND_DATA] is
		deferred
		end

end -- class CMD_CUT

