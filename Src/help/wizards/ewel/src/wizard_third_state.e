indexing
	description: "Page in which the user choose where he wants to generate the sources."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_THIRD_STATE

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		local
			browse1_b: EV_BUTTON
			h1,h2: EV_HORIZONTAL_BOX
			v1: EV_VERTICAL_BOX
		do 
			create h1
			Create location.make ("New Project Location",wizard_information.location,10,80,Current, FALSE)
			Create browse1_b.make_with_text ("Browse ...")
			browse1_b.set_minimum_width (74)
			browse1_b.set_minimum_height (23)
			browse1_b.select_actions.extend (~browse(FALSE))
			create v1
			v1.extend (create {EV_CELL})
			v1.extend (browse1_b)
			v1.disable_item_expand (browse1_b)
			h1.set_padding (11)
			h1.extend(location)
			h1.extend(v1)
			h1.disable_item_expand(v1)

			create to_compile_b.make_with_text ("Check if you want the wizard to compile the generated classes")
			if wizard_information.compile_project then
				to_compile_b.enable_select
			else
				to_compile_b.disable_select
			end

			choice_box.extend (h1)
			choice_box.disable_item_expand(h1)

			choice_box.extend (to_compile_b)
			choice_box.disable_item_expand (to_compile_b)
			choice_box.extend (create {EV_CELL})

			set_updatable_entries(<<browse1_b.select_actions,
									location.change_actions,
									to_compile_b.select_actions>>)

		end

	proceed_with_current_info is 
		local
			dir: DIRECTORY
		do
			create dir.make (location.text)

			if not dir.exists then
				Precursor
				proceed_with_new_state (create {WIZARD_ERROR_LOCATION}.make (wizard_information))
			else
				Precursor
				proceed_with_new_state (create {WIZARD_FINAL_STATE}.make (wizard_information))
			end
		end

	update_state_information is
			-- Check User Entries
		do
			wizard_information.set_location (location.text)
			wizard_information.set_compile_project (to_compile_b.is_selected)
			Precursor
		end


feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("CHOOSE LOCATION")
			message.set_text ("%NChoose the directory where you want to generate%
							    % your new project%
								%%NThen check the box if you want to compile the generated files")
		end

	browse (is_for_project: BOOLEAN) is
			-- Launch a computer directory Browser.
		local
			dir_selector: EV_DIRECTORY_DIALOG	
		do
			Create dir_selector
			dir_selector.ok_actions.extend (~directory_selected(dir_selector,is_for_project))
			dir_selector.show_modal
		end

	directory_selected (dir_selector: EV_DIRECTORY_DIALOG; is_for_project: BOOLEAN) is
			-- The user selected a directory from the browser. 
			-- It updates the text fields accordingly.
		require
			selector_exists: dir_selector /= Void
		do
			location.set_text (dir_selector.directory)
		end

feature -- Implementation

	location: WIZARD_SMART_TEXT_FIELD

	to_compile_b: EV_CHECK_BUTTON


end -- class WIZARD_THIRD_STATE
