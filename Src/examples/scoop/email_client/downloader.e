note
	description: "Downloads email messages and stores them in a separate list."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOADER

create
	make

feature {NONE} -- Initialization

	make (a_messages: like messages; a_controller: like controller)
			-- Initialization for `Current'.
		do
			messages := a_messages
			controller := a_controller
		end

feature -- Access

	messages: separate LINKED_LIST[separate STRING]
			-- The list of emails where new messages should be added.

	controller: separate CONTROLLER
			-- A separate controller which indicates when to stop execution.

	count: INTEGER
			-- Number of downloaded messages.

	D_temporization: INTEGER = 1
			-- The wait time in seconds between downloading two messages.

	computed_count: INTEGER
			-- Number of messages in client's message list.
		do
			separate messages as m do
				Result := m.count
			end
		end

feature -- Status report

	is_over: BOOLEAN
			-- Shall `Current' stop its operation?

----------------------------------------------- INLINE SEPARATE PART FOR THIRD PARTY CONTROL, PAGE 24 -----------------------------------------------

--	is_over: BOOLEAN
--			-- Shall `Current' stop its operation?
--		do
--			separate controller as c do
--				Result := c.is_downloader_over
--			end
--		end

feature -- Basic operations.

--	download_one (ml: separate LINKED_LIST [separate STRING])
--			-- Read one message and record it in `ml'.
--			-- Note: In a real application, downloading may take some time.
--			-- You probably do not want to do this while having exclusive access over the shared `ml' object.
--		do
--			ml.extend (fetch_message)
--		end

	download_one_fixed
			-- Read one message and record it in `messages'.
		do
			record_one (fetch_message, messages)
		end

	live
			-- Get messages and add them to the client message list.
		do
			from until is_over loop
				record_one (fetch_message, messages)
				wait(D_temporization)
			end
		end

	stop
			-- Set `is_over' to True.
			-- Note: It isn't possible to stop a SCOOP processor like this, as the client will never get exclusive
			-- access while `Current' is executing {DOWNLOADER}.live.
		do
			is_over := true
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

	record_one(m: separate STRING; ml: separate LINKED_LIST[separate STRING])
			-- Store message `m' at the end of list `ml'.
		do
			ml.extend (m)
		end

	fetch_message: separate STRING
			-- Download a new message.
		local
			l_downloaded: STRING
		do
			count := count + 1
			l_downloaded := "Message" + count.out
			print ("Adding message: " + l_downloaded + "%N")
			create <NONE> Result.make_from_separate (l_downloaded)
		end

end
