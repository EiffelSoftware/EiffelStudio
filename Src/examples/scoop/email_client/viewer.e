note
	description: "Displays email messages from a separate email client."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWER

inherit
	TUTORIAL_HELPER

create
	make

feature {NONE} -- Initialization

	make (c: separate CLIENT)
			-- Initialize viewer so that it will support viewing messages of `c'.
		do
			messages := c.messages
			controller := c.controller
		end

feature -- Access

	messages: separate LIST[STRING]
			-- The list of email messages to be displayed.

	controller: separate CONTROLLER
			-- A separate controller which indicates when to stop execution.

feature -- Status report

	is_over: BOOLEAN
			 -- Shall `Current' stop displaying messages?
		do
			separate controller as c do
				Result := c.is_over
			end
		end

feature -- Basic operations

	live
			-- Simulate a user viewing a message once in a while.
		do
			from until is_over loop
				view_one
			end
		end

	view_one
			-- Simulate viewing: if there are messages, display one, chosen randomly.
		local
			message: detachable STRING
		do
				-- Simulate viewing time.
				-- Note: Use `wait (1000)' instead to get more deterministic results.
			random_wait

				-- Select message to be displayed.
			message := select_one (messages)

				-- Display message, if any.
			if attached message then
				print("Viewing message: " +  message + "%N")
			end
		end

	select_one (ml: separate LIST [STRING]): detachable STRING
			-- Select a message from `ml'.
		local
			message: separate STRING
		do
			if not ml.is_empty then
				message := ml.i_th (random (1, ml.count))
				create Result.make_from_separate (message)
			end
		end

end
