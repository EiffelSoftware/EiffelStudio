note
	description: "[
		Aguments EiffelVision2 custom widgets with the ability to query their parent container window.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	TOP_LEVEL_WINDOW_PROVIDER

inherit
	ANY
		undefine
			default_create,
			copy,
			is_equal
		end

feature -- Access

	parent: EV_CONTAINER
			-- Parent container of `Current'
		deferred
		ensure
			result_attached: Result /= Void
		end

	top_level_window: EV_WINDOW
			-- Retrieve top level window
		local
			l_parent: EV_CONTAINER
		do
			Result ?= Current
			if Result = Void then
				l_parent := parent
				from until Result /= Void loop
					Result ?= l_parent
					if Result = Void then
						l_parent := l_parent.parent
					end
				end
			end
		end

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
