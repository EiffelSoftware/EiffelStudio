indexing
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	REGEX_MATCHER

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main (args: ARRAY [STRING])
			-- Program entry point
		local
			digit_regex: REGEX
			before, after: SYSTEM_STRING
		do
			create digit_regex.make ("(?<digit>[0-9])")
			before := "Here is so4848me te88xt with emb44983edded numbers."

			if args.count > 1 then
				before := {SYSTEM_STRING}.join (" ", {ENVIRONMENT}.get_command_line_args, 1, {ENVIRONMENT}.get_command_line_args.length - 1)
			end

			after := digit_regex.replace (before, "")

			{SYSTEM_CONSOLE}.write_line ("Before: " + create {STRING}.make_from_cil (before))
			{SYSTEM_CONSOLE}.write_line ("After : " + create {STRING}.make_from_cil (after))

			{SYSTEM_CONSOLE}.write_line
			{SYSTEM_CONSOLE}.write_line ("Please press Enter to continue...")
			{SYSTEM_CONSOLE}.read_line.do_nothing
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software/Microsoft Corporation. All rights reserved."
	license: "[
			This file is part of the Microsoft .NET Framework SDK Code Samples.

			This source code is intended only as a supplement to Microsoft
			Development Tools and/or on-line documentation.  See these other
			materials for detailed information regarding Microsoft code samples.

			THIS CODE AND INFORMATION ARE PROVIDED AS IS WITHOUT WARRANTY OF ANY
			KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
			IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
			PARTICULAR PURPOSE.
		]"


end
