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

	make (a_messages: like messages; a_controller: like controller)
			-- Initialize the {VIEWER} object with `messages'.
		do
			messages := a_messages
			controller := a_controller
		end

feature -- Access

	messages: separate LIST[STRING]
			-- The list of email messages to be displayed.

	controller: separate CONTROLLER
			-- A separate controller which indicates when to stop execution.

	V_temporization: INTEGER_32 = 1000
			-- The wait time in milliseconds between displaying two messages.

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
				random_wait
					-- Use this instead to get deterministic waiting.
--				wait (V_temporization)
			end
		end

	view_one
			-- Simulate viewing: if there are messages, display one, chosen randomly.
		do
			if attached select_message as l_message then
				print("Viewing message: " +  l_message + "%N")
			end
		end

--	view_one (ml: separate LINKED_LIST[separate STRING])
--			-- Simulate viewing: if there are messages, display one, chosen randomly.
--			-- TODO: This feature should be splitted as well, just like download_one.
--		local
--			s_message: separate STRING
--			l_message: STRING
--		do
--			if not ml.is_empty then
--				s_message := ml [random (1, ml.count)]
--				create l_message.make_from_separate (s_message)
--				print("Viewing message: " +  l_message + "%N")
--			end
--		end


feature {NONE} -- Implementation

	select_message: detachable STRING
			-- Get a new message to be displayed from the client.
		local
			s_message: separate STRING
		do
			separate messages as ml do
				if not ml.is_empty then
					s_message := ml [random (1, ml.count)]
					create Result.make_from_separate (s_message)
				end
			end
		end

end
