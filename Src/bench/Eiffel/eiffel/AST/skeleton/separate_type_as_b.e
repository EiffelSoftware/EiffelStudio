indexing

	description:
		"Abstract description of separate class type. %
		%Version for Bench version.";
	date: "$Date$";
	revision: "$Revision$"

class SEPARATE_TYPE_AS_B

inherit
	SEPARATE_TYPE_AS
		undefine
			same_as, associated_eiffel_class, append_to
		redefine
			record_separate,
			class_name, generics
		end

	CLASS_TYPE_AS_B
		undefine
			set, dump, simple_format
		redefine
			actual_type, solved_type, class_name, generics
		end

feature -- Properties

	class_name: ID_AS_B;

	generics: EIFFEL_LIST_B [TYPE_B]

feature

	record_separate is
			-- Record the use of the separate keyword
		do
			if System.Concurrent_eiffel then
				System.set_has_separate;
			elseif System.current_class.lace_class = System.general_class then
				-- Allow declaration of `deep_import' in GENERAL
			else
				Error_handler.make_separate_syntax_error
			end
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
		do
			Result := {CLASS_TYPE_AS_B} Precursor (feat_table, f);
			Result.set_is_separate (True);
			record_separate_dependance (Result.associated_class);		
		end;

	actual_type: CL_TYPE_A is
			-- Separate actual class type
		do
			Result := {CLASS_TYPE_AS_B} Precursor
			Result.set_is_separate (True);
		end;

end -- class SEPARATE_TYPE_AS_B
