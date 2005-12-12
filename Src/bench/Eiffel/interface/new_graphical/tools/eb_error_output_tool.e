indexing
	description	: "Tool where information warnings are displayed."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ERROR_OUTPUT_TOOL

inherit
	EB_OUTPUT_TOOL
		redefine
			process_text,
			process_errors
		end

create
	make

feature {NONE} -- Implementation

	process_errors (errors: LINKED_LIST [ERROR]) is
			-- Display contextual error information from `errors'.
		local
			st: STRUCTURED_TEXT
			retried_count: INTEGER
		do
			if retried_count = 0 then
				create st.make
				display_error_list (st, errors)
				if errors.is_empty then
						-- There is no error in the list put a separation before the next message
					display_separation_line (st)
				end
				process_error_text (st)
			else
				if retried_count = 1 then
						-- Most likely a failure in `display_error_list'.
					display_error_error (st)
					process_error_text (st)
				else
						-- Here most likely a failure in `process_text', so
						-- we clear its content and only display the error message.
					create st.make
					display_error_error (st)
					clear
					process_error_text (st)
				end
			end
			parent_notebook.select_item (widget)
		end

	process_error_text (st: STRUCTURED_TEXT) is
			-- Display `st' on the text area.
		local
			old_st: STRUCTURED_TEXT
		do
			old_st := text_area.current_text
			if old_st /= Void then
				old_st := old_st.twin
				old_st.append (st)
				text_area.process_text (old_st)
			else
				text_area.process_text (st)
			end
		end

	process_text (st: STRUCTURED_TEXT) is
			-- Display `st' on the text area.
		do
			-- Do nothing.
		end

end -- class EB_ERROR_OUTPUT_TOOL
