indexing
	description: "Dialog for displaying error informaion."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_DIALOG

inherit
	ERROR_DIALOG_IMP

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			ok.select_actions.extend (agent hide)
		end		

feature -- Status Setting

	set_error (a_error: ERROR; a_context: STRING) is
			-- Set errors with `error_list'.
		require
			error_not_void: a_error /= Void
		do						
			create errors
			show_error_description (a_error)
			error_container.wipe_out
			error_container.extend (errors)
		end			
		
feature {NONE} -- Implementation
	
	show_error_description (a_error: ERROR) is
			-- Show error description of `a_error'
		local
			l_item: EV_LIST_ITEM
		do
			create l_item.make_with_text (a_error.description)
			if a_error.action /= Void then
				l_item.pointer_double_press_actions.force_extend (a_error.action)
			end
			errors.extend (l_item)			
		end			
			
	errors: EV_LIST
			-- Error widget
	
end -- class ERROR_DIALOG

