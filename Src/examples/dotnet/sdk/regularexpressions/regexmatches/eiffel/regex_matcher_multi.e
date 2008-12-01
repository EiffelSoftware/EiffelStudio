indexing
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	REGEX_MATCHER_MULTI

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main (args: ARRAY [STRING])
			-- Program entry point
		local
			digit_regex: REGEX
			s: SYSTEM_STRING
			mc: MATCH_COLLECTION
			enum: IENUMERATOR
			m: MATCH
		do
			create digit_regex.make ("(?<number>\d+)")
			s := "abc 123 def 456 ghi 789"

			if args.count > 1 then
				s := {SYSTEM_STRING}.join (" ", {ENVIRONMENT}.get_command_line_args, 1, {ENVIRONMENT}.get_command_line_args.length - 1)
			end

			mc := digit_regex.matches (s)

			if mc.count > 0 then
				{SYSTEM_CONSOLE}.write_line ("Digits:")
				from enum := mc.get_enumerator until not enum.move_next loop
					m ?= enum.current_
					check m_attached: m /= Void end
					{SYSTEM_CONSOLE}.write_line ("   " + create {STRING}.make_from_cil (m.value))
				end
			else
				{SYSTEM_CONSOLE}.write_line ("[" + create {STRING}.make_from_cil (s) + "] contains no numbers.")
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
