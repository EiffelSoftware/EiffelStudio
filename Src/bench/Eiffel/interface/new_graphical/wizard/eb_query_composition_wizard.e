indexing
	description: "Version of FCW that only allows for queries."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_QUERY_COMPOSITION_WIZARD

inherit
	EB_FEATURE_COMPOSITION_WIZARD
		redefine
			feature_editor,
			set_default_editor,
			feature_type
		end

feature {NONE} -- Initialization

	set_default_editor is
		do
			proc_button.disable_sensitive
			create {EB_ATTRIBUTE_EDITOR} feature_editor
			feature_editor_frame.extend (feature_editor)
			if not attr_button.is_selected then
				attr_button.enable_select
			end
		end

feature -- Status setting

	set_type (s: STRING) is
			-- Create a supplier of type `s'.
			-- (Could disable user selection...)
		do
			feature_editor.set_type (s)
		end

	set_name_number (a_number: INTEGER) is
			-- Assign `a_number' to `name_number'.
		do
			feature_editor.set_name_number (a_number)
		ensure
			a_number_assigned: feature_editor.name_number = a_number
		end

feature {CLASS_TEXT_MODIFIER} -- Status setting

	enable_expanded_needed is
			-- Set `expanded_needed' to `True' in `feature_editor'.
		do
			feature_editor.enable_expanded_needed
		end

feature -- Access

	feature_type: STRING is
			-- Return type if attribute or function.
		do
			Result := feature_editor.type
		end

feature {NONE} -- Implementation

	feature_editor: EB_QUERY_EDITOR

end -- class EB_QUERY_COMPOSITION_WIZARD
