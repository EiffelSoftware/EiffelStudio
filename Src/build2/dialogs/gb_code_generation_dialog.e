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
		
	GB_SHARED_SYSTEM_STATUS
		undefine
			default_create, copy
		end
		
	GB_CONSTANTS
	
	GB_SHARED_STATUS_BAR
		undefine
			default_create, copy
		end

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
			
				-- Create all widgets.
			create l_vertical_box_1
			create l_horizontal_box_1
			create l_cell_1
			create l_label_1
			create l_horizontal_box_2
			create generation_progress
			
				-- Build_widget_structure.
			extend (l_vertical_box_1)
			l_vertical_box_1.extend (l_horizontal_box_1)
			l_horizontal_box_1.extend (l_cell_1)
			l_horizontal_box_1.extend (l_label_1)
			l_vertical_box_1.extend (l_horizontal_box_2)
			l_horizontal_box_2.extend (generation_progress)
			
				-- Initialize properties of all widgets.
			
			set_minimum_width (250)
			disable_user_resize
			set_title ("Generation progress")
			l_vertical_box_1.disable_item_expand (l_horizontal_box_2)
			l_horizontal_box_1.disable_item_expand (l_cell_1)
			l_cell_1.set_minimum_width (10)
			l_label_1.set_text ("Generating...")
			l_label_1.align_text_left
			l_horizontal_box_2.set_border_width (10)
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
			show_actions.extend (agent start_generation)
		end
		
feature {GB_GENERATION_COMMAND} -- Basic operation
		
	show_completion is
			-- Display to user that completion has finished.
		local
			temp_label: EV_LABEL
			temp_file_name: FILE_NAME
		do
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
			generation_progress.set_proportion (1)
			set_timed_status_text ("Generation successful - " + system_status.current_project_settings.project_location)
			destroy
		end
		

	start_generation is
			-- Begin generation and set generation
			-- output progress bar to `progress_bar'.
		local
			code_generator: GB_CODE_GENERATOR
		do
			create code_generator
			code_generator.set_progress_bar (generation_progress)
			code_generator.generate
			show_completion
		end
		
		
feature {NONE} -- Implementation

	l_vertical_box_1: EV_VERTICAL_BOX
	l_horizontal_box_1, l_horizontal_box_2: EV_HORIZONTAL_BOX
	l_cell_1: EV_CELL
	l_label_1: EV_LABEL
	generation_progress: EV_HORIZONTAL_PROGRESS_BAR


end -- class GB_CODE_GENERATION_DIALOG

