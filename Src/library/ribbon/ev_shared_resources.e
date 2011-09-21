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

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
