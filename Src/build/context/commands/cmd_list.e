
deferred class CMD_LIST 

inherit

	CONTEXT_CMD



	
feature {NONE}

	cmd_list: LINKED_LIST [CONTEXT_CMD];

	context_work is
		do
		end;

	context_undo is
		do
			from
				cmd_list.start
			until
				cmd_list.offright
			loop
				cmd_list.item.undo;
				cmd_list.forth;
			end;
		end;

end
