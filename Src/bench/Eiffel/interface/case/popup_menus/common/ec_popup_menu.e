indexing
	description: "Popup Menu launched from Ecase part."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EC_POPUP_MENU

inherit
	EV_POPUP_MENU

feature -- Operations

	remove (args: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Delete 'data'
		deferred
		end

	popup_editor (args: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Popup Editor relative to 'data'.
		local
			clas_data: CLASS_DATA
			r_data: RELATION_DATA
		--	class_window: EC_CLASS_WINDOW
			relation_window: EC_RELATION_WINDOW
		do
			clas_data ?= data
			r_data ?= data
			if r_data /= Void then
				!! relation_window.make(workarea.analysis_window)
				relation_window.set_entity (r_data)
		--	elseif clas_data /= Void then
		--		!! class_window.make(workarea.analysis_window)
		--		class_window.set_entity (clas_data)
			end
		end

feature -- Implementation

	data: COLORABLE is deferred end
		-- Current data that applies to Current Menu.

	workarea: WORKAREA
		-- Current workarea

feature -- Operations

	colorize (args: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Delete 'data'
		local
			color_command: COLORING_COMMAND
		do
			!! color_command.make_from_menu(workarea.scrollable_area, data)
			color_command.execute(Void,Void)
		end


invariant
	data_exists: data /= Void
	workarea_consistent: workarea /= Void and then workarea.analysis_window /= Void

end -- class EC_POPUP_MENU
