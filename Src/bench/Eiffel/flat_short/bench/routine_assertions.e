indexing
	description	: "Pre and Post condition defined in origin feature."
	date		: "$Date$"
	revision	: "$Revision $"

class ROUTINE_ASSERTIONS

create
	make, 
	make_for_feature
	
feature {NONE} -- Initialization

	make (feat_adapter: FEATURE_ADAPTER) is
			-- Initialize Current assertion
			-- with assertions from `ast'.
		require
			valid_feat_adapter: feat_adapter /= Void
		local
			routine_as: ROUTINE_AS	
		do
			routine_as ?= feat_adapter.ast.body.content
			if routine_as /= Void then
				precondition := routine_as.precondition
				postcondition := routine_as.postcondition
			end
			origin := feat_adapter.source_feature
		end

	make_for_feature (feat: FEATURE_I; ast: FEATURE_AS) is
			-- Initialize Current with feature `feat'
			-- and ast structure `ast'.
		local
			rout_as: ROUTINE_AS
		do
			if ast /= Void then
				rout_as ?= ast.body.content

				if rout_as /= Void then
					precondition := rout_as.precondition
					postcondition := rout_as.postcondition
				end
			end
			origin := feat
		end

feature -- Properties

	precondition: REQUIRE_AS
			-- Precondition ast for origin
			-- Void if none

	postcondition: ENSURE_AS
			-- Postcondition ast for origin
			-- Void if none
		
	origin: FEATURE_I
			-- Feature where assertions are defined

	written_in: INTEGER is
			-- Written in id of origin feature
		require
			origin_set: origin /= Void
		do
			Result := origin.written_in
		end

feature -- Output

	format_precondition (ctxt: FORMAT_CONTEXT; hide_breakable_marks: BOOLEAN) is
			-- Format the precondition. Do not display the breakable mark
			-- (i.e.: breakpoint slots) if `hide_breakable_marks' is set.
		local
			l_old_is_with_breakable: BOOLEAN
		do
			ctxt.set_source_feature_for_assertion (origin)
			l_old_is_with_breakable := ctxt.is_with_breakable
			if hide_breakable_marks then
				ctxt.set_is_without_breakable
			else
				ctxt.set_is_with_breakable
			end
			ctxt.format_ast (precondition)
			if l_old_is_with_breakable then
				ctxt.set_is_with_breakable
			else
				ctxt.set_is_without_breakable
			end
		end

	format_postcondition (ctxt: FORMAT_CONTEXT; hide_breakable_marks: BOOLEAN) is
			-- Format the precondition. Do not display the breakable mark
			-- (i.e.: breakpoint slots) if `hide_breakable_marks' is set.
		local
			l_old_is_with_breakable: BOOLEAN
		do
			ctxt.set_source_feature_for_assertion (origin)
			l_old_is_with_breakable := ctxt.is_with_breakable
			if hide_breakable_marks then
				ctxt.set_is_without_breakable
			else
				ctxt.set_is_with_breakable
			end
			ctxt.format_ast (postcondition)
			if l_old_is_with_breakable then
				ctxt.set_is_with_breakable
			else
				ctxt.set_is_without_breakable
			end
		end

feature -- Debug

	trace is
		do
			io.error.put_string ("origin feature for assertion: ")
			io.error.put_string (origin.feature_name)
			io.error.put_new_line
		end

end
