note
	description: "[
		Used to read INI files in a progressive manner, using callbacks to intepret meaning.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_FAST_PARSER

feature -- Access

	line: NATURAL
			-- Current line being processed by the parser.

	column: NATURAL
			-- Current column being processed by the parser.

feature -- Status report

	is_successful: BOOLEAN
			-- Indicates if the last call to `parse' was successful.

feature -- Basic operations

	parse (a_contents: READABLE_STRING_GENERAL; a_callbacks: INI_CALLBACKS)
			-- Parsers the contents of `a_contents'.
			--
			-- `a_contents': INI file contents to parse.
			-- `a_callbacks': Callbacks used when parsing.
		require
			a_contents_attached: attached a_contents
			not_a_contents_is_empty: not a_contents.is_empty
			a_callbacks_attached: a_callbacks /= Void
		local
			l_buffer: READABLE_STRING_32
			l_partial_buffer: STRING_32
			l_name: detachable STRING_32
			l_started: BOOLEAN
			l_skip: BOOLEAN
			l_error: BOOLEAN
			l_stop: BOOLEAN
			l_state: NATURAL
			i, l_count: INTEGER
			c32: CHARACTER_32
			c: CHARACTER
			retried: BOOLEAN
		do
			is_successful := False
			if not retried then
				line := 0
				column := 0

				a_callbacks.reset
				a_callbacks.on_start
				l_started := True

				l_buffer := a_contents.as_string_32
				create l_partial_buffer.make (30)
				from
					i := 1
					l_count := l_buffer.count
				until
					i > l_count or l_stop
				loop
						-- Set position information.
					line := line + 1
					column := i.as_natural_32

						-- Analyze content.
					c32 := l_buffer.item (i)
					if c32.is_character_8 then
						c := c32.to_character_8

						if not l_error then
							if l_state /= comment_state then
								l_skip := True
								inspect c
								when section_start then
										--
										-- '[' section start
										--
									if l_state = default_state then
										l_state := section_state_start
									else
											-- Already in section error.
										l_error := True
										a_callbacks.on_error (e_open_bracket_in_section_id, line, column)
									end
								when section_end then
										--
										-- ']' section end
										--
									if l_state = section_state_start then
										l_state := section_state_end
									else
											-- Illegal section end
										l_error := True
										a_callbacks.on_error (e_unmatched_close_bracket, line, column)
									end
								when property_value_qualifier then
										--
										-- '=' value qualifier
										--
									if l_state = default_state then
										if not l_partial_buffer.is_empty then
											if not a_callbacks.is_whitespace_preserved then
												l_partial_buffer.right_adjust
											end
											create l_name.make_from_string (l_partial_buffer)

												-- Clear buffer
											l_partial_buffer.wipe_out
											l_state := property_value_state
										else
											-- No property name
											l_error := True
											a_callbacks.on_error (e_property_without_name, line, column)
										end
									else
										-- Part of value or other state, allow to pass through.
									end
								when comment_pound, comment_semi_colon then
										--
										-- ';' '#' comment start
										--
									l_state := comment_state
								when '%N', '%R' then
										-- Do not process new lines
									if l_state = section_state_start then
										l_error := True
										a_callbacks.on_error (e_unmatched_open_bracket, line, column)
									end
								when ' ', '%T' then
										-- Skip initial whitespace
									l_skip := not a_callbacks.is_whitespace_preserved and then
										l_partial_buffer.is_empty and then c.is_space
								else
									l_skip := False
								end
							else
									-- Skip new-line characters in comments.
								l_skip := c = '%N' or c = '%R'
									-- The following line will remove initial whitespace from comments, but this is not
									-- effective because initial whitespace may be desired.
--								if not l_skip then
--									l_skip := not a_callbacks.is_whitespace_preserved and then
--										l_partial_buffer.is_empty and then c.is_space
--								end
							end

							if l_error then
									-- An error occurred in processing, check if we should stop.
								l_stop := not a_callbacks.is_recoverable
							end
						else
								-- There was an error so skip all processing.
							l_skip := True
						end
					end

					if l_skip then
						l_skip := False
					else
							-- Append the current buffer.
						l_partial_buffer.append_character (c32)
					end

					if not l_stop then
						if c32 = '%N' then
								-- New line, reset state and raise appproriate event.
							if not l_error then
									-- No error so notify callback.
								if not a_callbacks.is_whitespace_preserved then
									l_partial_buffer.right_adjust
								end
								if l_state = section_state_end then
										-- Section
									a_callbacks.on_section (create {STRING_32}.make_from_string (l_partial_buffer))
								elseif l_state = comment_state then
										-- Comment
									a_callbacks.on_comment (create {STRING_32}.make_from_string (l_partial_buffer))
								elseif l_state = default_state then
									if not l_partial_buffer.is_empty then
											-- Property (no value)
										a_callbacks.on_property (create {STRING_32}.make_from_string (l_partial_buffer), Void)
									end
								elseif l_state = property_value_state then
										-- Property (with value)
									check
										l_name_attached: attached l_name
										not_l_name_is_empty: not l_name.is_empty
									end
									a_callbacks.on_property (l_name, create {STRING_32}.make_from_string (l_partial_buffer))
								else
									check unknown_state: False end
								end
							else
									-- Reset error state.
								l_error := False
							end

								-- Reset state and buffer
							l_state := default_state
							l_partial_buffer.wipe_out
						end

						if not l_stop then
							l_stop := a_callbacks.is_abort_requested
						end
					end

					i := i + 1
				end

				if l_started then
					is_successful := not l_error
					a_callbacks.on_finished (not l_error)
				end
			elseif l_started then
				a_callbacks.on_finished (False)
			end
		rescue
			is_successful := False
			l_error := True
			a_callbacks.on_error (e_unknown_error, line, column)
		end

feature {NONE} -- Constants: Dictionary

	comment_pound: CHARACTER = '#'
	comment_semi_colon: CHARACTER = ';'
	section_start: CHARACTER = '['
	section_end: CHARACTER = ']'
	property_value_qualifier: CHARACTER = '='
	quote: CHARACTER = '%"'

feature {NONE} -- Constants: Stats

	default_state: NATURAL = 0
	comment_state: NATURAL = 1
	section_state_start: NATURAL = 2
	section_state_end: NATURAL = 3
	property_value_state: NATURAL = 4

feature {NONE} -- Internationalization

	e_open_bracket_in_section_id: STRING = "Illegal '[' found in a section name."
	e_unmatched_open_bracket: STRING = "Unmatched opening '['."
	e_unmatched_close_bracket: STRING = "Unmatched closing ']'."
	e_property_without_name: STRING = "Property specified without a name."
	e_unknown_error: STRING = "An unknown error occurred."

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
