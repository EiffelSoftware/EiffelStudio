indexing
	description	: "Dialog for output while generating code."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_CODE_GENERATION_DIALOG

inherit
	EV_DIALOG

	EV_LAYOUT_CONSTANTS
		undefine
			default_create, copy
		end
	
	GB_WIDGET_UTILITIES
		undefine
			default_create, copy
		end
		
	GB_ACCESSIBLE_SYSTEM_STATUS
		undefine
			default_create, copy
		end
		
	GB_CONSTANTS

create
	make_default

feature {NONE} -- Initialization

	make_default is
			-- Create current in default state.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			padding_cell: EV_CELL
		do
			default_create
			create widget_holder
			create label.make_with_text ("Generating code")
			create progress_bar
			progress_bar.set_minimum_width (200)
			progress_bar.set_proportion (0.25)
			label.align_text_center
			widget_holder.extend (label)
			
			create horizontal_box
			widget_holder.extend (horizontal_box)
			create padding_cell
			horizontal_box.extend (padding_cell)
			horizontal_box.extend (progress_bar)
			create padding_cell
			horizontal_box.extend (padding_cell)
			horizontal_box.disable_item_expand (progress_bar)

			widget_holder.set_padding_width (20)
			widget_holder.set_border_width (20)
			extend (widget_holder)
		end
		
feature {GB_CODE_GENERATION_TOOL_BAR_BUTTON} -- Basic operation
		
	show_completion is
			--
		local
			temp_label: EV_LABEL
			temp_file_name: FILE_NAME
		do
			progress_bar.set_proportion (1)
			label.set_text ("Generation completed")
			create temp_file_name.make_from_string (system_status.current_project_settings.project_location)
			temp_file_name.extend (generation_directory)
			create temp_label.make_with_text ("Files generated in : " + temp_file_name)		
			widget_holder.extend (temp_label)
			create ok_button.make_with_text ((create {EV_DIALOG_CONSTANTS}).ev_ok)
			widget_holder.extend (ok_button)
			ok_button.select_actions.extend (agent destroy)
		end
		
		
	start_generation is
			--
		local
			code_generator: GB_CODE_GENERATOR
		do
			create code_generator
			code_generator.set_progress_bar (progress_bar)
			code_generator.generate
		end
		
		
feature {NONE} -- Implementation

	widget_holder: EV_VERTICAL_BOX
		--
		
	label: EV_LABEL
		
	progress_bar: EV_HORIZONTAL_PROGRESS_BAR
		-- Progress bar to display current progress of code
		-- generation.
		
	ok_button: EV_BUTTON

end -- class GB_CODE_GENERATION_DIALOG

