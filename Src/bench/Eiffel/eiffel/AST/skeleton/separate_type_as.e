indexing
	description:
		"Abstract description of separate class type. %
		%Version for Bench version."
	date: "$Date$"
	revision: "$Revision$"

class SEPARATE_TYPE_AS

inherit
	CLASS_TYPE_AS
		redefine
			initialize,
			dump, simple_format,
			actual_type, solved_type
		end

feature {AST_FACTORY} -- Initialization

	initialize (n: like class_name; g: like generics) is
			-- Create a new SEPARATE_CLASS_TYPE AST node.
		do
			Precursor {CLASS_TYPE_AS} (n, g)
			record_separate
		end

feature {NONE} -- Initialization

	record_separate is
			-- Record the use of the separate keyword
		do
			if System.Concurrent_eiffel then
				System.set_has_separate
			elseif System.current_class.lace_class = System.any_class then
				-- Allow declaration of `deep_import' in ANY
			else
				Error_handler.make_separate_syntax_error
			end
		end

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
		do
			Result := {CLASS_TYPE_AS} Precursor (feat_table, f)
			Result.set_is_separate (True)
			record_separate_dependance (Result.associated_class);		
		end

	actual_type: CL_TYPE_A is
			-- Separate actual class type
		do
			Result := {CLASS_TYPE_AS} Precursor
			Result.set_is_separate (True)
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			!! Result.make (class_name.count + 9)
			Result.append ("separate ")
			Result.append ({CLASS_TYPE_AS} Precursor)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Separate_keyword)
			ctxt.put_space
			{CLASS_TYPE_AS} Precursor (ctxt)
		end

end -- class SEPARATE_TYPE_AS
