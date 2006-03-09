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
						l_item := l_internal.item (l_pos - 1)
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
		do
				--| Do not compare implementation data
			Result := {SYSTEM_OBJECT}.equals (internal_operands, other.internal_operands)
				and then {SYSTEM_OBJECT}.equals (open_map, other.open_map)
				and then (rout_disp = other.rout_disp)
				and then (target_object = other.target_object)
				and then (is_cleanup_needed = other.is_cleanup_needed)
		end

	valid_operands (args: OPEN_ARGS): BOOLEAN is
			-- Are `args' valid operands for this routine?
		do
			if args = Void or open_map = Void then
					-- Void operands are only allowed
					-- if object has no open operands.
				Result := (open_map = Void)
			else
					-- True for the moment. If it is not valid then an
					-- exception will be thrown by the .NET runtime during
					-- feature call.
				Result := True
			end
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
						l_internal.put (l_pos - 1, args.fast_item (i + 1))
					end
					i := i + 1
				end
			end
		ensure
			operands_set: (operands /= Void implies equal (operands, args)) or
				(operands = Void implies (args = Void or else args.is_empty))
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


feature {ROUTINE, E_FEATURE} -- Implementation

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

	frozen set_rout_disp (handle: RUNTIME_METHOD_HANDLE; args: OPEN_ARGS; 
						 omap: ARRAY [INTEGER]) is
			-- Initialize object. 
		require
			args_not_void: args /= Void
		local
			i, nb: INTEGER
			l_internal: like internal_operands
		do
			rout_disp := {METHOD_BASE}.get_method_from_handle (handle)

			target_object := args.fast_item (1)
			nb := args.count - 1
			if nb > 0 then
				from
					i := 1
					create l_internal.make (nb)
				until
					i > nb
				loop
					l_internal.put (i - 1, args.fast_item (i + 1))
					i := i + 1
				end
			end
			internal_operands := l_internal

			if omap /= Void then
				open_map := omap.to_cil
			else
				open_map := Void
			end
			
			compute_is_cleanup_needed (args)
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
		do
			if open_types = Void then
				create open_types.make (1, open_map.count)
			end
			Result := open_types.item (i)
			if Result = 0 then
				Result := eif_gen_param_id (
					- 1,
					eif_gen_create (Current, 2),
					i)
				open_types.force (Result, i)
			end
		end

feature {NONE} -- Externals

	eif_gen_conf (type1, type2: INTEGER): BOOLEAN is
			-- Does `type1' conform to `type2'?
		do
			check
				False
			end
		end

	eif_gen_create (obj: ANY; pos: INTEGER): POINTER is
			-- Adapt `args' for `idx' and `val'.
		do
			check
				False
			end
		end

	eif_gen_param_id (stype: INTEGER; obj: POINTER; pos: INTEGER): INTEGER is
			-- Type of generic parameter in `obj' at position `pos'.
		do
			check
				False
			end
		end

	eif_gen_typecode (obj: POINTER; pos: INTEGER): INTEGER_8 is
			-- Code for generic parameter `pos' in `obj'.
		do
			check
				False
			end
		end

	eif_gen_typecode_str (obj: POINTER): STRING is
			-- Code name for generic parameter `pos' in `obj'.
		do
			check
				False
			end
		end

	eif_gen_tuple_typecode_str (obj: POINTER): STRING is
			-- Code name for generic parameter `pos' in `obj'.
		do
			check
				False
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

