indexing
	description: "Component to let the user create features."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FEATURE_EDITOR

inherit
	EV_VERTICAL_BOX
		redefine
			is_in_default_state
		end

	FEATURE_WIZARD_COMPONENT
		undefine
			default_create, is_equal, copy
		end

feature -- Access

	code: STRING is
			-- Current text of the feature in the wizard.
		deferred
		end

	name_number: INTEGER
			-- Number to append to initial feature name.

feature -- Element change

	set_name_number (a_number: INTEGER) is
			-- Assign `a_number' to `name_number'.
		deferred
		ensure
			a_number_assigned: name_number = a_number
		end

feature -- Status report

	valid_content: BOOLEAN is
			-- Is user input valid for code generation?
		deferred
		end

	is_procedure: BOOLEAN is
			-- Is `Current' a procedure editor?
		do
		end

	is_function: BOOLEAN is
			-- Is `Current' a function editor?
		do
		end

	is_attribute: BOOLEAN is
			-- Is `Current' an attribute editor?
		do
		end

feature {NONE} -- Implementation

	comments_code: STRING is
			-- Formatted Eiffel comments.
		local
			n: INTEGER
		do
			create Result.make (10)
			from
				n := 1
			until
				n > comment_field.line_count
			loop
				Result.append ("%T%T%T-- " + comment_field.line (n) + "%N")
				n := n + 1
			end
		end

	add_label (a_text: STRING; ind: INTEGER) is
			-- Create new label with `a_text'.
		local
			hb: EV_HORIZONTAL_BOX
			l: EV_LABEL
			tab: EV_CELL
		do
			create hb
			tab := new_tab (ind)
			hb.extend (tab)
			hb.disable_item_expand (tab)
			l := new_label (a_text)
			l.align_text_left
			hb.extend (l)
			extend (hb)
			disable_item_expand (hb)
		end

	add_indented (a_widget: EV_WIDGET; ind: INTEGER) is
			-- Add `a_widget' to `Current', indented.
		local
			hb: EV_HORIZONTAL_BOX
			tab: EV_CELL
		do
			create hb
			tab := new_tab (ind)
			hb.extend (tab)
			hb.disable_item_expand (tab)
			hb.extend (a_widget)
			extend (hb)
			disable_item_expand (hb)
		end

	add_comment_field is
			-- Add `comment_field' to `Current'.
		local
			hb: EV_HORIZONTAL_BOX
			tab: EV_CELL
		do
			create hb
			tab := new_tab (3)
			hb.extend (tab)
			hb.disable_item_expand (tab)
			hb.extend (new_label ("-- "))
			hb.disable_item_expand (hb.last)
			create comment_field
			hb.extend (comment_field)
			extend (hb)
			disable_item_expand (hb)
		end

feature -- Adaptation

	adapt (other: EB_FEATURE_EDITOR) is
			-- Set with `other'.
		local
			tmpstr: STRING
		do
			tmpstr := other.feature_name_field.text
			if tmpstr /= Void and then not tmpstr.is_empty then
				feature_name_field.set_text (tmpstr)
			else
				feature_name_field.remove_text
			end
			tmpstr := other.comment_field.text
			if tmpstr /= Void and then not tmpstr.is_empty then
				comment_field.set_text (tmpstr)
			else
				comment_field.remove_text
			end
		end

feature {EB_FEATURE_EDITOR, EB_FEATURE_COMPOSITION_WIZARD} -- Access

	feature_clause_selector: EB_FEATURE_CLAUSE_SELECTOR

	feature_name_field: EB_FEATURE_NAME_EDIT

	comment_field: EB_FEATURE_LINE_EDIT

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := True
		end

end -- class EB_FEATURE_EDITOR
