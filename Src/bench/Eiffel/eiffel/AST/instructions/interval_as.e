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
			is_equivalent, byte_node, type_check, 
			fill_calls_list, replicate
		end

	SHARED_INSPECT

	SHARED_TYPES

feature {AST_FACTORY} -- Initialization

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

feature -- Attributes

	lower: ATOMIC_AS
			-- Lower bound

	upper: ATOMIC_AS
			-- Upper bound
			-- Void if constant rather than interval
			
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
					context.a_feature.argument_position (id_as) /= 0
					or else context.locals.item (id_as) /= Void
				then
					!!vomb2
					context.init_error (vomb2)
					if Inspect_control.integer_type then
						vomb2.set_type (integer_type)
					else
						vomb2.set_type (character_type)
					end
					Error_handler.insert_error (vomb2)
				elseif not context.a_class.feature_table.has (id_as) then
					!! veen
					context.init_error (veen)
					veen.set_identifier (id_as)
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
			error_found: BOOLEAN
			error_type: TYPE_A
		do
			check_for_veen (lower);	
			check_for_veen (upper)
			Error_handler.checksum
			Inspect_control.set_interval (Current)
			if Inspect_control.integer_type then
				if not good_integer_interval then
					error_found := True
					error_type := Integer_type
				else
					Intervals.insert (Inspect_control.integer_interval)
				end
			else
				if not good_character_interval then
					error_found := True
					error_type := Character_type
				else
					Intervals.insert (Inspect_control.character_interval)
				end
			end;	
			if error_found then
				!!vomb2
				context.init_error (vomb2)
				vomb2.set_type (error_type)
				Error_handler.insert_error (vomb2)
			else
				lower.record_dependances
				if upper /= Void then
					upper.record_dependances
				end
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

feature {COMPILER_EXPORTER} -- Access

	good_integer_interval: BOOLEAN is
			-- Is the current interval a good integer interval ?
		do
			Result := lower.good_integer
						and then (upper = Void or else upper.good_integer)
		end

	good_character_interval: BOOLEAN is
			-- Is the current interval a good character interval ?
		do
			Result := lower.good_character
						and then (upper = Void or else upper.good_character)
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		local
			new_list: like l
		do
			!!new_list.make
			lower.fill_calls_list (new_list)
			l.merge (new_list)
			if upper /= Void then
				new_list.make
				upper.fill_calls_list (new_list)
				l.merge (new_list)
			end
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to Replication
		do
			Result := clone (Current)
			Result.set_lower (lower.replicate (ctxt))
			if upper /= Void then
				Result.set_upper (upper.replicate (ctxt))
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.format_ast (lower)
			if upper /= Void then
				ctxt.put_text_item_without_tabs (ti_Dotdot)
				ctxt.format_ast (upper)
			end
		end

feature {INTERVAL_AS} -- Replication

	set_lower (l: like lower) is
			-- Set `lower' to `l'.
		do
			lower := l
		end

	set_upper (u: like upper) is
			-- Set `upper' to `u'.
		require
			valid_arg: u /= Void
		do
			upper := u
		end

end -- class INTERVAL_AS
