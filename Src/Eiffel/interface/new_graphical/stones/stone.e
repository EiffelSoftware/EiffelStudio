note
	legal: "See notice at end of class."
	status: "See notice at end of class."
deferred class
	STONE

inherit
	EB_CONSTANTS

	EB_POSITIONABLE

feature -- Properties

	stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone.
			-- Default is Void, meaning no cursor is associated with `Current'.
		deferred
		end

	x_stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
			-- Default is Void, meaning no cursor is associated with `Current'.
		deferred
		end

feature  -- Access

	help_text: STRING_32
			-- Explaination of what current element means,
			-- "No help available" by default
		do
			Result := Interface_names.h_No_help_available.twin
		end

	stone_signature: STRING
			-- Short string to describe Current
			-- (basically the name of the stoned object).
		deferred
		end

	header: STRING_GENERAL
			-- String to describe Current
			-- (as it may be described in the title of a development window).
		deferred
		end

	history_name: STRING_32
			-- Name used in the history list,
			-- (By default, it is the stone_signature
			-- and a string to describe the type of stone (Class, feature,...)).
		deferred
		end

	is_valid: BOOLEAN
			-- Is `Current' a valid stone?
		do
			Result := True
		end

	is_storable: BOOLEAN
			-- Can `Current' be kept?
			-- True by default.
		do
			Result := True
		end

	synchronized_stone: STONE
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		do
			if is_valid then
				Result := Current
			end
		ensure
			valid_stone: Result /= Void implies Result.is_valid
		end

	same_as (other: STONE): BOOLEAN
			-- Is `other' same as Current?
			--| By default: Result = equal (Current, other).
		do
			if attached {like Current} other as o then
				Result := is_equal (o)
			end
		end

	stone_name: STRING_GENERAL
			-- Name of Current stone
		do
			Result := ""
		ensure
			result_attached: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class STONE
