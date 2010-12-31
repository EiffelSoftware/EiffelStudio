note
	description: "Summary description for {ER_GENERATE_CODE_COMMAND}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_GENERATE_CODE_COMMAND

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
			create code_generator.make
		end

feature -- Command

	execute
			-- <Precursor>
		local
			l_warning: EV_WARNING_DIALOG
		do
			if code_generator.is_uicc_available then
				code_generator.generate_all_codes
			else
				if attached main_window as l_win then
					create l_warning.make_with_text ("Windows SDK 7.0 (or higher) not found, nothing generated.")
					l_warning.show_modal_to_window (l_win)
				end
			end
		end

	new_tool_bar_item: SD_TOOL_BAR_BUTTON
			--
		do
			create Result.make
			Result.set_text ("Generate Code")
			Result.select_actions.extend (agent execute)
			tool_bar_items.extend (Result)
		end

	set_main_window (a_main_window: MAIN_WINDOW)
			--
		do
			main_window := a_main_window
		end

feature {NONE} -- Implementation

	shared_singleton: ER_SHARED_SINGLETON
			--

	code_generator: ER_CODE_GENERATOR
			--		

	main_window: detachable MAIN_WINDOW
			--

end
