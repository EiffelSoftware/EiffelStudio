note
	description	: "Byte code to handle the `rescue_clause'."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class DO_RESCUE_B

inherit
	INSTR_B
		redefine
			analyze, generate, enlarge_tree,
			find_assign_result, last_all_in_result,
			assigns_to, is_unsafe,
			optimized_byte_node, calls_special_features,
			size, inlined_byte_code, pre_inlined_code, enlarged, need_enlarging
		end

create
	make

feature {NONE} -- Initialization

	make (a_compound: like compound; a_rescue: like rescue_clause)
			-- Initialize rescue clause with `a_compound', `a_rescue_clause' and `a_is_once'.
		do
			compound := a_compound
			rescue_clause := a_rescue
		ensure
			compount_set: compound = a_compound
			rescue_clause_set: rescue_clause = a_rescue
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_do_rescue_b (Current)
		end

feature -- Access

	compound: BYTE_LIST [BYTE_NODE]
			-- Main compound {list of INSTR_B}

	rescue_clause: BYTE_LIST [BYTE_NODE]
			-- Main rescue_clause {list of INSTR_B}

	wrapped_into_byte_list: BYTE_LIST [BYTE_NODE]
		do
			create Result.make (1)
			Result.extend (Current)
		end

feature -- Settings

	set_compound (c: like compound)
			-- Assign `c' to `compound'.
		do
			compound := c
		end

	set_rescue_clause (c: like rescue_clause)
			-- Assign `c' to `rescue_clause'.
		do
			rescue_clause := c
		end

	need_enlarging: BOOLEAN
			-- Does current need to be modified for improved code generation?
 		do
				-- Made `need_enlarging' return True in final mode. This enables us to implement
				-- `enlarged' that will simplify current IF_B node into something simpler if
				-- associated boolean expressions can be simplified.
			Result := context.final_mode
		end

	enlarged: INSTR_B
			-- Enlarge the tree to get more attributes and return the
			-- new enlarged tree node.
		do
			Result := Current
			if attached compound as c then
				c.enlarge_tree
			end
			if attached rescue_clause as r then
				r.enlarge_tree
			end
		end

	enlarge_tree
			-- Enlarge the if construct
		do
			if attached compound as c then
				c.enlarge_tree
			end
			if attached rescue_clause as r then
				r.enlarge_tree
			end
		end

	find_assign_result
			-- Find all terminal assignments made to Result
		do
			if attached compound as c then
				c.finish
				c.item.find_assign_result
			end
			if attached rescue_clause as r then
				r.finish
				r.item.find_assign_result
			end
		end

	last_all_in_result: BOOLEAN
			-- Are all the exit points in the function assignments
			-- in a Result entity ?
		do
			if attached compound as c then
				c.finish
				Result := c.item.last_all_in_result
			end
			if Result and attached rescue_clause as r then
				r.finish
				Result := r.item.last_all_in_result
			else
				Result := False
			end
			Result := Result and not context.has_postcondition and
					not context.has_invariant
		end

	analyze
			-- Builds a proper context (for C code).
		do
			context.init_propagation
			if attached compound as c then
				c.analyze
			end
			if attached rescue_clause as r then
				r.analyze
			end
		end

	trace_enabled: BOOLEAN
			-- Is the trace enabled for the associated class
			-- in final mode?
		do
			Result := not context.workbench_mode and
				Context.associated_class.trace_level.is_yes
		end

	profile_enabled: BOOLEAN
			-- Is the profile enabled for the associated class
			-- in final mode?
		do
			Result := not context.workbench_mode and
				Context.associated_class.profile_level.is_yes
		end

	generate_profile_stop
			-- Generate the "stop of progile" macro
		local
			buf: GENERATION_BUFFER
		do
			if profile_enabled then
				buf := buffer
				buf.put_new_line
				buf.put_string ("RTXP;")
			end
		end

	generate
			-- Generate C code in `buffer'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer

			if rescue_clause /= Void then
					-- Generate a `setjmp' C instruction in case of a
					-- rescue clause
				if trace_enabled then
					buf.put_new_line
					buf.put_string ("RTTI;")
				end
				if profile_enabled then
					buf.put_new_line
					buf.put_string ({C_CONST}.rtpi)
					buf.put_character (';')
				end
				buf.put_new_line
				buf.put_string ("RTE_T")
			end
			if attached compound as c then
				buf.indent
				c.generate
				buf.exdent
			end

			generate_rescue
		end

	generate_rescue
			-- Generate the rescue clause
		local
			nb_refs: INTEGER
			buf: GENERATION_BUFFER
		do
			if attached rescue_clause as r then
				buf := buffer
				buf.put_new_line
				buf.put_string ("RTE_E")
					-- Restore the C operational stack
				if context.workbench_mode then
					buf.put_new_line
					buf.put_string ("RTLXE;")
				end
					-- Resynchronize local variables stack
				nb_refs := context.ref_var_used
				buf.put_new_line
				buf.put_string ("RTXSC;")
				r.generate
				generate_profile_stop
				buf.put_new_line
				buf.put_string ("/* NOTREACHED */")
				buf.put_new_line
				buf.put_string ("RTE_EE")
			else
				context.generate_external_result_check
			end
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN
		do
			Result := (attached compound as c and then c.assigns_to (i)) or else
					(attached rescue_clause as r and then r.assigns_to (i))
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			Result := (attached compound as c and then c.calls_special_features (array_desc)) or else
				(attached rescue_clause as r and then r.calls_special_features (array_desc))
		end

	is_unsafe: BOOLEAN
		do
			Result := (attached compound as c and then c.is_unsafe) or else
				(attached rescue_clause as r and then r.is_unsafe)
		end

	optimized_byte_node: like Current
		do
			Result := Current
			if attached compound as c then
				compound := c.optimized_byte_node
			end

			if attached rescue_clause as r then
				rescue_clause := r.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER
		do
			Result := 1
			if attached compound as c then
				Result := Result + c.size
			end
			if attached rescue_clause as r then
				Result := Result + r.size
			end
		end

	pre_inlined_code: like Current
		do
			Result := Current
			if attached compound as c then
				compound := c.pre_inlined_code
			end
			if attached rescue_clause as r then
				rescue_clause := r.pre_inlined_code
			end
		end

	inlined_byte_code: like Current
		do
			Result := Current
			if attached compound as c then
				compound := c.inlined_byte_code
			end
			if attached rescue_clause as r then
				rescue_clause := r.inlined_byte_code
			end
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
