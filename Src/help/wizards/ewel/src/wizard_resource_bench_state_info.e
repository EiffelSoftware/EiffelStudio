indexing
	description: "Page in which the user choose where he wants to generate the sources."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RESOURCE_BENCH_STATE_INFO

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
--			update_state_information,
			proceed_with_current_info,
			build
		end

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		local
			h1: EV_HORIZONTAL_BOX
		do 
--			main_box.disable_item_expand (choice_box)

--			create h1
--			h1.set_minimum_height (2)
--			choice_box.extend (h1)
--			choice_box.disable_item_expand (h1)
		end

	proceed_with_current_info is 
		do
			Precursor
			proceed_with_new_state (create {WIZARD_RESOURCE_BENCH_SECOND_STATE}.make (wizard_information))
		end

feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("GENERATION INFO")
			message.set_text ("%NIn the next step you will have to select the generation options.%
							  %%NYou will have to choose:%
							  %%N%N%T+ Which of your dialog will be the unique main dialog.%
							  %%N%T%TChoose to inherit from MAIN_DIALOG to set your main dialog.%
							  %%N%N%T+ Which features of your dialogs will need to be redefine.%
							  %%N%T%TCheck the needed features in the 'Select features...' list%
							  %%N%N%T+ Which buttons will you want to integrate in the project.%
							  %%N%T%TSelect all availaible buttons in the 'Select controls...' list.%
							  %")
		end

end -- class WIZARD_RESOURCE_BENCH_STATE_INFO

