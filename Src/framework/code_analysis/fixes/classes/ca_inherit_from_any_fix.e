note
	description: "Fixes violations of rule #31 (Explicit inheritance from ANY')."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CA_INHERIT_FROM_ANY_FIX

inherit
	CA_FIX
		redefine
			process_parent_as
		end

create
	make_with_class

feature {NONE} -- Initialization
	make_with_class (a_class: attached CLASS_C)
			-- Initializes `Current' with class `a_class'.
		do
			make (ca_names.inherit_from_any_fix, a_class)
		end

feature {NONE} -- Implementation

	process_parent_as (a_parent: PARENT_AS)
		do
			if a_parent.type.class_name.name_32.is_equal ("ANY") then
				a_parent.remove_text (match_list)
			end
		end

end

