note
	description: "Individual error of verifying a Boogie procedure."

class
	E2B_BOOGIE_PROCEDURE_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_error_message: STRING)
			-- Make error with `a_error_message'.
		do
			error_message := a_error_message.twin
		ensure
			error_message_set: error_message ~ a_error_message
		end

feature -- Access

	error_message: STRING
			-- Boogie error message

	line: INTEGER
			-- Line where error occured.

	line_text: STRING
			-- Text of line where error occured.

	attributes: STRING_TABLE [STRING]
			-- Attributes of line.

	related_line: INTEGER
			-- Line of related location (if any).

	related_line_text: STRING
			-- Text of line of related location (if any).

	related_attributes: STRING_TABLE [STRING]
			-- Attributes of related line.

feature -- Status report

	is_assert_error: BOOLEAN
			-- Is this an assertion error?
		do
			Result := error_message.has_substring ("assertion")
		end

	is_precondition_violation: BOOLEAN
			-- Is this a precondition violation?
		do
			Result := error_message.has_substring ("precondition")
		end

	is_postcondition_violation: BOOLEAN
			-- Is this a postcondition violation?
		do
			Result := error_message.has_substring ("postcondition");
		end

	is_loop_inv_violated_on_entry: BOOLEAN
			-- Is this a loop invariant failed on entry error?
		do
			Result := error_message.has_substring ("entry")
		end

	is_loop_inv_not_maintained: BOOLEAN
			-- Is this a loop invariant not maintained error?
		do
			Result := error_message.has_substring ("maintained")
		end

	has_related_location: BOOLEAN
			-- Does this error have a related location?
		do
			Result := is_precondition_violation or is_postcondition_violation
		end

feature -- Element change

	set_line (a_line: INTEGER; a_line_text: STRING)
			-- Set `line' to `a_line' and `line_text' to `a_line_text'.
		do
			line := a_line
			line_text := a_line_text.twin
			attributes := parsed_attributes (a_line_text)
		ensure
			line_set: line = a_line
			line_text_set: line_text ~ a_line_text
		end

	set_related_line (a_line: INTEGER; a_line_text: STRING)
			-- Set `related_line' to `a_line' and `related_line_text' to `a_line_text'.
		do
			related_line := a_line
			related_line_text := a_line_text.twin
			related_attributes := parsed_attributes (a_line_text)
		ensure
			related_line_set: related_line = a_line
			related_line_text_set: related_line_text ~ a_line_text
		end

feature {NONE} -- Implementation

	parsed_attributes (a_line: STRING): STRING_TABLE [STRING]
			-- Parse attributes from line `a_line'.
		local
			l_index: INTEGER
			l_parts: LIST [STRING]
			l_part: STRING
			value: STRING
		do
			create Result.make (4)
			l_index := a_line.substring_index ("//", 1)
			if l_index > 0 then
				l_parts := a_line.substring (l_index + 2, a_line.count).split (' ')
				across l_parts as i loop
					l_part := i
					l_part.left_adjust
					l_part.right_adjust
					if not l_part.is_empty then
						l_index := l_part.index_of (':', 1)
						if l_index = 0 then
							Result.force (Void, l_part)
						else
							value := l_part.substring (l_index + 1, l_part.count)
								-- Replace no-break spaces with ordinary ones.
							value.replace_substring_all ("%/194/%/160/", " ")
							Result.force (value, l_part.substring (1, l_index - 1))
						end
					end
				end
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013-2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2021-2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
