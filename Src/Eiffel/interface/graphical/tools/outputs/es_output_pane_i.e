note
	description: "[
		A specialized output ({OUTPUT_I}) for use with EiffelStudio's output tool ({ES_OUTPUTS_TOOL}).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_OUTPUT_PANE_I

inherit
	OUTPUT_I

feature -- Access

	icon: !EV_PIXEL_BUFFER
			-- An icon representing the output pane.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

	icon_pixmap: !EV_PIXMAP
			-- A pixmap icon representing the output pane.
		require
			is_interface_usable: is_interface_usable
		do
			Result := icon.to_pixmap.as_attached
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

feature -- Query

	text_for_window (a_window: !SHELL_WINDOW_I): !STRING_32
			-- Retrieves current text for a given shell window.
			--
			-- `a_window': A window to retrieve an text for.
			-- `Result': The text for the given shell window.
		require
			is_interface_usable: is_interface_usable
			a_window_is_interface_usable: a_window.is_interface_usable
		deferred
		end

	output_window_for_window (a_window: !SHELL_WINDOW_I): !OUTPUT_WINDOW
			-- Retrieves a writer for a given shell window.
			--
			-- `a_window': A window to retrieve an output window for.
			-- `Result': An output window for the given shell window.
		require
			is_interface_usable: is_interface_usable
			a_window_is_interface_usable: a_window.is_interface_usable
		deferred
		ensure
			result_consistent: Result = output_window_for_window (a_window)
		end

feature -- Query: User interface elements

	widget_for_window (a_window: !SHELL_WINDOW_I): !ES_WIDGET [EV_WIDGET]
			-- Retrieves a graphical widget reprentation of the output for a given shell window.
			--
			-- `a_window': A window to retrieve an output window for.
			-- `Result': An output window widget for the given shell window.
		require
			is_interface_usable: is_interface_usable
			a_window_is_interface_usable: a_window.is_interface_usable
		deferred
		ensure
			result_consistent: Result = widget_for_window (a_window)
			result_is_interface_usable: Result.is_interface_usable
		end

feature -- Basic operations

	clear_window (a_window: !SHELL_WINDOW_I)
			-- Clears any cached output.
			--
			-- `a_window': A window to clear the output on.
		require
			is_interface_usable: is_interface_usable
			a_window_is_interface_usable: a_window.is_interface_usable
		local
			l_output_window: like output_window_for_window
		do
			l_output_window := output_window_for_window (a_window)
			if l_output_window /= Void then
				l_output_window.clear_window
			end
		end

;note
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

end
