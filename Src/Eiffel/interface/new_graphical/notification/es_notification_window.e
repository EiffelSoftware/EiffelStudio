note
	description: "Summary description for {ES_NOTIFICATION_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NOTIFICATION_WINDOW

inherit
	EV_POPUP_WINDOW

	ES_SHARED_FONTS_AND_COLORS
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_message: NOTIFICATION_MESSAGE; a_manager: like manager)
		do
			make_with_shadow
			message := a_message
			manager := a_manager
			build_interface
		end

feature -- Access

	manager: detachable ES_NOTIFICATION_MANAGER

	message: NOTIFICATION_MESSAGE

feature -- Element change

	build_interface
		local
			l_widget: ES_NOTIFICATION_WIDGET
		do
			create l_widget.make (message)
			l_widget.set_terminate_action (agent close)
			extend (l_widget)
		end

	auto_close
		do
			reset_auto_close_timeout
			if attached manager as l_manager then
				l_manager.deactivate_notification (Current, True)
			end
			destroy
		end

	close
		do
			reset_auto_close_timeout
			if attached manager as l_manager then
				l_manager.deactivate_notification (Current, False)
			end
			destroy
		end

	set_auto_close_delay (a_delay_ms: INTEGER)
		local
			t: EV_TIMEOUT
		do
			t := auto_close_timeout
			if t /= Void then
				t.destroy
			end
			create t
			auto_close_timeout := t
			t.actions.extend (agent auto_close)
			t.set_interval (a_delay_ms)
		end

feature {NONE} -- Implementation

	reset_auto_close_timeout
		do
			if attached auto_close_timeout as l_timeout then
				l_timeout.destroy
				auto_close_timeout := Void
			end
		end

	auto_close_timeout: detachable EV_TIMEOUT

invariant

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
