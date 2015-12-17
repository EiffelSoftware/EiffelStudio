note
	description: "[
			A formatter that injects objects of arbitrary types into a string message.
			A formal parameter of the class denotes a type of the underlying formatter.
			Argument placeholders in a string message are denoted by {n}
			where n stands for an argument number n (starting from 1).
			The same argument number can be used multiple times.

			Example. Assuming there is a function as_injectable that converts its arguments to an injectable list,
				format ("{1} has {3} apples, all {3} are {2}", as_injectable ("Bob", "green", 8))
			the generated message looks like "Bob has 8 apples, all 8 are green".
		]"
	syntax: "[
			The following characters have special meaning:
				{ (opening brace) - beginning of an argument placeholder
				} (closing brace) - end of an argument placeholder
				| (vertical bar) - separator between argument number and format specification
				` (backquote) - escape character
			Escape character is discarded from the original string and removes any special meaning of the character that follows it:
				`` - denotes a single character ` without any special meaning,
				`{ - denotes a single character { without any special meaning, etc.
			An argument placeholder for an argument number n is denoted in a message string by one of the following sequences:
				{n} - a placeholder with default format
				{n|f} - a placeholder with (possibly empty) format specification f
			The format specification f (if specified) or void (if there is no format specofication) is passed to the corresponding argument injector.
		]"

class COMPOSITE_FORMATTER [G]

create
	make

feature {NONE} -- Creation

	make (format_substring: PROCEDURE [G, READABLE_STRING_GENERAL, INTEGER_32, INTEGER_32])
			-- Associate formatter with the procedure `format_substring' to render message string elements.
		do
			format_message := format_substring
		end

feature -- Formatting

	format (formatter: G; message: READABLE_STRING_GENERAL; arguments: ITERABLE [PROCEDURE [detachable FORMAT_SPECIFICATION, G]])
			-- Format `message' replacing placeholders with elements from `arguments' using `formatter'.
			-- Placeholders are denoted by {n} where n indicates an argument position.
		local
			a: detachable ARRAYED_LIST [PROCEDURE [detachable FORMAT_SPECIFICATION, G]]
			i: INTEGER
			j: INTEGER
			n: INTEGER
			nesting_level: NATURAL_32
			has_number: BOOLEAN
			argument_number: INTEGER_32
			cursor: ITERATION_CURSOR [PROCEDURE [detachable FORMAT_SPECIFICATION, G]]
			state: NATURAL_32
		do
			from
				i := 1
				n := message.count
				state := state_message
				j := 1
			until
				j > n
			loop
				inspect state
				when state_message then
						-- Regular message string between `i' and `j - 1'.
					inspect message [j]
					when escape_char then
							-- Emit message collected so far.
						if j > i then
							format_message (formatter, message, i, j - 1)
						end
							-- Do not interpret next character.
						j := j + 1
							-- Advance to the next part.
						i := j
					when start_spec then
							-- Emit message collected so far.
						if j > i then
							format_message (formatter, message, i, j - 1)
						end
							-- Increase nesting level.
						nesting_level := nesting_level + 1
							-- Advance to the next part.
						state := state_placeholder
						i := j + 1
					else
							-- Continue collecting regular characters.
					end
				when state_placeholder then
						-- Beginning of a placeholder.
					inspect message [j]
					when '0' .. '9' then
							-- There is an argument number.
						has_number := True
						state := state_number
					else
							-- Bad format, skip it.
						has_number := False
						state := state_format
					end
						-- Process the current character in a new state.
					j := j - 1
				when state_number then
						-- Argument number.
					inspect message [j]
					when '0' .. '9' then
							-- Read argument number.
						argument_number := argument_number * 10 + (message [j].code - zero_code)
							-- Check for overflow.
						if argument_number < 0 then
								-- Bad format, skip it.
							has_number := False
							argument_number := 0
							state := state_format
						end
					when middle_spec then
							-- Advance to the format specification.
						i := j + 1
						state := state_format
					when stop_spec then
							-- Advance to the empty format specification.
						i := j + 1
						state := state_format
							-- Process the current character in a new state.
						j := j - 1
					else
							-- Bad format, skip it.
						has_number := False
						argument_number := 0
						state := state_format
					end
				when state_format then
						-- Format specification.
					inspect message [j]
					when start_spec then
							-- Nested placeholder.
						nesting_level := nesting_level + 1
					when stop_spec then
							-- Decrease nesting level and check if this is the end of the current format specification.
						nesting_level := nesting_level - 1
						if nesting_level = 0 then
								-- This is the end of the current format specification.
								-- Ignore invalid placeholders.
							if has_number and then argument_number > 0 then
									-- This is a valid format specification, replace it with a formatted argument.
								if not attached a or else not attached cursor then
										-- Avoid allocating too much space in case there is an error in the argument specification.
									if argument_number < 10 then
										create a.make (argument_number)
									else
										create a.make (10)
									end
										-- Initialize iteration.
									cursor := arguments.new_cursor
								end
									-- Compute argument at position `argument_number' if possible and store it to `a'.
								compute_argument (a, cursor, argument_number)
									-- Check if an argument is found.
								if a.valid_index (argument_number) and then attached a [argument_number] as append then
										-- Check if there is a format specification.
									if i <= j then
											-- Use given format specification.
										append (create {FORMAT_SPECIFICATION}.make (message.substring (i, j - 1)), formatter)
									else
											-- Use default format.
										append (Void, formatter)
									end
								end
							end
						end
							-- Prepare for a regular message.
						i := j + 1
						state := state_message
					when escape_char then
							-- Do not interpret next character.
						j := j + 1
					else
							-- Continue collecting format specification.
					end
				end
					-- Advance to the next character.
				j := j + 1
			end
			if state = state_message and then i <= n then
					-- Emit last message.
				format_message (formatter, message, i, n)
			end
		end

feature {NONE} -- State of a parser

	state_message: NATURAL_32 = 0
			-- State of message collection.

	state_placeholder: NATURAL_32 = 1
			-- State of placeholder parsing.

	state_number: NATURAL_32 = 2
			-- State of number parsing.

	state_format: NATURAL_32 = 3
			-- State of format specification parsing.

feature {NONE} -- Argument evaluation

	compute_argument
			(storage: detachable ARRAYED_LIST [PROCEDURE [detachable FORMAT_SPECIFICATION, G]];
			cursor: ITERATION_CURSOR [PROCEDURE [detachable FORMAT_SPECIFICATION, G]];
			argument_number: INTEGER_32)
			-- Compute argument at position `argument_number' if possible using `cursor' and put it to `storage'.
		local
			n: INTEGER_32
		do
				-- Check if argument has been computed.
			n := storage.count
			if argument_number > n and then not cursor.after then
					-- Argument has not been computed yet.
					-- The loop cannot be replaced with an iteration form because the cursor is reused.
				from
				until
					n = argument_number or else cursor.after
				loop
						-- Place next argument at the unallocated index.
					storage.extend (cursor.item)
						-- Update number of arguments.
					n := n + 1
						-- Advance to next argument.
					cursor.forth
				end
			end
		end

feature -- Constructor

	list (add_list: PROCEDURE [detachable FORMAT_SPECIFICATION, G, ITERABLE [PROCEDURE [G]]]; items: ITERABLE [PROCEDURE [G]]): PROCEDURE [detachable FORMAT_SPECIFICATION, G]
			-- New list composed by `add_list' from given `items' that can be passed as an element to `format'.
			-- For example, "t.format ("{1}", [t.list (..., foo)])" will process "foo" as a list to be injected at position "{1}".
			-- If "foo" were an iterable object, the call "t.format ("{1}", [foo])" will inject only the first item of "foo" instead.
		do
			Result := agent (s: detachable FORMAT_SPECIFICATION; a: PROCEDURE [detachable FORMAT_SPECIFICATION, G, ITERABLE [PROCEDURE [G]]]; i: ITERABLE [PROCEDURE [G]]; t: G)
				do
					a (s, t, i)
				end (?, add_list, items, ?)
		end

feature {NONE} -- Access

	format_message: PROCEDURE [TUPLE [f: G; s: READABLE_STRING_GENERAL; first: INTEGER_32; last: INTEGER_32]]
			-- Formatter to be used for rendering message `s' from index `first' to index `last' using formatter `f'..

	escape_char: CHARACTER_32 = '`'
			-- Escape character.

	start_spec: CHARACTER_32 = '{'
			-- Character used to strart placeholder.

	stop_spec: CHARACTER_32 = '}'
			-- Character used to stop placeholder.

	middle_spec: CHARACTER_32 = '|'
		-- Character used to delimit argument number associated with a placeholder from the format specification string.

	zero_code: INTEGER_32 = 48
			-- Code of the character '0'.

invariant
	zero_code_definition: zero_code = ('0').code

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
