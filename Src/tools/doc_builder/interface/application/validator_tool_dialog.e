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
		end

feature -- Commands

	process_links is
			-- Process links according to options
		local
			l_manager: LINK_MANAGER			
		do
			create l_manager.make_with_documents (shared_project.documents)
			if link_check.is_selected then
				l_manager.check_links
			end	
			if link_relative_check.is_selected then
				l_manager.set_links_relative
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
			if xml_radio.is_selected then
				Shared_project.validate_files_xml
			elseif schema_radio.is_selected then
				Shared_project.validate_files
			elseif link_radio.is_selected then				
				process_links
			end
		end

end -- class VALIDATOR_TOOL_DIALOG

