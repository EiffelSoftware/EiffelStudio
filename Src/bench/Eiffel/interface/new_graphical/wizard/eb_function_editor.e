indexing
	description:
		"Wizard to create features and insert them in a specific%N%
		%feature clause."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FUNCTION_EDITOR

inherit
	EB_ROUTINE_EDITOR
		undefine
			adapt
		redefine
			is_function
		end

	EB_QUERY_EDITOR
		undefine
			initialize
		redefine
			is_function,
			enable_expanded_needed
		end

feature {NONE} -- Initialization

	routine_is_part: EV_HORIZONTAL_BOX is
			-- Box with `add_argument_button' and "): is".
		local
			c: EV_CELL
		do
			create Result
			Result.extend (add_argument_button)
			Result.disable_item_expand (Result.last)
			Result.extend (new_label ("): "))
			Result.disable_item_expand (Result.last)
			create type_selector
			Result.extend (type_selector)
			Result.extend (new_label (" is"))
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
				Result.append ("%T" + feature_name_field.text + arguments_code + ": " + type_selector.code + " is%N")
			else
				Result.append ("%T" + arguments_code + ": " + type_selector.code + " is%N")
			end
			Result.append (comments_code)
			Result.append (routine_code)
		end

feature -- Status report

	valid_content: BOOLEAN is
			-- Is user input valid for code generation?
		do
		end

	is_function: BOOLEAN is True
			-- Is `Current' a function editor?

feature {EB_QUERY_COMPOSITION_WIZARD} -- Status setting

	enable_expanded_needed is
			-- Set `expanded_needed' to `True'.
		local
			hb_type: EV_HORIZONTAL_BOX
		do
			Precursor
			hb_type ?= type_selector.parent
			check hb_type /= Void end
			hb_type.prune (hb_type.last)
			hb_type.prune (hb_type.last)
			hb_type.extend (new_label ("expanded "))
			hb_type.disable_item_expand (hb_type.last)
			hb_type.extend (type_selector)
			hb_type.extend (new_label (" is"))
			hb_type.disable_item_expand (hb_type.last)
		end

end -- class EB_FUNCTION_EDITOR
