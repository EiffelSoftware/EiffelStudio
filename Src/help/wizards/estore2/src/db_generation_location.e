indexing
	description: "Page which deals with the different location entries."
	author: "David S"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_GENERATION_LOCATION


inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

create
	make

feature -- basic Operations

	build is 
			-- Build user entries.
		local
			browse1_b: EV_BUTTON
			h1: EV_HORIZONTAL_BOX
			v1: EV_VERTICAL_BOX
		do 
			create h1
			create location.make ("Project Directory",wizard_information.location,10,80,Current, False)
			create browse1_b.make_with_text ("Browse ...")
			browse1_b.set_minimum_width (74)
			browse1_b.set_minimum_height (23)
			browse1_b.select_actions.extend (~browse)
			create v1
			v1.extend (create {EV_CELL})
			v1.extend (browse1_b)
			v1.disable_item_expand (browse1_b)
			h1.set_padding (11)
			h1.extend(location)
			h1.extend(v1)
			h1.disable_item_expand(v1)
			choice_box.extend (h1)
			choice_box.disable_item_expand(h1)

			create to_compile_b.make_with_text ("Compile generated classes.")
			if wizard_information.compile_project then
				to_compile_b.enable_select
			else
				to_compile_b.disable_select
			end

			create to_precompiled_base_b.make_with_text ("Use EiffelBase precompiled library.")
			if wizard_information.precompiled_base then
				to_precompiled_base_b.enable_select
			else
				to_precompiled_base_b.disable_select
			end

			if not wizard_information.new_project then
				to_compile_b.disable_sensitive
				to_compile_b.disable_select
				to_precompiled_base_b.disable_sensitive
				to_precompiled_base_b.disable_select
			end

			choice_box.extend (to_compile_b)
			choice_box.disable_item_expand (to_compile_b)
			choice_box.extend (to_precompiled_base_b)
			choice_box.disable_item_expand (to_precompiled_base_b)
			choice_box.extend (create {EV_CELL})

			set_updatable_entries(<<browse1_b.select_actions,
									location.change_actions,
									to_compile_b.select_actions,
									to_precompiled_base_b.select_actions>>)
		end

	proceed_with_current_info is 
			-- Process user entries.
		local
			next_step: DB_FINISH
			mess: EV_ERROR_DIALOG
			dir: DIRECTORY
		do 
			create dir.make (location.text)
			if not dir.exists then
				Precursor
				proceed_with_new_state (create {DB_ERROR_LOCATION}.make (wizard_information))
				
			else
				precursor
				proceed_with_new_state (create {DB_FINISH}.make (wizard_information))
			end
		end

	update_state_information is
			-- Check user entries.
		do
			wizard_information.set_location(location.text)
			wizard_information.set_compile_project (to_compile_b.is_selected)
			wizard_information.set_precompiled_base (to_precompiled_base_b.is_selected)
			precursor
		end

	display_state_text is
		do
			title.set_text ("STEP 4: CHOOSE PROJECT DIRECTORY")
			if wizard_information.new_project then
				message.set_text ("%NYou will now choose a directory where the EiffelStore Wizard will generate%
								%%Nthe application.%
								%%NYou may also ask the Wizard to compile the application for you.%N%N")
			else
				message.set_text ("%NYou will now choose a directory where the EiffelStore Wizard will generate%
								%%Nthe application.%N%N")
			end
		end


	browse is
			-- Launch a computer directory Browser.
		local
			dir_selector: EV_DIRECTORY_DIALOG	
		do
			Create dir_selector
			dir_selector.ok_actions.extend (~directory_selected(dir_selector))
			dir_selector.show_modal
		end

	directory_selected (dir_selector: EV_DIRECTORY_DIALOG) is
			-- The user selected a directory from the browser. 
			-- It updates the text fields accordingly.
		require
			selector_exists: dir_selector /= Void
		do
			location.set_text (dir_selector.directory)
		end

feature -- Implementation

	location: WIZARD_SMART_TEXT_FIELD
		-- Location where the project will be created

	to_compile_b, to_precompiled_base_b : EV_CHECK_BUTTON
		-- To choose to compile the project, to use the precompiled base library

end -- class DB_GENERATION_LOCATION
