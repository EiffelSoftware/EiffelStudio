indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

deferred class AST_LACE

inherit
	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER;
	SHARED_L_CONTEXT;
	COMPILER_EXPORTER

feature {COMPILER_EXPORTER}

	adapt is
		do
		end

feature -- Duplication

	duplicate: like Current is
			-- Do a full copy of Current and its sub-ojects.
		deferred
		ensure
			duplicated: Result /= Void and then Result /= Current
			-- We should ensure that `is_equal' is defined for all
			-- descendants of `AST_LACE' but we do not have time to
			-- define it at the moment.
			-- valid_duplication: Result.is_equal (Current)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		require
			same_type: other /= Void implies same_type (other) 
		deferred
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		require
			st_not_void: st /= Void
		deferred
		end

feature {AST_LACE} -- Safe duplication

	frozen duplicate_ast (ast: AST_LACE): like ast is
			-- Do a full copy of `ast' and its sub-ojects.
		do
			if ast /= Void then
				Result := ast.duplicate
			end
		end

feature {AST_LACE} -- Safe comparison

	frozen same_ast (target: AST_LACE; other: like target): BOOLEAN is
			-- Is `target' same as `other'?
		do
			Result := (target = Void and then other = Void) or else
				((target /= Void and other /= Void) and then
				target.same_type (other) and then target.same_as (other))
		end

end -- class AST_LACE
