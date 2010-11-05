note
	description	: "Byte code for TRY EXCEPT END."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class TRY_B

inherit
	INSTR_B
		redefine
			analyze, generate, enlarge_tree,
			find_assign_result, last_all_in_result,
			assigns_to, is_unsafe,
			optimized_byte_node, calls_special_features,
			size, inlined_byte_code, pre_inlined_code, enlarged, need_enlarging
		end

	VOID_REGISTER
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_try_b (Current)
		end

feature -- Access

	compound: BYTE_LIST [BYTE_NODE]
			-- Main compound {list of INSTR_B}

	except_part: BYTE_LIST [BYTE_NODE]
			-- Default compound {list of INSTR_B}

	wrapped_into_byte_list: BYTE_LIST [BYTE_NODE]
		do
			create Result.make (1)
			Result.extend (Current)
		end

	propagating_exception: BOOLEAN
			-- Exception propagated if occurred?
			--| i.e: calling ereturn()...

feature -- Settings

	propagate_exception
			-- Enable the `propagating_exception'
		do
			propagating_exception := True
		end

	set_compound (c: like compound)
			-- Assign `c' to `compound'.
		do
			compound := c
		end

	set_except_part (e: like except_part)
			-- Assign `e' to `except_part'.
		do
			except_part := e
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
			if attached except_part as e then
				e.enlarge_tree
			end
		end

	enlarge_tree
			-- Enlarge the if construct
		do
			if attached compound as c then
				c.enlarge_tree
			end
			if attached except_part as e then
				e.enlarge_tree
			end
		end

	find_assign_result
			-- Find all terminal assignments made to Result
		do
			if attached compound as c then
				c.finish
				c.item.find_assign_result
			end
			if attached except_part as e then
				e.finish
				e.item.find_assign_result
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
			if attached except_part as e and Result then
				e.finish
				Result := e.item.last_all_in_result
			else
					-- No else part, so we may continue.
					-- As this is the LAST compound statement, this
					-- means we are followed by an implicit return Result.
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
			if attached except_part as e then
				e.analyze
			end
		end

	generate
			-- Generate C code in `buffer'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
				-- Generate the hook for "if cond then"

			buf.put_new_line
			buf.put_string ("RTO_TRY")
			if attached compound as c then
				buf.indent
				c.generate
				buf.exdent
			end
			buf.put_new_line
			buf.put_string ("RTO_EXCEPT")
			if attached except_part as e then
				buf.indent
				e.generate
				buf.exdent
			end
			if propagating_exception then
				buf.put_new_line
				buf.put_string ("ereturn();")
			end
			buf.put_new_line
			buf.put_string ("RTO_END_EXCEPT")
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN
		do
			Result := (attached compound as c and then c.assigns_to (i)) or else
					(attached except_part as e and then e.assigns_to (i))
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			Result := (attached compound as c and then c.calls_special_features (array_desc)) or else
					(attached except_part as e and then e.calls_special_features (array_desc))
		end

	is_unsafe: BOOLEAN
		do
			Result := (attached compound as c and then c.is_unsafe) or else
					(attached except_part as e and then e.is_unsafe)
		end

	optimized_byte_node: like Current
		do
			Result := Current
			if attached compound as c then
				compound := c.optimized_byte_node
			end
			if attached except_part as e then
				except_part := e.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER
		do
			Result := 1
			if attached compound as c then
				Result := Result + c.size
			end
			if attached except_part as e then
				Result := Result + e.size
			end
		end

	pre_inlined_code: like Current
		do
			Result := Current
			if compound /= Void then
				compound := compound.pre_inlined_code
			end
			if except_part /= Void then
				except_part := except_part.pre_inlined_code
			end
		end

	inlined_byte_code: like Current
		do
			Result := Current
			if attached compound as c then
				compound := c.inlined_byte_code
			end
			if attached except_part as e then
				except_part := e.inlined_byte_code
			end
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
