note
	description: "Summary description for {ER_NEW_RIBBON_COMMAND}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_NEW_RIBBON_COMMAND


inherit
	ER_COMMAND

create
	make

feature {NONE} -- Initlization

	make
			-- Creation method
		do
			init
			create shared_singleton
		end

feature -- Command

	execute
			-- <Precursor>
		local
			layout_constructor: ER_LAYOUT_CONSTRUCTOR
		do
			if attached main_window as l_win then
				if attached l_win.docking_manager as l_dock then
					create layout_constructor.make

					layout_constructor.attach_to_docking_manager (l_dock)
				end
			end
		end

	new_tool_bar_item: SD_TOOL_BAR_BUTTON
			--
		do
			create Result.make
			Result.set_text ("New Ribbon")
			Result.select_actions.extend (agent execute)
			tool_bar_items.extend (Result)
		end

	set_main_window (a_main_window: ER_MAIN_WINDOW)
			--
		do
			main_window := a_main_window
		end

feature {NONE} -- Implementation

	shared_singleton: ER_SHARED_SINGLETON
			--

	main_window: detachable ER_MAIN_WINDOW
			--

end
