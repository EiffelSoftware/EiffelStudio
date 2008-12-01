indexing
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	SERIALIZATION_TEST

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main
			-- Program entry point
		local
			l: ARRAY_LIST
			s, r: SYSTEM_STREAM
			x: INTEGER
		do
			{SYSTEM_CONSOLE}.write_line ("Create object graph")
			create l.make
			from x := 0 until x = 10 loop
				{SYSTEM_CONSOLE}.write_line (x)
				l.add (x).do_nothing
				x := x + 1
			end

			{SYSTEM_CONSOLE}.write_line ("Serializing object graph to disk...")
			s := (agent (list: ARRAY_LIST): SYSTEM_STREAM
					-- Use an inline agent to capture exceptions inline
				local
					b: BINARY_FORMATTER
					retried: BOOLEAN
				do
					if not retried then
						Result := {SYSTEM_FILE}.open ("foo.bin", {FILE_MODE}.create_, {FILE_ACCESS}.write)
						create b.make
						b.serialize (Result, list)
					else
						{SYSTEM_CONSOLE}.write_line ("An exception occurred during serialization: " + create {STRING}.make_from_cil ({ISE_RUNTIME}.last_exception.to_string))
					end
				rescue
					retried := True
					retry
				end).item ([l])
			if s /= Void then
				s.close
			end
			{SYSTEM_CONSOLE}.write_line ("Complete.")

			{SYSTEM_CONSOLE}.write_line ("Deserializing object graph to disk...")
			r := (agent (): SYSTEM_STREAM
					-- Use an inline agent to capture exceptions inline
				local
					c: BINARY_FORMATTER
					p: ARRAY_LIST
					enum: IENUMERATOR
					retried: BOOLEAN
				do
					if not retried then
						Result := {SYSTEM_FILE}.open ("foo.bin", {FILE_MODE}.open, {FILE_ACCESS}.read)
						create c.make
						p ?= c.deserialize (Result)
						from enum := p.get_enumerator until not enum.move_next loop
							{SYSTEM_CONSOLE}.write_line (enum.current_)
						end
					else
						{SYSTEM_CONSOLE}.write_line ("An exception occurred during deserialization: " + create {STRING}.make_from_cil ({ISE_RUNTIME}.last_exception.to_string))
					end
				rescue
					retried := True
					retry
				end).item ([])
			if r /= Void then
				r.close
			end
			{SYSTEM_CONSOLE}.write_line ("Complete.")

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
