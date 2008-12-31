note
	status: "See notice at end of class."
	legal: "See notice at end of class."
	
	dotnet_constructors:
		make

class
	HELLO_SERVER

inherit
	MARSHAL_BY_REF_OBJECT
		rename
			make as make_base
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize new server
		do
			{SYSTEM_CONSOLE}.write_line (generating_type + " activated")
		end

feature -- Basic operations

	hello_method (obj: FORWARD_ME): FORWARD_ME
			-- Remote hello method
		require
			obj_attached: obj /= Void
		local
			i: INTEGER
		do
			from i := 0 until i = 5 loop
				obj.call_me
				i := i + 1
			end
			Result := obj
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
