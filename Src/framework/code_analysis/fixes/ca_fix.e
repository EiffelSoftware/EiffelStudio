note
	description: "Represents a fix for a rule violation."
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_FIX

inherit
	FIX_CLASS

	AST_ROUNDTRIP_ITERATOR

	CA_SHARED_NAMES

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
		obsolete "Use `match_list` instead."
		require
			is_valid: is_valid
		do
			Result := match_list
		end

feature -- Access

	source_class: CLASS_I
			-- <Precursor>
		do
			Result := class_to_change.lace_class
		end

feature -- Basic Operations

	execute (a_class: attached CLASS_AS)
		do
			process_ast_node (a_class)
			process_all_break_as
		end

feature -- Properties

	caption: STRING_32
			-- Caption of this fix. Used in the GUI, for example.

	class_to_change: CLASS_C
			-- Class this fix will change.

feature -- Output

	append_name (t: TEXT_FORMATTER)
			-- <Precursor>
		do
				-- TODO: Implement  in descendants with clickable and remove this feature from this class.
			t.add (ca_messages.fix)
			t.add (caption)
		end

	append_description (t: TEXT_FORMATTER)
			-- <Precursor>
		do
				-- TODO: Implement  in descendants with clickable and remove this feature from this class.
			t.add (ca_messages.fix)
			t.add (caption)
		end

end
