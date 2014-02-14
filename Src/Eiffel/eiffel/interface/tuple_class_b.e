note
	description: "Compiled class TUPLE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE_CLASS_B

inherit
	EIFFEL_CLASS_C
		redefine
			create_generic_type,
			initialize_actual_type,
			is_tuple,
			partial_actual_type,
			check_validity
		end

create
	make

feature -- Status report

	is_tuple: BOOLEAN = True
			-- Current class is TUPLE.

feature {NONE} -- Initialization

	initialize_actual_type
		do
			if generics /= Void then
				Precursor
			else
				create {TUPLE_TYPE_A} actual_type.make (class_id, create {ARRAYED_LIST [TYPE_A]}.make (0))
				if lace_class.is_attached_by_default then
					actual_type.set_is_attached
				else
					actual_type.set_is_implicitly_attached
				end
			end
		end

	create_generic_type (g: ARRAYED_LIST [TYPE_A]): GEN_TYPE_A
			-- <Precursor>
		do
			create {TUPLE_TYPE_A} Result.make (class_id, g)
		end

feature -- Validity class

	check_validity
			-- Special classes validity check.
		local
			l_feature: FEATURE_I
		do
			if system.il_generation then
				if
					not attached feature_of_name_id ({PREDEFINED_NAMES}.put_name_id) as l_feat or else
					l_feat.argument_count /= 2 or else l_feat.has_return_value
				then
					error_handler.insert_error (
						create {SPECIAL_ERROR}.make ("Class TUPLE must have a procedure `put'.", Current))
				end
			end
		end

feature {CLASS_TYPE_AS} -- Actual class type

	partial_actual_type (gen: detachable ARRAYED_LIST [TYPE_A]; is_exp: BOOLEAN): CL_TYPE_A
			-- Actual type of `current depending on the context in which it is declared
			-- in CLASS_TYPE_AS. That is to say, it could have generics `gen' but not
			-- be a generic class. It simplifies creation of `CL_TYPE_A' instances in
			-- CLASS_TYPE_AS when trying to resolve types, by using dynamic binding
			-- rather than if statements.
		do
			if gen /= Void then
				create {TUPLE_TYPE_A} Result.make (class_id, gen)
			else
				create {TUPLE_TYPE_A} Result.make (class_id, create {ARRAYED_LIST [TYPE_A]}.make (0))
			end
				-- Note that TUPLE is not expanded by default.
			if is_exp then
				Result.set_expanded_mark
			end
			if is_expanded then
				Result.set_expanded_class_mark
			end
		end

invariant
	types_has_only_one_element: types /= Void implies types.count <= 1

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
