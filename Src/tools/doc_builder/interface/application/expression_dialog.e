indexing
	description: "Dialog for building and executing regular expressions."
	date: "$Date$"
	revision: "$Revision$"

class
	EXPRESSION_DIALOG

inherit
	EXPRESSION_DIALOG_IMP
	
	UTILITY_FUNCTIONS
		undefine
			default_create,
			copy
		end
	
	SHARED_OBJECTS
		undefine
			default_create,
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
			apply_button.select_actions.extend (agent apply)
			okay_button.select_actions.extend (agent okay)
			cancel_button.select_actions.extend (agent hide)
			expression_browse_button.select_actions.extend (agent load_expression_file)
			save_expressions_button.select_actions.extend (agent save_expressions_to_file)
			expression_button.select_actions.extend (agent update_expression)
			expression_list.select_actions.force_extend (agent list_selected)
			expression_list.key_press_actions.extend (agent key_pressed)
			expression_list.set_column_title ("Expression Text", 1)
			expression_list.set_column_title ("Replacement Text", 2)
		end

feature -- Access		
		
	overwrite_documents: BOOLEAN is
			-- Should we overwrite documents
		do
			Result := overwrite_documents_check.is_selected
		end
		
	all_documents: BOOLEAN is
			-- Should parsing be done on all open documents?
		do
			Result := all_document_check.is_selected
		end
		
	all_project: BOOLEAN is
			-- Should parsing be done on all documents in loaded projet?
		do
			Result := all_project_check.is_selected	
		end		

feature -- Interface Events

	apply is
			-- Apply
		do
			if is_valid then
				build_expressions
				run_expressions
			end
		end
		
	okay is
			-- Apply changes
		do
			if is_valid then
				build_expressions
				run_expressions
			end
			hide
		end

	list_selected is
			-- An item in the expression list was selected
		local
			l_row: EV_MULTI_COLUMN_LIST_ROW
		do
			l_row := expression_list.selected_item
			if l_row /= Void then
				expression_text.set_text (l_row @ 1)
				replacement_text.set_text (l_row @ 2)
			end
		end		

	key_pressed (a_key: EV_KEY) is
			-- A key was pressed on the list
		do
			if a_key.code = feature {EV_KEY_CONSTANTS}.Key_delete then
				expression_list.go_i_th (expression_list.index_of (expression_list.selected_item, 1))
				Expressions.remove (expression_list.selected_item @ 1)
				Ordered_expressions.go_i_th (Ordered_expressions.index_of (expression_list.selected_item @ 1, 1))
				Ordered_expressions.remove
				expression_list.remove
			end
		end		

	update_expression is
			-- Update regular expression
		local
			l_row: EV_MULTI_COLUMN_LIST_ROW
		do
			if not expression_text.text.is_empty then
				create l_row
				l_row.extend (expression_text.text)
				l_row.extend (replacement_text.text)
				expression_list.extend (l_row)
				Expressions.put (l_row @ 2, l_row @ 1)
				Ordered_expressions.extend (l_row @ 1)
			end
		end		
		
	load_expression_file is
			-- Attempt to load an file to populate `expression_list' from user
			-- selected file
		local
			open_dialog: EV_FILE_OPEN_DIALOG
		do
			create open_dialog
			open_dialog.set_start_directory (Shared_constants.Application_constants.parser_file_resources_directory)
			--open_dialog.set_filter (".xsd")
			open_dialog.show_modal_to_window (Current)
			if open_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_open) then
				initialize_expressions (open_dialog.file_name)
			end
		end	
		
	save_expressions_to_file is
			-- Save expressions and replacement strings in `expression_list' to a 
			-- file for later retrieval
		local
			save_dialog: EV_FILE_SAVE_DIALOG
		do
			create save_dialog
			save_dialog.set_start_directory (Shared_constants.Application_constants.Parser_file_resources_directory)
			--open_dialog.set_filter (".xsd")
			save_dialog.show_modal_to_window (Current)
			if save_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_save) then
				save_expressions (save_dialog.file_name)
			end
		end
		
feature {NONE} -- Implementation
	
	initialize_expressions (a_filename: STRING) is
			-- Initial expressions from file
		local
			l_expr_file: PLAIN_TEXT_FILE
			l_expr_line, l_expr, l_replacement, l_token: STRING
			l_row: EV_MULTI_COLUMN_LIST_ROW
		do
			l_token := "||"
			Expressions.clear_all
			Ordered_expressions.wipe_out
			expression_list.wipe_out
			create l_expr_file.make (a_filename)
			if l_expr_file /= Void and then l_expr_file.exists then
				l_expr_file.open_read
				from
					l_expr_file.start
				until
					l_expr_file.end_of_file			
				loop
					l_expr_file.read_line
					l_expr_line := l_expr_file.last_string
					if l_expr_line /= Void and then not l_expr_line.is_empty then
						if not l_expr_line.substring (1, 2).is_equal ("--") then
							l_expr := l_expr_line.substring (1, l_expr_line.substring_index (l_token, 1) - 2)
							l_replacement := l_expr_line.substring (l_expr_line.substring_index (l_token, 1) + 3, l_expr_line.count)
							create l_row
							l_row.extend (l_expr)
							l_row.extend (l_replacement)
							expression_list.extend (l_row)
							Expressions.put (l_row @ 2, l_row @ 1)
						end						
					end
				end
				l_expr_file.close
			end
		end
	
	save_expressions (a_filename: STRING) is
			-- Save expression in list to file
		local
			l_file: PLAIN_TEXT_FILE
			l_token: STRING
		do
			l_token := "||"
			create l_file.make_open_write (a_filename)
			if l_file /= Void and then l_file.exists then
				from
					expression_list.start
				until
					expression_list.after
				loop
					l_file.putstring (expression_list.item @ 1 + " " + l_token + " " + expression_list.item @ 2 + "%N")
					expression_list.forth
				end
			end
			l_file.close
		end		
	
	build_expressions is
			-- Build expressions to run
		local
			l_row: EV_MULTI_COLUMN_LIST_ROW
		do
			from
				expression_list.start
			until
				expression_list.after
			loop
				l_row := expression_list.item
				expressions.put (l_row @ 2, l_row @ 1)
				ordered_Expressions.extend (l_row @ 1)
				expression_list.forth
			end
		end		
	
	run_expressions is
			-- Run all expressions in list sequentially
		do
			if all_project then
				run_expressions_on_directory (create {DIRECTORY}.make (Shared_project.root_directory))
			elseif all_documents then
				run_expressions_on_documents (Shared_document_editor.documents)
			else
				run_expressions_on_document (Shared_document_editor.current_document)
			end
		end
		
	run_expressions_on_directory (a_dir: DIRECTORY) is
			-- Run expression recursively on files in `a_dir'
		local
			cnt: INTEGER
			l_dir: DIRECTORY
			l_file: PLAIN_TEXT_FILE
			l_doc: DOCUMENT
		do
			from
				a_dir.open_read
				cnt := 0
			until
				cnt = a_dir.count
			loop
				a_dir.readentry
				if not (a_dir.lastentry.is_equal (".") or a_dir.lastentry.is_equal ("..")) then
					create l_dir.make (a_dir.name + "\" + a_dir.lastentry)
					if l_dir /= Void and then l_dir.exists then
						run_expressions_on_directory (l_dir)
					else
						create l_file.make (l_dir.name)
						if l_file /= void and then l_file.exists and then filetypes.has (file_type (a_dir.lastentry)) then
							create l_doc.make_from_file (l_file)
							run_expressions_on_document (l_doc)
						end
					end
				end
				cnt := cnt + 1
			end
		end

	run_expressions_on_documents (documents: ARRAYED_LIST [DOCUMENT]) is
			-- Run expressions on all DOCUMENTs in `documents'
		do
			from
				documents.start
			until
				documents.after
			loop
				if documents.item /= Void then
					run_expressions_on_document (documents.item)
				end				
				documents.forth
			end
		end		

	run_expressions_on_document (a_doc: DOCUMENT) is
			-- Run expression on `a_file'
		require
			doc_not_void: a_doc /= void
			doc_has_associated_file: a_doc.file.exists
		local
			l_file: PLAIN_TEXT_FILE
			l_file_string, l_subject, l_matched_text, 
			l_final_string, l_replacement, l_substring: STRING
			regexp: RX_PCRE_REGULAR_EXPRESSION
			l_cnt: INTEGER
		do
			l_file := a_doc.file
			l_file.open_read_write
			l_file.readstream (l_file.count)
			l_file_string := l_file.laststring
			l_subject := clone (l_file_string)
			l_final_string := clone (l_file_string)
			from
				Ordered_expressions.start
			until
				Ordered_expressions.after
			loop
					-- Create the regular expression.
				create regexp.make
				regexp.set_caseless (True)
				
					-- Compile a pattern.
				regexp.compile (Ordered_expressions.item)
				
					-- Match on a subject.
				regexp.match (l_subject)
				
					-- 
				if regexp.has_matched then
					from						
					until
						not regexp.has_matched
					loop					
						l_replacement := clone (Expressions.item (Ordered_expressions.item))
						if regexp.match_count > 1 then
							from
								l_cnt := 1
							until
								l_cnt = regexp.match_count
							loop
								l_substring := regexp.captured_substring (l_cnt)								
								l_replacement.replace_substring_all ("\" + l_cnt.out + "\", l_substring)
								l_cnt := l_cnt + 1
							end
						end
						l_matched_text := regexp.captured_substring (0)
						if l_matched_text /= Void and then not l_matched_text.is_empty then
							l_final_string.replace_substring_all (l_matched_text, l_replacement)
						end
						regexp.next_match
					end
					l_subject := clone (l_final_string)
				end
				
				Ordered_expressions.forth
			end
			
			l_file.close
			
			if overwrite_documents then
				if Shared_document_editor.is_document_open (a_doc.name) then
					a_doc.set_text (l_final_string)
					a_doc.save
				elseif all_project then
					l_file.wipe_out
					l_file.open_write
					l_file.putstring (l_final_string)
					l_file.close
				end
			else
				
			end			
			l_file.close
		end
	
	expressions: HASH_TABLE [STRING, STRING] is
			-- Regular Expressions and associated replacement strings for
			-- matches
		once
			create Result.make (5)
		end
	
	ordered_expressions: ARRAYED_LIST [STRING] is
			-- List of regular expressions as found in expressions, used for
			-- iterating expressions where correct order is required
		once
			create Result.make (5)
		end		
	
	filetypes: ARRAYED_LIST [STRING] is
			-- File types to apply parsing to
		once
			create Result.make (3)
			Result.extend ("xml")
--			Result.extend ("html")
--			Result.extend ("htm")
			Result.compare_objects
		end

	is_valid: BOOLEAN is
			-- Is current information valid for beginning parsing?
		do
			Result := not expression_list.is_empty	
		end		
	
end -- class EXPRESSION_DIALOG

