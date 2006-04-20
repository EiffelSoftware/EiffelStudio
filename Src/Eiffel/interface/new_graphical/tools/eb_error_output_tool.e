indexing
	description	: "Tool where information warnings are displayed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ERROR_OUTPUT_TOOL

inherit
	EB_OUTPUT_TOOL
		redefine
			process_errors, is_general,
			process_warnings
		end

create
	make

feature -- Implementation

	process_warnings (warnings: LINKED_LIST [ERROR]) is
			-- Do nothing.
		do
		end

	process_errors (errors: LINKED_LIST [ERROR]) is
			-- Display contextual error information from `errors'.
		local
			retried_count: INTEGER
		do

			if retried_count = 0 then
				text_area.handle_before_processing (false)
				if errors.is_empty then
						-- There is no error in the list put a separation before the next message
					display_separation_line (text_area.text_displayed)
				end
				display_error_list (text_area.text_displayed, errors)
				text_area.handle_after_processing
			else
				if retried_count = 1 then
						-- Most likely a failure in `display_error_list'.
					text_area.handle_before_processing (false)
					display_error_error (text_area.text_displayed)
					text_area.handle_after_processing
				else
						-- Here most likely a failure in `process_text', so
						-- we clear its content and only display the error message.
					clear
					text_area.handle_before_processing (false)
					display_error_error (text_area.text_displayed)
					text_area.handle_after_processing
				end
			end
			parent_notebook.select_item (widget)
		end

	is_general: BOOLEAN is false;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_ERROR_OUTPUT_TOOL
