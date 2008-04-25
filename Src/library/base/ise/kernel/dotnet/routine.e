indexing
	description: "[
		Objects representing delayed calls to a routine,
		with some operands possibly still open
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROUTINE [BASE_TYPE, OPEN_ARGS -> TUPLE create default_create end]

inherit
	HASHABLE
		redefine
			is_equal, copy
		end

feature -- Initialization

	adapt (other: like Current) is
			-- Initialize from `other'.
			-- Useful in descendants.
		require
			other_exists: other /= Void
			conforming: conforms_to (other)
		do
			internal_operands := other.internal_operands
			target_object := other.target_object
			open_map := other.open_map
			rout_disp := other.rout_disp
			is_cleanup_needed := other.is_cleanup_needed
		ensure
			same_call_status: other.callable implies callable
		end

feature -- Access

	operands: OPEN_ARGS is
			-- Open operands.
		local
			i, nb: INTEGER
			l_open_map: like open_map
			l_pos: INTEGER
			l_item: SYSTEM_OBJECT
			l_internal: like internal_operands
		do
			l_open_map := open_map
			if l_open_map /= Void then
				from
					create Result
					i := 0
					nb := l_open_map.count - 1
					l_internal := internal_operands
				until
					i > nb
				loop
					l_pos := l_open_map.item (i) - 1
					if l_pos = 0 then
						l_item := target_object
					else
						if is_inline_agent then
							l_item := l_internal.item (l_pos)
						else
							l_item := l_internal.item (l_pos - 1)
						end
					end
					Result.put (l_item, i + 1)
					i := i + 1
				end
			end
		end

	target: ANY is
			-- Target of call.
		do
			Result ?= target_object
		end

	hash_code: INTEGER is
			-- Hash code value.
		do
			Result := rout_disp.get_hash_code.hash_code
		end

	precondition (args: like operands): BOOLEAN is
			-- Do `args' satisfy routine's precondition
			-- in current state?
		do
			Result := True
			--| FIXME compiler support needed!
		end

	postcondition (args: like operands): BOOLEAN is
			-- Does current state satisfy routine's
			-- postcondition for `args'?
		do
			Result := True
			--| FIXME compiler support needed!
		end

	empty_operands: OPEN_ARGS is
			-- Empty tuple matching open operands
		do
			create Result
		ensure
			empty_operands_not_void: Result /= Void
		end

feature -- Status report

	callable: BOOLEAN is
			-- Can routine be called on current object?
		do
			Result := (rout_disp /= Void)
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is associated routine the same as the one
			-- associated with `other'.
		local
			int_ops, other_int_ops: like internal_operands
			i: INTEGER
			e, oe: ANY
			vt: VALUE_TYPE
		do
				--| Do not compare implementation data
			Result := (rout_disp = other.rout_disp)
				and then (target_object = other.target_object)
				and then (is_cleanup_needed = other.is_cleanup_needed)
				and then deep_equal (open_map, other.open_map)

			if Result then
				int_ops := internal_operands
				other_int_ops := other.internal_operands
				if int_ops.count = other_int_ops.count then
					from i := int_ops.lower until not Result or else i > other_int_ops.upper loop
						e := int_ops.item (i)
						oe := other_int_ops.item (i)
						vt ?= e
						if vt /= Void then
							vt ?= oe
							if vt /= Void then
								Result := equal (e, oe)
							else
								Result := False
							end
						else
							Result := e = oe
						end
						i := i + 1
					end
				end
			end
		end

	valid_operands (args: OPEN_ARGS): BOOLEAN is
			-- Are `args' valid operands for this routine?
		local
			i, arg_type_code: INTEGER
			arg: ANY
			int: INTERNAL
		do
			create int
			if args = Void or open_map = Void then
					-- Void operands are only allowed
					-- if object has no open operands.
				Result := (open_map = Void)
			elseif open_map /= Void and then int.generic_count (args) >= open_map.count then
				from
					Result := True
					i := 1
				until
					i > open_map.count or not Result
				loop
					arg_type_code := args.item_code (i)
					if arg_type_code = {TUPLE}.reference_code then
						arg := args.item (i)
						Result := arg = Void or else
							int.type_conforms_to (int.dynamic_type (arg), open_operand_type (i))
					else
							-- We provided a closed argument which is expanded, we have to ensure
							-- that open type has the exact same type.
						Result := int.generic_dynamic_type (args, i) = open_operand_type (i)
					end
					i := i + 1
				end
			end
		end

	is_target_closed: BOOLEAN is
			-- Is target for current agent closed, i.e. specified at creation time?
		do
			Result := open_map = void or else not (open_map.count > 0 and then open_map.item (0) = 1)
		end

feature -- Measurement

	open_count: INTEGER is
			-- Number of open operands.
		do
			if open_map /= Void then
				Result := open_map.count
			end
		end

feature -- Element change

	frozen set_operands (args: OPEN_ARGS) is
			-- Use `args' as operands for next call.
		require
			valid_operands: valid_operands (args)
		local
			i, nb: INTEGER
			l_pos: INTEGER
			l_open_map: like open_map
			l_internal: like internal_operands
		do
			l_open_map := open_map
			if l_open_map /= Void then
				from
					i := 0
					nb := l_open_map.count - 1
					l_internal := internal_operands
				until
					i > nb
				loop
					l_pos := l_open_map.item (i) - 1
					if l_pos = 0 then
						target_object := args.fast_item (i + 1)
					else
						if is_inline_agent then
							l_internal.put (l_pos, args.fast_item (i + 1))
						else
							l_internal.put (l_pos - 1, args.fast_item (i + 1))
						end
					end
					i := i + 1
				end
			end
		ensure
			operands_set: (operands /= Void implies equal (operands, args)) or
				(operands = Void implies (args = Void or else args.is_empty))
		end

	set_target (a_target: like target) is
		require
			a_target_not_void: a_target /= Void
			is_target_closed: is_target_closed
			target_not_void: target /= Void
			same_target_type: target.same_type (a_target)
		do
			target_object := a_target
		ensure
			target_set: target = a_target
		end

feature -- Duplication

	copy (other: like Current) is
			-- Use same routine as `other'.
		do
			internal_operands := other.internal_operands
			target_object := other.target_object
			open_map := other.open_map
			rout_disp := other.rout_disp
			is_cleanup_needed := other.is_cleanup_needed
		ensure then
			same_call_status: other.callable implies callable
		end

feature -- Basic operations

	call (args: OPEN_ARGS) is
			-- Call routine with operands `args'.
		require
			valid_operands: valid_operands (args)
			callable: callable
		do
			set_operands (args)
			apply
			if is_cleanup_needed then
				remove_gc_reference
			end
		end

	apply is
			-- Call routine with `operands' as last set.
		require
			valid_operands: valid_operands (operands)
			callable: callable
		deferred
		end

feature -- Obsolete

	adapt_from (other: like Current) is
			-- Adapt from `other'. Useful in descendants.
		obsolete
			"Please use `adapt' instead (it's also a creation procedure)"
		require
			other_exists: other /= Void
			conforming: conforms_to (other)
		do
			adapt (other)
		ensure
			same_call_status: other.callable implies callable
		end


feature {ROUTINE} -- Implementation

	frozen target_object: SYSTEM_OBJECT
			-- Target of call.

	frozen internal_operands: NATIVE_ARRAY [SYSTEM_OBJECT]
			-- All open and closed arguments provided at creation time

	frozen open_map: NATIVE_ARRAY [INTEGER]
			-- Index map for open arguments

	frozen rout_disp: METHOD_BASE
			-- Routine dispatcher

	frozen is_cleanup_needed: BOOLEAN
			-- If open arguments contain some references, we need
			-- to clean them up after call.

	frozen is_inline_agent: BOOLEAN
			-- Is the target feature an inline agent

	frozen set_rout_disp (handle: RUNTIME_METHOD_HANDLE; closed_args: TUPLE;
						  omap: ARRAY [INTEGER]; a_is_inline_agent: BOOLEAN) is
			-- Initialize object.
		require
			closed_args_not_void: closed_args /= Void
		local
			closed_idx, operand_idx, l_closed_count, l_open_count, l_next_open, l_omap_pos: INTEGER
			l_internal: like internal_operands
			l_target_closed: BOOLEAN
		do
			is_inline_agent := a_is_inline_agent
			rout_disp := {METHOD_BASE}.get_method_from_handle (handle)

			l_closed_count := closed_args.count

			if omap /= Void then
				open_map := omap.to_cil
				l_open_count := omap.count
			else
				open_map := Void
				l_open_count := 0
			end

			if is_inline_agent then
				l_target_closed := True
				target_object := Void
				create l_internal.make (l_open_count + l_closed_count)
				closed_idx := 1
				operand_idx := 1
			else
				l_target_closed := not (l_open_count > 0 and then omap.item (1) = 1)
				if l_target_closed then
					target_object := closed_args.fast_item (1)
					closed_idx := 2
				else
					l_omap_pos := 1
					closed_idx := 1
				end
				operand_idx := 2
				create l_internal.make (open_count + l_closed_count - 1)
			end

			if l_open_count > l_omap_pos then
				l_next_open := omap.item (l_omap_pos + 1)
				l_omap_pos := l_omap_pos + 1
			else
				l_next_open := {INTEGER}.max_value
			end

			if l_closed_count > 0 then
				from
				until
					closed_idx > l_closed_count
				loop
					if operand_idx = l_next_open then
						if l_open_count > l_omap_pos then
							l_next_open := omap.item (l_omap_pos + 1)
							l_omap_pos := l_omap_pos + 1
						else
							l_next_open := {INTEGER}.max_value
						end
					else
						if is_inline_agent then
							l_internal.put (operand_idx - 1, closed_args.fast_item (closed_idx))
						else
							l_internal.put (operand_idx - 2, closed_args.fast_item (closed_idx))
						end
						closed_idx := closed_idx + 1
					end
					operand_idx := operand_idx + 1
				end
			end
			internal_operands := l_internal

--			compute_is_cleanup_needed (closed_args)
		end

feature {NONE} -- Implementation

	frozen open_types: ARRAY [INTEGER]
			-- Types of open operands

	frozen remove_gc_reference is
			-- Remove all references from `internal_operands' so that GC
			-- can collect them if necessary.
		require
			is_cleanup_needed: is_cleanup_needed
			has_open_operands: open_map /= Void
		local
			l_open_map: like open_map
			i, nb, l_pos: INTEGER
			l_internal: like internal_operands
		do
			l_open_map := open_map
			from
				i := 0
				nb := l_open_map.count - 1
				l_internal := internal_operands
			until
				i > nb
			loop
				l_pos := l_open_map.item (i) - 1
				if l_pos = 0 then
					target_object := Void
				else
					l_internal.put (l_pos - 1, Void)
				end
				i := i + 1
			end
		end

	frozen compute_is_cleanup_needed (args: OPEN_ARGS) is
			-- Set `is_cleanup_needed' to True if some open arguments are references.
		local
			l_open_map: like open_map
			i, nb, l_pos: INTEGER
		do
			is_cleanup_needed := False
			l_open_map := open_map
			if l_open_map /= Void then
				from
					i := 0
					nb := l_open_map.count - 1
				until
					i > nb or is_cleanup_needed
				loop
					l_pos := l_open_map.item (i)
						-- We only need to clean up references so that GC
						-- can collect them if necessary.
					if args.is_reference_item (l_pos) then
						is_cleanup_needed := False
					end
					i := i + 1
				end
			end
		end

	open_operand_type (i: INTEGER): INTEGER is
			-- Type of `i'th open operand.
		require
			positive: i >= 1
			within_bounds: i <= open_count
		local
			l_internal: INTERNAL
		do
			if open_types = Void then
				create open_types.make (1, open_map.count)
			end
			Result := open_types.item (i)
			if Result = 0 then
				create l_internal
				Result := l_internal.generic_dynamic_type_of_type (
					l_internal.generic_dynamic_type (Current, 2), i)
				open_types.force (Result, i)
			end
		end

feature -- Obsolete

	arguments: OPEN_ARGS is
		obsolete
			"use operands"
		do
			Result := operands
		end

	set_arguments (args: OPEN_ARGS) is
		obsolete
			"use set_operands"
		do
			set_operands (args)
		end

	valid_arguments (args: OPEN_ARGS): BOOLEAN is
		obsolete
			"use valid_operands"
		do
			Result := valid_operands (args)
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class ROUTINE

