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
		once
			create Result.make
		end

	dispatcher: EV_RIBBON_DISPACHER
		once
			create Result.make
		end

	ribbon_resource: EV_RIBBON_RESOURCES
		once
			create Result
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
