indexing
	description: "Rename a Renamble Data"
	author: "Reda Kolli"
	date: "$Date$"
	revision: "$Revision$"

class
	RENAME_ENTITY_COMMAND

inherit
	EV_COMMAND

	ONCES

creation
	make

feature -- Initialization

	make (n: like name_data; t: like text_field) is
			-- Initialize
		do
			name_data := n
			text_field := t
		end

feature -- Properties

	name_data: NAME_DATA
	text_field: EV_TEXT_FIELD

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
		do
			name_data.set_name (text_field.text)
			observer_management.update_observer (system)
		end


end -- class INIT_EDITOR_COMMAND
