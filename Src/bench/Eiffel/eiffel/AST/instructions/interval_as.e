indexing

	description:
			"Abstract node for alternative values of a multi-branch %
			%instruction. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INTERVAL_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent, byte_node, type_check, start_location, end_location
		end

	SHARED_INSPECT

	SHARED_TYPES

create
	initialize

feature {NONE} -- Initialization

	initialize (l: like lower; u: like upper) is
			-- Create a new INTERVAL AST node.
		require
			l_not_void: l /= Void
		do
			lower := l
			upper := u
		ensure
			lower_set: lower = l
			upper_set: upper = u
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_interval_as (Current)
		end

feature -- Attributes

	lower: ATOMIC_AS
			-- Lower bound

	upper: ATOMIC_AS
			-- Upper bound
			-- Void if constant rather than interval

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := lower.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if upper /= Void then
				Result := upper.end_location
			else
				Result := lower.end_location
			end
		end
			
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (lower, other.lower) and
				equivalent (upper, other.upper)
		end

feature -- Type check and byte code

	check_for_veen (at_as: ATOMIC_AS) is
		local
			id_as: ID_AS
			static: STATIC_ACCESS_AS
			veen: VEEN
			vomb2: VOMB2
			vomb6: VOMB6
		do
			id_as ?= at_as
			if (id_as /= Void) then
				if
					context.current_feature.argument_position (id_as) /= 0
					or else context.locals.item (id_as) /= Void
				then
					create vomb2
					context.init_error (vomb2)
					vomb2.set_type (Inspect_control.type)
					vomb2.set_location (id_as)
					Error_handler.insert_error (vomb2)
				elseif not context.current_class.feature_table.has (id_as) then
					create veen
					context.init_error (veen)
					veen.set_identifier (id_as)
					veen.set_location (id_as)
					Error_handler.insert_error (veen)
				end
			else
				static ?= at_as
				if static /= Void then
					static.type_check
					Error_handler.checksum
					if not static.associated_feature.is_constant then
							-- Not a valid constant
						create vomb6
						context.init_error (vomb6)
						vomb6.set_unique_feature (static.associated_feature)
						vomb6.set_written_class (static.associated_class)
						vomb6.set_location (static.start_location)
						Error_handler.insert_error (vomb6)
					else
							-- Since we do not need the CONSTANT_B object,
							-- we simply remove it from access_line. Not
							-- doing so, shift the code generation of one
							-- instruction.
						context.access_line.remove
					end
				end
			end
		end

	type_check is
			-- Type check interval
		local
			vomb2: VOMB2
		do
			check_for_veen (lower)
			check_for_veen (upper)
			Error_handler.checksum
			Inspect_control.set_interval (Current)
			if is_good_interval then
				Intervals.insert (Inspect_control.interval_byte_node)
				lower.record_dependances
				if upper /= Void then
					upper.record_dependances
				end
			else
				create vomb2
				context.init_error (vomb2)
				vomb2.set_type (Inspect_control.type)
				vomb2.set_location (start_location)
				Error_handler.insert_error (vomb2)
			end
		end

	byte_node: INTERVAL_B is
			-- Associated byte code
		do
			Result := Intervals.item
			Intervals.forth
		end

	Intervals: LINE [INTERVAL_B] is
			-- Line of intervals computed by `type_check' and used
			-- by `byte_node'.
		once
			Result := context.interval_line
		end

feature -- Access

	is_good_interval: BOOLEAN is
			-- Is the current interval a good one?
			-- (Are its bounds constant and of the same type
			-- as inspect expression?)
		local
			type: TYPE_A
		do
			type := inspect_control.type
			Result := lower.is_valid_inspect_value (type)
						and then (upper = Void or else upper.is_valid_inspect_value (type))
		end

feature {INTERVAL_AS} -- Replication

	set_lower (l: like lower) is
			-- Set `lower' to `l'.
		require
			l_not_void: l /= Void
		do
			lower := l
		end

	set_upper (u: like upper) is
			-- Set `upper' to `u'.
		do
			upper := u
		end

invariant
	lower_not_void: lower /= Void

end -- class INTERVAL_AS
