deferred class EWB_QUERY

inherit
	EWB_CMD
		redefine
			loop_action
		end;

	SHARED_QUERY_VALUES

feature {NONE} -- Execution

	loop_action is
		do
			execute;
		end;

end -- class EWB_QUERY
