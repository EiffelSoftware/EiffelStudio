indexing

	description: "[
		Collection of features that are used to mark
		places in code that needs refactoring.
		]"

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

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 2004 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end
