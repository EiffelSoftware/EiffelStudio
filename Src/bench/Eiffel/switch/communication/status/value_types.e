indexing
	description: "Types shared by all debug values"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	VALUE_TYPES

feature -- Shared constants

	Immediate_value: INTEGER is 1
	Void_value: INTEGER is 2
	Reference_value: INTEGER is 3
	Expanded_value: INTEGER is 4
	Special_value: INTEGER is 5
	External_reference_value: INTEGER is 6 -- used for dotnet
	Error_message_value: INTEGER is 7 -- used to display error on value retrieving

end -- class VALUE_TYPES
