class ROUTINE_ASSERTIONS

creation
	make, make_for_feature
	
feature

	precondition: REQUIRE_AS_B;

	postcondition: ENSURE_AS_B;
		
	origin: FEATURE_I;

	make (ast: FEATURE_FSAS) is
		do
			precondition := ast.precondition;
			postcondition := ast.postcondition;
			origin := ast.adapter.old_feature;
		end;

	make_for_feature (feat: FEATURE_I; ast: FEATURE_AS_B) is
		local
			rout_as: ROUTINE_AS_B
		do
			rout_as ?= ast.body.content;
			if rout_as /= Void then
				precondition := rout_as.precondition;
				postcondition := rout_as.postcondition;
			end;
			origin := feat;
		end;

	format_precondition (ctxt: FORMAT_CONTEXT_B) is
		do
			ctxt.begin;
			ctxt.set_source_context (origin);
			ctxt.set_source_class (origin.written_class);
			precondition.format (ctxt);
			ctxt.commit
		end;

	format_postcondition (ctxt: FORMAT_CONTEXT_B) is
		do
			ctxt.begin;
			ctxt.set_source_context (origin);
			ctxt.set_source_class (origin.written_class);
			postcondition.format (ctxt);
			ctxt.commit;
		end;

	written_in: INTEGER is
		require
			origin_set: origin /= Void
		do
			Result := origin.written_in
		end;

	trace is
		do
			io.error.putstring ("origin feature for assertion: ");
			io.error.putstring (origin.feature_name);
			io.error.new_line;
		end;


end
		


	
