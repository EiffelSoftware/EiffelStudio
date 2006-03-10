indexing

	description:
		"Saves source class where invariant ast was defined%
		%which is to be used in then format context."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision $"

class INVARIANT_ADAPTER

feature -- Update

	register (invariant_ast: like ast; format_reg: FORMAT_REGISTRATION) is
			-- Initialize and register Current with invariant ast
			-- `ast'.
		require
			valid_ast: invariant_ast /= Void;
			valid_reg: format_reg /= Void
		do
			ast := invariant_ast;
			source_class := format_reg.current_class;
			format_reg.record_invariant (Current)
		ensure
			ast = invariant_ast;
			source_class = format_reg.current_class
		end;

feature -- Properties

	ast: INVARIANT_AS
			-- Associated invariant AST

	source_class: CLASS_C;
			-- Where invariant was defined

feature -- Output

	format (ctxt: TEXT_FORMATTER_DECORATOR) is
			-- Format invariant.
		do
			ctxt.begin
			ctxt.set_source_class (source_class)
			ctxt.format_ast (ast)
			ctxt.commit
		end;

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

end -- class class INVARIANT_ADAPTER
