note
	description: "Summary description for {DOWNLOADER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOADER

create
	make

feature
	make
		--Initialization

		do
			create messages.make
			create controller
			D_temporization := 1
		end

feature
		--wrapper
	wrap_mail_file_allocation (c: separate CLIENT)
		do
			messages := c.messages
		end

feature
	messages: separate LINKED_LIST[separate STRING]

feature

	download_one(ml:separate LINKED_LIST[separate STRING])
		-- Read one message and record it

		local
			latest: STRING
			exported_message: separate STRING
		do
			count := count + 1
			create latest.make_empty
			latest := "Message" + count.out
			print("%NAdding message: " + latest)
			create exported_message.make_from_separate (latest)
			record_one(exported_message, ml)
		end

feature
	record_one(m: separate STRING; list: separate LINKED_LIST[separate STRING])
		-- Store message m at the end of list
		do
			list.extend (m)
		end

feature
	live
		do
			from

			until
				is_over
			loop
				download_one(messages)
				wait(D_temporization)
			end
		end

feature
	count: INTEGER
	is_over: BOOLEAN
	D_temporization: INTEGER
	controller: separate CONTROLLER

feature
	stop
		do
			is_over := true
		end

feature
	computed_count: INTEGER
			-- Number of messages in client's message list
		do
			Result := wrapped_feature_for_computed_count(messages)
		end

feature
		--wrapper
	wrapped_feature_for_computed_count(msg: separate LINKED_LIST[separate STRING]): INTEGER
		do
			Result := msg.count
		end

feature
	wait(s: INTEGER_64)
		do
			(create {EXECUTION_ENVIRONMENT}).sleep (s * 1_000_000_000)
		end

----------------------------------------------- INLINE SEPARATE PART FOR THIRD PARTY CONTROL, PAGE 24 -----------------------------------------------
--feature
--	is_over: BOOLEAN
--			-- Has operation termination ben requested
--		do
--			separate controller as c do
--				Result := c.is_downloader_over
--			end
--		end
end
