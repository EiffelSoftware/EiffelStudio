note
	description: "[
					Shared resources
																]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SHARED_RESOURCES

feature -- Factory methods

	command_handler_singleton: ER_COMMAND_HANDLER
			--
		local
			l_result: detachable ER_COMMAND_HANDLER
		do
			l_result := global_command_handler_cell.item
			if l_result = void then
				create l_result.make
				global_command_handler_cell.put (l_result)
			end
			Result := l_result
		end

feature {NONE} -- Implementation

	global_command_handler_cell: CELL [detachable ER_COMMAND_HANDLER]
			--
		once
			create Result.put (void)
		end

end
