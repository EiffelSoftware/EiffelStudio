note
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	FORWARD_ME

inherit
	MARSHAL_BY_REF_OBJECT

create
	make

feature -- Basic operations

	call_me (text: SYSTEM_STRING)
		require
			text_attached: text /= Void
		do
			{SYSTEM_CONSOLE}.write_line (text)
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
