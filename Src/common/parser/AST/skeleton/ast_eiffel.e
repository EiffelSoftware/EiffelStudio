indexing
	description: "Abstract node produce by yacc. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

deferred class AST_EIFFEL

inherit
	ANY

	REFACTORING_HELPER
		export
			{NONE} all
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		deferred
		end

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

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST (body only)
		do
			-- Return 0 by default
		end

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		deferred
		ensure
			start_location_not_void: Result /= Void
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		deferred
		ensure
			end_location_not_void: Result /= Void
		end

	start_position: INTEGER is
			-- Starting position for current construct.
		do
			Result := start_location.position
		ensure
			start_position_non_negative: Result >= 0
		end

	end_position: INTEGER is
			-- End position for current construct
		local
			l_location: like end_location
		do
			l_location := end_location
			Result := l_location.position + l_location.location_count
		ensure
			end_position_non_negative: Result >= 0
		end
		
feature {NONE} -- Constants

	null_location: LOCATION_AS is
			-- Null location
		once
			create Result.make_null
		ensure
			null_location_not_void: Result /= Void and then Result.is_null
		end
		
end
