indexing
	description: "Choice window to edit an existing instance of %
				% the curent command."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class CMD_ED_CHOICE_WND

inherit

	CHOICE_WND
		redefine
			continue_after_popdown
		end

creation

	make, make_with_cmd

feature -- Creation

	make_with_cmd (a_composite: COMPOSITE; cmd: CMD) is
		do
			make (a_composite)
			popuper_cmd := cmd
		end

feature
	
	popuper_cmd: CMD

	data_list: LINKED_LIST [EDITABLE]

	popup_with_list (l: LINKED_LIST [EDITABLE]) is
		require
			valid_list: l /= Void 
		local
			string_list: LINKED_LIST [STRING]
			ed: EDITABLE
		do
			!! string_list.make
			string_list.extend ("New instance")
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
			if not l.empty then
				string_list.extend (" Edit all ")
			end
			popup (string_list)
		end

	continue_after_popdown is
		local
			cmd_instance: CMD_INSTANCE 
			pos: INTEGER
			cmd_tool: COMMAND_TOOL
		do
			pos := position
			if pos /= 1 then
				if pos > 2 then
					if pos = data_list.count + 3 then
						-- Selected edit all
						from
							data_list.start
						until
							data_list.after
						loop
							cmd_instance ?= data_list.item
							cmd_instance.create_editor
							data_list.forth
						end
					else	
						cmd_instance ?= data_list.i_th (pos - 2)
						cmd_instance.create_editor
					end
				else
					--| create a new instance
					cmd_tool := window_mgr.command_tool
					cmd_tool.set_command (popuper_cmd)	
					cmd_tool.display
				end
			end
			data_list := Void
		end

end
