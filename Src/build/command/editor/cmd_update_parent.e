
deferred class CMD_UPDATE_PARENT 

inherit

	CMD_COMMAND

feature {NONE}

	previous_parent: CMD;

	labels: LINKED_LIST [CMD_LABEL] is
		do
			Result := edited_command.labels;
		end;

	arguments: LINKED_LIST [ARG] is
		do
			Result := edited_command.arguments;
		end;

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
				end;
			end;
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
				end;
			end;
			edited_command.set_parent_type (Void)
		end; -- undo

	set_parent (c: CMD) is
		local
			a: ARG;
			l: CMD_LABEL;
			oal: LINKED_LIST [ARG];
			oll: LINKED_LIST [CMD_LABEL];
			new_label: STRING;
		do
			if previous_parent /= Void then		
				remove_parent
			end;
			edited_command.set_parent_type (c);
			from
				oal := c.arguments;
				oal.start;
				arguments.finish;
			until
				oal.after
			loop
				!!a.set (oal.item.type, c);
				arguments.extend (a);
				oal.forth;
			end;
			from
				oll := c.labels;
				oll.start;
				labels.finish;
			until
				oll.after
			loop
				new_label := clone (oll.item.label);
				!!l.make (oll.item.label);
				l.set_parent (c);
				labels.extend (l);
				oll.forth;
			end;
		end; 

	worked_on: STRING is
		do
			if edited_command /= Void and then edited_command.parent_type /= Void then	
				!!Result.make (0);
				Result.append (edited_command.parent_type.label);
			end
		end; -- worked_on

end
