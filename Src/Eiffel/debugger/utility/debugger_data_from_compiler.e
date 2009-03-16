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

			cl_i := sys.ise_exception_manager_class
			if cl_i /= Void then
				exception_manager_class_c := cl_i.compiled_class
			end
		end

feature -- Query

	object_test_locals (a_class_type: CLASS_TYPE; a_feat: E_FEATURE): ARRAYED_LIST [TUPLE [id: ID_AS; type: TYPE_A]]
			-- Object test locals from `a_feat' in the context of class `a_class_type'
		require
			a_class_type /= Void
			a_feat /= Void
		local
			type_vis: AST_DEBUGGER_EXPRESSION_CHECKER_GENERATOR
			l_type_as: TYPE_AS
			l_cl_type_a: CL_TYPE_A
			l_type_a: TYPE_A
			l_old_ast_context, l_ast_context: like ast_context
			retried: BOOLEAN
			cl: CLASS_C
		do
			if not retried then
				if attached create {AST_DEBUGGER_OBJECT_TEST_LOCAL_VISITOR} as vis then
					vis.get_object_test_locals (a_feat.ast)
					if attached vis.object_test_locals as l_object_test_locals then
							--| FIXME jfiat [2009/03/16] : we should cache `vis.object_test_locals', to avoid recomputation...
						create type_vis
						l_ast_context := ast_context
						l_old_ast_context := l_ast_context.twin
						l_ast_context.clear_all
						if a_class_type = Void then
							cl := a_feat.associated_class
							l_cl_type_a := cl.actual_type
						else
							cl := a_class_type.associated_class
							l_cl_type_a := a_class_type.type
						end
						l_ast_context.initialize (cl, l_cl_type_a, cl.feature_table)
						l_ast_context.set_current_feature (a_feat.associated_feature_i)
						type_vis.init (l_ast_context)
						type_vis.set_current_feature (a_feat.associated_feature_i)
						from
							create Result.make (l_object_test_locals.count)
							l_object_test_locals.start
						until
							l_object_test_locals.after
						loop
							if attached l_object_test_locals.item as l_item then
								l_type_as := l_item.type
								if l_type_as /= Void then
									l_type_a := type_vis.type_a_from_type_as (l_type_as)
								else
									l_type_a := type_vis.type_a_from_expr_as (l_object_test_locals.item.exp)
								end
								Result.force ([l_item.name, l_type_a])
							else
								check should_not_occur: False end
							end
							l_object_test_locals.forth
						end
						l_ast_context.restore (l_old_ast_context)
					end
--				else
--					Result := a_feat.object_test_locals
				end
			else
				if l_ast_context /= Void and l_old_ast_context /= Void then
					l_ast_context.restore (l_old_ast_context)
				end
			end
		rescue
			retried := True
			retry
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

	internal_class_c: CLASS_C
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

	ise_runtime_class_c: CLASS_C
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

;note
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
