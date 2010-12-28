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
		do
			code_generator.generate_all_codes
		end

	new_tool_bar_item: SD_TOOL_BAR_BUTTON
			--
		do
			create Result.make
			Result.set_text ("Generate Code")
			Result.select_actions.extend (agent execute)
			tool_bar_items.extend (Result)
		end

feature {NONE} -- Implementation

	shared_singleton: ER_SHARED_SINGLETON
			--

	code_generator: ER_CODE_GENERATOR
			--			
end
