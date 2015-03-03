note
	description: "Test if nested separate callbacks are handled correctly."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	SUPPLIER

feature

	perform_callback (a_client: separate CLIENT)
		local
			l_string: STRING
		do
				-- Note: This is not a callback, but thanks to lock
				-- passing we have the call stack lock of the root processor.
				-- This means that any call to `a_client' is a separate callback.

				-- Note that with the next callback we're passing an argument
				-- handled by the current processor.
			l_string := "Hello World.%N"
			a_client.callback (l_string)
		end
end
