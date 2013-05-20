note
	description: "General error output visitor"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OUTPUT_ERROR_VISITOR

inherit
	ERROR_VISITOR

	REFACTORING_HELPER

feature -- Output

	output_string (a_str: detachable READABLE_STRING_GENERAL)
			-- Output Unicode string
		deferred
		end

	output_any (obj: detachable ANY)
			-- Output Unicode string
		do
			if attached {READABLE_STRING_GENERAL} obj as l_str then
				to_implement ("Convert into UTF-8 or console encoding before output")
				output_string (l_str)
			elseif obj /= Void then
				output_string (obj.out)
			end
		end

	output_integer (i: INTEGER)
		do
			output_string (i.out)
		end

	output_new_line
		do
			output_string ("%N")
		end

feature -- Process

	process_error (e: ERROR)
		do
			output_string ({STRING_32}"Error Name: ")
			output_string (e.name)
			output_string ({STRING_32}"Code: ")
			output_integer (e.code)
			output_new_line
			output_string ({STRING_32}"%TMessage: ")
			output_string (e.message)
			output_new_line
		end

	process_custom (e: ERROR_CUSTOM)
		do
			output_string ({STRING_32}"Error Name: ")
			output_string (e.name)
			output_string ({STRING_32}"Code: ")
			output_integer (e.code)
			output_new_line
			output_string ({STRING_32}"%TMessage: ")
			output_string (e.message)
			output_new_line
		end

	process_group (g: ERROR_GROUP)
		local
			l_errors: LIST [ERROR]
		do
			from
				l_errors := g.sub_errors
				l_errors.start
			until
				l_errors.after
			loop
				l_errors.item.process (Current)
				l_errors.forth
			end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
