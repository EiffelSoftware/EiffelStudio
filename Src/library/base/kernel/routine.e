deferred class ROUTINE [T_T -> ANY, A_T -> TUPLE]

inherit
	MEMORY
		redefine
			dispose, is_equal, copy
		end

feature -- Calls

	call (tgt : T_T; args : A_T) is
			-- Call routine on target `tgt' with arguments `args'.
		require
			target_exists: tgt /= Void
			valid_arguments: valid_arguments (args)
			callable: callable
		do
			target := tgt
			rout_set_arguments (args)
			apply
		end

	apply is
			-- Call routine on `target' with `arguments'.
		require
			target_exists : target /= Void
			callable: callable
		deferred
		end

	apply_to (tgt : T_T) is
			-- Call routine on `tgt' with `arguments'.
		require
			target_exists : tgt /= Void
			callable: callable
		do
			target := tgt
			rout_set_cargs
			apply
		end

feature -- Target / arguments

	target : ANY
			-- Current target

	set_target (tgt : T_T) is
			-- Set `target' to `tgt'.
		require
			valid_target : tgt /= Void
		do
			target := tgt
			rout_set_cargs
		ensure
			target_set : equal (target, tgt)
		end

	arguments : TUPLE
			-- Current arguments

	set_arguments (args : A_T) is
			-- Set `arguments' from `args'.
		require
			valid_arguments: valid_arguments (args)
		do
			rout_set_arguments (args)
		end

feature -- Call target

	call_target : ANY is
			-- True target of the call.
		local
			modulus, idx : INTEGER
		do
			modulus := arguments.count + 1
			idx := (modulus-tilde_count) \\ modulus

			if idx = 0 then
				Result := target
			else
				Result := arguments.item (idx)
			end
		end

	set_call_target (call_tgt : ANY) is
			-- Set the true target of the call to `call_tgt'
		require
			call_target_exists : call_tgt /= Void
		local
			modulus, idx : INTEGER
		do
			modulus := arguments.count + 1
			idx := (modulus-tilde_count) \\ modulus

			if idx = 0 then
				target := call_tgt
			else
				arguments.put (call_tgt, idx)
			end
		ensure
			call_target_set : equal (call_target, call_tgt)
		end

feature -- Queries

	valid_arguments (args : A_T) : BOOLEAN is
			-- Are `args' valid arguments for this routine?
		do
			if args = Void then
				Result := (arguments.count = 0)
			else
				Result := args.conforms_to (arguments)
			end
		end

	callable : BOOLEAN is
			-- Can a routine call through Current be made?
		local
			null_ptr : POINTER
		do
			Result := (rout_disp /= null_ptr)
		end

	is_equal (other : like Current) : BOOLEAN is

		do
			-- Do not compare C argument union structure
			Result := equal (target, other.target)
							and then
					  equal (arguments, other.arguments)
							and then
					  (rout_disp = other.rout_disp)
							and then
					  (tilde_count = other.tilde_count)
		end

feature -- Duplication

	copy (other : like Current) is

		local
			null_ptr : POINTER
		do
			-- Free own C argument structure
			if rout_cargs /= null_ptr then
				rout_obj_free_args (rout_cargs)
				rout_cargs := null_ptr
			end

			target := other.target
			tilde_count := other.tilde_count
			type_codes := other.type_codes
			rout_set_arguments (other.arguments)
			rout_disp := other.rout_disp
		end

feature -- Adaptation

	adapt_from (other : ROUTINE [T_T, A_T]) is
			-- Adapt Current from `other'. Useful
			-- in descendants.
		require
			other_exists : other /= Void
			conforming: conforms_to (other)
		local
			null_ptr : POINTER
		do
			-- Free own C argument structure
			if rout_cargs /= null_ptr then
				rout_obj_free_args (rout_cargs)
				rout_cargs := null_ptr
			end

			target := other.target
			tilde_count := other.tilde_count
			type_codes := other.type_codes
			rout_set_arguments (other.arguments)
			rout_disp := other.rout_disp
		end

feature {NONE} -- Garbage collection

	dispose is
			-- Free routine argument union structure
		local
			null_ptr : POINTER
		do
			if rout_cargs /= null_ptr then
				rout_obj_free_args (rout_cargs)
				rout_cargs := null_ptr
			end
		end

feature {NONE} -- Implementation

	-- WARNING:
	-- Modifying or using one of the following
	-- features may give unpredictable results.

	frozen rout_set_arguments (args : TUPLE) is
			-- Set `arguments' from `args'.
		local
			cur_args : TUPLE
			i, cnt : INTEGER
		do
			cur_args := arguments

			from
				cnt := cur_args.count
				i := 1
			until
				i > cnt
			loop
				cur_args.put (args.item (i), i)
				i := i + 1
			end

			rout_set_cargs
		end

	frozen rout_set_cargs is
			-- Allocate and fill argument structure
		local
			new_args : POINTER
			i, j, cnt : INTEGER
			modulus, tcnt: INTEGER
			code : CHARACTER
			cargs : like arguments
			ref_arg : ANY
			null_ptr : POINTER
		do
			cargs := arguments
			cnt := cargs.count
			modulus := cnt + 1
			tcnt := tilde_count

			-- Create C union structure if necessary

			if rout_cargs /= null_ptr then
				new_args := rout_cargs
			else
				new_args := rout_obj_new_args (cnt + 1)
			end

			from
				i := 0
			until
				i > cnt
			loop
				code := type_codes.item (i+1)

				if i = 0 then
					ref_arg := target
				else
					if code = 'f' then
						-- Special treatment of reals
						ref_arg := cargs.real_item (i)
					else
						ref_arg := cargs.item (i)
					end
				end

				j := (i+tcnt) \\ modulus

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
		end

feature {ROUTINE} -- Feature dispatch address

	frozen rout_disp : POINTER
			-- Routine dispatcher
			-- WARNING: Never use this feature!

	frozen set_rout_disp (p : POINTER; tgt : ANY; args : TUPLE; tcnt : INTEGER) is
			-- Set `rout_disp' to `p'.
			-- WARNING: Never call this feature! 
		local
			i, j, count, modulus, tpos : INTEGER
		do
			-- Set routine dispatch pointer (->ececil)
			rout_disp := p

			-- Set tilde count
			tilde_count := tcnt

			-- Create argument tuple
			-- Same type as second generic parameter of Current
			arguments := eif_gen_create ($Current, 2)
			arguments.make

			-- Compute call target position
			count := arguments.count
			modulus := count + 1

			tpos := (modulus - tcnt) \\ modulus

			if tpos < 0 then
				tpos := tpos + modulus
			end

			-- Fill argument list. Set target.

			if args /= Void then
				from
					i := 1
				until
					i > count
				loop
					j := (i-tcnt) \\ modulus

					if j < 0 then
						j := j + modulus
					end

					if j = 0 then
						-- This becomes the target
						target := args.item (i)
					else
						arguments.put (args.item (i), j)
					end
					i := i + 1
				end
			end

			if tpos = 0 then
				target := tgt
			else
				arguments.put (tgt, tpos)
			end

			-- Compute type codes
			type_codes := eif_gen_typecode_str ($Current)

			-- Setup C argument union
			rout_set_cargs
		end

feature {NONE}  -- Routine C argument structure

	frozen rout_cargs : POINTER

feature {ROUTINE}  -- target and argument type codes

	frozen type_codes : STRING

feature {ROUTINE} -- Nr. of tildes

	frozen tilde_count : INTEGER
		-- Nr. of tildes - 1 used in creation of Current

feature {NONE}

	rout_obj_new_args (cnt : INTEGER) : POINTER is

		external "C | %"eif_rout_obj.h%""
		end

	rout_obj_free_args (args : POINTER) is

		external "C | %"eif_rout_obj.h%""
		end

	rout_obj_putb (args : POINTER; idx : INTEGER; val : POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putc (args : POINTER; idx : INTEGER; val : POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putd (args : POINTER; idx : INTEGER; val : POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_puti (args : POINTER; idx : INTEGER; val : POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putp (args : POINTER; idx : INTEGER; val : POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putf (args : POINTER; idx : INTEGER; val : POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	rout_obj_putr (args : POINTER; idx : INTEGER; val : POINTER) is

		external "C[macro %"eif_rout_obj.h%"]"
		end

	eif_gen_create (obj : POINTER; pos : INTEGER) : TUPLE is

		external "C | %"eif_gen_conf.h%""
		end

	eif_gen_typecode_str (obj : POINTER) : STRING is

		external "C | %"eif_gen_conf.h%""
		end

end -- class ROUTINE

