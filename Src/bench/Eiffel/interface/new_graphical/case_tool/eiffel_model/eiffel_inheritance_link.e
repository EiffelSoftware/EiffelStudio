indexing
	description: "Objects that is a model vor an inheritance link."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EM_INHERITANCE_LINK
	
inherit
	EG_LINK
		rename
			source as descendant,
			target as ancestor
		redefine
			default_create
		end
	
feature {NONE} -- Initialization

	default_create is
			-- Create an EIFFEL_INHERITANCE_LINK.
		do
			Precursor {EG_LINK}
		end

	make_with_classes (a_descendant, an_ancestor: EM_CLASS) is
			-- Create an EIFFEL_INHERITANCE_LINK connecting `a_descendant' with `an_ancestor'.
		require
			a_descendant_not_void: a_descendant /= Void
			an_ancestor_not_void: an_ancestor /= Void
		do
			make_directed_with_source_and_target (a_descendant, an_ancestor)
		ensure
			set: descendant = a_descendant and ancestor = an_ancestor
		end

end -- class EM_INHERITANCE_LINK
