indexing
	description:
		"Wizard to create features and insert them in a specific%N%
		%feature clause."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROCEDURE_EDITOR

inherit
	EB_ROUTINE_EDITOR
		redefine
			initialize,
			is_procedure
		end

feature {NONE} -- Initialization

	initialize is
		do
			Precursor
			feature_clause_selector.set_clause_name (fc_Element_change)
		end

	routine_is_part: EV_HORIZONTAL_BOX is
			-- Box with `add_argument_button' and "): is".
		local
			c: EV_CELL
		do
			create Result
			Result.extend (add_argument_button)
			Result.disable_item_expand (Result.last)
			Result.extend (new_label (") is"))
			Result.disable_item_expand (Result.last)
			create c
			extend (c)
			disable_item_expand (c)
		end

feature -- Access

	code: STRING is
			-- Current text of the feature in the wizard.
		do
			create Result.make (100)
			if feature_name_field.text /= Void then
				Result.append ("%T" + feature_name_field.text + arguments_code + " is%N")
			else
				Result.append ("%T" +arguments_code + " is%N")
			end
			Result.append (comments_code)
			Result.append (routine_code)
		end

feature -- Status report

	valid_content: BOOLEAN is
			-- Is user input valid for code generation?
		do
		end

	is_procedure: BOOLEAN is True
			-- Is `Current' a procedure editor?

end -- class EB_PROCEDURE_EDITOR
