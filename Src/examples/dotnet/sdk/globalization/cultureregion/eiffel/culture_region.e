note
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	CULTURE_REGION

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main
			-- Program entry point
		local
			c, c2: CULTURE_INFO
			r, r2: REGION_INFO
		do
			create c.make ("en-us")
			{SYSTEM_CONSOLE}.write_line ("The CultureInfo is set to: {0}", c.display_name)
			{SYSTEM_CONSOLE}.write_line ("The parent culture is: {0}", c.parent.display_name)
			{SYSTEM_CONSOLE}.write_line ("The three letter ISO language name is: {0}", c.three_letter_iso_language_name)
			{SYSTEM_CONSOLE}.write_line ("The default calendar for this culture is: {0}%N%N", c.calendar.to_string)

			create r.make  ("us")
			{SYSTEM_CONSOLE}.write_line ("The name of this region is: {0}", r.name)
			{SYSTEM_CONSOLE}.write_line ("The ISO currency symbol for the region is: {0}", r.iso_currency_symbol)
			{SYSTEM_CONSOLE}.write_line ("Is this region metric : {0} %N%N", r.is_metric)

			create c2.make ("de-ch")
			{SYSTEM_CONSOLE}.write_line ("The CultureInfo is set to: {0}", c2.display_name)
			{SYSTEM_CONSOLE}.write_line ("The parent culture is: {0}", c2.parent.display_name)
			{SYSTEM_CONSOLE}.write_line ("The three letter ISO language name is: {0}", c2.three_letter_iso_language_name)
			{SYSTEM_CONSOLE}.write_line ("The default calendar for this culture is: {0}%N%N", c2.calendar.to_string)

			create r2.make ("de")
			{SYSTEM_CONSOLE}.write_line ("The name of this region is: {0}", r2.name)
			{SYSTEM_CONSOLE}.write_line ("The ISO currency symbol for the region is: {0}", r2.iso_currency_symbol)
			{SYSTEM_CONSOLE}.write_line ("Is this region metric : {0}", r2.is_metric)

			{SYSTEM_CONSOLE}.write_line
			{SYSTEM_CONSOLE}.write_line ("Please press Enter to continue...")
			{SYSTEM_CONSOLE}.read_line.do_nothing
		end

note
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
