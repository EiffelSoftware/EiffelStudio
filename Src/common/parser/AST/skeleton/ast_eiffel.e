indexing
	description: "Abstract syntax tree node."
	date: "$Date$"
	revision: "$Revision$"

deferred class AST_EIFFEL

inherit
	AST_YACC

feature -- Access

--feature {AST_EIFFEL, COMPILER_EXPORTER} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconsitute text according to context.
--		deferred
--		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		require
			arg_non_void: other /= Void
			same_type: same_type (other)
		deferred
		end

	frozen equivalent (o1, o2: AST_EIFFEL): BOOLEAN is
			-- Are `o1' and `o2' equivalent ?
			-- this feature is similar to `deep_equal'
			-- but ARRAYs and STRINGs are processed correctly
			-- (`deep_equal' will compare the size of the `area')
		do
			if o1 = Void then
				Result := o2 = Void
			else
				Result := o2 /= Void and then o2.same_type (o1) and then
					o1.is_equivalent (o2)
			end
		end

feature -- Location of Node

	frozen start_position: INTEGER is
			-- Start position of the item in text
		local
			l: like location
		do
			l := location
			if l /= Void then
				Result := l.start_position
			else
					-- Return -1 which refers to an unknown value.
				Result := -1
			end
		end

	frozen end_position: INTEGER is
			-- End position of the item in text
		local
			l: like location
		do
			l := location
			if l /= Void then
				Result := l.end_position
			else
					-- Return -1 which refers to an unknown value.
				Result := -1
			end
		end

	frozen line_number : INTEGER is
			-- line of the item in the source text
		local
			l: like location
		do
			l := location
			if l /= Void then
				Result := l.line_number
			else
					-- Return -1 which refers to an unknown value.
				Result := -1
			end
		end

feature {AST_FACTORY} -- Location

	location: TOKEN_LOCATION is
			-- location of the item in the source text
		do
			-- Not used by default.
		end

end -- class AST_EIFFEL
