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

	set_error_list (a_error_list: LIST [ERROR]) is
			-- Set errors with `error_list'.  Put current error list, if any,
			-- in `error_reports'.
		require
			error_list_not_void: a_error_list /= Void
			error_list_not_empty: not a_error_list.is_empty
		do
			error_list := a_error_list
			errors.wipe_out
			error_list.do_all (agent show_error_description (?))
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
	
	error_list: LIST [ERROR]
			-- Errors
	
	error_reports: ARRAYED_LIST [ERROR_REPORT] is
			-- List of error reports for quick browsing
		once
			create Result.make (5)
		end
	
end -- class ERROR_DIALOG

