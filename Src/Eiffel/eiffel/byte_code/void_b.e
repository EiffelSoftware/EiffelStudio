note
	description: "Byte node for Void value."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VOID_B

inherit
	EXPR_B
		redefine
			is_constant_expression,
			is_fast_as_local,
			is_predefined,
			is_simple_expr,
			print_checked_target_register,
			print_register
		end

	SHARED_TYPES
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_void_b (Current)
		end

feature -- Access

	type: TYPE_A
			-- Expression type.
		do
			Result := detachable_none_type
		ensure then
			type_not_void: Result /= Void
		end

feature -- Status report

	is_simple_expr: BOOLEAN = True
			-- Void is a simple expression

	is_predefined: BOOLEAN = False
			-- Void is not predefined

	is_constant_expression: BOOLEAN = True
			-- Void is a constant.

	used (r: REGISTRABLE): BOOLEAN
			-- Is register `r' used in local or forthcomming dot calls ?
		do
			-- False
		ensure then
			not_used: not Result
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN = true
			-- Is expression calculation as fast as loading a local?

feature -- C code generation

	print_register
			-- Print Void value.
		do
			buffer.put_string ("NULL")
		end

	print_checked_target_register
			-- <Precursor>
		local
			buf: like {BYTE_CONTEXT}.buffer
		do
				-- Specify explicit type to allow for code with constant propagation, e.g.
				--    f (a: CELL [BOOLEAN]): BOOLEAN do if attached a then Result := a.item end end
				--    f (Void)
				-- After inlining the generated code could be
				--    if (NULL != NULL) { tb1 = *(EIF_BOOLEAN *)(RTCW(NULL) + O1234[Dtype(NULL)-56]); }
				-- so that the part "RTCW(NULL)" would expand into "((void *) 0)",
				-- but there is no operation "+" for type "(void *)", and C compilation would fail.
			buf := Context.buffer
			buf.put_string ({C_CONST}.rtcw_open)
			buf.put_string ("(EIF_REFERENCE) NULL)")
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
