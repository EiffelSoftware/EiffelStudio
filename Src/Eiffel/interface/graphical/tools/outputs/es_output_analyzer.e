note
	description: "[
		Base class for analyzing an EiffelStudio output contents.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_OUTPUT_ANALYZER

inherit
	ES_RECYCLABLE

feature {NONE} -- Initialization

	make (a_formatter: ES_NOTIFIER_FORMATTER)
			-- Initializes the C output analyzer.
			--
			-- `a_formatter': A notifier formatter to extract the C compilation output from.
		require
			a_formatter_attached: attached a_formatter
		do
			register_action (a_formatter.text_changed_actions, agent (ia_formatter: ES_NOTIFIER_FORMATTER)
				require
					is_interface_usable: is_interface_usable
				do
					if ia_formatter.string.is_empty then
							-- The output change to empty text, which means it was cleared.
						on_output_text_cleared (ia_formatter)
					end
				end)
			register_action (a_formatter.new_line_actions, agent on_output_new_line)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
		end

feature {NONE} -- Measurement

	position: INTEGER
			-- Last position in the text a processed output line was take.

feature {NONE} -- Basic operations

	process_line (a_line: READABLE_STRING_8; a_number: NATURAL_32)
			-- Processes a line.
			--
			-- `a_line': A line to process/parse.
			-- `a_number': Line number being processed
		require
			is_interface_usable: is_interface_usable
			a_line_attached: attached a_line
			not_a_line_is_empty: not a_line.is_empty
			a_number_positive: a_number > 0
		deferred
		end

feature {NONE} -- Action handlers

	on_output_text_cleared (a_formatter: ES_NOTIFIER_FORMATTER)
			-- Called when the output is cleared/reset.
			--
			-- `a_formatter': Formatter that was cleared.
		require
			is_interface_usable: is_interface_usable
			a_formatter_attached: attached a_formatter
		do
			position := 0
		ensure
			position_reset: position = 0
		end

	on_output_new_line (a_formatter: ES_NOTIFIER_FORMATTER; a_lines: NATURAL_32)
			-- Called when a new line was added to the output string.
			--
			-- `a_formatter': Formatter that were a new line was produced.
			-- `a_lines': Number of lines in the current formatter.
		require
			is_interface_usable: is_interface_usable
			a_formatter_attached: attached a_formatter
		local
			l_next_position: INTEGER
			l_position: INTEGER
			l_string: STRING_32
			l_line: STRING
		do
			l_string := a_formatter.string
			l_position := position + 1
			l_next_position := l_string.count
			check valid_position: l_next_position >= l_position end

			if l_next_position > l_position then
				l_line := l_string.substring (l_position, l_next_position)
				if {PLATFORM}.is_windows then
					l_line.prune_all_trailing ('%R')
				end
				l_line.prune_all_trailing ('%N')
				if not l_line.is_empty then
					process_line (l_line, a_lines)
				end
			end
			position := l_next_position
		ensure
			position_set: position = a_formatter.string.count
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
