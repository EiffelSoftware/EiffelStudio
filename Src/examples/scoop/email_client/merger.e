note
	description: "Merges two lists of email messages."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	MERGER

feature
	merge(c1,c2: separate CLIENT)
		do
			merge_list(c1.messages, c2.messages)
			print("%NMerge successful!")
		end

feature
	merge_list(l1,l2: separate LINKED_LIST[separate STRING])
		do
			across l2 as e loop l1.extend (e.item)  end
			l2.wipe_out
		end
end
