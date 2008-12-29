note
	description: "Heirs are standrad value or a name."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

	make (v: like value)
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

	make_yes
			-- Create a `yes' option.
		do
			value := yes_sd
			internal_flags := Yes_mask
		ensure
			is_yes_option: is_yes
		end

	make_no
			-- Create a `no' option.
		do
			value := no_sd
			internal_flags := No_mask
		ensure
			is_no_option: is_no
		end

	make_all
			-- Create a `all' option.
		do
			value := all_sd
			internal_flags := All_mask
		ensure
			is_all_option: is_all
		end

	make_check
			-- Create a `check' option.
		do
			value := check_sd
			internal_flags := check_mask
		ensure
			is_check_option: is_check
		end

	make_require
			-- Create a `require' option.
		do
			value := require_sd
			internal_flags := Require_mask
		ensure
			is_require_option: is_require
		end

	make_ensure
			-- Create a `ensure' option.
		do
			value := ensure_sd
			internal_flags := Ensure_mask
		ensure
			is_ensure_option: is_ensure
		end

	make_loop
			-- Create a `loop' option.
		do
			value := loop_sd
			internal_flags := Loop_mask
		ensure
			is_loop_option: is_loop
		end

	make_invariant
			-- Create a `invariant' option.
		do
			value := invariant_sd
			internal_flags := Invariant_mask
		ensure
			is_invariant_option: is_invariant
		end

feature -- Properties

	value: ID_SD;

	is_yes: BOOLEAN
			-- Is the option value `yes' ?
		do
			Result := internal_flags & Yes_mask = Yes_mask
		end;

	is_no: BOOLEAN
			-- Is the option value `no' ?
		do
			Result := internal_flags & No_mask = No_mask
		end;

	is_all: BOOLEAN
			-- Is the option value `all' ?
		do
			Result := internal_flags & All_mask = All_mask
		end;

	is_require: BOOLEAN
			-- Is the option value `require' ?
		do
			Result := internal_flags & Require_mask = Require_mask
		end;

	is_ensure: BOOLEAN
			-- Is the option value `ensure' ?
		do
			Result := internal_flags & Ensure_mask = Ensure_mask
		end;

	is_invariant: BOOLEAN
			-- Is the option value `invariant' ?
		do
			Result := internal_flags & Invariant_mask = Invariant_mask
		end;

	is_loop: BOOLEAN
			-- Is the option value `loop' ?
		do
			Result := internal_flags & Loop_mask = Loop_mask
		end;

	is_check: BOOLEAN
			-- Is the option value `check' ?
		do
			Result := internal_flags & Check_mask = Check_mask
		end;

	is_name: BOOLEAN
			-- is the option value a name value ?
		do
			Result := internal_flags & Name_mask = Name_mask
		end;

feature {NONE} -- Internal

	internal_flags: INTEGER
			-- Store status of Current.

	yes_mask: INTEGER = 1
	no_mask: INTEGER = 2
	require_mask: INTEGER = 4
	ensure_mask: INTEGER = 8
	check_mask: INTEGER = 16
	loop_mask: INTEGER = 32
	invariant_mask: INTEGER = 64
	name_mask: INTEGER = 128
	all_mask: INTEGER = 256
			-- Different mask.

	yes_sd: ID_SD
			-- ID_SD instance for `yes' keyword.
		once
			create Result.initialize ("yes")
		end

	no_sd: ID_SD
			-- ID_SD instance for `no' keyword.
		once
			create Result.initialize ("no")
		end

	all_sd: ID_SD
			-- ID_SD instance for `all' keyword.
		once
			create Result.initialize ("all")
		end

	check_sd: ID_SD
			-- ID_SD instance for `check' keyword.
		once
			create Result.initialize ("check")
		end

	require_sd: ID_SD
			-- ID_SD instance for `require' keyword.
		once
			create Result.initialize ("require")
		end

	ensure_sd: ID_SD
			-- ID_SD instance for `ensure' keyword.
		once
			create Result.initialize ("ensure")
		end

	loop_sd: ID_SD
			-- ID_SD instance for `loop' keyword.
		once
			create Result.initialize ("loop")
		end

	invariant_sd: ID_SD
			-- ID_SD instance for `invariant' keyword.
		once
			create Result.initialize ("invariant")
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class OPT_VAL_SD
