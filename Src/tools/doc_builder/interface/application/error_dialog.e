indexing
	description: "Dialog for displaying error informaion."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_DIALOG

inherit
	ERROR_DIALOG_IMP

	SHARED_OBJECTS
		undefine
			copy,
			default_create
		end

create
	make,
	default_create
	
feature -- Initialization		

	make (error_list: LIST [TUPLE [STRING, INTEGER, INTEGER]]) is
			-- Create with `error_list'
		require
			error_list_not_void: error_list /= Void
			error_list_not_empty: not error_list.is_empty
		do
			default_create
			build_errors_table (error_list)
			errors.set_strings (error_strings (error_list))
			errors.do_all (agent highlight_error (?))
		end
		
	make_with_action (error_list: LIST [TUPLE [STRING, INTEGER, INTEGER]]; action: PROCEDURE [ANY, TUPLE [EV_LIST_ITEM]]) is
			-- Create with `error_list' and `action'
		require
			error_list_not_void: error_list /= Void
			error_list_not_empty: not error_list.is_empty
		do
			default_create
			build_errors_table (error_list)
			errors.set_strings (error_strings (error_list))
			errors.do_all (action)
		end

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

	build_errors_table (a_errors_list: LIST [TUPLE [STRING, INTEGER, INTEGER]]) is
			-- Build table of errors associated with line position from
			-- `a_errors_list'.
		local
			l_line_data: TUPLE [INTEGER, INTEGER]
			line_no, line_pos: INTEGER
			l_error: STRING
		do
			from
				a_errors_list.start
				create internal_errors.make (a_errors_list.count)
			until
				a_errors_list.after
			loop
				l_error ?= a_errors_list.item @ 1
				line_no := a_errors_list.item.integer_32_item (2)
				line_pos :=	a_errors_list.item.integer_32_item (3)
				l_line_data := [line_no, line_pos]
				internal_errors.extend (l_line_data, l_error)
				a_errors_list.forth
			end
		end		

feature -- Status Setting

	set_error_list (error_list: LIST [TUPLE [STRING, INTEGER, INTEGER]]) is
			-- Set errors with `error_list'.  Put current error list, if any,
			-- in `error_reports'.
		require
			error_list_not_void: error_list /= Void
			error_list_not_empty: not error_list.is_empty
		do
			if internal_errors /= Void then
				error_reports.extend (internal_errors)
			end
			build_errors_table (error_list)
			errors.wipe_out
			errors.set_strings (error_strings (error_list))
		end
		
	set_error_action (action: PROCEDURE [ANY, TUPLE [EV_LIST_ITEM]]) is
			-- Set `action' to call when error message is double clicked
		require
			action_not_void: action /= Void
		do
			errors.do_all (action)
		end			

feature -- Query

	line_data (a_error: STRING): TUPLE [INTEGER, INTEGER] is
			-- Get the line data about `a_error'
		require
			a_error_not_void: a_error /= Void
			a_error_not_empty: not a_error.is_empty
		do
			Result := internal_errors.item (a_error)
		end

feature {NONE} -- Query

	error_strings (a_errors: LIST [TUPLE]): ARRAYED_LIST [STRING] is
			-- Extract error string from error tuples
		do
			from
				create Result.make (5)
				internal_errors.start
			until
				internal_errors.after
			loop				
				Result.extend (internal_errors.key_for_iteration)	
				internal_errors.forth
			end
		end
		
feature {NONE} -- Implementation

	internal_errors: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING]
			-- Errors with associated line numbers hashed

	highlight_error (a_item: EV_LIST_ITEM) is
			-- Highlight error in editor
		local
			curr_doc: DOCUMENT_TEXT_WIDGET
			l_no, l_pos: INTEGER
		do
--			curr_doc := Shared_document_manager.current_document
			l_no := line_data (a_item.text).integer_32_item (1)
			l_pos := line_data (a_item.text).integer_32_item (2)
			a_item.pointer_double_press_actions.force_extend 
				(agent curr_doc.highlight_error_pos (l_no, l_pos))
		end
	
	error_reports: ARRAYED_LIST [HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING]] is
			-- List of error reports for quick browsing
		once
			create Result.make (5)
		end
	
end -- class ERROR_DIALOG

