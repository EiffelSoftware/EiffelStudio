note

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
			copy,
			is_equal
		end

feature -- Initialization

	adapt (other: like Current)
			-- Initialize from `other'.
			-- Useful in descendants.
		require
			other_exists: other /= Void
			conforming: conforms_to (other)
		do
			rout_disp := other.rout_disp
			encaps_rout_disp := other.encaps_rout_disp
			calc_rout_addr := other.calc_rout_addr
			closed_operands := other.closed_operands
			operands := other.operands
			class_id := other.class_id
			feature_id := other.feature_id
			is_precompiled := other.is_precompiled
			is_basic := other.is_basic
			is_target_closed := other.is_target_closed
			is_inline_agent := other.is_inline_agent
			open_count := other.open_count
		end

feature -- Access

	frozen operands: OPEN_ARGS

	target: ANY
			-- Target of call.
		do
			if is_target_closed then
				Result := closed_operands.item (1)
			elseif operands /= Void and then operands.count > 0 then
				Result := operands.item (1)
			end
		end

	hash_code: INTEGER
			-- Hash code value.
		do
			Result := rout_disp.hash_code.bit_xor (
				class_id.hash_code).bit_xor (
					feature_id.hash_code)
		end

	precondition (args: like operands): BOOLEAN
			-- Do `args' satisfy routine's precondition
			-- in current state?
		do
			Result := True
			--| FIXME compiler support needed!
		end

	postcondition (args: like operands): BOOLEAN
			-- Does current state satisfy routine's
			-- postcondition for `args'?
		do
			Result := True
			--| FIXME compiler support needed!
		end

	empty_operands: OPEN_ARGS
			-- Empty tuple matching open operands
		do
			create Result
		ensure
			empty_operands_not_void: Result /= Void
		end

feature -- Status report

	callable: BOOLEAN = True
			-- Can routine be called on current object?

	is_equal (other: like Current): BOOLEAN
			-- Is associated routine the same as the one
			-- associated with `other'.
		do
			--| Do not compare implementation data
			Result := equal (closed_operands, other.closed_operands)
				and then equal (operands, other.operands)
				and then equal (open_map, other.open_map)
				and then (rout_disp = other.rout_disp)
				and then (class_id = other.class_id)
				and then (feature_id = other.feature_id)
				and then (encaps_rout_disp = other.encaps_rout_disp)
				and then (calc_rout_addr = other.calc_rout_addr)
		end

	valid_operands (args: OPEN_ARGS): BOOLEAN
			-- Are `args' valid operands for this routine?
		local
			i, arg_type_code: INTEGER
			arg: ANY
			int: INTERNAL
			open_type_codes: STRING
		do
			if args = Void then
					-- Void operands are only allowed
					-- if object has no open operands.
				Result := (open_count = 0)
			else
				create int
				if int.generic_count (args) >= open_count then
					from
						Result := True
						open_type_codes := eif_gen_typecode_str ($Current)
						i := 1
					until
						i > open_count or not Result
					loop
						arg_type_code := args.item_code (i)
						Result := arg_type_code = open_type_codes.item (i + 1).code
						if Result and then arg_type_code = {TUPLE}.reference_code then
							arg := args.item (i)
							Result := arg = Void or else
								int.type_conforms_to (int.dynamic_type (arg), open_operand_type (i))
						end
						i := i + 1
					end
				end
			end
			if Result and then not is_target_closed then
				Result := args.item (1) /= Void
			end
		end

	valid_target (args: TUPLE): BOOLEAN
			-- Is the first element of tuple `args' a valid target
		do
			if args /= Void and then args.count > 0 then
				if args.is_reference_item (1) then
					Result := args.reference_item (1) /= Void
				else
					Result := True
				end
			end
		end

feature -- Measurement

	open_count: INTEGER
			-- Number of open operands.

feature -- Settings

	frozen set_operands (args: OPEN_ARGS)
			-- Use `args' as operands for next call.
		require
			valid_operands: valid_operands (args)
		do
			operands := args
		ensure
			operands_set: (operands /= Void implies equal (operands, args)) or
				(operands = Void implies (args = Void or else args.is_empty))
		end

feature -- Duplication

	copy (other: like Current)
			-- Use same routine as `other'.
		do
			open_map := other.open_map
			rout_disp := other.rout_disp
			calc_rout_addr := other.calc_rout_addr
			encaps_rout_disp := other.encaps_rout_disp
			class_id := other.class_id
			feature_id := other.feature_id
			is_precompiled := other.is_precompiled
			is_basic := other.is_basic
			is_target_closed := other.is_target_closed
			is_inline_agent := other.is_inline_agent
			closed_operands := other.closed_operands
			open_count := other.open_count
		ensure then
			same_call_status: other.callable implies callable
		end

feature -- Basic operations

	call (args: OPEN_ARGS)
			-- Call routine with `args'.
		require
			valid_operands: valid_operands (args)
		deferred
		end

	apply
			-- Call routine with `operands' as last set.
		require
			valid_operands: valid_operands (operands)
		deferred
		end

feature -- Obsolete

	adapt_from (other: like Current)
			-- Adapt from `other'. Useful in descendants.
		obsolete
			"Please use `adapt' instead (it's also a creation procedure)"
		require
			other_exists: other /= Void
			conforming: conforms_to (other)
		do
			adapt (other)
		end

feature {ROUTINE} -- Implementation

	frozen closed_operands: TUPLE
			-- All closed arguments provided at creation time

	closed_count: INTEGER
			-- The number of closed operands (including the target if it is closed)
		do
			if closed_operands /= Void then
				Result := closed_operands.count
			end
		end

	frozen rout_disp: POINTER
			-- Routine dispatcher

	frozen calc_rout_addr: POINTER
			-- Address of the final routine

	frozen open_map: SPECIAL [INTEGER]
			-- Index map for open arguments

	frozen encaps_rout_disp: POINTER
			-- Eiffel routine dispatcher

	frozen class_id: INTEGER

	frozen feature_id: INTEGER

	frozen is_precompiled: BOOLEAN

	frozen is_basic: BOOLEAN

	frozen is_target_closed: BOOLEAN

	frozen is_inline_agent: BOOLEAN

	frozen set_rout_disp (a_rout_disp, a_encaps_rout_disp, a_calc_rout_addr: POINTER
						  a_class_id, a_feature_id: INTEGER; a_open_map: SPECIAL [INTEGER]
						  a_is_precompiled, a_is_basic, a_is_target_closed, a_is_inline_agent: BOOLEAN
						  a_closed_operands: TUPLE; a_open_count: INTEGER)
			-- Initialize object.
		require
			target_valid: a_is_target_closed implies valid_target (a_closed_operands)
		do
			set_rout_disp_int (a_rout_disp, a_encaps_rout_disp, a_calc_rout_addr, a_class_id, a_feature_id,
							   a_open_map, a_is_precompiled, a_is_basic, a_is_target_closed,
							   a_is_inline_agent, a_closed_operands, a_open_count)
		end

	frozen set_rout_disp_final (a_rout_disp, a_encaps_rout_disp, a_calc_rout_addr: POINTER
						  		a_closed_operands: TUPLE; a_is_target_closed: BOOLEAN; a_open_count: INTEGER)
			-- Initialize object.
		do
			rout_disp := a_rout_disp
			encaps_rout_disp := a_encaps_rout_disp
			calc_rout_addr := a_calc_rout_addr
			closed_operands := a_closed_operands
			is_target_closed := a_is_target_closed
			open_count := a_open_count
		end

	frozen set_rout_disp_int (a_rout_disp, a_encaps_rout_disp, a_calc_rout_addr: POINTER
						  	  a_class_id, a_feature_id: INTEGER; a_open_map: SPECIAL [INTEGER]
	 						  a_is_precompiled, a_is_basic, a_is_target_closed, a_is_inline_agent: BOOLEAN
							  a_closed_operands: TUPLE; a_open_count: INTEGER)
			-- Initialize object.
		require
			a_class_id_valid: a_class_id > -1
			a_feature_id_valid: a_feature_id > -1
		do
			rout_disp := a_rout_disp
			encaps_rout_disp := a_encaps_rout_disp
			calc_rout_addr := a_calc_rout_addr
			class_id := a_class_id
			feature_id := a_feature_id
			open_map := a_open_map
			is_precompiled := a_is_precompiled
			is_basic := a_is_basic
			is_target_closed := a_is_target_closed
			is_inline_agent := a_is_inline_agent
			closed_operands := a_closed_operands
			open_count := a_open_count
		ensure
			rout_disp_set: rout_disp = a_rout_disp
			encaps_rout_disp_set: encaps_rout_disp = a_encaps_rout_disp
			calc_rout_addr_set: calc_rout_addr = a_calc_rout_addr
			class_id_set: class_id = a_class_id
			feature_id_set: feature_id = a_feature_id
			open_map_set: open_map = a_open_map
			is_target_closed_set: is_target_closed = a_is_target_closed
			is_precompiled_set: is_precompiled = a_is_precompiled
			is_basic_set: is_basic = a_is_basic
			is_inline_agent_set: is_inline_agent = a_is_inline_agent
			closed_operands_set: closed_operands = a_closed_operands
			open_count_set: open_count = a_open_count
		end

feature {NONE} -- Implementation

	frozen open_types: ARRAY [INTEGER]
			-- Types of open operands

	open_operand_type (i: INTEGER): INTEGER
			-- Type of `i'th open operand.
		require
			positive: i >= 1
			within_bounds: i <= open_count
		local
			l_internal: INTERNAL
		do
			if open_types = Void then
				create open_types.make (1, open_count)
			end
			Result := open_types.item (i)
			if Result = 0 then
				create l_internal
				Result := l_internal.generic_dynamic_type_of_type (
					l_internal.generic_dynamic_type (Current, 2), i)
				open_types.force (Result, i)
			end
		end

feature {NONE} -- Externals

	eif_gen_typecode_str (obj: POINTER): STRING
			-- Code name for generic parameter `pos' in `obj'.
		external
			"C signature (EIF_REFERENCE): EIF_REFERENCE use %"eif_gen_conf.h%""
		end

feature -- Obsolete

	arguments: OPEN_ARGS
		obsolete
			"use operands"
		do
			Result := operands
		end

	set_arguments (args: OPEN_ARGS)
		obsolete
			"use set_operands"
		do
			set_operands (args)
		end

	valid_arguments (args: OPEN_ARGS): BOOLEAN
		obsolete
			"use valid_operands"
		do
			Result := valid_operands (args)
		end

invariant
	callable: callable

note
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

