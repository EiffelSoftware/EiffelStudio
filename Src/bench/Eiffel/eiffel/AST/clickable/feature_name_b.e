indexing

	description:
		"Abstract class for an Eiffel feature name: id or %
		%infix/prefix notation.";
	date: "$Date$";
	revision: "$Revision$"

deferred class FEATURE_NAME_B

inherit

	FEATURE_NAME
		redefine
			internal_name, temp_name,
			main_feature_format
		end;

	AST_EIFFEL_B
		undefine
			simple_format
		redefine
			format
		end;

	STONABLE;

feature -- Stoning

	internal_name: ID_AS_B is
			-- Internal name used by the compiler.
		deferred
		end;

	temp_name: ID_AS_B is
			-- Buffer for internal name evaluation.
		once
			!! Result.make (25)
		end;
 
	stone (reference_class: CLASS_C): FEATURE_STONE is
		local
			a_feature_i: FEATURE_I
		do
			a_feature_i := reference_class.feature_named (internal_name);
			if a_feature_i /= Void then
				Result := a_feature_i.stone (reference_class)
			else
--io.error.putstring ("error in making feature stone ");
--io.error.putstring (internal_name);
--io.error.new_line;
				!!Result.make (Void, reference_class, 0, 0);
			end
		end

feature -- Formatting

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			if is_frozen then
				ctxt.put_text_item (ti_Frozen_keyword);
				ctxt.put_space
			end;
			ctxt.prepare_for_feature (internal_name, void);
			ctxt.put_current_feature;
		end;

	main_feature_format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			if is_frozen then
				ctxt.put_text_item (ti_Frozen_keyword);
				ctxt.put_space
			end;
			ctxt.prepare_for_main_feature;
			ctxt.put_current_feature
		end;

end -- class FEATURE_NAME_B
