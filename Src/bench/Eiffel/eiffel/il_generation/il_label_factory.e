indexing
	description: "Factory used for managing label symbols into generated IL"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IL_LABEL_FACTORY

inherit
	SHARED_IL_CODE_GENERATOR

create
	make

feature -- Initialization

	make is
			-- Create IL_LABEL_FACTORY
		do
		end

feature -- Label creation

	new_label: IL_LABEL is
			-- Create new instance of IL_LABEL object.
		do
			Result := il_generator.create_label
		end

feature -- Retry label

	create_retry_label is
			-- Initialize `retry_label' object.
		do
			retry_label := new_label
		end

	retry_label: IL_LABEL
			-- Label used for `retry' statement.

end -- class IL_LABEL_FACTORY
