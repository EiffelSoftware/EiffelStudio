indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create 
	make

feature

	make is 
		do
			create managed_windows.make (10)
			managed_windows.extend ("hello1")
			managed_windows.extend ("hello2")
			managed_windows.start
			for_all (agent (s: STRING) do print (s) end)
			io.new_line
		end

	for_all (action: PROCEDURE [ANY, TUPLE]) is
			-- Iterate `action' on every managed window.
		do
			action.call ([managed_windows.item])
		end

	managed_windows: ARRAYED_LIST [STRING]

end
