note
	description: "Summary description for {TAGCOUNT_CALLBACKS}."
	date: "$Date$"
	revision: "$Revision$"
class TAGCOUNT_CALLBACKS

inherit

	XM_CALLBACKS_NULL
		redefine
			on_start,
			on_start_tag
		end

create

	make

feature -- Events

	on_start is
			-- Reset tag count.
		do
			count := 0
		end

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Count start tags.
		local
			np: STRING
			pr: STRING
			lp: STRING
		do
			if a_namespace = void then
				np := ""
			else
				np := a_namespace
			end

			if a_prefix = void then
				pr := ""
			else
				pr := a_prefix
			end

			if a_local_part = void then
				lp := ""
			else
				lp:= a_local_part
			end

			print ("namespace '" + np + "', prefix '" + pr + "', local_part '" + lp + "'%N")
			count := count + 1
		end

feature -- Access

	count: INTEGER
			-- Number of tags seen.

end
