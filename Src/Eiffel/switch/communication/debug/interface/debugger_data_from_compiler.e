indexing
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

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		local
			sys: SYSTEM_I
			cl_i: CLASS_I
		do
			sys := Eiffel_system.system
			cl_i := sys.any_class
			if cl_i /= Void then
				any_class_c := cl_i.compiled_class
			end

			cl_i := sys.routine_class
			if cl_i /= Void then
				routine_class_c := cl_i.compiled_class
			end

			cl_i := sys.array_class
			if cl_i /= Void then
				array_class_c := cl_i.compiled_class
			end

			cl_i := sys.tuple_class
			if cl_i /= Void then
				tuple_class_c := cl_i.compiled_class
			end

			cl_i := sys.type_class
			if cl_i /= Void then
				type_class_c := cl_i.compiled_class
			end

			cl_i := sys.string_8_class
			if cl_i /= Void then
				string_8_class_c := cl_i.compiled_class
			end

			cl_i := sys.string_32_class
			if cl_i /= Void then
				string_32_class_c := cl_i.compiled_class
			end

			cl_i := sys.natural_8_class
			if cl_i /= Void then
				natural_8_class_c := cl_i.compiled_class
			end

			cl_i := sys.natural_16_class
			if cl_i /= Void then
				natural_16_class_c := cl_i.compiled_class
			end

			cl_i := sys.natural_32_class
			if cl_i /= Void then
				natural_32_class_c := cl_i.compiled_class
			end

			cl_i := sys.natural_64_class
			if cl_i /= Void then
				natural_64_class_c := cl_i.compiled_class
			end

			cl_i := sys.Integer_8_class
			if cl_i /= Void then
				integer_8_class_c := cl_i.compiled_class
			end

			cl_i := sys.Integer_16_class
			if cl_i /= Void then
				integer_16_class_c := cl_i.compiled_class
			end

			cl_i := sys.Integer_32_class
			if cl_i /= Void then
				integer_32_class_c := cl_i.compiled_class
			end

			cl_i := sys.Integer_64_class
			if cl_i /= Void then
				integer_64_class_c := cl_i.compiled_class
			end

			cl_i := sys.Boolean_class
			if cl_i /= Void then
				boolean_class_c := cl_i.compiled_class
			end

			cl_i := sys.character_8_class
			if cl_i /= Void then
				character_8_class_c := cl_i.compiled_class
			end

			cl_i := sys.character_32_class
			if cl_i /= Void then
				character_32_class_c := cl_i.compiled_class
			end

			cl_i := sys.real_32_class
			if cl_i /= Void then
				real_32_class_c := cl_i.compiled_class
			end

			cl_i := sys.real_64_class
			if cl_i /= Void then
				real_64_class_c := cl_i.compiled_class
			end

			cl_i := sys.Pointer_class
			if cl_i /= Void then
				pointer_class_c := cl_i.compiled_class
			end

			cl_i := sys.Bit_class
			if cl_i /= Void then
				bit_class_c := cl_i.compiled_class
			end

			cl_i := sys.system_object_class
			if cl_i /= Void then
				system_object_class_c := cl_i.compiled_class
			end

			cl_i := sys.system_string_class
			if cl_i /= Void then
				system_string_class_c := cl_i.compiled_class
			end

			cl_i := sys.native_array_class
			if cl_i /= Void then
				native_array_class_c := cl_i.compiled_class
			end

			cl_i := sys.exception_class
			if cl_i /= Void then
				exception_class_c := cl_i.compiled_class
			end

			cl_i := sys.exception_manager_class
			if cl_i /= Void then
				exception_manager_class_c := cl_i.compiled_class
			end
		end

feature -- Access

	any_class_c: CLASS_C
	routine_class_c: CLASS_C
	array_class_c: CLASS_C
	tuple_class_c: CLASS_C
	type_class_c: CLASS_C
	string_8_class_c: CLASS_C
	string_32_class_c: CLASS_C
	natural_8_class_c: CLASS_C
	natural_16_class_c: CLASS_C
	natural_32_class_c: CLASS_C
	natural_64_class_c: CLASS_C
	integer_8_class_c: CLASS_C
	integer_16_class_c: CLASS_C
	integer_32_class_c: CLASS_C
	integer_64_class_c: CLASS_C
	boolean_class_c: CLASS_C
	character_8_class_c: CLASS_C
	character_32_class_c: CLASS_C
	real_32_class_c: CLASS_C
	real_64_class_c: CLASS_C
	pointer_class_c: CLASS_C
	bit_class_c: CLASS_C
	exception_class_c: CLASS_C
	exception_manager_class_c: CLASS_C

feature -- Specific access

	internal_class_c: CLASS_C is
			--
		local
			lst: LIST [CLASS_I]
			l_cli: CLASS_I
		do
			Result := opo_internal_class_c
			if Result = Void then
				lst := eiffel_universe.classes_with_name ("INTERNAL")
				if lst.count = 1 then
					l_cli := lst.first
				else
					l_cli := eiffel_universe.class_named ("INTERNAL", eiffel_universe.group_of_name ("base"))
				end
				if l_cli /= Void then
					Result := l_cli.compiled_class
				end
				opo_internal_class_c := Result
			end
		ensure
			Result_not_Void: Result /= Void
		end

	ise_runtime_class_c: CLASS_C is
			-- ISE_RUNTIME class (for dotnet)
		local
			lst: LIST [CLASS_I]
			l_cli: CLASS_I
		do
			Result := opo_ise_runtime_class_c
			if Result = Void then
				lst := eiffel_universe.classes_with_name ("ISE_RUNTIME")
				if lst.count = 1 then
					l_cli := lst.first
				else
					l_cli := eiffel_universe.class_named ("ISE_RUNTIME", eiffel_universe.group_of_name ("base"))
				end
				if l_cli /= Void then
					Result := l_cli.compiled_class
				end
				opo_ise_runtime_class_c := Result
			end
		end

feature -- IL Access

	system_object_class_c: CLASS_C
	system_string_class_c: CLASS_C;
	native_array_class_c: CLASS_C;

feature {NONE} -- Once per object

	opo_internal_class_c: like internal_class_c
	opo_ise_runtime_class_c: like ise_runtime_class_c

;indexing
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
