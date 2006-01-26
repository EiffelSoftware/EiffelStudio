indexing
	description: "Create new instance of FEATURE_I"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_FEATURE_I_GENERATOR

inherit
	ANY

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

feature -- Factory

	new_feature (a_node: FEATURE_AS): FEATURE_I is
			-- Create associated FEATURE_I instance of `a_node'
		require
			a_node_not_void: a_node /= Void
		local
			l_once: ONCE_PROC_I
		do
			process_body_as (a_node.body)
			Result := last_feature
			last_feature := Void
			if Result.is_once and then a_node.indexes /= Void then
				l_once ?= Result
				if l_once /= Void then
					l_once.set_is_process_relative (a_node.indexes.has_global_once)
				else
					fixme ("support process-relative constants (e.g., string constants)")
				end
			end
		end

feature {NONE} -- Implementation: Access

	last_feature: FEATURE_I
			-- Last computed feature

feature {NONE} -- Implementation

	process_body_as (l_as: BODY_AS) is
		local
			l_attr: ATTRIBUTE_I
			l_const: CONSTANT_I
			l_constant: CONSTANT_AS
			l_routine: ROUTINE_AS
			l_def_func: DEF_FUNC_I
			l_def_proc: DEF_PROC_I
			l_dyn_func: DYN_FUNC_I
			l_once_func: ONCE_FUNC_I
			l_proc, l_func: PROCEDURE_I
			l_extern_proc: EXTERNAL_I
			l_extern_func: EXTERNAL_FUNC_I
			l_external_body: EXTERNAL_AS
				-- Hack Hack Hack
				-- A litteral numeric value is interpreted as
				-- a DOUBLE. In the case of a constant REAL
				-- declaration that wont do!
			l_extension: EXTERNAL_EXT_I
			l_il_ext: IL_EXTENSION_I
			l_lang: COMPILER_EXTERNAL_LANG_AS
			l_is_deferred_external, l_is_attribute_external: BOOLEAN
			l_result: FEATURE_I
			l_assigner_name_id: INTEGER
		do
			if l_as.assigner /= Void then
				names_heap.put (l_as.assigner)
				l_assigner_name_id := names_heap.found_item
			end
			if l_as.content = Void then
					-- It is an attribute
				create l_attr.make
				check
					type_exists: l_as.type /= Void
				end
				l_attr.set_type (l_as.type, l_assigner_name_id)
				l_result := l_attr
				l_result.set_is_empty (True)
			elseif l_as.content.is_constant then
					-- It is a constant feature
				l_constant ?= l_as.content
				if l_as.content.is_unique then
						-- No constant value is processed for a unique
						-- feature, since the second pass does it.
					create {UNIQUE_I} l_const.make
				else
						-- Constant value is processed here.
					create l_const.make
					l_const.set_value (value_i_generator.value_i (l_constant.value))
				end
				check
					constant_exists: l_constant /= Void
					type_exists: l_as.type /= Void
				end
				l_const.set_type (l_as.type, l_assigner_name_id)
				l_result := l_const
				l_result.set_is_empty (True)

			elseif l_as.type = Void then
				l_routine ?= l_as.content
				check
					routine_exists: l_routine /= Void
				end
				if l_routine.is_deferred then
						-- Deferred procedure
					create {DEF_PROC_I} l_proc
				elseif l_routine.is_once then
						-- Once procedure
					create {ONCE_PROC_I} l_proc
				elseif l_routine.is_external then

						-- External procedure
					l_external_body ?= l_routine.routine_body
					l_lang ?= l_external_body.language_name
					check
						l_lang_not_void: l_lang /= Void
					end
					l_extension := l_lang.extension_i
					if l_external_body.alias_name_id > 0 then
						l_extension.set_alias_name_id (l_external_body.alias_name_id)
					end

					if System.il_generation then
						l_il_ext ?= l_extension
						l_is_deferred_external := l_il_ext /= Void and then
							l_il_ext.type = (create {SHARED_IL_CONSTANTS}).Deferred_type
					end
					if not l_is_deferred_external then
						create l_extern_proc.make (l_extension)

							-- if there's a macro or a signature then encapsulate
						l_extern_proc.set_encapsulated (l_extension.need_encapsulation)
						l_proc := l_extern_proc
					else
						create l_def_proc
						l_def_proc.set_extension (l_il_ext)
						l_proc := l_def_proc
					end
				else
					create {DYN_PROC_I} l_proc
				end
				if l_as.arguments /= Void then
						-- Arguments initialization
					l_proc.init_arg (l_as.arguments)
				end
				l_proc.init_assertion_flags (l_routine)
				if l_routine.obsolete_message /= Void then
					l_proc.set_obsolete_message (l_routine.obsolete_message.value)
				end
				l_result := l_proc
				l_result.set_is_empty (l_as.content.is_empty)
			else
				l_routine ?= l_as.content
				check
					routine_exists: l_routine /= Void
				end
				if l_routine.is_deferred then
						-- Deferred function
					create l_def_func
					l_def_func.set_type (l_as.type, l_assigner_name_id)
					l_func := l_def_func
				elseif l_routine.is_once then
						-- Once function
					create l_once_func
					l_once_func.set_type (l_as.type, l_assigner_name_id)
					l_func := l_once_func
				elseif l_routine.is_external then

						-- External procedure
					l_external_body ?= l_routine.routine_body
					l_lang ?= l_external_body.language_name
					check
						l_lang_not_void: l_lang /= Void
					end
					l_extension := l_lang.extension_i
					if l_external_body.alias_name_id > 0 then
						l_extension.set_alias_name_id (l_external_body.alias_name_id)
					end

					if System.il_generation then
						l_il_ext ?= l_extension
						l_is_deferred_external := l_il_ext /= Void and then
							l_il_ext.type = (create {SHARED_IL_CONSTANTS}).Deferred_type
						l_is_attribute_external := l_il_ext /= Void and then
							(l_il_ext.type = (create {SHARED_IL_CONSTANTS}).Field_type or
							l_il_ext.type = (create {SHARED_IL_CONSTANTS}).Static_field_type)

					end
					if not l_is_deferred_external and not l_is_attribute_external then
						create l_extern_func.make (l_extension)

							-- if there's a macro or a signature then encapsulate
						l_extern_func.set_encapsulated (l_extension.need_encapsulation)
						l_extern_func.set_type (l_as.type, l_assigner_name_id)
						l_func := l_extern_func
					elseif l_is_attribute_external then
						create l_attr.make
						check
							il_generation: System.il_generation
							type_exists: l_as.type /= Void
						end
						l_attr.set_type (l_as.type, l_assigner_name_id)
						l_attr.set_is_empty (True)
						l_attr.set_extension (l_il_ext)
						l_result := l_attr
						if l_external_body.alias_name_id > 0 then
							l_result.set_private_external_name_id (l_external_body.alias_name_id)
						end
					else
						check
							il_generation: System.il_generation
						end
						create l_def_func
						l_def_func.set_extension (l_il_ext)
						l_def_func.set_type (l_as.type, l_assigner_name_id)
						l_func := l_def_func
						if l_external_body.alias_name_id > 0 then
							l_func.set_private_external_name_id (l_external_body.alias_name_id)
						end
					end
				else
					create l_dyn_func
					l_dyn_func.set_type (l_as.type, l_assigner_name_id)
					l_func := l_dyn_func
				end
				if not l_is_attribute_external then
					if l_as.arguments /= Void then
							-- Arguments initialization
						l_func.init_arg (l_as.arguments)
					end
					l_func.init_assertion_flags (l_routine)
					if l_routine.obsolete_message /= Void then
						l_func.set_obsolete_message (l_routine.obsolete_message.value)
					end
					l_result := l_func
					l_result.set_is_empty (l_as.content.is_empty)
				end
			end
			last_feature := l_result
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

end
