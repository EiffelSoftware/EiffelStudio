note
	status: "See notice at end of class."
	legal: "See notice at end of class."

frozen class
	REMOTE_CONSTANTS

inherit
	SYSTEM_OBJECT

feature -- Access

	tcp_port: INTEGER = 8085
	http_port: INTEGER = 8086

	name: SYSTEM_STRING = "SayHello";

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
