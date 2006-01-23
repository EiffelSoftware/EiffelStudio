indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Lines of the form VARIABLES ":" SUM
-- This is the top construct of the Polynomial language

class
	LINE 

inherit

	AGGREGATE
		export
			{PROCESS} all
		redefine 
			post_action
		end

	POLYNOM
		undefine
			copy, is_equal
		end

create
	make

feature 

	construct_name: STRING is
		once
			Result := "LINE"
		end -- construct_name

	production: LINKED_LIST [CONSTRUCT] is
		local
			var: VARIABLES
			sum: SUM
		once
			create Result.make
			Result.forth
			create var.make
			put (var)
			keyword (":")
			create sum.make
			put (sum)
		end -- production

	post_action is
		do
			child_start
			child.post_action
			from
				child_finish
			until
				info.end_session
			loop
				info.set_value
				child.post_action
				io.putstring ("value: ")
				io.putint (info.child_value)
				io.new_line
			end
		end -- post_action

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class LINE

