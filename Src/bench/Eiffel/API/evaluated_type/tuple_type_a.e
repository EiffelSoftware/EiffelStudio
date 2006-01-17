indexing
	description: "Description of a TUPLE type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_TYPE_A

inherit
	GEN_TYPE_A
		redefine
			good_generics, error_generics, check_constraints,
			is_tuple, conform_to, type_i
		end

create
	make

feature -- Properties

	is_tuple: BOOLEAN is True

feature {COMPILER_EXPORTER} -- Primitives

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
		local
			tuple_type: TUPLE_TYPE_A
			i, count, other_count: INTEGER
			other_generics: ARRAY [TYPE_A]
		do
			tuple_type ?= other

			if tuple_type /= Void then
					-- Conformance TUPLE -> TUPLE
				other_generics := tuple_type.generics
				from
					i := 1
					count := generics.count
					other_count := other_generics.count
					Result := (count >= other_count)
				until
					(i > other_count) or else (not Result)
				loop
					Result := generics.item (i).conform_to (
						other_generics.item (i))
					i := i + 1
				end
			else
					-- Conformance TUPLE -> other classtypes
				Result := Precursor {GEN_TYPE_A} (other)
			end
		end

	type_i: TUPLE_TYPE_I is
			-- Meta generic interpretation of the generic type
			-- Same definition as in GEN_TYPE_A except return type
			-- which is TUPLE_TYPE_I.
		local
			i, count: INTEGER
			meta_generic: META_GENERIC
			true_generics: ARRAY [TYPE_I]
			gt:TYPE_A
		do
			from
				i := 1
				count := generics.count
				create meta_generic.make (count)
				create true_generics.make (1, count)
			until
				i > count
			loop
				gt := generics.item (i)
				meta_generic.put (gt.meta_type, i)
				true_generics.put (gt.type_i, i)
				i := i + 1
			end

			create Result.make (class_id, meta_generic, true_generics)
			Result.set_mark (declaration_mark)
		end

	good_generics: BOOLEAN is

		local
			i, count: INTEGER
		do
			-- Any number of generic parameters is allowed.
			-- Therefore we only check the gen. parameters.
			from
				Result := True
				count := generics.count
				i := 1
			until
				i > count or else not Result
			loop
				Result := generics.item (i).good_generics
				i := i + 1
			end
		end

	error_generics: VTUG is

		local
			i, count: INTEGER
		do
			-- Any number of generic parameters is allowed.
			-- Therefore we only check the gen. parameters.
			from
				count := generics.count
				i := 1
			until
				i > count or else (Result /= Void)
			loop
				if not generics.item (i).good_generics then
					Result := generics.item (i).error_generics
				end
				i := i + 1
			end
		end

	check_constraints (context_class: CLASS_C) is
			-- Check the constrained genericity validity rule
		local
			i, count: INTEGER
			gen_param: TYPE_A
		do
				-- There are no constraints in a TUPLE type.
				-- Therefore we only check the gen. parameters.
			from
				i := 1
				count := generics.count
			until
				i > count
			loop
				gen_param := generics.item (i)
				gen_param.check_constraints (context_class)
				i := i + 1
			end
		end

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

end -- class TUPLE_TYPE_A

