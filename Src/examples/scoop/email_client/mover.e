note
	description: "Summary description for {MOVER}."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	MOVER

create
	make


feature
	make
		do
			create messages.make
			Max := 10000
			Min := 1000
		end

feature --wrapper function
	wrap_mail_file_allocation (c: separate CLIENT)
		do
			messages := c.messages
		end


feature
	live
			--keep watching for client's mailbox to reach Max messages,
			--and when it does, remove all messages except last Min ones.
		do
			from

			until
				is_over
			loop
				trim (messages)
			end
		end

feature
	is_ready(ml: separate LINKED_LIST[separate STRING]): BOOLEAN
			-- Has the size of ml reached Max messages?
		do
			Result := (ml.count >= Max)
		end

feature
	trim (ml: separate LINKED_LIST[separate STRING])
		require
			ml.count >= Max
		local
			t: INTEGER
		do
			across
				1 |..| Min as i
			loop
				ml[i.item] := ml[ml.count-Min+i.item]
			end

			ml.go_i_th (Min + 1)

			from
				t := Min + 1
			until
				t > Max
			loop
				ml.remove
				t := t + 1
			end

			print("%Nsize after trimming:" + ml.count.out)
		end

feature
	messages: separate LINKED_LIST[separate STRING]
	is_over: BOOLEAN

feature
	Max, Min: INTEGER
end
