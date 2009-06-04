note
	description: "A notifier to informing users what assemblies are being consumed"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	NOTIFIER

inherit
	SYSTEM_OBJECT

	IDISPOSABLE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize notifier
		local
			l_thread: detachable SYSTEM_THREAD
			l_start: THREAD_START
		do
			create notify_form.make

				-- To make void-safe happy.
			l_thread := {SYSTEM_THREAD}.current_thread
			check l_thread_attached: l_thread /= Void end
			application_thread := l_thread

				-- Create the real thread
			create l_start.make (Current, $on_init)
			create l_thread.make (l_start)
			application_thread := l_thread
			l_thread.priority := {THREAD_PRIORITY}.highest
			l_thread.name := "Notifer"
			l_thread.start

			from
				l_thread := {SYSTEM_THREAD}.current_thread
				check l_thread_attached: l_thread /= Void end
			until
				notify_form.visible
			loop
				l_thread.sleep (10)
			end
		ensure
			application_thread_attached: application_thread /= Void
			not_application_thread_is_current_thread: application_thread /= {SYSTEM_THREAD}.current_thread
		end

	on_init
			-- Initialize worker application thread.
		local
			l_context: WINFORMS_APPLICATION_CONTEXT
		do
			create l_context.make_from_main_form (notify_form)
			{WINFORMS_APPLICATION}.run (l_context)
			check notify_form_attached: notify_form /= Void end
			notify_form.dispose
		end

feature -- Clean Up

	dispose
			-- Disposes of notifier
		do
			if notify_form /= Void then
				{WINFORMS_APPLICATION}.exit
			end
			if application_thread.is_alive then
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
		require
			notify_form_attached: notify_form /= Void
			a_message_attached: a_message /= Void
			not_is_zombie: not is_zombie
		do
			notify_form.notify_consume (a_message)
		end

	notify_info (a_message: STRING)
			-- Notifier user of an event
		require
			a_message_attached: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
		do
			notify_form.notify_info (a_message)
		end

	restore_last_notification
			-- Restores last message
		do
			notify_form.restore_last_notification
		end

	clear_notification
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

	application_thread: SYSTEM_THREAD
			-- Nofitier application thread

invariant
	notify_form_attached: not is_zombie implies notify_form /= Void

note
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
