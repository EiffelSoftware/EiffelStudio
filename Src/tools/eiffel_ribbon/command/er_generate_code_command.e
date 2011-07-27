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
		end

feature -- Command

	execute
			-- <Precursor>
		local
			l_warning: EV_WARNING_DIALOG
			l_code_generator: like code_generator
		do
			-- Must use local here, since `is_uicc_available' will initialize `uicc_full_path'
			l_code_generator := code_generator
			if l_code_generator.is_uicc_available then
				if attached shared_singleton.main_window_cell.item as l_main_window then
					l_main_window.output_tool.show
				end
				l_code_generator.generate_all_codes
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

	set_main_window (a_main_window: ER_MAIN_WINDOW)
			--
		do
			main_window := a_main_window
		end

feature {NONE} -- Implementation

	shared_singleton: ER_SHARED_SINGLETON
			--

	code_generator: ER_COMMON_CODE_GENERATOR
			--		
		local
			l_factory: ER_CODE_GENERATOR_FACTORY
		do
			create l_factory
			Result := l_factory.code_generator
		end

	main_window: detachable ER_MAIN_WINDOW
			--

end
