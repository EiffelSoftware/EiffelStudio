note
	description: "Displays email messages from a separate email client."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWER

create
	make


feature
	make
		-- Initialize viewer
		do
			create messages.make
			create controller
			V_temporization := 1

		end

feature
		--wrapper
	wrap_mail_file_allocation (c: separate CLIENT)
		do
			messages := c.messages
		end

feature
	view_one(ml: separate LINKED_LIST[separate STRING])
		-- Simulate viewing: if there are messages, display one, chosen randomly.
		local
			rand: RANDOM
			index: INTEGER
			st: STRING
		do
			if
				not ml.is_empty
			then
				create rand.make
				index := rand.item \\ ml.count
				if
					index = 0
				then
					create st.make_from_separate (ml[index + 1])
				else
					create st.make_from_separate(ml[index])
				end
				print("%NViewing message: " +  st.out)
			end
		end


feature
	live
		do
			from

			until
				is_over
			loop
				view_one(messages)
				wait(V_temporization)
			end
		end

feature
	messages: separate LINKED_LIST[separate STRING]
	is_over: BOOLEAN
	V_temporization: INTEGER
	controller: separate CONTROLLER

feature
	stop
		do
			is_over := true
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
--				Result := c.is_viewer_over
--			end
--		end		
end
