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
	Static_external_reference_value: INTEGER is 7 -- Used for static external reference value
	Static_reference_value: INTEGER is 8 -- Used for static external reference value (known in ec)
	Error_message_value: INTEGER is 9 -- used to display error on value retrieving

end -- class VALUE_TYPES
