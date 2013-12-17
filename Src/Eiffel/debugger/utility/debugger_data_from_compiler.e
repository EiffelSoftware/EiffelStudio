note
	description: "Objects that represents data from compiler..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_DATA_FROM_COMPILER

inherit
	SHARED_EIFFEL_PROJECT

	SHARED_AST_CONTEXT
		rename
			context as ast_context
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			sys: SYSTEM_I
		do
			sys := Eiffel_system.system

			any_class_c := class_c_from_class_i (sys.any_class)
			routine_class_c := class_c_from_class_i (sys.routine_class)
			array_class_c := class_c_from_class_i (sys.array_class)
			special_class_c := class_c_from_class_i (sys.special_class)
			tuple_class_c := class_c_from_class_i (sys.tuple_class)
			type_class_c := class_c_from_class_i (sys.type_class)
			readable_string_8_class_c := class_c_by_name ("READABLE_STRING_8")
			readable_string_32_class_c := class_c_by_name ("READABLE_STRING_32")
			string_8_class_c := class_c_from_class_i (sys.string_8_class)
			string_32_class_c := class_c_from_class_i (sys.string_32_class)
			immutable_string_8_class_c := class_c_by_name ("IMMUTABLE_STRING_8")
			immutable_string_32_class_c := class_c_by_name ("IMMUTABLE_STRING_32")
			natural_8_class_c := class_c_from_class_i (sys.natural_8_class)
			natural_16_class_c := class_c_from_class_i (sys.natural_16_class)
			natural_32_class_c := class_c_from_class_i (sys.natural_32_class)
			natural_64_class_c := class_c_from_class_i (sys.natural_64_class)
			integer_8_class_c := class_c_from_class_i (sys.Integer_8_class)
			integer_16_class_c := class_c_from_class_i (sys.Integer_16_class)
			integer_32_class_c := class_c_from_class_i (sys.Integer_32_class)
			integer_64_class_c := class_c_from_class_i (sys.Integer_64_class)
			boolean_class_c := class_c_from_class_i (sys.Boolean_class)
			character_8_class_c := class_c_from_class_i (sys.character_8_class)
			character_32_class_c := class_c_from_class_i (sys.character_32_class)
			real_32_class_c := class_c_from_class_i (sys.real_32_class)
			real_64_class_c := class_c_from_class_i (sys.real_64_class)
			pointer_class_c := class_c_from_class_i (sys.Pointer_class)
			system_object_class_c := class_c_from_class_i (sys.system_object_class)
			system_string_class_c := class_c_from_class_i (sys.system_string_class)
			native_array_class_c := class_c_from_class_i (sys.native_array_class)
			exception_class_c := class_c_from_class_i (sys.exception_class)
			assertion_violation_class_c := class_c_by_name ("ASSERTION_VIOLATION")
			exception_manager_class_c := class_c_from_class_i (sys.ise_exception_manager_class)
		end

feature -- Access

	any_class_c,
	routine_class_c,
	array_class_c,
	special_class_c,
	tuple_class_c,
	type_class_c,
	readable_string_8_class_c,
	readable_string_32_class_c,
	immutable_string_8_class_c,
	immutable_string_32_class_c,
	string_8_class_c,
	string_32_class_c,
	natural_8_class_c,
	natural_16_class_c,
	natural_32_class_c,
	natural_64_class_c,
	integer_8_class_c,
	integer_16_class_c,
	integer_32_class_c,
	integer_64_class_c,
	boolean_class_c,
	character_8_class_c,
	character_32_class_c,
	real_32_class_c,
	real_64_class_c,
	pointer_class_c,
	exception_class_c,
	assertion_violation_class_c,
	exception_manager_class_c: detachable CLASS_C

feature -- Specific access

	class_c_from_class_i (a_class_i: detachable CLASS_I): detachable CLASS_C
			-- CLASS_C associated with `a_class_i' if any.
		do
			if a_class_i /= Void then
				Result := a_class_i.compiled_class
			end
		end

	class_i_by_name (a_class_name: STRING_8): detachable CLASS_I
			-- Instance of CLASS_I related to `a_name'
		local
			lst: LIST [CLASS_I]
		do
			lst := eiffel_universe.classes_with_name (a_class_name)
			if lst.count = 1 then
				Result := lst.first
			else
				Result := eiffel_universe.class_named (a_class_name, eiffel_universe.group_of_name (base_cluster_name))
			end
		end

	class_c_by_name (a_class_name: STRING_8): detachable CLASS_C
			-- Instance of CLASS_C related to `a_name'
		local
			l_cli: detachable CLASS_I
		do
			l_cli :=  class_i_by_name (a_class_name)
			if l_cli /= Void then
				Result := l_cli.compiled_class
			end
		end

	internal_class_c: detachable CLASS_C
			--
		do
			Result := opo_internal_class_c
			if Result = Void then
				Result := class_c_by_name ("REFLECTOR")
				if Result = Void then
					Result := class_c_by_name ("INTERNAL")
				end
				opo_internal_class_c := Result
			end
		ensure
			result_not_void: Result /= Void
		end

	ise_runtime_class_c: detachable CLASS_C
			-- ISE_RUNTIME class (for dotnet)
		do
			Result := opo_ise_runtime_class_c
			if Result = Void then
				Result := class_c_by_name ("ISE_RUNTIME")
				opo_ise_runtime_class_c := Result
			end
		end

feature -- IL Access

	system_object_class_c: CLASS_C
	system_string_class_c: CLASS_C;
	native_array_class_c: CLASS_C;

feature {NONE} -- Once per object

	base_cluster_name: STRING_8 = "base"

	opo_internal_class_c: like internal_class_c
	opo_ise_runtime_class_c: like ise_runtime_class_c

;note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
