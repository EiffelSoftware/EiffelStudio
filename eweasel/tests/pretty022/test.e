
class
	TEST

create
	make

feature

	make
		do
		end

	req_report (rpt_comment: STRING)
		do
			if the_reported_ifi = Void and  -- not specified
			   all_the_ifis.count = 1 and  -- only one
			  the_ifi.has_fab_id -- is in fab
 			then
				the_reported_ifi := the_ifi
elseif -- Let's try a new condition
	good then
	do_something
elseif
	-- A comment on a new string
	good then
	do_something
elseif good -- An inline comment
then
	do_something
else -- whatever
	do_nothing
			end
			x := ok 		-- OK so far
				and valid   	-- No errors found
				and good	-- Really good
		end

end
