indexing
	description: "Generic class where `meta_generic' and `true_generics' %
		%are aliased in .NET and where there is only one generic parameter."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ONE_GEN_TYPE_I

inherit
	GEN_TYPE_I
		rename
			make as old_gen_make
		export
			{ONE_GEN_TYPE_I} old_gen_make
		undefine
			il_type_name, type_a, generic_il_type_name
		redefine
			anchor_instantiation_in,
			duplicate,
			instantiation_in,
			generic_derivation,
			same_as
		end

	REFACTORING_HELPER
		undefine
			is_equal
		end

feature {NONE} -- Initialization

	make (an_id: like class_id; a_type: TYPE_A) is
			-- New instance of type based on a class of id `an_id' and with
			-- `a_type' as generic parameter.
		do
			if system.il_generation then
				old_make (an_id)
				create meta_generic.make (1)
				meta_generic.put (a_type.type_i, 1)
				true_generics := meta_generic
			else
				old_make (an_id)
				create meta_generic.make (1)
				meta_generic.put (a_type.meta_type, 1)
				create true_generics.make (1, 1)
				true_generics.put (a_type.type_i, 1)
			end
		end

feature -- Comparison

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current?
		local
			l_full_gen_type_i: like Current
		do
			l_full_gen_type_i ?= other
			if l_full_gen_type_i /= Void then
				Result := Precursor {GEN_TYPE_I} (l_full_gen_type_i)
			end
		end

feature -- Access

	generic_derivation: like Current is
			-- Precise generic derivation of current type.
			-- That is to say given a type, it gives the associated TYPE_I
			-- which can be used to search its associated CLASS_TYPE.
		do
			if system.il_generation then
					-- We need to keep track of all generic derivation,
					-- thus we can keep current as a valid generic derivation.
				Result := Current
			else
				Result := Precursor {GEN_TYPE_I}
			end
		end

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current.
		local
			l_meta: like meta_generic
		do
			if system.il_generation then
					-- It cannot be the inherited version, because
					-- we want to alias `true_generics' with `meta_generic'.
				Result := twin
				l_meta := meta_generic.twin
				Result.old_gen_make (class_id, l_meta, l_meta)
			else
				Result := Precursor {GEN_TYPE_I}
			end
		end

feature -- Status report

	instantiation_in (other: CLASS_TYPE): like Current is
			-- Instantiation of Current in context of `other'
		local
			l_type: TYPE_I
		do
			if system.il_generation then
				Result := duplicate
				l_type := meta_generic.item (1).complete_instantiation_in (other)
				Result.meta_generic.put (l_type, 1)
			else
				Result := Precursor {GEN_TYPE_I} (other)
			end
		end

	anchor_instantiation_in (other: CLASS_TYPE): CL_TYPE_I is
			-- Instantation of `like Current' parts of Current in `other'
		do
			if system.il_generation then
				Result := duplicate
				Result.meta_generic.put (meta_generic.item (1).anchor_instantiation_in (other), 1)
			else
				Result := Precursor {GEN_TYPE_I} (other)
			end
		end

feature {NONE} -- Implementation

	Object_type: CL_TYPE_I is
			-- Type of SYSTEM_OBJECT.
		require
			in_il_generation: system.il_generation
			system_not_void: system /= Void
			object_class_not_void: system.system_object_class /= Void
			object_class_compiled: system.system_object_class.is_compiled
		once
			Result := system.system_object_class.compiled_class.actual_type.type_i
		ensure
			object_type_not_void: Result /= Void
		end

invariant
	aliasing: system.il_generation implies
		((true_generics /= Void and meta_generic /= Void) implies true_generics = meta_generic)
	true_generics_count_one: true_generics /= Void implies true_generics.count = 1
	meta_generic_count_one: meta_generic /= Void implies meta_generic.count = 1

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

end
