indexing
	description: "Initialize the Editor"
	author: "Reda Kolli"
	date: "$Date$"
	revision: "$Revision$"

class
	INIT_EDITOR_COMMAND

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

	editor: EDITOR_WINDOW_NAMER

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			pnd_data: EV_PND_EVENT_DATA
			stone: EC_STONE

			namable_data: NAME_DATA

			rename_data: RENAME_DATA_COMMAND

			box: SMART_TEXT_FIELD
			text_field: EV_TEXT_FIELD
		do
			pnd_data ?= data
	
			if pnd_data /= Void then
				stone ?= pnd_data.data

				if stone /= Void then
					namable_data ?= stone.data
					if namable_data /= Void then
						editor.set_entity (namable_data)

						box := editor.name
					
						if box /= Void then
							text_field := box.text_field

							if text_field /= Void then
								text_field.set_editable (true)
								text_field.set_text (namable_data.name)
			
								!! rename_data.make (editor)
							--	text_field.add_activate_command (rename_data, Void)
							end
						end
					end
				end
			end
		end


end -- class RENAME_DATA_COMMAND
