indexing

	description: 
		"Pre and Post condition defined in origin feature.";
	date: "$Date$";
	revision: "$Revision $"

class ROUTINE_ASSERTIONS

creation

	make, make_for_feature
	
feature -- Initialization

	make (feat_adapter: FEATURE_ADAPTER) is
			-- Initialize Current assertion
			-- with assertions from `ast'.
		require
			valid_feat_adapter: feat_adapter /= Void
		local
			routine_as: ROUTINE_AS	
		do
			routine_as ?= feat_adapter.ast.body.content;
			if routine_as /= Void then
				precondition := routine_as.precondition;
				postcondition := routine_as.postcondition;
			end;
			origin := feat_adapter.source_feature;
		end;

	make_for_feature (feat: FEATURE_I; ast: FEATURE_AS) is
			-- Initialize Current with feature `feat'
			-- and ast structure `ast'.
		local
			rout_as: ROUTINE_AS
		do
			if ast /= Void then
				rout_as ?= ast.body.content;
			end;
			if rout_as /= Void then
				precondition := rout_as.precondition;
				postcondition := rout_as.postcondition;
			end;
			origin := feat;
		end;

feature -- Properties

	precondition: REQUIRE_AS;
			-- Precondition ast for origin

	postcondition: ENSURE_AS;
			-- Postcondition ast for origin
		
	origin: FEATURE_I;
			-- Feature where assertions are defined

	written_in: CLASS_ID is
			-- Written in id of origin feature
		require
			origin_set: origin /= Void
		do
			Result := origin.written_in
		end;

feature -- Output

	format_precondition (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.set_source_feature_for_assertion (origin);
			precondition.format (ctxt);
		end;

	format_postcondition (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.set_source_feature_for_assertion (origin);
			postcondition.format (ctxt);
		end;

feature -- Debug

	trace is
		do
			io.error.putstring ("origin feature for assertion: ");
			io.error.putstring (origin.feature_name);
			io.error.new_line;
		end;

end
