indexing
	description	: "Third state of the profiler wizard (Choose input file)"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_THIRD_STATE

inherit
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

	EB_PROFILER_WIZARD_SHARED_INFORMATION
		export
			{NONE} all
		end
		
	EB_CONSTANTS
		export
			{NONE} all
		end

	EIFFEL_ENV
		export
			{NONE} all
		end

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		local
			profiler_type_box: EV_HORIZONTAL_BOX
			profiler_type_label: EV_LABEL
		do
			create runtime_information_record_textfield.make (Current)
			runtime_information_record_textfield.set_label_string (Interface_names.l_Runtime_information_record)
			runtime_information_record_textfield.enable_file_browse_button ("*.*")
			runtime_information_record_textfield.set_starting_directory (information.generation_path)
			runtime_information_record_textfield.generate
		
			create profiler_type_label.make_with_text (Interface_names.l_Profiler_used)
			profiler_type_label.align_text_left

			create profiler_list
			profiler_list.disable_edit
			fill_profiler_list
			
			create profiler_type_box
			profiler_type_box.set_padding (Layout_constants.Small_padding_size)
			profiler_type_box.extend (profiler_type_label)
			profiler_type_box.disable_item_expand (profiler_type_label)
			profiler_type_box.extend (profiler_list)
			
				-- Link
			choice_box.set_padding (Small_padding_size)
			choice_box.extend (runtime_information_record_textfield.widget)
			choice_box.extend (profiler_type_box)

				-- Update controls to reflect `information'
			select_profiler (information.runtime_information_type)
			runtime_information_record_textfield.set_text (information.runtime_information_record)
		end

	proceed_with_current_info is 
		do
			if is_supplied_runtime_information_record_valid then
				proceed_with_new_state(create {EB_PROFILER_WIZARD_FOURTH_STATE}.make (wizard_information))
			else
				proceed_with_new_state(create {EB_PROFILER_WIZARD_RUNTIME_INFO_RECORD_ERROR_STATE}.make (wizard_information))
			end
		end

	update_state_information is
			-- Check User Entries
		local
			record_filename: FILE_NAME
		do
			Precursor
			
			if runtime_information_record_textfield.text /= Void then
				create record_filename.make_from_string (runtime_information_record_textfield.text)
				information.set_runtime_information_record (record_filename) 
			end
			
			information.set_runtime_information_type (profiler_list.text)
		end


feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text (Interface_names.wt_Execution_Profile_Generation)
			subtitle.set_text (Interface_names.ws_Execution_Profile_Generation)
			message.set_text (Interface_names.wb_Execution_Profile_Generation)
		end
		
	fill_profiler_list is
			-- Fill in `profiler_list' with all available profiler configuration files.
			-- Fill `profiler_list' with profilers
			-- for which configuration files could be found
			-- in Eiffel installation directory at "bench/profiler".
		require
			profiler_list_not_void: profiler_list /= Void
		local
			profdir: DIRECTORY
			list_string: EV_LIST_ITEM
			lastentry: STRING
		do
			create profdir.make_open_read (profile_path)
			from
				profdir.start
				profdir.readentry
			until
				profdir.lastentry = Void
			loop
				lastentry := profdir.lastentry
				if not lastentry.is_equal (".") and not lastentry.is_equal ("..") then
					create list_string.make_with_text (lastentry)
					profiler_list.extend (list_string)
				end
				profdir.readentry
			end
		end
		
	select_profiler (a_profiler: STRING) is
			-- Select `a_profiler' in the list `profiler_list'.
		require
			profiler_list_not_void: profiler_list /= Void
		local
			an_item: EV_LIST_ITEM
			found: BOOLEAN
		do
			if a_profiler /= Void then
				from
					profiler_list.start
				until
					profiler_list.after or found
				loop
					an_item := profiler_list.item
					if an_item.text.is_equal (a_profiler) then
						an_item.enable_select
						found := True
					end
					profiler_list.forth
				end
			else
				profiler_list.first.enable_select
			end
		end
		
	is_supplied_runtime_information_record_valid: BOOLEAN is
			-- Is the supplied Runtime information record a valid file?
		local
			rtir_file: RAW_FILE
			rtir_text: STRING
			index_sep: INTEGER
			rtir_path: STRING
		do
			rtir_text := runtime_information_record_textfield.text
			Result := True
			
				-- Check that the filename is not empty
			if rtir_text = Void then
				Result := False
			end
			
				-- Check that the filename indicate a valid and readable file
			if Result then
				create rtir_file.make (rtir_text)
				Result := rtir_file.exists and then rtir_file.is_readable
			end
			
				-- Check that the file is located in the W_CODE or F_CODE
				-- Directory
			if Result then
				index_sep := rtir_text.last_index_of (Operating_environment.Directory_separator, rtir_text.count)
				if index_sep /= 0 then
					rtir_path := rtir_text.substring (1, index_sep - 1)
					Result := rtir_path.is_equal (information.generation_path)	
				end
			end
		end

feature {NONE} -- Vision2 controls

	runtime_information_record_textfield: EB_WIZARD_SMART_TEXT_FIELD
			-- Text field where the Runtime information record is entered.
	
	profiler_list: EV_COMBO_BOX
			-- Type of the profiler used to generate the record.

end -- class EB_PROFILER_WIZARD_THIRD_STATE

