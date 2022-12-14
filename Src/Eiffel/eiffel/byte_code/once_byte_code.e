note
	description: "Byte code for once feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class ONCE_BYTE_CODE

inherit
	STD_BYTE_CODE
		redefine
			append_once_mark,
			generate_once_data,
			generate_once_declaration,
			generate_once_prologue,
			generate_once_epilogue,
			inlined_byte_code_type,
			is_object_relative_once,
			is_once,
			is_once_creation,
			is_process_relative_once,
			pre_inlined_code
		end

	REFACTORING_HELPER

feature {NONE} -- Status

	internal_is_process_relative_once: BOOLEAN
			-- Is current once to be generated in multithreaded mode has a global once?

feature -- Status

	is_once: BOOLEAN = True
			-- Is the current byte code relative to a once feature ?

	is_process_relative_once: BOOLEAN
			-- Is current once compiled in multithreaded mode with global status?
		do
			Result := (System.has_multithreaded or else System.il_generation) and then internal_is_process_relative_once
		end

	is_object_relative_once: BOOLEAN
			-- Is current once compiled as per object once?

feature -- Setting

	set_is_process_relative_once
			-- Set once as per process (global).
		do
			is_object_relative_once := False
			internal_is_process_relative_once := True
		ensure
			internal_is_process_relative_once
		end

	set_is_thread_relative_once
			-- Set once as per thread (default).
		do
			internal_is_process_relative_once := False
			is_object_relative_once := False
		ensure
			is_thread_relative_once
		end

	set_is_object_relative_once
			-- Set once as per object.
		do
			internal_is_process_relative_once := False
			is_object_relative_once := True
		ensure
			is_object_relative_once
		end

feature -- Byte code generation

	append_once_mark (ba: BYTE_ARRAY)
			-- Append byte code indicating a kind of a once routine
			-- (thread-relative once, process-relative once, etc.)
			-- and associated information (code index)
		do
			if is_object_relative_once then
				ba.append (once_mark_object_relative)
			else
					-- The once mark.
				ba.append (if is_process_relative_once then once_mark_process_relative else once_mark_thread_relative end)
					-- Record routine body index.
				ba.append_integer_32 (body_index)
			end
				-- Put the number of breakpoint slots.
			ba.append_integer (if attached context.current_feature as f then f.number_of_breakpoint_slots else 1 end)
		end

feature {NONE} -- C code generation: implementation

	generate_object_relative_once_result_definition (macro: STRING)
			-- Generate definition of once data using `result_macro_prefix' to define Result and
			-- `data_macro_prefix' to initialize associated variables (if required).
		require
			is_object_relative_once: is_object_relative_once
			macro_not_void: macro /= Void
		local
			type_i: TYPE_A
			buf: like buffer
		do
			type_i := real_type (result_type)
			if
				not type_i.is_void and then
				(context.workbench_mode or else context.result_used)
			then
					-- Generate Result definition.
				buf := buffer
				buf.put_new_line_only
				buf.put_string ("#define ")
				buf.put_string (macro)
				buf.put_character ('%T')
					-- Use "EIF_POINTER" C type for TYPED_POINTER and CECIL type name for other types.
				buf.put_string (if type_i.is_typed_pointer then "EIF_POINTER" else type_i.c_type.c_string end)
			end
		end

	generate_once_result_definition (result_macro_prefix: STRING; data_macro_prefix: STRING)
			-- Generate definition of once data using `result_macro_prefix' to define Result and
			-- `data_macro_prefix' to initialize associated variables (if required).
		require
			is_not_object_relative_once: not is_object_relative_once
			result_macro_prefix_not_void: result_macro_prefix /= Void
			data_macro_prefix_not_void: data_macro_prefix /= Void
		local
			type_i: TYPE_A
			c_type_name: STRING
			buf: like buffer
			data_macro_suffix: CHARACTER
			is_basic_type: BOOLEAN
		do
			buf := buffer
			type_i := real_type (if is_once_creation then context.current_type else result_type end)
			if type_i.is_void then
				data_macro_suffix := 'V'
			else
					-- Use "EIF_POINTER" C type for TYPED_POINTER and CECIL type name for other types
				c_type_name := if type_i.is_typed_pointer then "EIF_POINTER" else type_i.c_type.c_string end
				if type_i.c_type.is_reference then
						-- Reference result type
					data_macro_suffix := 'R'
				else
						-- Basic result type
					data_macro_suffix := 'B'
					is_basic_type := True
				end
				if context.workbench_mode or else context.result_used then
						-- Generate Result definition
					buf.put_new_line_only
					buf.put_string ("#define Result ")
					buf.put_string (result_macro_prefix)
					buf.put_character (data_macro_suffix)
					if is_basic_type then
							-- Specify basic result type
						buf.put_character ('(')
						buf.put_string (c_type_name)
						buf.put_character (')')
					end
				end
			end
			buf.put_new_line
			buf.put_string (data_macro_prefix)
			buf.put_character (data_macro_suffix)
			buf.put_character ('(')
			if is_basic_type then
				buf.put_string (c_type_name)
				buf.put_string ({C_CONST}.comma_space)
			end
		end

feature {NONE} -- Status report

	is_once_creation: BOOLEAN
			-- Is it a creation procedure of a once class?
		do
			Result :=
				context.associated_class.is_once and then
				is_process_or_thread_relative_once and then
				(context.associated_class.has_creator_of_name_id (feature_name_id) or else
				context.associated_class.allows_default_creation and then
				attached context.associated_class.default_create_feature as d and then
				d.feature_name_id = feature_name_id)
		end

feature -- C code generation

	generate_once_declaration (a_name: STRING; a_type: TYPE_C)
			-- Generate declaration of static fields that keep once result or point to it.
		local
			buf: GENERATION_BUFFER
			declaration_macro_prefix: STRING
		do
				-- Register once code index
			if is_process_relative_once then
				context.add_process_relative_once (a_type, body_index)
			else
				check process_or_thread_relative: is_thread_relative_once end
				context.add_thread_relative_once (a_type, body_index)
			end
			if context.workbench_mode then
					-- Once result is accessed by index
				buf := buffer
				buf.put_new_line
				buf.put_string ("RTOID (")
				buf.put_string (a_name)
				buf.put_character (')')
			else
					-- Once result is kept in global static fields.
				buf := context.header_buffer
				if is_process_relative_once then
					declaration_macro_prefix := "RTOPH"
				elseif not System.has_multithreaded then
					declaration_macro_prefix := "RTOSH"
				end
				if declaration_macro_prefix /= Void then
						-- Generate static declaration and definition of `once_done'
						-- and `once_result' variables used to find out if once has
						-- already been computed or not.
					buf.put_new_line
					buf.put_string (declaration_macro_prefix)
					if a_type.is_void then
						buf.put_string ("P (")
					else
						buf.put_string ("F (")
						buf.put_string (a_type.c_string)
						buf.put_character (',')
					end
					buf.put_integer (body_index)
					buf.put_character (')')
				end
			end
		end

	generate_once_data (name: STRING)
			-- Generate once-specific data
		local
			buf: like buffer
		do
			buf := buffer
			if not is_object_relative_once then
				if context.workbench_mode then
					if is_process_relative_once then
						generate_once_result_definition ("RTOQR", "RTOQD")
					else
						generate_once_result_definition ("RTOTR", "RTOTD")
					end
					buf.put_string (generated_c_feature_name)
					buf.put_two_character (')', ';')
				elseif is_thread_relative_once and then System.has_multithreaded then
						-- Generate locals for thread-relative once routine
					generate_once_result_definition ("RTOTR", "RTOUD")
					buf.put_integer (context.thread_relative_once_index (body_index))
					buf.put_character (')')
				end
			end
			init_dftype
			init_dtype
			buf.put_new_line_only
		end

	generate_once_prologue (name: STRING)
			-- Generate test at the head of once routines
		local
			buf: like buffer
		do
				-- Object relative once are handled with _B objects and not with specific generated code.
				-- TODO: check that this decision for object-relative onces does not cause problems for recompilation.
			if not is_object_relative_once then
				buf := buffer
				buf.put_new_line
				if context.workbench_mode then
					if is_process_relative_once then
							-- Once is accessed using code index.
						buf.put_string ("RTOQP;")
						if context.result_used and then real_type (result_type).c_type.is_reference then
							buf.put_new_line
							buf.put_string ("RTOC_GLOBAL(Result);")
						end
					else
							-- Once is accessed using local variable.
						buf.put_string ("RTOTP;")
					end
				elseif is_process_relative_once then
						-- Once is accessed using code index
					buf.put_string ("RTOPP (")
					buf.put_integer (body_index)
					buf.put_string (");")
					if context.result_used then
						buf.put_new_line_only
						buf.put_string ("#define Result RTOPR(")
						buf.put_integer (body_index)
						buf.put_character (')')
						if real_type(result_type).c_type.is_reference then
							buf.put_new_line
							buf.put_string ("RTOC_GLOBAL(Result);")
						end
					end
				elseif System.has_multithreaded then
						-- Once is accessed using pre-calculated once index
					buf.put_string ("RTOTP;")
				else
						-- Once is accessed using code index
					buf.put_string ("RTOSP (")
					buf.put_integer (body_index)
					buf.put_string (");")
					if context.result_used then
						buf.put_new_line_only
						buf.put_string ("#define Result RTOSR(")
						buf.put_integer (body_index)
						buf.put_character (')')
						if real_type(result_type).c_type.is_reference then
							buf.put_new_line
							buf.put_string ("RTOC_NEW(Result);")
						end
					end
				end
			end
		end

	generate_once_epilogue (a_name: STRING)
			-- Generate end of a once block.
		local
			buf: like buffer
		do
				-- See `generate_once_prologue' for details.
				-- Object relative once are handled with _B objects and not with specific generated code.
				-- TODO: check that this decision for object-relative onces does not cause problems for recompilation.
			if not is_object_relative_once then
				buf := context.buffer
				buf.put_new_line
				if context.workbench_mode then
					buf.put_string (if is_process_relative_once then "RTOQE;" else "RTOTE;" end)
				elseif is_process_relative_once then
					buf.put_string ("RTOPE (");
					buf.put_integer (body_index)
					buf.put_string (");")
				elseif System.has_multithreaded then
					buf.put_string ("RTOTE;")
				else
					buf.put_string ("RTOSE (")
					buf.put_integer (body_index)
					buf.put_string (");")
				end
			end
		end

feature -- Inlining

	pre_inlined_code: like Current
			-- Never called!!! (a once function cannot be inlined)
		do
		end

	inlined_byte_code_type: INLINED_ONCE_BYTE_CODE
			-- Type for `inlined_byte_code'.
		do
		end

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
