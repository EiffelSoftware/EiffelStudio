indexing
	description: "Heirs are standrad value or a name.";
	date: "$Date$";
	revision: "$Revision$"

class OPT_VAL_SD

inherit
	AST_LACE

create
	make,
	make_yes,
	make_no,
	make_all,
	make_check,
	make_require,
	make_ensure,
	make_loop,
	make_invariant

feature {NONE} -- Initialization

	make (v: like value) is
			-- Create a new OPT_VAL AST node.
		require
			v_not_void: v /= Void
		do
			value := v
			internal_flags := Name_mask
		ensure
			value_set: value = v
			is_name_option: is_name
		end

	make_yes is
			-- Create a `yes' option.
		do
			value := yes_sd
			internal_flags := Yes_mask
		ensure
			is_yes_option: is_yes
		end
		
	make_no is
			-- Create a `no' option.
		do
			value := no_sd
			internal_flags := No_mask
		ensure
			is_no_option: is_no
		end

	make_all is
			-- Create a `all' option.
		do
			value := all_sd
			internal_flags := All_mask
		ensure
			is_all_option: is_all
		end
		
	make_check is
			-- Create a `check' option.
		do
			value := check_sd
			internal_flags := check_mask
		ensure
			is_check_option: is_check
		end
		
	make_require is
			-- Create a `require' option.
		do
			value := require_sd
			internal_flags := Require_mask
		ensure
			is_require_option: is_require
		end
		
	make_ensure is
			-- Create a `ensure' option.
		do
			value := ensure_sd
			internal_flags := Ensure_mask
		ensure
			is_ensure_option: is_ensure
		end
		
	make_loop is
			-- Create a `loop' option.
		do
			value := loop_sd
			internal_flags := Loop_mask
		ensure
			is_loop_option: is_loop
		end
		
	make_invariant is
			-- Create a `invariant' option.
		do
			value := invariant_sd
			internal_flags := Invariant_mask
		ensure
			is_invariant_option: is_invariant
		end
		
feature -- Properties

	value: ID_SD;

	is_yes: BOOLEAN is
			-- Is the option value `yes' ?
		do
			Result := internal_flags & Yes_mask = Yes_mask
		end;

	is_no: BOOLEAN is
			-- Is the option value `no' ?
		do
			Result := internal_flags & No_mask = No_mask
		end;

	is_all: BOOLEAN is
			-- Is the option value `all' ?
		do
			Result := internal_flags & All_mask = All_mask
		end;

	is_require: BOOLEAN is
			-- Is the option value `require' ?
		do
			Result := internal_flags & Require_mask = Require_mask
		end;

	is_ensure: BOOLEAN is
			-- Is the option value `ensure' ?
		do
			Result := internal_flags & Ensure_mask = Ensure_mask
		end;

	is_invariant: BOOLEAN is
			-- Is the option value `invariant' ?
		do
			Result := internal_flags & Invariant_mask = Invariant_mask
		end;

	is_loop: BOOLEAN is
			-- Is the option value `loop' ?
		do
			Result := internal_flags & Loop_mask = Loop_mask
		end;

	is_check: BOOLEAN is
			-- Is the option value `check' ?
		do
			Result := internal_flags & Check_mask = Check_mask
		end;

	is_name: BOOLEAN is
			-- is the option value a name value ?
		do
			Result := internal_flags & Name_mask = Name_mask
		end;

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		do
			if is_name then
				create Result.make (value.duplicate)
			else
				Result := clone (Current)
			end
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then value.same_as (other.value)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Append current in `st'.
		do
			st.putstring ("(")
			value.save (st)
			st.putstring (")")
		end

feature {NONE} -- Internal

	internal_flags: INTEGER
			-- Store status of Current.

	yes_mask: INTEGER is 1
	no_mask: INTEGER is 2
	require_mask: INTEGER is 4
	ensure_mask: INTEGER is 8
	check_mask: INTEGER is 16
	loop_mask: INTEGER is 32
	invariant_mask: INTEGER is 64
	name_mask: INTEGER is 128
	all_mask: INTEGER is 256
			-- Different mask.

	yes_sd: ID_SD is
			-- ID_SD instance for `yes' keyword.
		once
			create Result.initialize ("yes")
		end

	no_sd: ID_SD is
			-- ID_SD instance for `no' keyword.
		once
			create Result.initialize ("no")
		end

	all_sd: ID_SD is
			-- ID_SD instance for `all' keyword.
		once
			create Result.initialize ("all")
		end

	check_sd: ID_SD is
			-- ID_SD instance for `check' keyword.
		once
			create Result.initialize ("check")
		end

	require_sd: ID_SD is
			-- ID_SD instance for `require' keyword.
		once
			create Result.initialize ("require")
		end

	ensure_sd: ID_SD is
			-- ID_SD instance for `ensure' keyword.
		once
			create Result.initialize ("ensure")
		end

	loop_sd: ID_SD is
			-- ID_SD instance for `loop' keyword.
		once
			create Result.initialize ("loop")
		end

	invariant_sd: ID_SD is
			-- ID_SD instance for `invariant' keyword.
		once
			create Result.initialize ("invariant")
		end

end -- class OPT_VAL_SD
