indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CANCEL_NAME_COMMAND

inherit
	EV_COMMAND

creation
	make

feature -- Initialization

	make (e: like editor) is
			-- Initialize
		do
			editor := e
		end

feature -- Properties

	editor: ENTITY_NAME_FIELD
	
feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			window: EC_EDITOR_WINDOW [NAME_DATA]
			entity: NAME_DATA
		do
			if editor /= Void then
				window := editor.editor_window

				if window /= Void then
					entity := window.entity

					if entity /= Void then
						editor.set_text (entity.name)
					end
				end
			end
		end

end -- class CANCEL_NAME_COMMAND
