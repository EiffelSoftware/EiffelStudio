indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LEAF_STUB_AS

inherit
	LEAF_AS
		redefine
			text
		end

create
	make

feature{NONE} -- Implementation

	make (a_text: STRING; a_leaf: LEAF_AS) is
			--
		require
			a_text_not_void: a_text /= Void
			a_leaf_not_void: a_leaf /= Void
		do
			literal_text := a_text
			make_from_other (a_leaf)
		ensure
			literal_text_set: literal_text = a_text
		end

feature

	text (a_list: LEAF_AS_LIST): STRING is
		do
			Result := literal_text
		end

	literal_text: STRING
			-- Literal text in code

feature

	is_equivalent (other: like Current): BOOLEAN is
		do
			check
				should_not_arrive_here: False
			end
		end

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			check
				should_not_arrive_here: False
			end
		end

	number_of_breakpoint_slots: INTEGER is
		do
			check
				should_not_arrive_here: False
			end
		end

invariant
	literal_text_not_void: literal_text /= Void

end
