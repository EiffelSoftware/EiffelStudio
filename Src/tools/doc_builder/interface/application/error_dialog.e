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
			close.select_actions.extend (agent close_error_list)
		end		

feature -- Status Setting

	set_error_list (a_error_list: LIST [ERROR]; a_context: STRING) is
			-- Set errors with `error_list'.
		require
			error_list_not_void: a_error_list /= Void
			error_list_not_empty: not a_error_list.is_empty
		do			
			error_list := a_error_list
			create errors
			error_list.do_all (agent show_error_description (?))
			errors_notebook.extend (errors)
			errors_notebook.set_item_text (errors, a_context)
			errors_notebook.select_item (errors)
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
		
	close_error_list is
			-- Close error list with focus
		do
			if not errors_notebook.is_empty then
				errors_notebook.prune_all (errors_notebook.selected_item)
			end	
		end		
	
	error_list: LIST [ERROR]
			-- Errors
			
	errors: EV_LIST
			-- Error widget
	
end -- class ERROR_DIALOG

