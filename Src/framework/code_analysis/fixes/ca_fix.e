note
	description: "Represents a fix for a rule violation."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_FIX

inherit
	AST_ROUNDTRIP_ITERATOR

	CA_SHARED_NAMES

	SHARED_SERVER

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Implementation

	make (a_caption: attached STRING_32; a_class: attached CLASS_C)
			-- Initializes `Current'. Sets the caption of the fix to `a_caption' (which
			-- is used in the GUI, e. g.). Set the class the fix will change to `a_class'.
		do
			caption := a_caption
			class_to_change := a_class
		end

	matchlist: detachable LEAF_AS_LIST
			-- The matchlist of the class the fix will change.
		do
			Result := Match_list_server.item (class_to_change.class_id)
		end

feature -- Basic Operations

	execute (a_class: attached CLASS_AS)
		do
			process_ast_node (a_class)
		end

feature -- Setting properties

	set_applied (a_applied: BOOLEAN)
			-- Marks this fix as applied.
		do
			applied := a_applied
		end

feature -- Properties

	caption: STRING_32
			-- Caption of this fix. Used in the GUI, for example.

	class_to_change: CLASS_C
			-- Class this fix will change.

	applied: BOOLEAN
			-- Has the fix already been applied?

end
