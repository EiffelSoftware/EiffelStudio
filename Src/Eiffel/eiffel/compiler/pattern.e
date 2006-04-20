indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Pattern of a feature: it is constitued of the meta types of the
-- arguments and result.

class PATTERN

inherit

	SHARED_WORKBENCH
		redefine
			is_equal
		end;
	HASHABLE
		redefine
			is_equal
		end;

create

	make

feature

	result_type: TYPE_I;
			-- Meta type of the result

	argument_types: ARRAY [TYPE_I];
			-- Meta types of the arguments

	set_argument_types (a: like argument_types) is
			-- Assign `a' to `argument_types'.
		do
			argument_types := a;
		end;

	make (t: TYPE_I) is
			-- Creation of a pattern with a result meta type
		require
			good_argument: t /= Void;
		do
			result_type := t;
		end;

	argument_count: INTEGER is
			-- Number of arguments
		do
			if argument_types /= Void then
				Result := argument_types.count;
			end;
		end;

	is_valid: BOOLEAN is
			-- Is `Current' valid?
		local
			n, i: INTEGER;
		do
			Result := result_type.is_valid
			if Result then
				from
					i := 1
					n := argument_count
				until
					i > n or else not Result
				loop
					Result := argument_types.item (i).is_valid
					i := i + 1
				end
			end
		end

	is_equal (other: PATTERN): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			n, i: INTEGER;
		do
			n := argument_count;
			Result := n = other.argument_count and then
					type_deep_equal (result_type, other.result_type)
			from
				i := 1;
			until
				i > n or else not Result
			loop
				Result := type_deep_equal (argument_types.item (i),
										other.argument_types.item (i));
				i := i + 1;
			end;
		end;

	is_standalone: BOOLEAN is
			-- Is pattern described only in terms of standalone types,
			-- i.e. types that involve only class types without either
			-- anchored types or formal generics?
		local
			type: TYPE_I
			i: INTEGER
		do
			type := result_type
			Result := not type.has_formal and then not type.is_anchored
			if Result then
				from
					i := argument_count
				until
					i <= 0 or else not Result
				loop
					type := argument_types.item (i)
					Result := not type.has_formal and then not type.is_anchored
					i := i - 1
				end
			end
		end

	has_formal (class_a: CL_TYPE_A): BOOLEAN is
			-- Are there some formal generic parameters in the current
			-- pattern consirered relative to class type `class_a'?
		local
			i, nb: INTEGER;
		do
			Result := result_type.has_formal;
			if not Result then
				from
					i := 1;
					nb := argument_count
				until
					i > nb or else Result
				loop
					Result := argument_types.item (i).has_formal;
					i := i + 1;
				end;
			end;
		end;

	duplicate: like Current is
			-- Duplication
		do
			create Result.make (result_type);
			if argument_count > 0 then
				Result.set_argument_types (argument_types.twin);
			end;
		end;

	instantiation_in (gen_type: CLASS_TYPE): PATTERN is
			-- Instantiated pattern in the context of generical type
			-- `gen_type'.
		require
			gen_type_not_void: gen_type /= Void
			gen_type_is_standalone: not gen_type.type.is_anchored and not gen_type.type.has_formal
		local
			i, n: INTEGER;
			new_arguments: like argument_types;
			type: TYPE_I;
			argument_type: TYPE_I
		do
				-- New pattern is created only when it is different
				-- from the current one in `gen_type'.
			type := result_type.instantiation_in (gen_type)
			if type /= result_type then
				create Result.make (type)
			end
			n := argument_count;
			if n > 0 then
					-- Create `new_arguments' as soon as it is discovered
					-- that `Result' is different from `Current'.
				from
					i := 1
					if Result /= Void then
						create new_arguments.make (1, n)
					end
				until
					i > n
				loop
					argument_type := argument_types.item (i)
					type := argument_type.instantiation_in (gen_type)
					if type /= argument_type and then new_arguments = Void then
						new_arguments := argument_types.twin
					end
					if new_arguments /= Void then
						new_arguments.put (type, i)
					end
					i := i + 1
				end
				if new_arguments /= Void then
					if Result = Void then
						create Result.make (result_type)
					end
					Result.set_argument_types (new_arguments)
				end
			end
			if Result = Void then
				Result := Current
			end
		ensure
			result_not_void: Result /= Void
			result_is_standalone: Result.is_standalone
		end

	c_pattern: C_PATTERN is
			-- C pattern
		require
			is_standalone: is_standalone
		local
			new_arguments: ARRAY [TYPE_C];
			i, arg_count: INTEGER;
		do
			create Result.make (result_type.c_type);
			arg_count := argument_count;
			if arg_count > 0 then
				create new_arguments.make (1, arg_count);
				from
					i := 1;
				until
					i > arg_count
				loop
					new_arguments.put (argument_types.item (i).c_type, i);
					i := i + 1;
				end;
				Result.set_argument_types (new_arguments);
			end;
		end;

feature -- Hash code

	hash_code: INTEGER is
			-- Hash code for pattern
		local
			i, n: INTEGER
		do
			Result := result_type.hash_code
			n := argument_count
			if n > 0 then
				from
					i := 1
				until
					i > n
				loop
					Result := Result + (argument_types.item (i).hash_code |<< (i \\ 16))
					i := i + 1
				end
				Result := Result.abs
			end
		end

feature -- Debug

	trace is
			-- Debug purpose
		local
			i: INTEGER;
		do
			from
				i := 1;
			until
				i > argument_count
			loop
				argument_types.item (i).trace;
				io.error.put_character ('/');
				i := i + 1;
			end;
			io.error.put_character ('|');
			result_type.trace;
			io.error.put_string ("|");
		end;

feature {NONE} -- Implementation

	type_deep_equal (first_type, other_type: TYPE_I): BOOLEAN is
			-- Deep equal comparison wich does not compare the `cr_info� attribute
			-- declared in CL_TYPE_I and the `true_generics' attributes declared
			-- in GEN_TYPE_I.
		require
			first_type_not_void: first_type /= Void
			other_type_not_void: other_type /= Void
		local
			bit_i, other_bit_i: BIT_I
			cl_type_i, other_cl_type_i: CL_TYPE_I
			gen_type_i, other_gen_type_i: GEN_TYPE_I
		do
			if (first_type.same_type (other_type)) then
				cl_type_i ?= first_type
				if cl_type_i /= Void then
					bit_i ?= first_type
					if bit_i /= Void then
						other_bit_i ?= other_type
						Result := bit_i.size = other_bit_i.size
					else
						Result := True
					end

					other_cl_type_i ?= other_type
					Result := Result and then deep_equal (cl_type_i.class_id, other_cl_type_i.class_id)
					Result := Result and then (cl_type_i.is_expanded = other_cl_type_i.is_expanded)
					Result := Result and then (cl_type_i.is_separate = other_cl_type_i.is_separate)

					gen_type_i ?= first_type
					if gen_type_i /= Void then
						other_gen_type_i ?= other_type
						Result := Result and then deep_equal (gen_type_i.meta_generic, other_gen_type_i.meta_generic)
					end
				else
						-- There is no attributes to compare in the case of
						-- VOID_I, REFERENCE_I and NONE_I
						-- and only one attribute in case of FORMAL_I
					Result := deep_equal (first_type, other_type)
				end
			end
		end

invariant

	result_type_exists: result_type /= Void;

indexing
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

end
