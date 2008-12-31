note
	status: "See notice at end of class."
	legal: "See notice at end of class."

deferred class
	I_HELLO

feature -- Basic operations

	hello_method (name: SYSTEM_STRING): SYSTEM_STRING
		require
			not_name_is_void_or_empty: not {SYSTEM_STRING}.is_null_or_empty (name)
		deferred
		ensure
			not_result_is_void_or_empty: not {SYSTEM_STRING}.is_null_or_empty (Result)
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
