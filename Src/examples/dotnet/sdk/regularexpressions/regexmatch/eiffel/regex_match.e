indexing
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	REGEX_MATCH

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main (args: ARRAY [STRING])
			-- Program entry point
		local
			email_regex: REGEX
			s: SYSTEM_STRING
			m: MATCH
		do
			create email_regex.make ("(?<user>[^@]+)@(?<host>.+)")
			s := "johndoe@tempuri.org"

			if args.count > 1 then
				s := args[1]
			end

			m := email_regex.match (s)

			if m.success then
				{SYSTEM_CONSOLE}.write_line ("User: " + create {STRING}.make_from_cil (m.groups.item ("user").value))
				{SYSTEM_CONSOLE}.write_line ("Host: " + create {STRING}.make_from_cil (m.groups.item ("host").value))
			else
				{SYSTEM_CONSOLE}.write_line (s + " is not a value email address")
			end

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
