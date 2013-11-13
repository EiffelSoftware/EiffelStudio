note
	description: "Stores a repository-wide unique identifier for an object alongside a reference to it."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_OBJECT_IDENTIFIER_WRAPPER

inherit

	PS_ABEL_EXPORT

create --{PS_OBJECT_IDENTIFICATION_MANAGER}
	make

feature {NONE} -- Initialization

	make (identifier: INTEGER; object: ANY; object_metadata: PS_TYPE_METADATA)
			-- Initialize `Current'.
		do
			object_identifier := identifier
			item := object
			metadata := object_metadata
		end

feature {PS_ABEL_EXPORT} -- Access

	object_identifier: INTEGER
			-- The unique identifier for this object.

	item: ANY
			-- A reference to the actual object.

	metadata: PS_TYPE_METADATA
			-- Metadata information about the type of `item'.

end
