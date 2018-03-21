note
	description: "An Eiffel test error"
	legal: "See notice at end of class."
	status: "See notice at end of class."

deferred class EW_ERROR

inherit
	EW_SHARED_OBJECTS

feature -- Creation

	make_with_reason (r: like reason)
		do
			reason := r
		end

	make (fname: READABLE_STRING_32; line_no: INTEGER; orig_text: READABLE_STRING_32; subst_text: READABLE_STRING_32; reas: READABLE_STRING_32)
			-- Create `Current' with `fname' and
			-- `line_no' as the file name and line number at
			-- which error occurred.  `orig_text' is the original
			-- text of the line and `subst_text' is the text
			-- after substitution of environment variables.
			-- `Reas' is the reason for the error.
		require
			nonnegative_line_number: line_no >= 0
			orig_text_not_void: orig_text /= Void
			subst_text_not_void: subst_text /= Void
			reason_not_void: reas /= Void
		do
			file_name := fname
			line_number := line_no
			original_text := orig_text
			substituted_text := subst_text
			reason := reas
		end

feature -- Properties

	error_type: STRING
			-- Type of error which occurred
		deferred
		end

	file_name: READABLE_STRING_32
			-- Name of file on which error occurred (void if none)

	line_number: INTEGER
			-- Number of line being processed

	original_text: READABLE_STRING_32
			-- Text of line with error before substitution

	substituted_text: READABLE_STRING_32
			-- Text of line with error after substitution

	reason: READABLE_STRING_32
			-- Reason for error.

feature -- Display

	display
			-- Display `Current'
		require
			error_type_not_void: error_type /= Void
			reason_not_void: reason /= Void
		do
			output.append ("%T", False)
			output.append_error (error_type, False)
			output.append_error (" error", False)
			if file_name /= Void then
				output.append (" in file ", False)
				output.append_32 (file_name, False)
				output.append (" at line ", False)
				output.append (line_number.out, False)
			end
			output.append_new_line
			if attached original_text as t then
				output.append ("%TOriginal text:    ", False)
				output.append_32 (t, False)
				output.append_new_line
			end
			if attached substituted_text as t then
				output.append ("%TSubstituted text: ", False)
				output.append_32 (t, False)
				output.append_new_line
			end
			output.append ("%TReason: ", False)
			display_reason
			output.append_new_line
		end

feature {NONE} -- Implementation

	display_reason
			-- Display `reason' of `Current'.
		require
			reason_not_void: reason /= Void
		local
			pos: INTEGER
			c: CHARACTER_32
			u: UTF_CONVERTER
		do
			from
				pos := 1
			until
				pos > reason.count
			loop
				c := reason.item (pos)
				output.append_error
					(if c.is_character_8 then
						create {STRING_8}.make_filled (c.to_character_8, 1)
					else
						u.string_32_to_utf_8_string_8 (create {STRING_32}.make_filled (c, 1))
					end,
					False)
				if c = '%N' then
					output.append ("%T", False)
				end
				pos := pos + 1
			end
		end

note
	ca_ignore: "CA011", "CA011 — too many arguments"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"

end
