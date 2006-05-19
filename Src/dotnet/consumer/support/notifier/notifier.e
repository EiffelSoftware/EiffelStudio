indexing
	description: "A notifier to informing users what assemblies are being consumed"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFIER

inherit
	IDISPOSABLE

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize notifier
		local
			l_thread: SYSTEM_THREAD
			l_start: THREAD_START
		do
			create l_start.make (Current, $on_init)
			create l_thread.make (l_start)
			l_thread.priority := {THREAD_PRIORITY}.highest
			l_thread.start

			from until
				notify_form /= Void and then notify_form.visible
			loop
				{SYSTEM_THREAD}.current_thread.sleep (10)
			end
		end

	on_init is
			-- Initialize worker application thread.
		do
			create notify_form.make
			{WINFORMS_APPLICATION}.run (notify_form)
		end

feature -- Clean Up

	dispose is
			-- Disposes of notifier
		do
			check
				notify_form_attached: notify_form /= Void
			end
			if notify_form /= Void then
				{WINFORMS_APPLICATION}.exit
				notify_form := Void
			end
		ensure then
			notify_form_unattached: notify_form = Void
			is_zombie: is_zombie
		end

feature -- Status Report

	is_zombie: BOOLEAN
			-- Indicates object has been disposed of

feature -- Status Setting

	notify_consume (a_name, a_path, a_id, a_reason, a_version, a_cache: SYSTEM_STRING) is
			-- Notifies user of a consume
		require
			notify_form_attached: notify_form /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: a_name.length > 0
			a_path_attached: a_path /= Void
			not_a_path_is_empty: a_path.length > 0
			a_id_attached: a_id /= Void
			not_a_id_is_empty: a_id.length > 0
			a_reason_attached: a_reason /= Void
			not_a_reason_is_empty: a_reason.length > 0
			a_cache_attached: a_cache /= Void
			not_a_cache_is_empty: a_cache.length > 0
			not_is_zombie: not is_zombie
		do
			notify_form.notify_consume (a_name, a_path, a_id, a_reason, a_version, a_cache)
		end

	clear_notification is
			-- Clears last notification message.
		require
			notify_form_attached: notify_form /= Void
			not_is_zombie: not is_zombie
		do
			notify_form.clear_notification
		end

feature -- Implementation

	notify_form: NOTIFY_FORM;
			-- Windows form used to notify users of consumption

invariant
	notify_form_attached: not is_zombie implies notify_form /= Void

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

end -- class NOTIFIER
