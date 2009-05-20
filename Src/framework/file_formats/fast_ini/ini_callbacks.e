note
	description: "[
		Fast INI parser callbacks for use with an {INI_FAST_PARSER}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INI_CALLBACKS

feature {INI_FAST_PARSER} -- Status report

	is_whitespace_preserved: BOOLEAN
			-- Indicates if whitespace should be preserved in comments.
		do
			Result := True
		end

	is_recoverable: BOOLEAN
			-- Indicates if the parser should skip errors and continue parsing.
		do
			Result := False
		end

	is_abort_requested: BOOLEAN
			-- Indicates if the parser should abort at the next convience.

feature -- Basic operations

	reset
			-- Resest the callback object for reuse
		do
			is_abort_requested := False
		ensure
			not_is_abort_requested: not is_abort_requested
		end

	abort
			-- Requests an abort of parsing be made.
		do
			is_abort_requested := True
		ensure
			is_abort_requested: is_abort_requested
		end

feature {INI_FAST_PARSER} -- Actions

	on_start
			-- Called when a document is starting the reading process.
		require
			not_is_abort_requested: not is_abort_requested
		deferred
		end

	on_finished (a_successful: BOOLEAN)
			-- Called when a document has finished the reading process.
			--
			-- `a_successful': True if parsing was successful in finishing; False otherwise.
		deferred
		end

	on_error (a_msg: READABLE_STRING_32; a_line: NATURAL; a_column: NATURAL)
			-- Called when an error occurred when parsing the INI file.
			--
			-- `a_msg': A message containing a description of what happened.
			-- `a_line': The line where the error occurred.
			-- `a_column': The column number on the line where the error occurred.
		require
			a_msg_attached: attached a_msg
			not_a_msg_is_empty: not a_msg.is_empty
			a_line_positive: a_line > 0
			a_column_positive: a_column > 0
		do
		end

feature {INI_FAST_PARSER}  -- Actions: Atomic

	on_comment (a_comment: READABLE_STRING_32)
			-- Called when a comment was found.
			--
			-- `a_comment': The comment string.
		require
			not_is_abort_requested: not is_abort_requested
			a_comment_attached: a_comment /= Void
		do
		end

	on_section (a_name: READABLE_STRING_32)
			-- Called when a new section is parsed.
		require
			not_is_abort_requested: not is_abort_requested
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		deferred
		end

	on_property (a_name: READABLE_STRING_32; a_value: detachable READABLE_STRING_32)
			-- Called when a new property declaration.
			-- Note: Seen as name[=[value]].
			--
			-- `a_name': Name of the property.
			-- `a_value': Property value, if any.
		require
			not_is_abort_requested: not is_abort_requested
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			not_a_value_is_empty: attached a_value implies not a_value.is_empty
		deferred
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
