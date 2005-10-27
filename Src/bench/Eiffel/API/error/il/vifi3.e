indexing
	description: "Error when an expanded class inherits  classes that are either%
		%external classes or that inherit from external classes."
	date: "$Date$"
	revision: "$Revision$"

class VIFI3

inherit
	VIFI
		rename
			make as make_with_class
		redefine
			subcode
		end

create
	make

feature {NONE} -- Creation

	make (c: like class_c; parents: like parent_classes) is
			-- Create error for class `c' with offfending parent classes `parents'.
		require
			c_not_void: c /= Void
			parents_not_void: parents /= Void
			parents_not_empty: not parents.is_empty
		do
			make_with_class (c)
			parent_classes := parents
		ensure
			class_c_set: class_c = c
			parent_classes_set: parent_classes = parents
		end

feature -- Access

	subcode: INTEGER is 3
			-- Identifier for VIFI error.

	parent_classes: LIST [CLASS_C]
			-- Classes from which user tries to inherit from in `class_c'.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Display error message
		do
			check
				parent_classes_set: parent_classes /= Void
			end
			st.add_string ("Classes that cannot be inherited:")
			st.add_new_line
			from
				parent_classes.start
			until
				parent_classes.after
			loop
				parent_classes.item.append_signature (st, False)
				parent_classes.forth
				if not parent_classes.after then
					st.add_string (", ")
				end
			end
			st.add_new_line
		end

end
