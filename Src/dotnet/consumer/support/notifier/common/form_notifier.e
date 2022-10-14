note
	description: "A notifier to informing users what assemblies are being consumed"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	FORM_NOTIFIER

inherit
	NOTIFIER

	SYSTEM_OBJECT

	IDISPOSABLE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize notifier
		local
			t: SYSTEM_THREAD
		do
				-- To make void-safe happy.
			check attached {SYSTEM_THREAD}.current_thread as l_thread then
				application_thread := l_thread
					-- Create the real thread
				create t.make (create {THREAD_START}.make (Current, $on_init))
				t.priority := {THREAD_PRIORITY}.highest
				t.name := "Notifer"
				t.start
				from
				until
					attached notify_form as l_form and then l_form.visible
				loop
					l_thread.sleep (10)
				end
			end
		ensure
			application_thread_attached: application_thread /= Void
			not_application_thread_is_current_thread: application_thread /= {SYSTEM_THREAD}.current_thread
		end

	on_init
			-- Initialize worker application thread.
		local
			l_context: WINFORMS_APPLICATION_CONTEXT
			l_notify_form: like notify_form
		do
			create l_notify_form.make
			notify_form := l_notify_form
			create l_context.make_from_main_form (l_notify_form)
			{WINFORMS_APPLICATION}.add_idle (create {EVENT_HANDLER}.make (Current, $on_idle))
			{WINFORMS_APPLICATION}.run (l_context)
		end

	on_idle (a_sender: detachable SYSTEM_OBJECT; a_args: detachable EVENT_ARGS)
			-- Action to be called on idle to refresh the content of the ballon if needed.
		do
			if attached notify_form as l_form then
				l_form.on_idle (a_sender, a_args)
			end
		end

feature -- Clean Up

	dispose
			-- Disposes of notifier
		do
			if attached notify_form then
				{WINFORMS_APPLICATION}.exit
			end
			if
				attached {SYSTEM_THREAD}.current_thread as t and then
				t.managed_thread_id /= application_thread.managed_thread_id and then
				application_thread.is_alive
			then
				application_thread.join
			end
			is_zombie := True
		ensure then
			is_zombie: is_zombie
		end

feature -- Status Report

	is_zombie: BOOLEAN
			-- Indicates object has been disposed of

feature -- Status Setting

	notify_consume (a_message: NOTIFY_MESSAGE)
			-- Notifies user of a consume
		do
			if attached notify_form as l_form then
				l_form.notify_consume (a_message)
			end
		end

	notify_info (a_message: READABLE_STRING_32)
			-- Notifier user of an event
		do
			if attached notify_form as l_form then
				l_form.notify_info (a_message)
			end
		end

	restore_last_notification
			-- Restores last message
		do
			if attached notify_form as l_form then
				l_form.restore_last_notification
			end
		end

	clear_notification
			-- Clears last notification message.
		do
			if attached notify_form as l_form then
				l_form.clear_notification
			end
		end

feature -- Implementation

	notify_form: detachable NOTIFY_FORM;
			-- Windows form used to notify users of consumption

	application_thread: SYSTEM_THREAD
			-- Nofitier application thread

invariant
	notify_form_attached: not is_zombie implies notify_form /= Void

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
