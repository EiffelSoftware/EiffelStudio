indexing
	description: "Dialog for performaing validation tasks on projects."
	date: "$Date$"
	revision: "$Revision$"

class
	VALIDATOR_TOOL_DIALOG

inherit
	VALIDATOR_TOOL_DIALOG_IMP

	SHARED_OBJECTS
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			apply_bt.select_actions.extend (agent apply)
			okay_bt.select_actions.extend (agent okay)
			cancel_bt.select_actions.extend (agent hide)
			link_radio.select_actions.extend (agent link_radio_selected)
			document_tree_box.extend (document_selector_widget)
			initialize_document_selector
		end

	initialize_document_selector is
			-- Initialize the document selector widget according to project
			-- `root_directory' information from `preferences'.			
		do			
			create document_selector.make (shared_project.root_directory, document_selector_widget)
		end	

feature -- Commands

	process_links is
			-- Process links according to options
		local
			l_manager: LINK_MANAGER
			l_error_report: ERROR_REPORT			
			l_error: ERROR
		do
			create l_manager.make_with_documents (shared_project.documents)		
			l_manager.check_links
			if not l_manager.invalid_files.is_empty then
				create l_error_report.make ("Files containing invalid links")
				from
					l_manager.invalid_files.start
				until
					l_manager.invalid_files.after
				loop	
					create l_error.make (l_manager.invalid_files.item)
					l_error_report.append_error (l_error)
					l_error.set_action (agent (l_error_report.actions).load_file_in_editor (l_manager.invalid_files.item))
					l_manager.invalid_files.forth
				end
				l_error_report.show
			end
		end		

feature {NONE}  -- Events

	link_radio_selected is
			-- Radio was selected
		do
			if link_radio.is_selected then
				link_radio_box.enable_sensitive
			else
				link_radio_box.disable_sensitive
			end			
		end

feature {NONE} -- Implementation

	apply is
			-- Apply
		do
			run
		end
		
	okay is
			-- Okay
		do
			run
			hide
		end

	run is
			-- Run
		do
			register_checked_items
			if xml_radio.is_selected then
				Shared_project.validate_files_xml
			elseif schema_radio.is_selected then
				Shared_project.validate_files
			elseif link_radio.is_selected then				
				process_links
			end
		end

	register_checked_items is
			-- Register checked items for inclusion in processing
		local
			l_checked: ARRAYED_LIST [EV_CHECKABLE_TREE_ITEM]
			l_path: STRING
		do
			shared_constants.application_constants.set_is_include_list (True)
			l_checked := document_selector_widget.checked_items
			shared_project.include_documents_list.wipe_out
			if l_checked /= Void then
				from
					l_checked.start		
				until
					l_checked.after
				loop
					l_path ?= l_checked.item.data
					shared_project.add_include_document (l_path)
					l_checked.forth
				end
			end
			shared_constants.application_constants.set_is_include_list (False)
		end		

	document_selector_widget: EV_CHECKABLE_TREE is	
			-- Checkable document widget
		once
			create Result
		end
			
	document_selector: CHECKABLE_DOCUMENT_SELECTOR
			-- Checkable document selector

end -- class VALIDATOR_TOOL_DIALOG

