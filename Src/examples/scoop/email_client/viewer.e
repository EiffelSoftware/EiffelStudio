note
	description: "Displays email messages from a separate email client."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWER

create
	make

feature {NONE} -- Initialization

	make (a_messages: like messages)
			-- Initialize the {VIEWER} object with `messages'.
		do
			messages := a_messages
			create controller
		end

feature -- Access

	messages: separate LINKED_LIST[separate STRING]
			-- The list of email messages to be displayed.

	controller: separate CONTROLLER
			-- A separate controller which indicates when to stop execution.

	V_temporization: INTEGER_64 = 1
			-- The wait time in seconds between displaying two messages.

feature -- Status report

	is_over: BOOLEAN
			-- Shall `Current' stop displaying messages?

----------------------------------------------- INLINE SEPARATE PART FOR THIRD PARTY CONTROL, PAGE 24 -----------------------------------------------
--	is_over: BOOLEAN
--			-- Shall `Current' stop displaying messages?
--		do
--			separate controller as c do
--				Result := c.is_viewer_over
--			end
--		end	


feature -- Basic operations

	live
			-- Simulate a user viewing a message once in a while.
		do
			from until is_over loop
				view_one (messages)
				wait (V_temporization)
			end
		end

	view_one (ml: separate LINKED_LIST[separate STRING])
			-- Simulate viewing: if there are messages, display one, chosen randomly.
			-- TODO: This feature should be splitted as well, just like download_one.
		local
			s_message: separate STRING
			l_message: STRING
		do
			if not ml.is_empty then
				s_message := ml [random (1, ml.count)]
				create l_message.make_from_separate (s_message)
				print("Viewing message: " +  l_message + "%N")
			end
		end


feature {NONE} -- Implementation

	wait (sec: INTEGER_64)
			-- Sleep for `sec' seconds.
		local
			environment: EXECUTION_ENVIRONMENT
		do
			create environment
			environment.sleep (sec * 1_000_000_000)
		end

	random (a, b: INTEGER): INTEGER
			-- Generate a pseudo-random number in the interval [a,b].
		require
			valid_interval: a <= b
		do
			if a = b then
				Result := a
			else
				Result := random_generator.item
				random_generator.forth
				Result := (Result \\ (b-a)) + a
			end
		end

	random_generator: RANDOM
			-- A pseudo-random number generator.
		attribute
			create Result.make
		end

end
