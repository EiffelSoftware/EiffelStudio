note
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	CULTURE_AND_REGION

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main
			-- Program entry point
		local
			fs: FILE_STREAM
			t, t2, t3, t4: STREAM_WRITER
		do
				-- Create a text file for this example
			{SYSTEM_CONSOLE}.write_line ("Creating text.txt")
			create fs.make ("text.txt", {FILE_MODE}.open_or_create)

			{SYSTEM_CONSOLE}.write_line ("Writing UTF8")
			create t.make (fs, {ENCODING}.utf8)
			t.write_line ("This is in UTF8")
			t.flush

			{SYSTEM_CONSOLE}.write_line ("Writing Unicode")
			create t2.make (fs, {ENCODING}.unicode)
			t2.write_line ("This is in Unicode")
			t2.flush()

			{SYSTEM_CONSOLE}.write_line ("Writing Ascii")
			create t3.make (fs, {ENCODING}.ascii)
			t3.write_line ("This is in ASCII")
			t3.flush()

			-- Note that UTF-8 would be preferred as different systems or user settings
			-- could cause different {ENCODING}.default behaviors.  Additionally, {ENCODING}.default
			-- could lose or change data, whereas UTF-8 would be lossless.
			{SYSTEM_CONSOLE}.write ("Writing Your Default Code Page ")
			{SYSTEM_CONSOLE}.write_line ({ENCODING}.default.encoding_name);
			create t4.make (fs, {ENCODING}.default);
			t4.write ("This is in your default code page ")
			t4.write_line ({ENCODING}.default.encoding_name)
			t4.flush

			fs.close

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
