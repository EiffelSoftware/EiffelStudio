indexing
	description: "Abstract class for Eiffel types."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TYPE_AS

inherit
	AST_EIFFEL

feature -- Roundtrip

	lcurly_symbol, rcurly_symbol: SYMBOL_AS
			-- Left and/or right curly symbol(s) associated with this structure
			-- Maybe none of them, or maybe only left curly appears.

	set_lcurly_symbol (s_as: SYMBOL_AS) is
			-- Set `lcurly_symbol' with `s_as'.
		do
			lcurly_symbol := s_as
		ensure
			lcurly_symbol_set: lcurly_symbol = s_as
		end

	set_rcurly_symbol (s_as: SYMBOL_AS) is
			-- Set `rcurly_symbol' with `s_as'.
		do
			rcurly_symbol := s_as
		ensure
			rcurly_symbol_set: rcurly_symbol = s_as
		end

feature -- Properties

	has_like: BOOLEAN is
			-- Is the type an anchored type ?
		do
			-- Do nothing
		end;

	has_formal_generic: BOOLEAN is
			-- Has type a formal generic parameter?
		do
			-- Do nothing
		end

	is_loose: BOOLEAN is
			-- Does type depend on formal generic parameters and/or anchors?
		do
			-- Do nothing
		ensure
			definition: Result = (has_like or has_formal_generic)
		end

	is_void: BOOLEAN is
			-- Is the type void (procedure type) ?
		do
			-- Do nothing
		end;

	is_like_current: BOOLEAN is
			-- Is the current type a anchored type an Current ?
		do
			-- Do nothing
		end;

feature -- Access

	frozen is_deep_equal (other: TYPE_AS): BOOLEAN is
			-- Is the current type the same as `other' ?
			--| `deep_equal' cannot be used as for STRINGS, the area
			--| can have a different size but the STRING is still
			--| the same (problem detected for LIKE_FEATURE). Xavier
		do
			Result := other /= Void and then other.same_type (Current)
				and then is_internal_equivalent (other)
		end;

feature -- Comparison

	same_as (other: TYPE_AS): BOOLEAN is
			-- Is `other' the same as Current ?
			--|Note: implemented only for descendants of TYPE_A
		do
		end;

feature {NONE} -- Comparison

	frozen is_internal_equivalent (other: TYPE_AS): BOOLEAN is
			-- Safe call for descendants classes of AST_EIFFEL to `is_equivalent'.
		require
			other_not_void: other /= Void
			same_type: same_type (other)
		local
			l_other: like Current
		do
			l_other ?= other
			check
				not_void_since_same_type: l_other /= Void
			end
			Result := is_equivalent (l_other)
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		deferred
		end;

feature

	actual_type: TYPE_A is
		do
			fixme ("Manu")
		end
feature --

	is_solved: BOOLEAN is
			-- Is the type solved ? (i.e: is the type a result to a call
			-- to feature `solved_type' ?)
		do
			-- Do nothing
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

end -- class TYPE_AS
