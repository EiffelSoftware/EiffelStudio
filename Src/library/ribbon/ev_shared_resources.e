note
	description: "[
					Ribbon shared resources
																			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SHARED_RESOURCES

feature -- Factory methods

	command_handler_singleton: EV_COMMAND_HANDLER
			-- Command handler singleton
		local
			l_result: detachable EV_COMMAND_HANDLER
		do
			l_result := global_command_handler_cell.item
			if l_result = void then
				create l_result.make
				global_command_handler_cell.put (l_result)
			end
			Result := l_result
		end

feature {NONE} -- Implementation

	global_command_handler_cell: CELL [detachable EV_COMMAND_HANDLER]
			-- Singleton cell for command handler
		once
			create Result.put (void)
		end

end
