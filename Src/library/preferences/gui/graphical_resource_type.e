indexing
	description: "Resource types that provide a graphical way %
					%to edit their resources."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GRAPHICAL_RESOURCE_TYPE

inherit
	RESOURCE_TYPE

feature -- Access

	edition_box (caller: PREFERENCE_WINDOW): SELECTION_BOX is
			-- Widget that can be used in the preference dialog
			-- to edit resources of this type.
		deferred
		end

end -- class GRAPHICAL_RESOURCE_TYPE
