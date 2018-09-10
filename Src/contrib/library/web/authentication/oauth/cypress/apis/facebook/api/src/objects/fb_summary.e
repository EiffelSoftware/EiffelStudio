note
	description: "Summary description for {FB_SUMMARY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FB_SUMMARY

feature -- Access

	total_count: INTEGER
		-- Total number of objects on this edge.
feature -- Element Change

	set_total_count (a_count: INTEGER)
			-- Set `total_count' with `a_count'.
		do
			total_count := a_count
		ensure
			total_count_set: total_count = a_count
		end

feature  -- Status Report

	shout_out: STRING
		do
			create Result.make_from_string ("SUMMARY")
			Result.append (" %N total count:")
			Result.append_integer (total_count)
			Result.append ("%N")
		end
end
