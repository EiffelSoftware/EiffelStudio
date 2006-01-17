indexing

	description: 
		""
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class AST_LACE

inherit
	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER;
	SHARED_L_CONTEXT;
	COMPILER_EXPORTER

feature {COMPILER_EXPORTER}

	adapt is
			-- Process options to cluster.
		do
		end

	adapt_defaults is
			-- Process Ace default options to cluster level.
		do
			adapt
		end

feature -- Duplication

	duplicate: like Current is
			-- Do a full copy of Current and its sub-ojects.
		deferred
		ensure
			duplicated: Result /= Void and then Result /= Current
			-- We should ensure that `is_equal' is defined for all
			-- descendants of `AST_LACE' but we do not have time to
			-- define it at the moment.
			-- valid_duplication: Result.is_equal (Current)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		require
			same_type: other /= Void implies same_type (other) 
		deferred
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		require
			st_not_void: st /= Void
		deferred
		end

feature {AST_LACE} -- Safe duplication

	frozen duplicate_ast (ast: AST_LACE): like ast is
			-- Do a full copy of `ast' and its sub-ojects.
		do
			if ast /= Void then
				Result := ast.duplicate
			end
		end

feature {AST_LACE} -- Safe comparison

	frozen same_ast (target: AST_LACE; other: like target): BOOLEAN is
			-- Is `target' same as `other'?
		do
			Result := (target = Void and then other = Void) or else
				((target /= Void and other /= Void) and then
				target.same_type (other) and then target.same_as (other))
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

end -- class AST_LACE
