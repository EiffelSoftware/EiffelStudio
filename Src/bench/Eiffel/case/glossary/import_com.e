indexing
	description: "Class responsible for importing a glossary"
	date: "$Date$"
	revision: "$Revision$"

class
	IMPORT_COM

inherit
	EV_COMMAND

	ONCES

creation
	make

feature -- Creation

	make (m: like main_window; d: like drawing_component) is
		do
			main_window := m
			drawing_component := d
		end

feature {NONE} -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	local
		gl : IMPORT_GLOSSARY
	do
		if system.project_initialized then
			if drawing_component /= Void then
				!! gl.make (main_window, drawing_component.drawing_area)
			end
		else
			windows_manager.popup_message ("Mg","", main_window)
		end
	end

feature -- Properties

	main_window: MAIN_WINDOW
	drawing_component: DRAWING_COMPONENT

end -- class IMPORT_COM
