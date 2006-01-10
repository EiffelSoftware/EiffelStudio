indexing
	description: "List of clickable syntax items."
	date: "$Date$"
	revision: "$Revision$"

class
	CLICK_LIST

inherit
	ARRAYED_LIST [CLICK_AST]
		export
			{ANY} area, lower, upper
		end

create
	make

create {CLICK_LIST}
	make_filled

feature -- Access

	item_by_node (a_node: CLICKABLE_AST): CLICK_AST is
			-- Return item with `node' `a_node'.
		local
			i: INTEGER
		do
			from i := 1 until Result /= Void or i > count loop
				if i_th (i).node = a_node then
					Result := i_th (i)
					i := i + 1
				end
			end
		end

feature -- Debug

	trace is
			-- Output to `io.error'.
		local
			i: INTEGER
		do
			io.error.put_string ("Click list is:%N")
			io.error.put_string (out)
			io.error.put_string ("Content is:%N")
			from
			until
				i = count
			loop
				i := i + 1
				io.error.put_string (i_th (i).out)
			end
		end

end -- class CLICK_LIST
