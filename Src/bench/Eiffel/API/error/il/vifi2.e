indexing
	description: "Error when a class performs multiple inheritance of classes that are either%
		%external classes or that inherits from external classes."
	date: "$Date$"
	revision: "$Revision$"

class
	VIFI2

inherit
	VIFI
		redefine
			subcode
		end

create
	make

feature -- Access

	subcode: INTEGER is 2
			-- Identifier for VIFI error.

	parent_classes: LIST [CLASS_C]
			-- Classes from which user tries to inherit from in `class_c'.

feature -- Setting

	set_parent_classes (l: like parent_classes) is
			-- Set `l' to `parent_classes'.
		require
			l_not_void: l /= Void
		do
			parent_classes := l
		ensure
			parent_classes_set: parent_classes = l
		end
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Display error message
		do
			check
				parent_classes_set: parent_classes /= Void
			end
			st.add_string ("Class ")
			class_c.append_signature (st)
			st.add_string (" inherit multiply from classes that cannot be multiply inherited:")
			st.add_new_line
			from
				parent_classes.start
			until
				parent_classes.after
			loop
				parent_classes.item.append_signature (st)
				parent_classes.forth
				if not parent_classes.after then
					st.add_string (", ")
				end
			end
			st.add_new_line
		end

end -- class VIFI2
