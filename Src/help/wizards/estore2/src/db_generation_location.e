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
			browse1_b,browse2_b: EV_BUTTON
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

			create h2
			create project_location.make ("Existing Project Location",wizard_information.project_location,10,80,Current, FALSE)
			create browse2_b.make_with_text ("Browse ...")
			browse2_b.set_minimum_width (74)
			browse2_b.set_minimum_height (23)
			browse2_b.select_actions.extend (~browse(TRUE))
			create v1
			v1.extend (create {EV_CELL})
			v1.extend (browse2_b)
			v1.disable_item_expand (browse2_b)
			h2.set_padding (11)
			h2.extend (project_location)
			h2.extend (v1)
			h2.disable_item_expand (v1)

			create to_compile_b.make_with_text ("Check if you want the wizard to compile the generated classes")
			if wizard_information.compile_project then
				to_compile_b.enable_select
			else
				to_compile_b.disable_select
			end

			if wizard_information.new_project then
				choice_box.extend (h1)
				choice_box.disable_item_expand(h1)
			else
				choice_box.extend (h2)
				choice_box.disable_item_expand(h2)
				to_compile_b.disable_sensitive
				to_compile_b.disable_select
			end

			choice_box.extend (to_compile_b)
			choice_box.disable_item_expand (to_compile_b)
			choice_box.extend (create {EV_CELL})

			set_updatable_entries(<<browse2_b.select_actions,
									browse1_b.select_actions,
									location.change_actions,
									project_location.change_actions,
									to_compile_b.select_actions>>)
		end

	proceed_with_current_info is 
			-- Process user entries
		local
			next_step: DB_FINISH
			mess: EV_ERROR_DIALOG
			dir: DIRECTORY
		do 
			if project_location.text.count /= 0 then
				create dir.make (project_location.text)
			else
				create dir.make (location.text)
			end

			if not dir.exists then
				Precursor
				proceed_with_new_state (create {DB_ERROR_LOCATION}.make (wizard_information))
				
--				create mess.make_with_text ("Please provide a location.")
--				entries_checked := FALSE
--				entries_changed := TRUE
--				mess.show_modal
			else
				precursor
				proceed_with_new_state (create {DB_FINISH}.make (wizard_information))
			end
		end

	update_state_information is
			-- Check user entries
		do
--			wizard_information.set_locations(location.text,project_location.text)
			wizard_information.set_locations(location.text,location.text)
			wizard_information.set_compile_project (to_compile_b.is_selected)
			precursor
		end

	display_state_text is
		do
			title.set_text ("STEP 4: CHOOSE LOCATION")
			message.set_text ("%NChoose where do you want to generate your Project%N%N%
								%If you choose to compile, then the wizard will be freezed during the compilation%
								%%NThen ebench will be launched on the generated project.%
								%%NWarning !! You should use an empty directory if you want to compile !!%N%N")
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
			if is_for_project then
				project_location.set_text (dir_selector.directory)
			else	
				location.set_text (dir_selector.directory)
			end
		end

feature -- Implementation

	location,project_location: WIZARD_SMART_TEXT_FIELD

	to_compile_b: EV_CHECK_BUTTON

end -- class DB_GENERATION_LOCATION
