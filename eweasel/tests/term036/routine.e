note

	description: "[
		Objects representing delayed calls to a routine,
		with some operands possibly still open
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROUTINE [OPEN_ARGS -> TUPLE]

inherit
	MEMORY
		export
			{NONE} all
		redefine
			dispose, is_equal, copy
		end

	HASHABLE
		undefine
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
		local
			null_ptr: POINTER
		do
			-- Free own C argument structure
			if rout_cargs /= null_ptr then
				rout_obj_free_args (rout_cargs)
				rout_cargs := null_ptr
			end

			operands := other.operands
			operands_set_by_user := other.operands_set_by_user
			closed_operands := other.closed_operands
			open_map := other.open_map
			closed_map := other.closed_map
			rout_disp := other.rout_disp
		ensure
			same_call_status: other.callable implies callable
		end

feature -- Access

	operands: detachable OPEN_ARGS
			-- Open operands.

	target: ANY
			-- Target of call.
		do
			if
				closed_map.count > 0 and then
				closed_map.item (closed_map.lower) = 0
			then
				Result ?= closed_operands.item (closed_operands.lower)
			elseif
				operands /= Void and then operands.count > 0
			then
				Result ?= operands.item (operands.lower)
			end
		end

	open_operand_type (i: INTEGER): INTEGER
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
					eif_gen_create ($Current, 2),
					i
)
				open_types.force (Result, i)
			end
		end

	hash_code: INTEGER
			-- Hash code value.
		do
			Result := rout_disp.hash_code
		end

	precondition (args: like operands): BOOLEAN
			-- Do `args' satisfy routine's precondition
			-- in current state?
		do
			Result := True
		end

	postcondition (args: like operands): BOOLEAN
			-- Does current state satisfy routine's
			-- postcondition for `args'?
		do
			Result := True
		end

feature -- Status report

	callable: BOOLEAN
			-- Can routine be called on current object?
		local
			null_ptr: POINTER
		do
			Result := (rout_disp /= null_ptr)
		end

	is_equal (other: like Current): BOOLEAN
			-- Is associated routine the same as the one
			-- associated with `other'.
		do
			--| Do not compare implementation data
			Result := equal (operands, other.operands)
							and then
					 equal (closed_operands, other.closed_operands)
							and then
					 equal (open_map, other.open_map)
							and then
					 equal (closed_map, other.closed_map)
							and then
					 (rout_disp = other.rout_disp)
		end

	valid_operands (args: detachable OPEN_ARGS): BOOLEAN
			-- Are `args' valid operands for this routine?
		local
			i: INTEGER
			mismatch: BOOLEAN
			arg: ANY
			arg_type_code: CHARACTER
			open_arg_type_code: CHARACTER
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
		do
			if args = Void or open_map = Void then
				-- Void operands are only allowed
				-- if object has no open operands.
				Result := (open_map = Void)
			elseif open_map /= Void and then eif_gen_count ($args) >= open_map.count then
				from
					create int
					i := 1
				until
					i > open_map.count or mismatch
				loop
					arg ?= args.item (i)
					arg_type_code := args.arg_item_code (i)
					open_arg_type_code := open_type_codes.item (i)
					if arg_type_code = eif_reference_code then				
						inspect	open_arg_type_code
						when eif_boolean_code then
							a_boolean_ref ?= arg
							mismatch := a_boolean_ref = Void
						when eif_character_code then
							a_character_ref ?= arg	
							mismatch := a_character_ref = Void
						when eif_double_code then
							a_double_ref ?= arg
							mismatch := a_double_ref = Void
						when eif_integer_64_code then
							an_integer_64_ref ?= arg
							an_integer_ref ?= arg
							an_integer_16_ref ?= arg
							an_integer_8_ref ?= arg
							mismatch := an_integer_64_ref = Void and then an_integer_ref = Void
								and then an_integer_16_ref = Void and then an_integer_8_ref = Void
						when eif_integer_code then
							an_integer_ref ?= arg
							an_integer_16_ref ?= arg
							an_integer_8_ref ?= arg
							mismatch := an_integer_ref = Void and then
								an_integer_16_ref = Void and then an_integer_8_ref = Void
						when eif_integer_16_code then
							an_integer_16_ref ?= arg
							an_integer_8_ref ?= arg
							mismatch := an_integer_16_ref = Void and then an_integer_8_ref = Void
						when eif_integer_8_code then
							an_integer_8_ref ?= arg
							mismatch := an_integer_8_ref = Void
						when eif_pointer_code then
							a_pointer_ref ?= arg
							mismatch := a_pointer_ref = Void
						when eif_real_code then
							a_real_ref ?= arg
							mismatch := a_real_ref = Void
						when eif_reference_code then
							if arg /= Void and then not eif_gen_conf (
								int.dynamic_type (arg),
								open_operand_type (i))
							then
								mismatch := True
							end
						end
					else
						if arg_type_code /= open_arg_type_code then
							inspect
								open_arg_type_code
							when eif_integer_64_code then
								mismatch := arg_type_code /= eif_integer_code and then
									arg_type_code /= eif_integer_16_code and then
									arg_type_code /= eif_integer_8_code
							when eif_integer_code then
								mismatch := arg_type_code /= eif_integer_16_code and then
									arg_type_code /= eif_integer_8_code
							when eif_integer_16_code then
								mismatch := arg_type_code /= eif_integer_8_code
							when eif_integer_8_code then
									-- As seen in above if statement, `arg_type_code' is not
									-- equal to `open_arg_type_code'.
								mismatch := True
							else
								mismatch := (open_arg_type_code = eif_reference_code implies
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

	open_count: INTEGER
			-- Number of open operands.
		do
			if open_map /= Void then
				Result := open_map.count
			end
		end

feature -- Element change

	set_operands (args: OPEN_ARGS)
			-- Use `args' as operands for next call.
		require
			valid_operands: valid_operands (args)
		do
			operands := args
			operands_set_by_user := True
		end

feature -- Duplication

	copy (other: like Current)
			-- Use same routine as `other'.
		local
			null_ptr: POINTER
		do
			-- Free own C argument structure
			if rout_cargs /= null_ptr then
				rout_obj_free_args (rout_cargs)
				rout_cargs := null_ptr
			end

			operands := other.operands
			operands_set_by_user := other.operands_set_by_user
			closed_operands := other.closed_operands
			open_map := other.open_map
			closed_map := other.closed_map
			rout_disp := other.rout_disp
		ensure then
			same_call_status: other.callable implies callable
		end


feature -- Basic operations

	call (args: OPEN_ARGS)
			-- Call routine with operands `args'.
		require
			valid_operands: valid_operands (args)
			callable: callable
		local
			o: detachable like operands
		do
			operands := args
			apply
			if not operands_set_by_user then
				operands := o
			end
		end

	apply
			-- Call routine with `operands' as last set.
		require
			valid_operands: valid_operands (operands)
			callable: callable
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
		ensure
			same_call_status: other.callable implies callable
		end


feature {ROUTINE} -- Implementation

	frozen operands_set_by_user: BOOLEAN
			-- Are operands set throug call to `set_operands'.
			-- If not, we can delete them after routine call for
			-- later collection.

	frozen closed_operands: TUPLE
			-- Closed arguments provided at creation time

	frozen open_map: ARRAY [INTEGER]
			-- Index map for open arguments

	frozen closed_map: ARRAY [INTEGER]
			-- Index map for closed arguments

	open_type_codes: STRING
			-- Type codes for open arguments
		do
			if internal_open_type_codes = Void then
				internal_open_type_codes := eif_gen_typecode_str ($Current)
			end
			Result := internal_open_type_codes
		end

	frozen open_types: ARRAY [INTEGER]
			-- Types of open operands

	closed_type_codes: STRING
			-- Type codes for closed arguments
		do
			if closed_operands /= Void and internal_closed_type_codes = Void then
				internal_closed_type_codes := eif_gen_tuple_typecode_str ($closed_operands)
			end
			Result := internal_closed_type_codes
		end

	frozen rout_disp: POINTER
			-- Routine dispatcher

	frozen eiffel_rout_disp: POINTER
			-- Eiffel routine dispatcher

	frozen set_rout_disp (a_rout_disp, a_encaps_rout_disp, a_calc_rout_addr: POINTER;
						  a_routine_id: INTEGER; a_open_map: like open_map;
						  a_is_basic, a_is_target_closed: BOOLEAN; a_written_type_id_inline_agent: INTEGER;
						  a_closed_operands: TUPLE; a_open_count: INTEGER)
			-- Initialize object.
		do
		end

	frozen set_rout_disp_final (a_rout_disp, a_encaps_rout_disp, a_calc_rout_addr: POINTER
						  		a_closed_operands: TUPLE; a_is_target_closed: BOOLEAN; a_open_count: INTEGER)
			-- Initialize object.
		do
		end

	frozen set_lazy_rout_disp (a_class_id, a_feature_id: INTEGER
							   a_is_precompiled, a_is_basic: BOOLEAN
							   a_args: TUPLE; a_omap: ARRAY [INTEGER])
		require
			a_class_id_valid: a_class_id > 0
			a_feature_id_valid: a_feature_id > 0
			args_not_void: a_args /= Void
		do
		end

	frozen set_rout_args (closed_args: TUPLE; 
						 omap, cmap: ARRAY [INTEGER])
			-- Initialize object. 
		require
			consistent_args: (closed_args = Void and cmap = Void)
										or else
							 (closed_args /= Void and cmap /= Void)
										and then
							 (closed_args.count >= cmap.count)
			valid_maps: not (omap = Void and cmap = Void)
		do
			closed_operands := closed_args
			open_map := omap
			closed_map := cmap
		end

feature {NONE} -- Implementation

	frozen internal_open_type_codes: STRING

	frozen internal_closed_type_codes: STRING

	dispose
			-- Free routine argument union structure
		local
			null_ptr: POINTER
		do
			if rout_cargs /= null_ptr then
				rout_obj_free_args (rout_cargs)
				rout_cargs := null_ptr
			end
		end


	frozen rout_cargs: POINTER
			-- Routine operands

	frozen rout_set_cargs
			-- Allocate and fill argument structure
		local
			new_args: POINTER
			i, j, ocnt, ccnt: INTEGER
			code: CHARACTER
			ref_arg: ANY
			null_ptr: POINTER
			was_on: BOOLEAN
			loc_open_map: like open_map
			loc_closed_map: like closed_map
			loc_operands: like operands
			loc_closed_operands: like closed_operands
			loc_open_type_codes: like open_type_codes
			loc_closed_type_codes: like closed_type_codes
		do
			-- We must disable the GC in this routine.
			was_on := collecting
			collection_off


			-- Compute no. operands, including target.

			loc_open_map := open_map
			if loc_open_map /= Void then
				ocnt := loc_open_map.count
				loc_open_type_codes := open_type_codes
				loc_operands := operands
			end

			loc_closed_map := closed_map
			if loc_closed_map /= Void then
				ccnt := loc_closed_map.count
				loc_closed_type_codes := closed_type_codes
				loc_closed_operands := closed_operands
			end

			-- Create C union structure if necessary

			if rout_cargs = null_ptr then
				new_args := rout_obj_new_args (ocnt + ccnt + 1)
				rout_cargs := new_args
			else
				new_args := rout_cargs
			end

			-- Put open operands in C structure

			from
				i := 1
			until
				i > ocnt
			loop
				code := loc_open_type_codes.item (i + 1) -- pos. 1 is code of BASE_TYPE!

				check loc_operands /= Void end
				if code = Eif_real_code then
					-- Special treatment of reals
					ref_arg := loc_operands.real_item (i)
				else
					ref_arg ?= loc_operands.item (i)
				end

				j := loc_open_map.item (i)

				inspect code
					when Eif_boolean_code then
						rout_obj_putb (new_args, j, $ref_arg)
					when Eif_character_code then
						rout_obj_putc (new_args, j, $ref_arg)
					when Eif_double_code then
						rout_obj_putd (new_args, j, $ref_arg)
					when Eif_integer_8_code then
						rout_obj_puti8 (new_args, j, $ref_arg)
					when Eif_integer_16_code then
						rout_obj_puti16 (new_args, j, $ref_arg)
					when Eif_integer_code then
						rout_obj_puti32 (new_args, j, $ref_arg)
					when Eif_integer_64_code then
						rout_obj_puti64 (new_args, j, $ref_arg)
					when Eif_pointer_code then
						rout_obj_putp (new_args, j, $ref_arg)
					when Eif_real_code then
						rout_obj_putf (new_args, j, $ref_arg)
					when Eif_wide_char_code then
						rout_obj_putwc (new_args, j, $ref_arg)
					else
						rout_obj_putr (new_args, j, $ref_arg)
				end

				i := i + 1
			end

			-- Put closed operands in C structure

			from
				i := 1
			until
				i > ccnt
			loop
				code := loc_closed_type_codes.item (i)

				check loc_closed_operands /= Void end
				if code = Eif_real_code then
					-- Special treatment of reals
					ref_arg := loc_closed_operands.real_item (i)
				else
					ref_arg ?= loc_closed_operands.item (i)
				end

				j := loc_closed_map.item (i)

				inspect code
					when Eif_boolean_code then
						rout_obj_putb (new_args, j, $ref_arg)
					when Eif_character_code then
						rout_obj_putc (new_args, j, $ref_arg)
					when Eif_double_code then
						rout_obj_putd (new_args, j, $ref_arg)
					when Eif_integer_8_code then
						rout_obj_puti8 (new_args, j, $ref_arg)
					when Eif_integer_16_code then
						rout_obj_puti16 (new_args, j, $ref_arg)
					when Eif_integer_code then
						rout_obj_puti32 (new_args, j, $ref_arg)
					when Eif_integer_64_code then
						rout_obj_puti64 (new_args, j, $ref_arg)
					when Eif_pointer_code then
						rout_obj_putp (new_args, j, $ref_arg)
					when Eif_real_code then
						rout_obj_putf (new_args, j, $ref_arg)
					when Eif_wide_char_code then
						rout_obj_putwc (new_args, j, $ref_arg)
					else
						rout_obj_putr (new_args, j, $ref_arg)
				end

				i := i + 1
			end


			-- Now we turn the GC on again if `was_on'
			if was_on then
				collection_on
			end
		rescue
			if was_on then
				collection_on
			end
		end

feature {NONE} -- Runtime constants

	eif_boolean_code: CHARACTER = 'b'
	eif_character_code: CHARACTER = 'c'
	eif_double_code: CHARACTER = 'd'
	eif_real_code: CHARACTER = 'f'
	eif_integer_code: CHARACTER = 'i'
	eif_pointer_code: CHARACTER = 'p'
	eif_reference_code: CHARACTER = 'r'
	eif_integer_8_code: CHARACTER = 'j'
	eif_integer_16_code: CHARACTER = 'k'
	eif_integer_64_code: CHARACTER = 'l'
	eif_wide_char_code: CHARACTER = 'u'
			-- Type constants used by runtime to recognize types
			-- needed to perform call

feature {NONE} -- Externals

	rout_obj_new_args (cnt: INTEGER): POINTER
			-- Initialize for new operands.
		external "C | %"eif_rout_obj.h%""
		end

	rout_obj_free_args (args: POINTER)
			-- Free `args'.
		external "C | %"eif_rout_obj.h%""
		end

	rout_obj_putb (args: POINTER; idx: INTEGER; val: POINTER)
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putwc (args: POINTER; idx: INTEGER; val: POINTER)
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putc (args: POINTER; idx: INTEGER; val: POINTER)
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putd (args: POINTER; idx: INTEGER; val: POINTER)
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_puti8 (args: POINTER; idx: INTEGER; val: POINTER)
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_puti16 (args: POINTER; idx: INTEGER; val: POINTER)
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_puti32 (args: POINTER; idx: INTEGER; val: POINTER)
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_puti64 (args: POINTER; idx: INTEGER; val: POINTER)
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putp (args: POINTER; idx: INTEGER; val: POINTER)
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putf (args: POINTER; idx: INTEGER; val: POINTER)
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putr (args: POINTER; idx: INTEGER; val: POINTER)
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	eif_gen_conf (type1, type2: INTEGER): BOOLEAN
			-- Does `type1' conform to `type2'?
		external "C (int16, int16): EIF_BOOLEAN | %"eif_gen_conf.h%""
		end

	eif_gen_create (obj: POINTER; pos: INTEGER): POINTER
			-- Adapt `args' for `idx' and `val'.
		external "C | %"eif_gen_conf.h%""
		end

	eif_gen_param_id (stype: INTEGER; obj: POINTER; pos: INTEGER): INTEGER
			-- Type of generic parameter in `obj' at position `pos'.
		external
			"C (int16, EIF_REFERENCE, int): EIF_INTEGER | %"eif_gen_conf.h%""
		end

	eif_gen_typecode (obj: POINTER; pos: INTEGER): CHARACTER
			-- Code for generic parameter `pos' in `obj'.
		external
			"C | %"eif_gen_conf.h%""
		end

	eif_gen_typecode_str (obj: POINTER): STRING
			-- Code name for generic parameter `pos' in `obj'.
		external "C | %"eif_gen_conf.h%""
		end

	eif_gen_tuple_typecode_str (obj: POINTER): STRING
			-- Code name for generic parameter `pos' in `obj'.
		external "C | %"eif_gen_conf.h%""
		end

	eif_gen_count (obj: POINTER): INTEGER
			-- Number of generic parameters of `obj'.
		external
			"C | %"eif_gen_conf.h%""
		end

feature -- Obsolete

	arguments: detachable OPEN_ARGS
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

note

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
--| Copyright (c) 1993-2006 University of Southern California and contributors.
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

