indexing
	description	: "Dialog for output while generating code."
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_CODE_GENERATION_DIALOG

inherit
	EV_DIALOG

	EV_LAYOUT_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
	
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
	
	GB_SHARED_STATUS_BAR
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make_default

feature {NONE} -- Initialization

	make_default is
			-- Create current in default state.
		local 
			l_vertical_box_1, l_vertical_box_2, l_vertical_box_3: EV_VERTICAL_BOX
			l_horizontal_box_1, l_horizontal_box_2, l_horizontal_box_3: EV_HORIZONTAL_BOX
			l_pixmap_1: EV_PIXMAP
			l_cell_1, l_cell_2: EV_CELL
			l_label_1: EV_LABEL
			l_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
			l_button_1: EV_BUTTON
			eiffel_image: EV_PIXMAP
		do
			default_create
			
				-- Create all widgets.
			create l_vertical_box_1
			create l_horizontal_box_1
			create l_vertical_box_2
			--create l_pixmap_1
			eiffel_image := clone ((create {GB_SHARED_PIXMAPS}).Help_about_pixmap)
			eiffel_image.set_minimum_size (eiffel_image.width, eiffel_image.height)
			l_pixmap_1 := eiffel_image
			create l_horizontal_box_2
			create l_vertical_box_3
			create l_cell_1
			create l_label_1
			create l_horizontal_separator_1
			create l_horizontal_box_3
			create l_cell_2
			create l_button_1
			
				-- Build_widget_structure.
			extend (l_vertical_box_1)
			l_vertical_box_1.extend (l_horizontal_box_1)
			l_horizontal_box_1.extend (l_vertical_box_2)
			l_vertical_box_2.extend (l_pixmap_1)
			l_horizontal_box_1.extend (l_horizontal_box_2)
			l_horizontal_box_2.extend (l_vertical_box_3)
			l_vertical_box_3.extend (l_cell_1)
			l_vertical_box_3.extend (l_label_1)
			l_vertical_box_1.extend (l_horizontal_separator_1)
			l_vertical_box_1.extend (l_horizontal_box_3)
			l_horizontal_box_3.extend (l_cell_2)
			l_horizontal_box_3.extend (l_button_1)
			
				-- Initialize properties of all widgets.
			
			disable_user_resize
			set_title ("Code Generation")
			l_vertical_box_1.disable_item_expand (l_horizontal_separator_1)
			l_vertical_box_1.disable_item_expand (l_horizontal_box_3)
			l_horizontal_box_1.disable_item_expand (l_vertical_box_2)
			l_vertical_box_2.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_vertical_box_2.set_minimum_width (118)
			l_vertical_box_2.set_border_width (6)
		--	l_pixmap_1.set_with_named_file ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
			l_horizontal_box_2.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_horizontal_box_2.set_border_width (10)
			l_vertical_box_3.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_vertical_box_3.disable_item_expand (l_cell_1)
			l_vertical_box_3.disable_item_expand (l_label_1)
			l_cell_1.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_cell_1.set_minimum_height (10)
			l_label_1.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			l_label_1.set_text ("This is the evaluation version of EiffelBuild and%Ncode generation has been disabled.%N%NTo obtain a full copy of EiffelBuild contact:%N%NEiffel Software Inc.%NISE Building%N356 Storke Road, Goleta, CA 93117 USA%NTelephone: 805-685-1006, Fax 805-685-6869%NElectronice mail: <info@eiffel.com>%N%NWeb Customer Support: http://support.eiffel.com%NVisit Eiffel on the Web: http://www.eiffel.com")
			l_label_1.align_text_left
			l_horizontal_box_3.set_border_width (6)
			l_horizontal_box_3.disable_item_expand (l_button_1)
			l_cell_2.set_minimum_width (200)
			l_button_1.set_text ("OK")
			l_button_1.set_minimum_width (72)
			l_button_1.select_actions.extend (agent destroy)
		end
		
feature {GB_GENERATION_COMMAND} -- Basic operation
		
	show_completion is
			-- Display to user that completion has finished.
		do
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
		end
		

	start_generation is
			-- Begin generation and set generation
			-- output progress bar to `progress_bar'.
		local
			code_generator: GB_CODE_GENERATOR
		do
			create code_generator
	--		code_generator.set_progress_bar (generation_progress)
			code_generator.generate
			show_completion
		end

end -- class GB_CODE_GENERATION_DIALOG

