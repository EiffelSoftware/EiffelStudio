indexing
	description: "Initialize the Editor"
	author: "Reda Kolli"
	date: "$Date$"
	revision: "$Revision$"

class
	RENAME_DATA_COMMAND

inherit
	EV_COMMAND

	ONCES

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
			namable_data: NAME_DATA
			box: SMART_TEXT_FIELD
			text_field: EV_TEXT_FIELD
		do
			if editor /= Void then
				namable_data := editor.data
		
				if namable_data /= Void then
					namable_data.set_name (editor.entered_text)
					observer_management.update_observer (namable_data)
				end

				--box := editor.name
				--if box /= Void then
				--	text_field := box.text_field
				--	if text_field /= Void then
				--		text_field.set_editable (false)
				--	end
				--end
			end
		end


end -- class INIT_EDITOR_COMMAND
