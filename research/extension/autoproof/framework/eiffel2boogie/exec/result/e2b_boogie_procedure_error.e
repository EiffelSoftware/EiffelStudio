note
	description: "Individual error of verifying a Boogie procedure."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_BOOGIE_PROCEDURE_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_error_code: STRING)
			-- Make error with `a_error_code'.
		do
			error_code := a_error_code.twin
		ensure
			error_code_set: error_code ~ a_error_code
		end

feature -- Access

	error_code: STRING
			-- Boogie error code

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
			Result := error_code ~ "BP5001"
		end

	is_precondition_violation: BOOLEAN
			-- Is this a precondition violation?
		do
			Result := error_code ~ "BP5002"
		end

	is_postcondition_violation: BOOLEAN
			-- Is this a postcondition violation?
		do
			Result := error_code ~ "BP5003"
		end

	is_loop_inv_violated_on_entry: BOOLEAN
			-- Is this a loop invariant failed on entry error?
		do
			Result := error_code ~ "BP5004"
		end

	is_loop_inv_not_maintained: BOOLEAN
			-- Is this a loop invariant not maintained error?
		do
			Result := error_code ~ "BP5005"
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
			l_comment_text: STRING
			l_parts: LIST [STRING]
			l_part: STRING
		do
			create Result.make (4)
			l_index := a_line.substring_index ("//", 1)
			if l_index > 0 then
				l_comment_text := a_line.substring (l_index + 2, a_line.count)
				l_parts := l_comment_text.split (' ')
				across l_parts as i loop
					l_part := i.item
					l_part.left_adjust
					l_part.right_adjust
					if not l_part.is_empty then
						l_index := l_part.index_of (':', 1)
						if l_index = 0 then
							Result.force (Void, l_part)
						else
							Result.force (l_part.substring (l_index + 1, l_part.count), l_part.substring (1, l_index - 1))
						end
					end
				end
			end
		end

end
