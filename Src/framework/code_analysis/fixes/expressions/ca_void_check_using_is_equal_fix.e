note
	description: "Fixes violations of rule #47 ('Void-check using 'is_equal'')."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CA_VOID_CHECK_USING_IS_EQUAL_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_nested

feature {NONE} -- Initialization
	make_with_nested (a_class: attached CLASS_C; a_nested: attached NESTED_AS)
			-- Initializes `Current' with class `a_class'. `a_nested' is the nested call which is to be changed.
		do
			make (ca_names.void_check_using_is_equal_fix, a_class)
			nested_to_change := a_nested
		end

feature {NONE} -- Implementation

	nested_to_change: NESTED_AS
		-- The creation procedure this fix will change.

feature {NONE} -- Visitor

	execute (a_class: CLASS_AS)
		local
			l_new_text: STRING_32
		do
			create l_new_text.make_empty

			l_new_text.append ("(")
			l_new_text.append (nested_to_change.target.access_name_32)
			l_new_text.append (" = Void")
			l_new_text.append (")")

			nested_to_change.replace_text (l_new_text, matchlist)
		end

end
