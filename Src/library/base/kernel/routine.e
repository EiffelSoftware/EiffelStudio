indexing
	description:
		"Objects representing delayed calls to a routine,%N%
		%with some operands possibly still open"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROUTINE [BASE_TYPE, OPEN_ARGS -> TUPLE]

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

	adapt (other: ROUTINE [ANY, OPEN_ARGS]) is
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
			closed_operands := other.closed_operands
			open_map := other.open_map
			closed_map := other.closed_map
			rout_disp := other.rout_disp
			open_type_codes := other.open_type_codes
			closed_type_codes := other.closed_type_codes
		ensure
			same_call_status: other.callable implies callable
		end

feature -- Access

	operands: OPEN_ARGS
			-- Open operands.

	target: ANY is
			-- Target of call.
		do
			Result := closed_operands.item (1)
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
					-1,
					eif_gen_create ($Current, 2),
					i
				)
				open_types.force (Result, i)
			end
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
			check
				not_implemented: False
			end
		end

	postcondition (args: like operands): BOOLEAN is
			-- Does current state satisfy routine's
			-- postcondition for `args'?
		do
			check
				not_implemented: False
			end
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

	valid_operands (args: OPEN_ARGS): BOOLEAN is
			-- Are `args' valid operands for this routine?
		local
			l_args: like operands
			i: INTEGER
			mismatch: BOOLEAN
			arg: ANY
			arg_type_code: CHARACTER
		do
			if args = Void or open_map = Void then
				-- Void operands are only allowed
				-- if object has no open operands.
				Result := (open_map = Void)
			elseif open_map /= Void and then args.count >= open_map.count then
				from
					i := 1
				until
					i > open_map.count or mismatch
				loop
					arg := args.item (i)
					arg_type_code := args.arg_item_code (i)
					if arg_type_code = 'r' then
						if arg /= Void and then not eif_gen_conf (
								ei_dtype ($arg),
								open_operand_type (i)
							)
						then
							mismatch := True
						end
					else
						if arg_type_code /= open_type_codes.item (i + 1) then
							mismatch := True
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
			Result := open_map.count
		end

feature -- Element change

	set_operands (args: OPEN_ARGS) is
			-- Use `args' as operands for next call.
		require
			valid_operands: valid_operands (args)
		do
			operands := args
		end

feature -- Duplication

	copy (other: like Current) is
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
			closed_operands := other.closed_operands
			open_map := other.open_map
			closed_map := other.closed_map
			rout_disp := other.rout_disp

			open_type_codes := other.open_type_codes
			closed_type_codes := other.closed_type_codes
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
			operands := args
			apply
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

	frozen closed_operands: TUPLE
			-- Closed operands provided at creation time

	frozen open_map: ARRAY [INTEGER]
			-- Index map for open operands

	frozen closed_map: ARRAY [INTEGER]
			-- Index map for closed operands

	frozen open_type_codes: STRING
			-- Type codes for open operands

	frozen open_types: ARRAY [INTEGER]
			-- Types of open operands

	frozen closed_type_codes: STRING
			-- Type codes for closed operands

	frozen rout_disp: POINTER
			-- Routine dispatcher

	frozen set_rout_disp (p: POINTER; closed_args: TUPLE; 
						  omap, cmap: ARRAY [INTEGER]) is
			-- Initialize object. 
		require
			consistent_args: (closed_args = Void and cmap = Void)
										or else
							 (closed_args /= Void and cmap /= Void)
										and then
							 (closed_args.count >= cmap.count)
			valid_maps: not (omap = Void and cmap = Void)
		local
			i, cnt: INTEGER
		do
			rout_disp := p
			closed_operands := closed_args
			open_map := omap
			closed_map := cmap

			-- Compute type codes
			open_type_codes := eif_gen_typecode_str ($Current)

			if closed_args /= Void then
				cnt := closed_args.count
				!!closed_type_codes.make (cnt)
				from
					i := 1
				until
					i > cnt
				loop
					closed_type_codes.extend (eif_gen_typecode ($closed_args,i))
					i := i + 1
				end
			end

				-- Special initialization for FUNCTION
			func_init
		end

feature {NONE}  -- Implementation

	dispose is
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

	frozen rout_set_cargs is
			-- Allocate and fill argument structure
		local
			new_args: POINTER
			i, j, cnt, ocnt, ccnt: INTEGER
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

			loc_open_map := open_map
			loc_closed_map := closed_map
			loc_operands := operands
			loc_closed_operands := closed_operands
			loc_open_type_codes := open_type_codes
			loc_closed_type_codes := closed_type_codes

			-- Compute no. operands, including target.

			if loc_open_map /= Void then
				ocnt := loc_open_map.count
			end

			if loc_closed_map /= Void then
				ccnt := loc_closed_map.count
			end

			-- Create C union structure if necessary

			if rout_cargs = null_ptr then
				new_args := rout_obj_new_args (ocnt + ccnt + 1)
			else
				new_args := rout_cargs
			end

			-- Put open operands in C structure

			from
				i := 1
			until
				i > ocnt
			loop
				code := loc_open_type_codes.item (i+1) -- pos. 1 is code of BASE_TYPE!

				if code = 'f' then
					-- Special treatment of reals
					ref_arg := loc_operands.real_item (i)
				else
					ref_arg := loc_operands.item (i)
				end

				j := loc_open_map.item (i)

				inspect code
					when 'b' then
						rout_obj_putb (new_args, j, $ref_arg)
					when 'c' then
						rout_obj_putc (new_args, j, $ref_arg)
					when 'd' then
						rout_obj_putd (new_args, j, $ref_arg)
					when 'i' then
						rout_obj_puti (new_args, j, $ref_arg)
					when 'p' then
						rout_obj_putp (new_args, j, $ref_arg)
					when 'f' then
						rout_obj_putf (new_args, j, $ref_arg)
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

				if code = 'f' then
					-- Special treatment of reals
					ref_arg := loc_closed_operands.real_item (i)
				else
					ref_arg := loc_closed_operands.item (i)
				end

				j := loc_closed_map.item (i)

				inspect code
					when 'b' then
						rout_obj_putb (new_args, j, $ref_arg)
					when 'c' then
						rout_obj_putc (new_args, j, $ref_arg)
					when 'd' then
						rout_obj_putd (new_args, j, $ref_arg)
					when 'i' then
						rout_obj_puti (new_args, j, $ref_arg)
					when 'p' then
						rout_obj_putp (new_args, j, $ref_arg)
					when 'f' then
						rout_obj_putf (new_args, j, $ref_arg)
					else
						rout_obj_putr (new_args, j, $ref_arg)
				end

				i := i + 1
			end
			rout_cargs := new_args

			-- Now we turn the GC on again if `was_on'
			if was_on then
				collection_on
			end
		rescue
			if was_on then
				collection_on
			end
		end

	func_init is
			-- Initialize routine.
		do
			-- Nothing here
		end

	rout_obj_new_args (cnt: INTEGER): POINTER is
			-- Initialize for new operands.
		external "C | %"eif_rout_obj.h%""
		end

	rout_obj_free_args (args: POINTER) is
			-- Free `args'.
		external "C | %"eif_rout_obj.h%""
		end

	rout_obj_putb (args: POINTER; idx: INTEGER; val: POINTER) is
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putc (args: POINTER; idx: INTEGER; val: POINTER) is
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putd (args: POINTER; idx: INTEGER; val: POINTER) is
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_puti (args: POINTER; idx: INTEGER; val: POINTER) is
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putp (args: POINTER; idx: INTEGER; val: POINTER) is
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putf (args: POINTER; idx: INTEGER; val: POINTER) is
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putr (args: POINTER; idx: INTEGER; val: POINTER) is
			-- Adapt `args' for `idx' and `val'.
		external "C[macro %"eif_rout_obj.h%"]"
		end

	ei_dtype (obj: POINTER): INTEGER is
			-- Dynamic type of `obj'.
		external "C | %"eif_gen_conf.h%""
		end

	eif_gen_conf (type1, type2: INTEGER): BOOLEAN is
			-- Does `type1' conform to `type2'?
		external "C | %"eif_gen_conf.h%""
		end

	eif_gen_create (obj: POINTER; pos: INTEGER): POINTER is
			-- Adapt `args' for `idx' and `val'.
		external "C | %"eif_gen_conf.h%""
		end

	eif_gen_param_id (stype: INTEGER; obj: POINTER; pos: INTEGER): INTEGER is
			-- Type of generic parameter in `obj' at position `pos'.
		external "C | %"eif_gen_conf.h%""
		end

	eif_gen_typecode (obj: POINTER; pos: INTEGER): CHARACTER is
			-- Code for generic parameter `pos' in `obj'.
		external
			"C | %"eif_gen_conf.h%""
		end

	eif_gen_typecode_str (obj: POINTER): STRING is
			-- Code name for generic parameter `pos' in `obj'.
		external "C | %"eif_gen_conf.h%""
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

end -- class ROUTINE

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
