note
	description: "[
		A non-function output window used to only record changes and notify clients about the changes made.
		
		The object retains `string', which contains all of the text generated for all processing calls at that time.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NOTIFIER_FORMATTER

inherit
	OUTPUT_WINDOW
		redefine
			start_processing,
			put_string,
			put_new_line,
			clear_window
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize a notifier window.
		do
			create string.make_empty
		end

feature -- Access

	string: STRING_32
			-- String of contents generated to date.

feature -- Processing

	start_processing (append: BOOLEAN)
			-- <Precursor>
		do
			Precursor (append)
			if not append then
				reset
			end
		end

feature -- Basic operations

	reset
			-- Resets any cached data.
		do
			string.wipe_out
			if attached internal_text_changed_actions as l_actions then
				l_actions.call ([Current])
			end
		ensure
			string_is_empty: string.is_empty
		end

feature -- Output

	put_string (s: STRING_GENERAL)
			-- <Precursor>
		local
			l_count: NATURAL
		do
			if not s.is_empty then
				string.append_string_general (s)
				if attached internal_text_changed_actions as l_actions then
					l_actions.call ([Current])
				end
				if attached internal_new_line_actions as l_actions then
					if attached {READABLE_STRING_32} s as l_str32 then
						l_count := l_str32.occurrences ('%N').as_natural_32
					elseif attached {READABLE_STRING_8} s as l_str8 then
						l_count := l_str8.occurrences ('%N').as_natural_32
					else
						check unknown_string: False end
					end
					if l_count > 0 then
						l_actions.call ([Current, l_count])
					end
				end
			end
		end

	put_new_line
			-- <Precursor>	
		do
			string.append_character ('%N')
			if attached internal_text_changed_actions as l_actions then
				l_actions.call ([Current])
			end
			if attached internal_new_line_actions as l_actions then
				l_actions.call ([Current, {NATURAL} 1])
			end
		end

	clear_window
			-- <Precursor>
		do
			reset
		end

feature -- Actions

	new_line_actions: ACTION_SEQUENCE [TUPLE [sender: ES_NOTIFIER_FORMATTER; lines: NATURAL]]
			-- Actions called when a new line has been added to the output
			--
			-- 'sender': The sender (Current) of the action.
			-- 'lines': Number of new lines added.
		do
			if attached internal_new_line_actions as l_actions then
				Result := l_actions
			else
				create Result
				internal_new_line_actions := Result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = new_line_actions
		end

	text_changed_actions: ACTION_SEQUENCE [TUPLE [sender: ES_NOTIFIER_FORMATTER]]
			-- Actions called when the text has changed.
			--
			-- 'sender': The sender (Current) of the action.
			-- 'count': Number of new lines added.
		do
			if attached internal_text_changed_actions as l_actions then
				Result := l_actions
			else
				create Result
				internal_text_changed_actions := Result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = text_changed_actions
		end

feature {NONE} -- Implementation: Internal cache

	internal_new_line_actions: detachable like new_line_actions
			-- Cached version of `new_line_actions'.
			-- Note: Do not use directly!

	internal_text_changed_actions: detachable like text_changed_actions
			-- Cached version of `text_changed_actions'.
			-- Note: Do not use directly!

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
