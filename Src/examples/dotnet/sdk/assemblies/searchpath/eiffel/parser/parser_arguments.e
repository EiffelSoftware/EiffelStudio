note
	status: "See notice at end of class."
	legal: "See notice at end of class."
	dotnet_constructor:
		default_create

	metadata:
		create {EIFFEL_CONSUMABLE_ATTRIBUTE}.make (True) end

class
	PARSER_ARGUMENTS

inherit
	SYSTEM_OBJECT

feature -- Properties

	arg1: SYSTEM_STRING assign set_arg1
			-- Left hand argument
		note
			property: auto
		attribute
		end

	set_arg1 (a_arg1: like arg1)
			-- Set `arg1' with `a_arg1'.
		do
			arg1 := a_arg1
		ensure
			arg1_assigned: arg1 = a_arg1
		end

	operator: CHARACTER assign set_operator
			-- Operator
		note
			property: auto
		attribute
		end

	set_operator (a_operator: like operator)
			-- Set `operator' with `a_operator'.
		do
			operator := a_operator
		ensure
			operator_assigned: operator = a_operator
		end

	arg2: SYSTEM_STRING assign set_arg2
			-- Right hand argument
		note
			property: auto
		attribute
		end

	set_arg2 (a_arg2: like arg2)
			-- Set `arg2' with `a_arg2'.
		do
			arg2 := a_arg2
		ensure
			arg2_assigned: arg2 = a_arg2
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
