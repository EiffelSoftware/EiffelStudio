indexing
	description	: "Stone representing a replayed call stack stone."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class
	REPLAYED_CALL_STACK_STONE

inherit
	FEATURE_STONE
		rename
			make as feature_make
		redefine
			same_as,
			synchronized_stone
		end

create
	make

feature {NONE} -- Initialization

	make (a_feature: E_FEATURE; a_position: TUPLE [line: INTEGER; nested: INTEGER]) is
			-- Initialize stone.
		require
			a_feature_not_void: a_feature /= Void
			a_position_not_void: a_position /= Void
		do
			feature_make (a_feature)
			call_position := a_position
		end

feature -- Properties

	call_position: TUPLE [line: INTEGER; nested: INTEGER]

feature -- Status report

	same_as (other: STONE): BOOLEAN is
			-- Is `other' the same stone?
			-- Ie: does `other' represent the same feature?
		do
			if {st: like Current} other then
				Result := Precursor (st) and then st.call_position.is_equal (call_position)
			end
		end

feature -- dragging

	synchronized_stone: CLASSI_STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		do
			if is_valid then
				Result := twin
			else
				Result := Precursor {FEATURE_STONE}
			end
		end

invariant
	call_position_not_void: call_position /= Void

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

end -- class FEATURE_STONE
