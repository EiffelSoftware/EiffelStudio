note
	description: "[
		The ecosystem's default implementation for the {IDE_S} interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IDE

inherit
	IDE_S

	DISPOSABLE_SAFE

create
	make

feature {NONE} -- Creation.

	make
			-- Initialize event service.
		do
				-- Initialize events.
			create zoom_event
			auto_dispose (zoom_event)
			zoom_factor := 0
		end

feature -- Installation

	install
		do
		end

feature -- Access

	zoom_factor: INTEGER
			-- Current zoom factor value.

	set_zoom_factor (a_zoom_factor: INTEGER)
		do
			zoom_factor := a_zoom_factor
		end

feature -- Event

	zoom_event: EVENT_TYPE [TUPLE [zoom_factor: INTEGER]]
			-- <Precursor>

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

	ide_connection: EVENT_CONNECTION_I [IDE_OBSERVER, IDE_S]
			-- <Precursor>
		do
			Result := internal_connection
			if Result = Void then
				create {EVENT_CONNECTION [IDE_OBSERVER, IDE_S]} Result.make (
					agent (o: IDE_OBSERVER):
						ARRAY [TUPLE
							[event: EVENT_TYPE [INTEGER];
							action: PROCEDURE [INTEGER]]]
						do
							Result :=
								<<
									[zoom_event, agent o.on_zoom]
								>>
						end)
				automation.auto_dispose (Result)
				internal_connection := Result
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_connection: detachable like ide_connection
			-- Cached version of `ide_connection`.
			-- Note: Do not use directly!

invariant

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
