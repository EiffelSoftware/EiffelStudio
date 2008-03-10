indexing
	description: "Byte code for routine creation expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ROUTINE_CREATION_BL

inherit
	ROUTINE_CREATION_B
		redefine
			analyze, generate,
			register, set_register, free_register,
			unanalyze
		end

	SHARED_C_LEVEL
	SHARED_TABLE
	SHARED_DECLARATIONS
	SHARED_INCLUDE

	SHARED_TYPE_I
		export
			{NONE} all
		end

feature

	register: REGISTRABLE
			-- Register for array containing the routine object

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r
		do
			register := r
		end

	unanalyze is
			-- Unanalyze expression
		do
			if arguments /= Void then
				arguments.unanalyze
			end
			if open_positions /= Void then
				open_positions.unanalyze
			end
			set_register (Void)
		end

	analyze is
			-- Analyze expression
		do
			if arguments /= Void then
				arguments.analyze
			end
			if open_positions /= Void then
				open_positions.analyze
			end
			get_register
			context.add_dftype_current
		end

	free_register is
			-- Free used registers for later use.
		do
			Precursor {ROUTINE_CREATION_B}
			if arguments /= Void then
				arguments.free_register
			end
			if open_positions /= Void then
				open_positions.free_register
			end
		end

	generate is
			-- Generate expression
		local
			agent_type: CL_TYPE_A
			gen_type: GEN_TYPE_A
			buf: GENERATION_BUFFER
			sep: STRING
			wb_mode: BOOLEAN
			l_context: like context
		do
			check
				address_table_record_generated: not System.address_table.is_lazy (class_id, feature_id, is_target_closed, omap)
			end
			l_context := context
			sep := once ", "
			wb_mode := not l_context.final_mode
			if arguments /= Void then
				arguments.generate
			end

			if wb_mode and open_positions /= Void then
				open_positions.generate
			end

			buf := buffer
			agent_type ?= l_context.real_type (type)
			gen_type  ?= agent_type
			buf.put_new_line
			buf.generate_block_open
			l_context.generate_gen_type_conversion (gen_type, 0)
			buf.put_new_line
			print_register
			buf.put_string (once " = ")
			if wb_mode then
				buf.put_string (once "RTLNRW(typres0, ")
			else
				buf.put_string (once "RTLNRF(typres0, ")
			end
				-- now the parameters for set_rout_disp:
				-- rout_disp
			if wb_mode then
				buf.put_character ('0')
			else
				generate_routine_address (True, False)
			end
			buf.put_string (sep)

				-- encaps_rout_disp
			generate_routine_address (True, True)
			buf.put_string (sep)

				-- calc_rout_addr
			if is_target_closed then
				generate_precalc_routine_address
			else
				buf.put_character ('0')
				buf.put_string (sep)
			end

			if wb_mode then
				if is_precompiled then
					buf.put_integer (rout_origin)
					buf.put_string (sep)
					buf.put_integer (rout_offset)
					buf.put_string (sep)
				else
						-- Note that we use `context.current_type' because we do not adapt
						-- `a_node.class_type' to `context.context_class_type' for the simple reasons
						-- that `feature_id' is the one from where the agent creation is declared.
						-- If we were to adapt it, then we would need something like
						-- `{CALL_ACCESS_B}.real_feature_id' for a proper code generation.
					buf.put_static_type_id (class_type.static_type_id (context.current_type))
					buf.put_string (sep)
						-- feature_id
					buf.put_integer (feature_id)
					buf.put_string (sep)
				end
					-- open_map
				if open_positions /= Void and then not system.in_final_mode then
					open_positions.print_register
				else
					buf.put_character ('0')
				end
				buf.put_string (sep)
					-- is_precompiled
				if is_precompiled then
					buf.put_character ('1')
				else
					buf.put_character ('0')
				end
				buf.put_string (sep)
					-- is_basic
				if is_basic then
					buf.put_character ('1')
				else
					buf.put_character ('0')
				end
				buf.put_string (sep)
					-- is_target_closed
				if is_target_closed then
					buf.put_character ('1')
				else
					buf.put_character ('0')
				end
				buf.put_string (sep)
					-- is_inline_agent
				if is_inline_agent then
					buf.put_character ('1')
				else
					buf.put_character ('0')
				end
				buf.put_string (sep)
			end
				-- closed_operands
			if arguments /= Void then
				arguments.print_register
			else
				buf.put_character ('0')
			end
			buf.put_string (sep)
			if not wb_mode then
					-- is_target_closed
				if is_target_closed then
					buf.put_character ('1')
				else
					buf.put_character ('0')
				end
				buf.put_string (sep)
			end
				-- open_count
			if open_positions /= Void then
				buf.put_integer (open_positions.expressions.count)
			else
				buf.put_character ('0')
			end
			buf.put_string (");")
			buf.generate_block_close
		end

	generate_routine_address (optimized, oargs_encapsulated: BOOLEAN) is
			-- Generate routine address
		local
			table_name	: STRING
			buf			: GENERATION_BUFFER
			array_index: INTEGER
			l_omap: like omap
			l_context: like context
		do
			buf := buffer
			if optimized then
				l_omap := omap
			end
			l_context := context

				-- Note that we use `context.current_type/context.class_type' because we do not adapt
				-- `a_node.class_type' to `context.context_class_type' for the simple reasons
				-- that `feature_id' is the one from where the agent creation is declared.
				-- If we were to adapt it, then we would need something like
				-- `{CALL_ACCESS_B}.real_feature_id' for a proper code generation.

			if not l_context.workbench_mode and then not is_inline_agent then
				array_index := Eiffel_table.is_polymorphic (rout_id, class_type, context.class_type, True)
			end

			if array_index = -2 then
					-- Function pointer associated to a deferred feature without
					-- any implementation
				buf.put_string ("NULL")
			else
				check
					system.address_table.has_agent (
						class_type.associated_class.class_id, feature_id, is_target_closed, omap)
				end
				table_name := system.address_table.calc_function_name (
					True, feature_id, class_type.static_type_id (context.current_type), l_omap, oargs_encapsulated)

				buf.put_string ("(EIF_POINTER) ")
				buf.put_string (table_name)

					-- Remember extern declarations
				Extern_declarations.add_routine (type.c_type, table_name)

				if not l_context.workbench_mode and then not is_inline_agent and then array_index >= 0 then
						-- Mark table used
					Eiffel_table.mark_used (rout_id)
				end
			end
		end

	generate_current is
		do
			buffer.put_string ("((EIF_TYPED_VALUE *)")
			arguments.print_register
			buffer.put_string (")[1].")
			reference_c_type.generate_typed_field (buffer)
		end

	generate_precalc_routine_address is
		local
			l_class_type: CLASS_TYPE
			l_entry: POLY_TABLE [ENTRY]
			l_table_name, l_function_name: STRING
			l_rout_table: ROUT_TABLE
			l_feat: FEATURE_I
			l_c_return_type: TYPE_C
			l_args: ARRAY [STRING_8]
			l_seed: FEATURE_I
			l_return_type_string: STRING
			l_buffer: like buffer
			l_context: like context
		do
			l_buffer := buffer
			l_context := context
			l_buffer.put_string ("(EIF_POINTER)")
			l_buffer.put_character ('(')
			if is_inline_agent or else l_context.workbench_mode then
				l_buffer.put_string ("0),")
			else
					-- Note that we use `context.current_type' because we do not adapt
					-- `a_node.class_type' to `context.context_class_type' for the simple reasons
					-- that `feature_id' is the one from where the agent creation is declared.
					-- If we were to adapt it, then we would need something like
					-- `{CALL_ACCESS_B}.real_feature_id' for a proper code generation.
				l_class_type := class_type.associated_class_type (context.current_type)
				l_entry :=  Eiffel_table.poly_table (rout_id)

				if l_entry = Void then
						-- Function pointer associated to a deferred feature
						-- without any implementation
					l_buffer.put_string ("0),")
				else
					if l_entry.is_polymorphic (class_type, context.class_type) then
						l_table_name := Encoder.routine_table_name (rout_id)
						l_buffer.put_string (l_table_name)
						l_buffer.put_string ("[Dtype((")
						generate_current
						l_buffer.put_string (")) - ")
						l_buffer.put_type_id (l_entry.min_used)
						l_buffer.put_string ("]),")
							-- Remember extern declarations
						Extern_declarations.add_routine_table (l_table_name)
							-- Mark table used.
						Eiffel_table.mark_used (rout_id)
					else
						l_rout_table ?= l_entry
						l_rout_table.goto_implemented (class_type, context.class_type)

						l_feat := l_class_type.associated_class.feature_of_feature_id (feature_id)
						l_seed := system.seed_of_routine_id (rout_id)
							-- It is pretty important that we use `actual_type.is_formal' and not
							-- just `is_formal' because otherwise if you have `like x' and `x: G'
							-- then we would fail to detect that.
						if l_seed.type.actual_type.is_formal then
							l_c_return_type := reference_c_type
						else
							l_c_return_type := system.address_table.solved_type (l_class_type, l_feat.type)
						end
						l_return_type_string := l_c_return_type.c_string
						if l_rout_table.is_implemented then
							l_function_name := l_rout_table.feature_name + system.seed_of_routine_id (rout_id).generic_fingerprint
							l_buffer.put_string (l_function_name)
							l_buffer.put_string ("),")
							if l_feat.has_arguments then
								l_args := system.address_table.arg_types (l_class_type, l_feat.arguments, True, l_seed)
							else
								l_args := <<"EIF_REFERENCE">>
							end
							extern_declarations.add_routine_with_signature (
								l_return_type_string, l_function_name, l_args)
						else
								-- Function pointer associated to a deferred feature
								-- without any implementation. We mark `l_is_implemented'
								-- to False to not generate the argument list since
								-- RTNR takes only one argument.
							l_c_return_type.generate_function_cast (l_buffer, <<"EIF_REFERENCE">>, False)
							l_buffer.put_string ("RTNR),")
						end
					end
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end -- class ROUTINE_CREATION_BL

