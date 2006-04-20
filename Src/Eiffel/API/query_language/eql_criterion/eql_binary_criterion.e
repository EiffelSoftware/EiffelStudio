indexing
	description: "Object that represents a binary logic operation upon two EQL criteria"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_BINARY_CRITERION

inherit
	EQL_CRITERION

feature{NONE} -- Initialization

	make (a_cri1: like cri1; a_cri2: like cri2) is
			-- Initialize `cri1' with `a_cri1' and `cri2' with `a_cri2'.
		require
			a_cri1_not_void: a_cri1 /= Void
			a_cri2_not_void: a_cri2 /= Void
		do
			set_criteria (a_cri1, a_cri2)
		end

feature -- Operand criteria

	cri1: EQL_CRITERION
			-- First criterium	

	cri2: EQL_CRITERION
			-- Second criterium

feature -- Operand criteria setting

	set_cri1 (a_cri: like cri1) is
			-- Set `cri1' with `a_cri'.
		require
			a_cri_not_void: a_cri /= Void
		do
			cri1 := a_cri
		ensure
			cri1_set: cri1 = a_cri
		end

	set_cri2 (a_cri: like cri2) is
			-- Set `cri2' with `a_cri'.
		require
			a_cri_not_void: a_cri /= Void
		do
			cri2 := a_cri
		ensure
			cri2_set: cri2 = a_cri
		end

	set_criteria (a_cri1: like cri1; a_cri2: like cri2) is
			-- Initialize `cri1' with `a_cri1' and `cri2' with `a_cri2'.
		require
			a_cri1_not_void: a_cri1 /= Void
			a_cri2_not_void: a_cri2 /= Void
		do
			set_cri1 (a_cri1)
			set_cri2 (a_cri2)
		end

invariant
	cri1_not_void: cri1 /= Void
	cri2_not_void: cri2 /= Void

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
