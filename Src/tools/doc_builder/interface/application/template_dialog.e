indexing
	description: "Dialog for creating new documents from pre-defined templates."
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_DIALOG

inherit
	TEMPLATE_DIALOG_IMP
	
	SHARED_OBJECTS
		undefine
			copy,
			default_create
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			empty_file.pointer_button_press_actions.force_extend (agent highlight_label (empty_val, empty_label))
			how_to.pointer_button_press_actions.force_extend (agent highlight_label (howto_val, howto_label))
			sample.pointer_button_press_actions.force_extend (agent highlight_label (sample_val, sample_label))
			tutorial.pointer_button_press_actions.force_extend (agent highlight_label (tutorial_val, tutorial_label))
			project.pointer_button_press_actions.force_extend (agent highlight_label (project_val, project_label))
			ok_button.select_actions.extend (agent load_new_item)
			cancel_button.select_actions.extend (agent hide)
			label_selected := empty_label
		end

feature {NONE} -- Implementation

	highlight_label (label_id: INTEGER; a_label: EV_LABEL) is
			-- Highlight label
		do
			label_selected.set_background_color (create {EV_COLOR}.make_with_rgb (1.0, 1.0, 1.0))
			label_selected := a_label
			label_number := label_id
			label_selected.set_background_color (selection_color)
			set_item_description
		end
		
	set_item_description is
			-- Set description for selected template
		local
			empty_tmp: EMPTY_TEMPLATE
			project_tmp: PROJECT_TEMPLATE
			howto_tmp: HOWTO_TEMPLATE
		do
			inspect label_number
			when empty_val then
				create empty_tmp
				template_description.set_text (empty_tmp.description)
			when sample_val then
				
			when tutorial_val then
				
			when howto_val then
				create howto_tmp
				template_description.set_text (howto_tmp.description)				
			when project_val then
				create project_tmp
				template_description.set_text (project_tmp.description)
			end
		end		
		
	load_new_item is
			-- Load new chosen item
		do
			inspect label_number
			when empty_val then
				Shared_document_manager.create_document
			when sample_val then
				Shared_document_manager.create_document
			when tutorial_val then
				Shared_document_manager.create_document
			when howto_val then
				Shared_document_manager.create_document
			when project_val then
				Shared_project.create_new
			end
			hide
		end

	label_selected: EV_LABEL
			-- Currently selected label

	label_number: INTEGER
			-- Selected label id number

	selection_color: EV_COLOR is
			-- Selection Color
		once
			create Result.make_with_rgb (0.1, 0.3, 0.5)
		end

	empty_val: INTEGER is unique
	sample_val: INTEGER is unique
	howto_val: INTEGER is unique
	tutorial_val: INTEGER is unique
	project_val: INTEGER is unique
			-- Label number constants
	
end -- class TEMPLATE_DIALOG

