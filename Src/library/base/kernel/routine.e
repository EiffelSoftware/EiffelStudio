indexing
	description: "";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class ROUTINE [TBASE, TOPEN -> TUPLE]

inherit
	MEMORY
		redefine
			dispose, is_equal, copy
		end

feature -- Calls

	call (args: TOPEN) is
			-- Call routine with arguments `args'.
		require
			valid_arguments: valid_arguments (args)
			callable: callable
		do
			arguments := args
			apply
		end

	apply is
			-- Call routine with arguments `arguments'.
		require
			valid_arguments: valid_arguments (arguments)
			callable: callable
		deferred
		end

feature -- Arguments

	arguments: TOPEN
			-- Open arguments

	set_arguments (args: TOPEN) is
			-- Set `arguments' from `args'.
		require
			valid_arguments: valid_arguments (args)
		do
			arguments := args
		end

feature -- Queries

	valid_arguments (args: TOPEN): BOOLEAN is
			-- Are `args' valid arguments for this routine?
		local
			l_args: like arguments
		do
			if args = Void then
				-- Void arguments are only allowed
				-- if object has no open arguments.
				Result := (open_map = Void)
			else
				-- FIXME
				Result := True
--                l_args ?= args
--                Result := (largs /= Void)
			end
		end

	callable: BOOLEAN is
			-- Can a routine call through Current be made?
		local
			null_ptr: POINTER
		do
			Result := (rout_disp /= null_ptr)
		end

	is_equal (other: like Current): BOOLEAN is

		do
			-- Do not compare implementation data
			Result := equal (arguments, other.arguments)
							and then
					  equal (closed_arguments, other.closed_arguments)
							and then
					  equal (open_map, other.open_map)
							and then
					  equal (closed_map, other.closed_map)
							and then
					  (rout_disp = other.rout_disp)
		end

feature -- Duplication

	copy (other: like Current) is

		local
			null_ptr: POINTER
		do
			-- Free own C argument structure
			if rout_cargs /= null_ptr then
				rout_obj_free_args (rout_cargs)
				rout_cargs := null_ptr
			end

			arguments := other.arguments
			closed_arguments := other.closed_arguments
			open_map := other.open_map
			closed_map := other.closed_map
			rout_disp := other.rout_disp

			open_type_codes := other.open_type_codes
			closed_type_codes := other.closed_type_codes
		ensure then
			same_call_status: other.callable implies callable
		end

feature -- Adaptation

	adapt_from (other: ROUTINE [TBASE, TOPEN]) is
			-- Adapt Current from `other'. Useful
			-- in descendants.
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

			arguments := other.arguments
			closed_arguments := other.closed_arguments
			open_map := other.open_map
			closed_map := other.closed_map
			rout_disp := other.rout_disp

			open_type_codes := other.open_type_codes
			closed_type_codes := other.closed_type_codes
		ensure
			same_call_status: other.callable implies callable
		end

feature {NONE} -- Garbage collection

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

feature {ROUTINE} -- Implementation

	frozen closed_arguments: TUPLE
			-- Closed arguments provided at creation time

	frozen open_map: ARRAY [INTEGER]
			-- Index map for open arguments

	frozen closed_map: ARRAY [INTEGER]
			-- Index map for closed arguments

	frozen open_type_codes: STRING
			-- Type codes for open arguments

	frozen closed_type_codes: STRING
			-- Type codes for closed arguments

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
			closed_arguments := closed_args
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

feature {NONE}  -- Routine C argument structure

	frozen rout_cargs: POINTER

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
			loc_arguments: like arguments
			loc_closed_arguments: like closed_arguments
			loc_open_type_codes: like open_type_codes
			loc_closed_type_codes: like closed_type_codes
		do
			-- We must disable the GC in this routine.
			was_on := collecting
			collection_off

			loc_open_map := open_map
			loc_closed_map := closed_map
			loc_arguments := arguments
			loc_closed_arguments := closed_arguments
			loc_open_type_codes := open_type_codes
			loc_closed_type_codes := closed_type_codes

			-- Compute no. arguments, including target.

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

			-- Put open arguments in C structure

			from
				i := 1
			until
				i > ocnt
			loop
				code := loc_open_type_codes.item (i+1) -- pos. 1 is code of TBASE!

				if code = 'f' then
					-- Special treatment of reals
					ref_arg := loc_arguments.real_item (i)
				else
					ref_arg := loc_arguments.item (i)
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

			-- Put closed arguments in C structure

			from
				i := 1
			until
				i > ccnt
			loop
				code := loc_closed_type_codes.item (i)

				if code = 'f' then
					-- Special treatment of reals
					ref_arg := loc_closed_arguments.real_item (i)
				else
					ref_arg := loc_closed_arguments.item (i)
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

feature {NONE}  -- Function initialization

	func_init is

		do
			-- Nothing
		end

feature {NONE}  -- Run-time

	rout_obj_new_args (cnt: INTEGER): POINTER is

		external "C | %"eif_rout_obj.h%""
		end

	rout_obj_free_args (args: POINTER) is

		external "C | %"eif_rout_obj.h%""
		end

	rout_obj_putb (args: POINTER; idx: INTEGER; val: POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putc (args: POINTER; idx: INTEGER; val: POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putd (args: POINTER; idx: INTEGER; val: POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_puti (args: POINTER; idx: INTEGER; val: POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putp (args: POINTER; idx: INTEGER; val: POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putf (args: POINTER; idx: INTEGER; val: POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putr (args: POINTER; idx: INTEGER; val: POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	eif_gen_create (obj: POINTER; pos: INTEGER): TUPLE is

		external "C | %"eif_gen_conf.h%""
		end

	eif_gen_typecode (obj: POINTER; pos: INTEGER): CHARACTER is
			-- Code for generic parameter `pos' in `obj'.
		external
			"C | %"eif_gen_conf.h%""
		end

	eif_gen_typecode_str (obj: POINTER): STRING is

		external "C | %"eif_gen_conf.h%""
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
