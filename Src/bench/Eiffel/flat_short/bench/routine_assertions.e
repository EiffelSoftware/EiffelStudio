class ROUTINE_ASSERTIONS

creation
	make
	

feature

	make (ast: FEATURE_FSAS) is
		do
			precondition := ast.precondition;
			postcondition := ast.postcondition;
			origin := ast.adapter.old_feature;
		end;


	precondition: REQUIRE_AS;

	postcondition: ENSURE_AS;
		
	origin: FEATURE_I;


	format_precondition (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.begin;
			ctxt.set_source_context (origin);
			precondition.format (ctxt);
			ctxt.commit
		end;


	format_postcondition (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.begin;
			ctxt.set_source_context (origin);
			postcondition.format (ctxt);
			ctxt.commit;
		end;

	trace is
		do
			io.error.putstring ("origin feature for assertion: ");
			io.error.putstring (origin.feature_name);
			io.error.new_line;
		end;


end
		


	
