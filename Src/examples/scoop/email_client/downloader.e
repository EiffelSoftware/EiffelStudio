note
	description: "Downloads email messages and stores them in a separate list."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOADER

inherit
	TUTORIAL_HELPER

create
	make

feature {NONE} -- Initialization

	make (c: separate CLIENT)
			-- Initialize downloader so that it will download messages for `c'.
		do
			client := c
			controller := c.controller
		end

feature -- Access

	client: separate CLIENT
			-- The client where new messages should be stored.

	controller: separate CONTROLLER
			-- A separate controller which indicates when to stop execution.

	count: INTEGER
			-- Number of downloaded messages.

	computed_count: INTEGER
			-- Number of messages in client's message list.
		do
			separate client as m do
				Result := m.messages.count
			end
		end

feature -- Status report

	is_over: BOOLEAN
			-- Shall `Current' stop its operation?
		do
			separate controller as c do
				Result := c.is_over
			end
		end

feature -- Basic operations.

	download_one
			-- Read one message and record it in `client'.
		local
			latest: STRING
		do
				-- Simulate download time.
				-- Note: Use `wait (1000)' instead to get more deterministic results.
			random_wait

				-- Increment message count.
			count := count + 1

				-- Make up new message.
			latest := "Message" + count.out

				-- Display that message.
			print ("Adding message: " + latest + "%N")

				-- Add message to the client.
			record_one (client, latest)
		end

	record_one (c: separate CLIENT; m: STRING)
			-- Store message `m' in client `c'.
		do
			c.extend (m)
		end

	live
			-- Get messages and add them to the client message list.
		do
			from until is_over loop
				download_one
			end
		end

feature -- Stopping a Processor: the wrong approach.


--	is_over: BOOLEAN
			-- Shall `Current' stop its operation?

--	stop
--			-- Set `is_over' to True.
--			-- Note: It isn't possible to stop a SCOOP processor like this, as the client will never get exclusive
--			-- access while `Current' is executing {DOWNLOADER}.live.
--		do
--			is_over := True
--		end

end
