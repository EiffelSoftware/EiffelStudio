note
	status: "See notice at end of class."
	legal: "See notice at end of class."
	
	metadata:
		create {SERIALIZABLE_ATTRIBUTE}.make end

	dotnet_constructors:
		make

class
	FORWARD_ME

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize new instance
		do
			value := 1
		end

feature -- Basic operations

	call_me
		do
			value := value + 1
		end

feature -- Query

	get_value: INTEGER
		do
			Result := value
		end

feature {NONE} -- Access

	value: INTEGER

invariant
	value_is_positive: value > 0

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
