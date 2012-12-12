note
	description: "Objects that ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			arg_parser: APPLICATION_ARGUMENT_PARSER
		do
			create arg_parser.make
			arg_parser.set_is_usage_displayed_on_error (True)
			arg_parser.execute (agent execute (arg_parser))
		end

	execute (args: APPLICATION_ARGUMENTS)
		local
			app: ECF_UPDATER
		do
			create app.make (args)
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
