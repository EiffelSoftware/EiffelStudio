indexing

	description: 
		"Abstract syntax tree node.";
	date: "$Date$";
	revision: "$Revision$"

deferred class AST_EIFFEL

inherit

	AST_YACC;
	SHARED_ERROR_HANDLER;
	SHARED_TEXT_ITEMS

feature -- Access

	number_of_stop_points: INTEGER is
			-- Number of stop points for AST
		do
		end

feature {AST_EIFFEL, COMPILER_EXPORTER} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text according to context.
		deferred
		end;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
			--| default version uses `deep_equal'
		require
			arg_non_void: other /= Void
		do
			Result := c_deep_equal ($Current, $other)
		end

	frozen equivalent (o1, o2: AST_EIFFEL): BOOLEAN is
			-- Are `o1' and `o2' equivalent ?
			-- this feature is similatr to `deep_equal'
			-- but ARRAYs and STRINGs are processed correctly
			-- (`deep_equal' will compare the size of the `area')
		do
			if o1 = Void then
				Result := o2 = Void
			else
				Result := o2 /= Void and then c_same_type ($o1, $o2) and then
					o1.is_equivalent (o2)
			end
		end

feature {SERVER} -- Identity

	is_feature_obj: BOOLEAN is
			-- Is the current object an instance of FEATURE_AS ?
		do
			-- Do nothing
		end;

	is_invariant_obj: BOOLEAN is
			-- Is the current object an instance of INVARIANT_AS ?
		do
			-- Do nothing
		end;

	position: INTEGER is
			-- position of the item in text
		do
			Result := -1;
				-- treated as unknown
		end;

end -- class AST_EIFFEL
