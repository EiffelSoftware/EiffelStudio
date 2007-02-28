indexing

	description: "[
		Collection of features that are used to mark
		places in code that needs refactoring.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

	date: "$Date$"
	revision: "$Revision$"

class REFACTORING_HELPER

feature -- Markers

	fixme (comment: STRING) is
			-- Mark code that has to be "fixed" with `comment'.
		require
			comment_not_void: comment /= Void
		do
			debug ("refactor_fixme")
				io.error.put_string ("FIXME: ")
				io.error.put_string (comment)
				io.error.put_new_line
			end
		end

	to_implement (comment: STRING) is
			-- Mark code that has to be "implemented" with `comment'.
		require
			comment_not_void: comment /= Void
		do
			debug ("refactor_fixme")
				io.error.put_string ("TO_BE_IMPLEMENTED: ")
				io.error.put_string (comment)
				io.error.put_new_line
			end
		end

	to_implement_assertion (comment: STRING): BOOLEAN is
			-- Mark assertion that has to be "implemented" with `comment'.
		require
			comment_not_void: comment /= Void
		do
			debug ("refactor_fixme")
				io.error.put_string ("ASSERTION_TO_BE_IMPLEMENTED: ")
				io.error.put_string (comment)
				io.error.put_new_line
			end
			Result := True
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"







end
