indexing
	description: "Actual type for manifest array conformance."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class MULTI_TYPE_A 
	
inherit
	CL_TYPE_A
		rename
			make as class_make
		undefine
			copy, is_equal
		redefine
			is_multi_type, deep_actual_type, is_equivalent, same_as,
			dump, ext_append_to, conform_to, type_i,
			create_info, instantiation_of, generics
		end

	ARRAY [TYPE_A]
		rename
			make as array_make
		end

create {COMPILER_EXPORTER}
	make
	
feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Initialization
		require
			valid_n: n >= 0
		do
			class_make (System.array_id)
			array_make (1, n)
		end

feature -- Property

	last_type: GEN_TYPE_A
			-- Last type conforming to Current

	generics: ARRAY [TYPE_A] is
			-- Actual generic types
		do
			Result := last_type.generics
		end

	is_multi_type: BOOLEAN is True
			-- We are handling a manifest array.

feature {ARRAY_AS, MULTI_TYPE_A}

	set_last_type (t: like last_type) is
		require
			t_not_void: t /= Void
		do
			last_type := t
		ensure
			last_type_set: last_type = t
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		local
			i, nb: INTEGER
		do
			Result := Precursor {CL_TYPE_A} (other)
			nb := other.count
			if Result and count = nb then
				from
					i := 1
				until
					not Result or else i > nb
				loop
					Result := equivalent (item (i), other.item (i))
					i := i + 1
				end
			end
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			l_multi_type: like Current
			other_gen_type: GEN_TYPE_A
			i, nb: INTEGER
		do
			l_multi_type ?= other
			if l_multi_type /= Void then
				Result := Precursor {CL_TYPE_A} (l_multi_type)
				nb := count
				if Result and nb = l_multi_type.count then
					from
						i := 1
					until
						not Result or else i > nb
					loop
						Result := item (i).same_as (l_multi_type.item (i))
						i := i + 1
					end
				end
			else
				other_gen_type ?= other
				if
					other_gen_type /= Void
					and then other_gen_type.class_id = class_id
					and then is_expanded = other_gen_type.is_expanded
					and then other_gen_type.generics.count = 1
				then
					Result := last_type.generics.item (1).same_as (other_gen_type.generics.item (1))
				end
			end
		end

feature -- Output

	dump: STRING is
			-- Dump trace
		local
			i: INTEGER
		do
			create Result.make (10 * count)
			Result.append ("<<")
			from
				i := 1
			until
				i > count
			loop
				Result.append (item (i).dump)
				if i /= count then
					Result.append (", ")
				end
				i := i + 1
			end
			Result.append (">>")
		end

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		local
			i: INTEGER
		do
			st.add (ti_l_array)
			from
				i := 1
			until
				i > count
			loop
				item (i).ext_append_to (st, f)
				if i /= count then
					st.add (ti_comma)
					st.add_space
				end
				i := i + 1
			end
			st.add (ti_r_array)
		end

feature {COMPILER_EXPORTER}

	instantiation_of (type: TYPE_AS; a_class_id: INTEGER): TYPE_A is
			-- Instantiation of type `type' written in class of id `a_class_id'
			-- in the context of Current
		do
			check
				last_type_not_void: last_type /= Void
			end
			Result := last_type.instantiation_of (type, a_class_id)
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
			-- The rule is the following:
			-- <<e1,...,en>> conforms to A means that:
			-- if A is an ARRAY of T type, every element type of current conforms
			-- to T.
			-- Otherwise, computed type of Current conforms to A.
		local
			gen_type: GEN_TYPE_A
			generic_param, type_a: TYPE_A
			i, nb: INTEGER
		do
			nb := count
			gen_type ?= other
			if
				gen_type /= Void and then
				gen_type.class_id = System.array_id
			then
				generic_param := gen_type.generics.item (1).actual_type
				Result := True
				if nb > 0 then
					from
						i := 1
					until
						(i > count) or else (not Result)
					loop
						type_a := item (i)
						Result := type_a.conform_to (generic_param) or else
							type_a.convert_to (context.current_class, generic_param)
						i := i + 1
					end
				end
				if Result then
						-- Update the actual generic parameter to match the target type.
					last_type.generics.put (generic_param, 1)
				end
			else
				check
					last_type_not_void: last_type /= Void
				end
				Result := last_type.conform_to (other)
			end
		end

	deep_actual_type : MULTI_TYPE_A is

		local
			i: INTEGER
			type_a: TYPE_A
		do
			from
				i := 1
				create Result.make (count)
			until
				i > count
			loop
				type_a := item (i)
				Result.put (type_a.deep_actual_type, i)
				i := i + 1
			end
			check
				last_type_not_void: last_type /= Void
			end
			Result.set_last_type (last_type.deep_actual_type)
		end

	type_i: GEN_TYPE_I is
			-- Compiled type
		do
				-- FIXME: Manu 11/1/2001: why this sentence?
				-- We must resolve anchors here!
			check
				last_type_not_void: last_type /= Void
			end
			Result := last_type.deep_actual_type.type_i
		end

	create_info: CREATE_TYPE is
			-- Creation information
		do
			check
				False
			end
		end

invariant
	last_type_valid: last_type /= Void implies (last_type.generics /= Void and then last_type.generics.count = 1)
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class MULTI_TYPE_A
