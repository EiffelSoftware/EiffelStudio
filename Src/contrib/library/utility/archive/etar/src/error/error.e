note
	description: "[
			Error objects, inspired Jocelyn Fiat's error library
			(see https://svn.eiffel.com/eiffelstudio/branches/Eiffel_15.12/Src/contrib/library/utility/general/error/src/error.e)
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR

create
	make,
	make_with_parent

feature {NONE} -- Creation

	make (a_message: like message)
			-- Create new error object with message `a_message'.
		do
			message := a_message
			parent := Void
		ensure
			message_set: message = a_message
			no_parent: parent = Void
		end

	make_with_parent (a_message: like message; a_parent: like parent)
			-- Create new error object with parent `a_parent' and message `a_message'.
		do
			message := a_message
			parent := a_parent
		ensure
			message_set: message = a_message
			parent_set: parent = a_parent
		end

feature -- Access

	message: READABLE_STRING_GENERAL
			-- Error message.

	parent: detachable like Current
			-- Error parent (if any).

feature -- Output

	string_representation: STRING_32
			-- Output error message including all parents.
		local
			l_error: detachable like Current
		do
			from
				create Result.make_from_string_general (message)
				Result.append_character ('%N')
				l_error := parent
			until
				l_error = Void
			loop
				Result.append_character ('%T')
				Result.append_string_general (l_error.message)
				Result.append_character ('%N')
				l_error := l_error.parent
			end
		end
note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
