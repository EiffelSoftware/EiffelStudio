note
	description: "Merges two lists of email messages."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	MERGER

feature -- Basic operations

	merge(c1,c2: separate CLIENT)
			-- Merge the messages in `c1' and `c2'.
		do
			merge_list(c1.messages, c2.messages)
			print("Merge successful!%N")
		end

feature {NONE} -- Implementation

	merge_list(l1,l2: separate LINKED_LIST[separate STRING])
			-- Merge the two lists `l1' and `l2'.
		do
			across
				l2 as e
			loop
				l1.extend (e.item)
			end
			l2.wipe_out
		end

end
