note
	description: "[
					Server of class MIDDLE_ACTIVE_OBJECT
																						]"
	date: "$Date$"
	revision: "$Revision$"

class
	SERVER

feature -- Command

	do_work
			-- work
		do
			from
			until
				False
			loop
				increase_counter
			end
		end

feature -- Query

	counter: INTEGER
			-- Counter

feature {NONE} -- Implementation

	increase_counter
			-- Increase counter
		do
			counter := counter + 1
		end
end
