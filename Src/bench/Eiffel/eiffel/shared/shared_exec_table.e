class SHARED_EXEC_TABLE

inherit
	SHARED_WORKBENCH

feature

	Execution_table: EXECUTION_TABLE is
			-- Execution table
		once
			Result := System.execution_table
		end

end
