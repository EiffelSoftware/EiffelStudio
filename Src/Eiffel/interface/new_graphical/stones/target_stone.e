note
	description: "Stone for configuration targets."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_STONE

inherit
	STONE
		redefine
			is_valid,
			stone_name
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like target)
			-- Create.
		require
			a_target_ok: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

feature -- Properties

	stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		once
			Result := cursors.cur_target
		end

	x_stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		once
			Result := cursors.cur_x_target
		end

feature -- Access

	target: CONF_TARGET
			-- Target we are representing

	stone_signature: STRING
			-- Short string to describe Current
			-- (basically the name of the stoned object).
		do
			Result := target.name
		end

	header: STRING_GENERAL
			-- String to describe Current
			-- (as it may be described in the title of a development window).
		do
			Result := stone_signature
		end

	history_name: STRING_32
			-- Name used in the history list,
			-- (By default, it is the stone_signature
			-- and a string to describe the type of stone (Class, feature,...)).
		do
			Result := stone_signature
		end

	stone_name: STRING_GENERAL
			-- Name of Current stone
		do
			if is_valid then
				Result := target.name.twin
			else
				Result := Precursor
			end
		end

	set_is_delayed_application_target (b: BOOLEAN)
			-- Set `is_delayed_application_target' with `b'.
		do
			is_delayed_application_target := b
		ensure
			is_delayed_application_target_set: is_delayed_application_target = b
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Is `Current' a valid stone?
		local
			l_target: CONF_TARGET
		do
			l_target := eiffel_universe.conf_system.targets.item (target.name)
			Result := target = l_target
		end

	is_delayed_application_target: BOOLEAN
			-- Does current stone represents a delayed application target?		
			-- Used by metric tool

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
