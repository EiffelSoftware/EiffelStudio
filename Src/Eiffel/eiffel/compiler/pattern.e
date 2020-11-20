note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Pattern of a feature: it is constitued of the meta types of the
-- arguments and result.

frozen class PATTERN

inherit

	SHARED_WORKBENCH
		redefine
			is_equal
		end;
	HASHABLE
		redefine
			is_equal
		end;

	COMPILER_EXPORTER
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_result_type: TYPE_A; a_argument_types: like argument_types)
			-- Set pattern to represent Result `a_result_type' with arguments `a_argument_types' (if any).
		require
			valid_result_type: a_result_type /= Void
			valid_arguments: a_argument_types = Void or else a_argument_types.count > 0
		do
			result_type := a_result_type
			argument_types := a_argument_types
		end

feature {PATTERN, PATTERN_TABLE} -- Initialization

	update (a_result_type: TYPE_A; a_argument_types: like argument_types)
			-- Set pattern to represent Result `a_result_type' with arguments `a_argument_types' (if any).
		require
			valid_result_type: a_result_type /= Void
			valid_arguments: a_argument_types = Void or else a_argument_types.count > 0
		do
			result_type := a_result_type
			argument_types := a_argument_types
		end

feature -- Duplication

	duplicate: PATTERN
			-- Duplicate of `Current' to avoid aliasing.
		do
			create Result.make (result_type, if attached argument_types as a then a.twin else Void end)
		end

feature -- Access

	result_type: TYPE_A;
			-- Meta type of the result

	argument_types: SPECIAL [TYPE_A];
			-- Meta types of the arguments

	argument_count: INTEGER
			-- Number of arguments
		do
			if argument_types /= Void then
				Result := argument_types.count;
			end;
		end;

	is_valid (a_class: CLASS_C): BOOLEAN
			-- Is `Current' valid for `a_class'?
		local
			n, i: INTEGER;
		do
			Result := result_type.is_valid_for_class (a_class)
			if Result then
				from
					i := 0
					n := argument_count
				until
					i = n or else not Result
				loop
					Result := argument_types [i].is_valid_for_class (a_class)
					i := i + 1
				end
			end
		end

	is_equal (other: PATTERN): BOOLEAN
			-- Is `other' equal to Current ?
		local
			n, i: INTEGER
		do
			Result := other = Current
			if not Result then
				n := argument_count
					-- Note: We used to perform a deep equality here, now we simply `same_as'.
				from
					Result := n = other.argument_count and then result_type.same_as (other.result_type)
					i := 0
				until
					i = n or else not Result
				loop
					Result := argument_types [i].same_as (other.argument_types [i])
					i := i + 1
				end
			end
		end

	update_c_pattern_with_instantiation_in (a_c_pattern: C_PATTERN; gen_type: CLASS_TYPE)
			-- Update `a_c_pattern' from instantiation of `Current' in the context of `gen_type'.
		require
			valid_c_pattern: a_c_pattern /= Void
			valid_gen_type: gen_type /= Void
		local
			i, n: INTEGER;
			l_arg_types: like argument_types
			new_arguments: SPECIAL [TYPE_C];
		do
			n := argument_count;
			if n > 0 then
				l_arg_types := argument_types
				new_arguments := a_c_pattern.argument_types
				if new_arguments = Void then
					create new_arguments.make_empty (n)
				else
					new_arguments.keep_head (0)
					if new_arguments.capacity < n then
						new_arguments := new_arguments.aliased_resized_area (n)
					end
				end
				from
					i := 0
				until
					i = n
				loop
					new_arguments.extend (l_arg_types [i].adapted_in (gen_type).c_type)
					i := i + 1
				end
			end
				-- Update `a_c_pattern' with the instantiated result and argument C types.
			a_c_pattern.update (result_type.adapted_in (gen_type).c_type, new_arguments)
		end

	c_pattern: C_PATTERN
			-- C pattern
		local
			new_arguments: SPECIAL [TYPE_C];
			i, arg_count: INTEGER;
		do
			arg_count := argument_count;
			if arg_count > 0 then
				create new_arguments.make_empty (arg_count)
				from
					i := 0
				until
					i = arg_count
				loop
					new_arguments.extend (argument_types.item (i).c_type)
					i := i + 1;
				end;
			end;
			create Result.make (result_type.c_type, new_arguments);
		end;

feature -- Hash code

	hash_code: INTEGER
			-- Hash code for pattern
		local
			i, n: INTEGER
			l_rotate: INTEGER
			l_bytes: INTEGER
		do
			Result := result_type.hash_code
			n := argument_count
			if n > 0 then
				from
					i := 0
				until
					i = n
				loop
						-- Perform a rotation of the hash_code value every 4 bytes.
					l_rotate := argument_types.item (i).hash_code
					l_bytes := 4 * ((i + 1) \\ 8)
					l_rotate := (l_rotate |<< l_bytes) | (l_rotate |>> (32 - l_bytes))
					Result := Result.bit_xor (l_rotate)
					i := i + 1
				end
					-- To prevent negative values.				
				Result := Result.hash_code
			end
		end

invariant

	result_type_exists: result_type /= Void;

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
