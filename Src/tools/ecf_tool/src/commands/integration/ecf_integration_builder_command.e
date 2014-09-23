note
	description: "Summary description for {ECF_INTEGRATION_BUILDER_COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_INTEGRATION_BUILDER_COMMAND

inherit
	APPLICATION_COMMAND

create
	make

feature {NONE} -- Initialization

	make (a_name: detachable READABLE_STRING_8)
		do
			if a_name = void then
				create name.make_from_string (default_name)
			else
				create name.make_from_string (a_name)
			end
		end

feature -- Access

	default_name: STRING_8 = "integration"

	synopsis: STRING_32
		do
			Result := {STRING_32} "Include all scanned ecf files into a unique integration file to be able to compile all at once."
		end

feature -- Execution		

	process (args_src: ARGUMENT_SOURCE)
		local
			arg_parser: ECF_INTEGRATION_APPLICATION_ARGUMENT_PARSER
		do
			create arg_parser.make_with_source (args_src)
			arg_parser.set_is_usage_displayed_on_error (True)
			arg_parser.execute (agent execute (arg_parser))
		end

	execute (args: ECF_INTEGRATION_APPLICATION_ARGUMENTS)
		local
			app: ECF_INTEGRATION_BUILDER
		do
			create app.make (args)
		end


note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
