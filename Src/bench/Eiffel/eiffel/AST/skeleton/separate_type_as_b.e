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
			is_deep_equal, record_separate,
			class_name, generics
		end;

	CLASS_TYPE_AS_B
		rename
			actual_type as basic_actual_type,
			solved_type as basic_solved_type,
			format as basic_format
		undefine
			set, is_deep_equal, dump, simple_format
		redefine
			class_name, generics
		end;
	CLASS_TYPE_AS_B
		undefine
			set, is_deep_equal, dump, simple_format
		redefine
			actual_type, solved_type, format, class_name, generics
		select
			actual_type, solved_type, format
		end

feature -- Properties

	class_name: ID_AS_B;

	generics: EIFFEL_LIST_B [TYPE_B]

feature

	is_deep_equal (other: TYPE_B): BOOLEAN is
		local
			o: like Current
		do
			o ?= other;
			Result := o /= Void and then basic_is_deep_equal (other)
		end;

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
			Result := basic_solved_type (feat_table, f);
			Result.set_is_separate (True);
		end;

	actual_type: CL_TYPE_A is
			-- Separate actual class type
		do
			Result := basic_actual_type;
			Result.set_is_separate (True);
		end;

feature -- Output

	format (ctxt: FORMAT_CONTEXT_B) is
		do
			ctxt.put_text_item (ti_Separate_keyword);
			ctxt.put_space;
			basic_format (ctxt);
		end;

end -- class SEPARATE_TYPE_AS_B
