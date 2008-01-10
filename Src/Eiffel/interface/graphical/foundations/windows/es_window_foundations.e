indexing
	description: "[
		Base core for all EiffelStudio foundations windows and tool panels.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_WINDOW_FOUNDATIONS

inherit
	ES_TOOL_FOUNDATIONS
		rename
			foundation_widget as foundation_window
		redefine
			foundation_window,
			on_after_initialized
		end

feature {NONE} -- Initialization

    on_after_initialized
            -- Use to perform additional creation initializations, after the UI has been created.
        do
        	Precursor {ES_TOOL_FOUNDATIONS}
        		-- Register the internal event handlers, so we can guarentee state after execution because
        		-- sub classes cannot redefine the behavior.
        	register_action (foundation_window.show_actions, agent internal_on_shown)
        	register_action (foundation_window.hide_actions, agent internal_on_hidden)
        end

feature {NONE} -- Access

	foundation_window: EV_WINDOW
			-- Window used by tool foundation implementation
		deferred
		end

feature -- Status report

	is_recycled_on_closing: BOOLEAN
			-- Indicates if the foundation should be recycled on closing.
		deferred
		end

feature -- Actions

	show_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions performed when the foundation widget is shown.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_contains_attached_items: not Result.has (Void)
		end

	hide_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions performed when the foundation widget is hidden.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_contains_attached_items: not Result.has (Void)
		end

feature {NONE} -- Action handlers

	on_shown
			-- Called once the foundation widget has been shown.
		require
			is_interface_usable: is_interface_usable
			is_shown: is_shown
		do
		end

	on_hidden
			-- Called once the foundation widget has been hidden.
		require
			is_interface_usable: is_interface_usable
		do
		end

feature {NONE} -- Internal action handlers

	frozen internal_on_shown
			-- Called once the foundation widget has been shown.
		require
			is_interface_usable: is_interface_usable
			is_shown: is_shown
		do
			on_shown
			show_actions.call ([])
		end

	frozen internal_on_hidden
			-- Called once the foundation widget has been hidden.
		require
			is_interface_usable: is_interface_usable
		do
			on_hidden
			hide_actions.call ([])
			if is_recycled_on_closing then
				recycle
			end
		end

;indexing
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
