indexing
	description: "Abstract description of expanded class type. %
			%Version for Bench version."
	date: "$Date$"
	revision: "$Revision$"

class EXP_TYPE_AS

inherit
	CLASS_TYPE_AS
		redefine
			initialize,
			actual_type, solved_type,
			dump, simple_format
		end

feature {AST_FACTORY} -- Initialization

	initialize (n: like class_name; g: like generics) is
			-- Create a new EXPANDED_CLASS_TYPE AST node.
		do
			Precursor {CLASS_TYPE_AS} (n, g)
			record_expanded
		end

feature {NONE} -- Initialization

	record_expanded is
			-- This must be done before pass2
			-- `solved_type' and `actual type' are called in pass3 for
			-- local variables
		do
			System.set_has_expanded
			System.current_class.set_has_expanded
		end

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
		do
			Result := {CLASS_TYPE_AS} Precursor (feat_table, f)
			Result.set_is_true_expanded (True)
			record_exp_dependance (Result.associated_class)
		end

	actual_type: CL_TYPE_A is
			-- Expanded actual class type
		do
			Result := {CLASS_TYPE_AS} Precursor
			Result.set_is_true_expanded (True)
			record_exp_dependance (Result.associated_class)
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			!! Result.make (class_name.count + 9)
			Result.append ("expanded ")
			Result.append ({CLASS_TYPE_AS} Precursor)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Expanded_keyword)
			ctxt.put_space
			{CLASS_TYPE_AS} Precursor (ctxt)
		end

end -- class EXP_TYPE_AS
