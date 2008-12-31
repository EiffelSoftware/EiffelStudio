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
			counter := 0
			{SYSTEM_CONSOLE}.write_line (generating_type + " activated")
		end

feature {NONE} -- Access

	counter: INTEGER

feature -- Basic operations

	hello_method (name: SYSTEM_STRING; obj: FORWARD_ME): SYSTEM_STRING
			-- Remote hello method
		require
			not_name_is_void_or_empty: not {SYSTEM_STRING}.is_null_or_empty (name)
			obj_attached: obj /= Void
		do
			obj.call_me ("Regards from the server")
			{SYSTEM_CONSOLE}.write_line (generating_type + ".HelloMethod : {0}", name)
			Result := {SYSTEM_STRING}.format ("Hi there {0}", name)
		end

	count_me: INTEGER
			-- Remote count function
		local
			retried: BOOLEAN
		do
			if not retried then
				{MONITOR}.enter (Current)
				counter := counter + 1
				Result := counter				
			end
			{MONITOR}.exit (Current)
		rescue
			retried := True
			retry
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
