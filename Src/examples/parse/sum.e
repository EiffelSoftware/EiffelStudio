indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Sums: DIFF "+" DIFF "+" ... "+" DIFF

class
	SUM 

inherit

	REPETITION
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
			Result := "SUM"
		end -- construct_name

feature {NONE}

	separator: STRING is "+"

feature 

	production: LINKED_LIST [CONSTRUCT] is
		local
			base: DIFF
		once
			create Result.make
			Result.forth
			create base.make
			put (base)
		end -- production

	post_action is
		local
			int_value: INTEGER
		do
			if not no_components then
				from
					child_start
				until
					child_after
				loop
					child.post_action
					int_value := int_value + info.child_value
					child_forth
				end;
				info.set_child_value (int_value)
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


end -- class SUM

