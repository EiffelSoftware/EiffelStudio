note
	description: "Merges two lists of email messages."
	author: "Chandrakana Nandi"
	date: "$Date$"
	revision: "$Revision$"

class
	MERGER

feature -- Basic operations

	merge (c1, c2: separate CLIENT)
			-- Merge the messages in `c1' and `c2'.
		do
			merge_list (c1, c2.messages)
			print("Merge successful!%N")
		end

feature {NONE} -- Implementation

	merge_list (client: separate CLIENT; list: separate LIST [STRING])
			-- Append the emails in `list' to `client'.
		do
			across list as e loop
				client.extend (e.item)
			end
			list.wipe_out
		end

feature -- With inline separate

	merge_with_inline (c1, c2: separate CLIENT)
			-- Merge the messages in `c1' and `c2'.
		do
			separate c1 as client, c2.messages as list do
				across list as e loop
					client.extend (e.item)
				end
				list.wipe_out
			end
			print("Merge successful!%N")
		end

end
