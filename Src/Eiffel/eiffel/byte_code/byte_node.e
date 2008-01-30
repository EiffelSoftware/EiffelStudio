indexing
	description	: "Main description of a byte code tree node. All the classes which %
				  %describe the byte code inherit from us."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class BYTE_NODE

inherit
	SHARED_BYTE_CONTEXT
		export
			{ANY} all
		end

	SHARED_WORKBENCH

	SHARED_TYPE_I
		export
			{NONE} all
		end

	SHARED_GENERATION

	COMPILER_EXPORTER

	SHARED_IL_CODE_GENERATOR

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Visitor feature.
		require
			v_not_void: v /= Void
			v_valid: v.is_valid
		deferred
		end

feature -- Eiffel source line information

	line_number: INTEGER is
			-- Position where construct is located in Eiffel source.
		do
				-- Unknown by default.
			Result := -1
		ensure
			Result_positive: Result > 0
		end

	set_line_number (lnr: INTEGER) is
			-- Set `line_number' to `lnr'.
		require
			lnr_positive: lnr > 0
		do
			-- Nothing by default
		end

	generate_line_info is
			-- Generate source line information.
		local
			l_buffer: like buffer
		do
			if line_number > 0 and then System.line_generation then
				l_buffer := context.buffer
				l_buffer.put_new_line_only
				l_buffer.put_string (LINE_INFO)
				l_buffer.put_integer (line_number)
				l_buffer.put_character (' ')
				l_buffer.put_indivisible_string_literal (context.associated_class.lace_class.file_name)
			end
		end

	get_current_frozen_debugger_hook: INTEGER is
			-- Get the current hook number for the C debugger
		require
			workbench_mode: not context.final_mode or else system.exception_stack_managed
		do
			Result := context.get_breakpoint_slot
		end

	set_current_frozen_debugger_hook (a_hook_number: INTEGER) is
			-- Set the current hook number for the C debugger
			-- to `a_hook_number'
		require
			a_hook_number_positive: a_hook_number >= 0
		do
			context.set_breakpoint_slot (a_hook_number)
		end

	generate_frozen_debugger_hook is
			-- Generate the hook for the C debugger for the
			-- line number `lnr' (line number means breakpoint slot)
		local
			lnr: INTEGER
			l_buffer: like buffer
		do
			if not context.final_mode or else System.exception_stack_managed then
				if context.current_feature /= Void and then context.current_feature.supports_step_in then
					lnr := context.get_next_breakpoint_slot
					check
						lnr > 0
					end
					l_buffer := context.buffer
					l_buffer.put_new_line
					l_buffer.put_string(RTNHOOK_OPEN)
					l_buffer.put_integer(lnr)
					l_buffer.put_string(RTNHOOK_CLOSE)
				end
			end
		end

	generate_frozen_end_debugger_hook is
			-- Generate the hook for the C debugger corresponding
			-- to the end of the feature.
		local
			l_buffer: like buffer
			lnr: INTEGER
		do
			if not context.final_mode or else System.exception_stack_managed then
				if context.current_feature /= Void and then context.current_feature.supports_step_in then
					lnr := context.get_next_breakpoint_slot
					check
						lnr > 0
					end
					l_buffer := context.buffer
					l_buffer.put_new_line
					l_buffer.put_string (RTNHOOK_OPEN)
					l_buffer.put_integer (lnr)
					l_buffer.put_string (RTNHOOK_CLOSE)
				end
			end
		end

	generate_frozen_debugger_hook_nested is
			-- Generate the hook for the C debugger for the
			-- line number `lnr' (line number means breakpoint slot)
		local
			lnr: INTEGER
			l_buffer: like buffer
		do
				-- used to generate a debugger hook in the middle of nested call
				-- to be able to enter in the function applicated to the object
				-- with the debugger.
				--
				-- Example: a:A is
				--            do
				--            	if ... then
				--					Result := a1
				--				else
				--					Result := a2
				--            end
				--
				-- "a.toto; b.titi" will be generated as follow
				--
				-- debugger_hook(line n)
				-- retrieve a
				-- debugger_hook_nested(line n)
				-- call toto
				-- debugger_hook(line n+1)
				-- call b.titi
				--
				-- Note: the line number is not increased !!

			if not context.final_mode then
				if context.current_feature /= Void and then context.current_feature.supports_step_in then
					lnr := context.get_breakpoint_slot
						-- if lnr = 0 or -1 then we do nothing.
					if lnr > 0 then
						l_buffer := context.buffer
						l_buffer.put_new_line
						l_buffer.put_string(RTNHOOK_OPEN)
						l_buffer.put_integer(lnr)
						l_buffer.put_string(RTNHOOK_CLOSE)
					end
				end
			end
		end

	generate_melted_end_debugger_hook (ba: BYTE_ARRAY) is
			-- Record the breakable point corresponding to the end of the feature.
		local
			lnr: INTEGER
		do
			if context.current_feature /= Void and then context.current_feature.supports_step_in then
				lnr := context.get_next_breakpoint_slot
				check
					valid_line: lnr > 0
				end
				ba.generate_melted_debugger_hook (lnr)
			end
		end

feature {NONE} -- Implementation

	RTNHOOK_OPEN: STRING = "RTNHOOK("
	RTNHOOK_CLOSE: STRING = ");"
	LINE_INFO: STRING = "#line"
		-- String constants for generating debugging information.

feature

	null_byte_node: BYTE_LIST [BYTE_NODE] is
			-- Null instructions
		once
			create Result.make (0)
		end

	buffer: GENERATION_BUFFER is
			-- Generated file
		do
			Result := context.buffer
		ensure
			Result_not_void: Result /= Void
		end

	real_type (typ: TYPE_I): TYPE_I is
			-- Real type
		require
			typ_not_void: typ /= Void
		do
			Result := context.real_type (typ)
		ensure
			Result_not_void: Result /= Void
		end

	enlarge_tree is
			-- Enlarges the tree for suitable decoration
		do
		end

	enlarged: like Current is
			-- Enlarge current node for C code generation
		do
			Result := Current
		ensure
			Result_not_void: Result /= Void
		end

	need_enlarging: BOOLEAN is
			-- Does current node need to be enlarged ?
		do
		end

	analyze is
			-- First pass to build a proper context
		do
		end

	generate is
			-- Generate C code in `buffer'
		do
		end

	find_assign_result is
			-- Find assignments in Result at the very last
			-- instruction in a function.
		do
		end

	mark_last_instruction is
			-- Mark a last instruction if it needs special
			-- considerations (as formatting is concerned).
		do
		end

	last_all_in_result: BOOLEAN is
			-- Are all the exit points in a function occupied
			-- by an assignment in Result ?
		do
		end

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
		end

	is_unsafe: BOOLEAN is
		do
		end

	assigns_to (i: INTEGER): BOOLEAN is
			-- i > 0:	Does this byte node assign something to the attribute
			--			of `feature_id' `i'?
			-- i = 0:	Does this byte node assign something to `Result'
			-- i < 0:	Does this byte node assign something to the local # <-n>
		do
		end

	optimized_byte_node: like Current is
			-- Modify the byte code if the loop optimization is safe
		do
			Result := Current
		ensure
			Result_not_void: Result /= Void
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := 0
		ensure
			Result_greater_or_equal_to_one: Result >= 0
		end

	pre_inlined_code: like Current is
			-- Modified byte code: all the accesses to locals, Result,
			-- arguments, Current are modified to use local variables of
			-- the client
		do
			Result := Current
		ensure
			Result_not_void: Result /= Void
		end

	inlined_byte_code: like Current is
			-- Perform inlining in the current byte node
		do
			Result := Current
		ensure
			Result_not_void: Result /= Void
		end

indexing
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
