indexing
	description: "."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CMD_REFRESH_PARENT 

inherit

	COMMAND

feature {NONE}

	edited_command: USER_CMD

	labels: LINKED_LIST [CMD_LABEL] is
		do
			Result := edited_command.labels
		end

	arguments: LINKED_LIST [ARG] is
		do
			Result := edited_command.arguments
		end

	remove_parent is
		do
			from
				arguments.start
			until
				arguments.after
			loop
				if
					arguments.item.parent_type = edited_command.parent_type
				then
					arguments.remove
				else
					arguments.forth
				end
			end
			from
				labels.start
			until
				labels.after
			loop
				if
					labels.item.parent_type = edited_command.parent_type and
					labels.item.parent_type /= Void
				then
					labels.remove
				else
					labels.forth
				end
			end
		end -- undo

	refresh_parent (c: CMD) is
		local
			a: ARG
			l: CMD_LABEL
			oal: LINKED_LIST [ARG]
			oll: LINKED_LIST [CMD_LABEL]
			new_label: STRING
		do
			remove_parent
			from
				oal := c.arguments
				oal.start
				arguments.finish
			until
				oal.after
			loop
				!! a.set (oal.item.type, c)
				arguments.extend (a)
				oal.forth
			end
			from
				oll := c.labels
				oll.start
				labels.finish
			until
				oll.after
			loop
				new_label := clone (oll.item.label)
				!!l.make (oll.item.label)
				l.set_parent (c)
				labels.extend (l)
				oll.forth
			end
		end 

feature

	execute (argument: ANY) is
		do
			edited_command ?= argument
			if edited_command /= Void then
			    refresh_parent (edited_command.parent_type)
			end
		end
end
