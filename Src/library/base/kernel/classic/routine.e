indexing

	description: "[
		Objects representing delayed calls to a routine,
		with some operands possibly still open
		]"

	status: "See notice at end of class"
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

	adapt (other: like Current) is
			-- Initialize from `other'.
			-- Useful in descendants.
		require
			other_exists: other /= Void
			conforming: conforms_to (other)
		do
			internal_operands := other.internal_operands
			open_map := other.open_map
			rout_disp := other.rout_disp
			eiffel_rout_disp := other.eiffel_rout_disp
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
		do
			l_open_map := open_map
			if l_open_map /= Void then
				from
					create Result
					i := 0
					nb := l_open_map.count - 1
				until
					i > nb
				loop
					Result.put (internal_operands.item (l_open_map.item (i)), i + 1)
					i := i + 1
				end
			end
		end

	target: ANY is
			-- Target of call.
		do
			Result := internal_operands.item (1)
		end

	hash_code: INTEGER is
			-- Hash code value.
		do
			Result := rout_disp.hash_code
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

feature -- Status report

	callable: BOOLEAN is
			-- Can routine be called on current object?
		local
			null_ptr: POINTER
		do
			Result := (rout_disp /= null_ptr)
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is associated routine the same as the one
			-- associated with `other'.
		do
			--| Do not compare implementation data
			Result := equal (internal_operands, other.internal_operands)
				and then equal (open_map, other.open_map)
				and then (rout_disp = other.rout_disp)
				and then (eiffel_rout_disp = other.eiffel_rout_disp)
				and then (is_cleanup_needed = other.is_cleanup_needed)
		end

	valid_operands (args: OPEN_ARGS): BOOLEAN is
			-- Are `args' valid operands for this routine?
		local
			i: INTEGER
			mismatch: BOOLEAN
			arg: ANY
			arg_type_code: INTEGER_8
			open_arg_type_code: INTEGER
			a_boolean_ref: BOOLEAN_REF
			a_character_ref: CHARACTER_REF
			a_double_ref: DOUBLE_REF
			an_integer_ref: INTEGER_REF
			an_integer_8_ref: INTEGER_8_REF
			an_integer_16_ref: INTEGER_16_REF
			an_integer_64_ref: INTEGER_64_REF
			a_pointer_ref: POINTER_REF
			a_real_ref: REAL_REF
			int: INTERNAL
			open_type_codes: STRING
		do
			create int
			open_type_codes := eif_gen_typecode_str ($Current)
			if args = Void or open_map = Void then
				-- Void operands are only allowed
				-- if object has no open operands.
				Result := (open_map = Void)
			elseif open_map /= Void and then int.generic_count (args) >= open_map.count then
				from
					i := 1
				until
					i > open_map.count or mismatch
				loop
					arg := args.item (i)
					arg_type_code := args.arg_item_code (i)
					open_arg_type_code := open_type_codes.item (i + 1).code
					if arg_type_code = feature {TUPLE}.reference_code then				
						inspect	open_arg_type_code
						when feature {TUPLE}.boolean_code then
							a_boolean_ref ?= arg
							mismatch := a_boolean_ref = Void
						when feature {TUPLE}.character_code then
							a_character_ref ?= arg
							mismatch := a_character_ref = Void
						when feature {TUPLE}.double_code then
							a_double_ref ?= arg
							mismatch := a_double_ref = Void
						when feature {TUPLE}.integer_64_code then
							an_integer_64_ref ?= arg
							an_integer_ref ?= arg
							an_integer_16_ref ?= arg
							an_integer_8_ref ?= arg
							mismatch := an_integer_64_ref = Void and then an_integer_ref = Void
								and then an_integer_16_ref = Void and then an_integer_8_ref = Void
						when feature {TUPLE}.integer_32_code then
							an_integer_ref ?= arg
							an_integer_16_ref ?= arg
							an_integer_8_ref ?= arg
							mismatch := an_integer_ref = Void and then
								an_integer_16_ref = Void and then an_integer_8_ref = Void
						when feature {TUPLE}.integer_16_code then
							an_integer_16_ref ?= arg
							an_integer_8_ref ?= arg
							mismatch := an_integer_16_ref = Void and then an_integer_8_ref = Void
						when feature {TUPLE}.integer_8_code then
							an_integer_8_ref ?= arg
							mismatch := an_integer_8_ref = Void
						when feature {TUPLE}.pointer_code then
							a_pointer_ref ?= arg
							mismatch := a_pointer_ref = Void
						when feature {TUPLE}.real_code then
							a_real_ref ?= arg
							mismatch := a_real_ref = Void
						when feature {TUPLE}.reference_code then
							if arg /= Void and then not int.type_conforms_to (
								int.dynamic_type (arg),
								open_operand_type (i))
							then
								mismatch := True
							end
						else
								-- Must be NONE open type
							mismatch := arg /= Void
						end
					else
						if arg_type_code /= open_arg_type_code then
							inspect
								open_arg_type_code
							when feature {TUPLE}.integer_64_code then
								mismatch :=
									arg_type_code /= feature {TUPLE}.integer_32_code and then
									arg_type_code /= feature {TUPLE}.integer_16_code and then
									arg_type_code /= feature {TUPLE}.integer_8_code
							when feature {TUPLE}.integer_32_code then
								mismatch :=
									arg_type_code /= feature {TUPLE}.integer_16_code and then
									arg_type_code /= feature {TUPLE}.integer_8_code
							when feature {TUPLE}.integer_16_code then
								mismatch := arg_type_code /= feature {TUPLE}.integer_8_code
							when feature {TUPLE}.integer_8_code then
									-- As seen in above if statement, `arg_type_code' is not
									-- equal to `open_arg_type_code'.
								mismatch := True
							else
								mismatch :=
									(open_arg_type_code = feature {TUPLE}.reference_code implies
									open_operand_type (i) > 0)
							end
						end
					end
					i := i + 1
				end
				Result := not mismatch
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

feature -- Settings

	frozen set_operands (args: OPEN_ARGS) is
			-- Use `args' as operands for next call.
		require
			valid_operands: valid_operands (args)
		local
			i, nb: INTEGER
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
					rout_tuple_item_copy ($l_internal, l_open_map.item (i), $args, i + 1)
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
			open_map := other.open_map
			rout_disp := other.rout_disp
			eiffel_rout_disp := other.eiffel_rout_disp
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
			-- Call routine with `args' as last set.
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

	frozen internal_operands: TUPLE
			-- All open and closed arguments provided at creation time

	frozen open_map: SPECIAL [INTEGER]
			-- Index map for open arguments

	frozen rout_disp: POINTER
			-- Routine dispatcher

	frozen eiffel_rout_disp: POINTER
			-- Eiffel routine dispatcher

	frozen is_cleanup_needed: BOOLEAN
			-- If open arguments contain some references, we need
			-- to clean them up after call.

	frozen set_rout_disp (p: POINTER; tp: POINTER; args: TUPLE; 
						 omap: ARRAY [INTEGER]) is
			-- Initialize object. 
		require
			p_not_void: p /= Default_pointer
			tp_not_void: tp /= Default_pointer
			args_not_void: args /= Void
		do
			rout_disp := p
			eiffel_rout_disp := tp
			internal_operands := args
			if omap /= Void then
				open_map := omap.area
			else
				open_map := Void
			end
			compute_is_cleanup_needed
		ensure
			rout_disp_set: rout_disp = p
			eiffel_rout_disp_set: eiffel_rout_disp = tp
			internal_operands_set: internal_operands = args
			open_map_set: (omap = Void and open_map = Void) or
				(omap /= Void and then open_map = omap.area)
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
				l_pos := l_open_map.item (i)
					-- We only need to clean up references so that GC
					-- can collect them if necessary.
				if l_internal.is_reference_item (l_pos) then
					l_internal.put_reference (Void, l_pos)
				end
				i := i + 1
			end
		end
		
	frozen compute_is_cleanup_needed is
			-- Set `is_cleanup_needed' to True if some open arguments are references.
		local
			l_open_map: like open_map
			i, nb, l_pos: INTEGER
			l_internal: like internal_operands
		do
			is_cleanup_needed := False
			l_open_map := open_map
			if l_open_map /= Void then
				from
					i := 0
					nb := l_open_map.count - 1
					l_internal := internal_operands
				until
					i > nb or is_cleanup_needed
				loop
					l_pos := l_open_map.item (i)
						-- We only need to clean up references so that GC
						-- can collect them if necessary.
					if l_internal.is_reference_item (l_pos) then
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

feature {NONE} -- Externals

	rout_tuple_item_copy (a_target: POINTER; a_target_pos: INTEGER; a_source: POINTER; a_source_pos: INTEGER) is
			-- Copy tuple element at position `a_source_pos' in `a_source' to position
			-- `a_target_pos' in `a_target'.
		external
			"C macro use %"eif_rout_obj.h%""
		end

	eif_gen_typecode_str (obj: POINTER): STRING is
			-- Code name for generic parameter `pos' in `obj'.
		external
			"C signature (EIF_REFERENCE): EIF_REFERENCE use %"eif_gen_conf.h%""
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

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class ROUTINE

