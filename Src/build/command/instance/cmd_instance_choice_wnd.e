indexing
	description: "Choice window to create an instance from the default %
				% commands associated to a context "
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	CMD_INSTANCE_CHOICE_WND

inherit
	CHOICE_WND
		redefine
			continue_after_popdown
		end

creation
	make

feature -- Access

	data_list: LINKED_LIST [EDITABLE]

	command_hole: COMMAND_HOLE

	popup_with_list (cmd_hole: COMMAND_HOLE; l: LINKED_LIST [EDITABLE]) is
		require
			valid_list: l /= Void 
		local
			string_list: LINKED_LIST [STRING]
			ed: EDITABLE
		do
			!! string_list.make
			data_list := l
			from
				l.start
			until
				l.after
			loop
				ed := l.item
				string_list.extend (ed.label)
				l.forth
			end
			popup (string_list)
			command_hole := cmd_hole
		end

	continue_after_popdown is
		local
			command: CMD
			command_instance: CMD_INSTANCE
			command_instance_stone: COM_INST_IS
		do
			if position /= 1 then
				command ?= data_list.i_th (position - 1)
				command.create_editor
				!! command_instance_stone
				command_instance_stone.set_data (command.instances.last)
				command_instance_stone.process (command_hole)
			end
			data_list := Void
		end


end -- class CMD_INSTANCE_CHOICE_WND
