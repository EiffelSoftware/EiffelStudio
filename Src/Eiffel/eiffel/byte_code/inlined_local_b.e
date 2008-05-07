indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class INLINED_LOCAL_B

inherit
	LOCAL_B
		redefine
			type, propagate, analyze, generate, free_register,
			print_register, enlarged, Current_register,
			is_local, used
		end

feature

	type: TYPE_A;

feature -- Status report

	is_local: BOOLEAN is False
		-- Not really a local.

feature

	fill_from (l: LOCAL_B) is
		do
			parent := l.parent;
			position := l.position;
			type := l.type
		end

	enlarged: INLINED_LOCAL_B is
		do
			Result := Current
		end

feature -- Register and code generation

	Current_register: INLINED_CURRENT_B is
		once
			create Result
		end

	propagate (r: REGISTRABLE) is
			-- Do nothing
		do
		end

	analyze is
			-- Do nothing
		do
		end;

	generate is
			-- Do nothing
		do
		end;

	free_register is
			-- Do nothing
		do
		end;

	print_register is
		do
			System.remover.inliner.inlined_feature.local_regs.item (position).print_register
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is `r' the same as us ?
		do
			if {l_local: like Current} r then
				Result := l_local.position = position
			end
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
