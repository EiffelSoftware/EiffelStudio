indexing
	description: "Allows non GUI threads to add idle actions to GUI thread%
					%Protect all access to idle actions list"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_THREAD_APPLICATION_IMP

inherit
	EV_APPLICATION_IMP
		redefine
			make,
			call_idle_actions,
			add_idle_action,
			do_once_on_idle
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Initialize thread handling.
		do
			if not g_thread_supported then
				g_thread_init
			end
			check
				threading_supported: g_thread_supported
			end
				-- Initialize the recursive mutex.
			static_mutex := new_g_static_rec_mutex
			g_static_rec_mutex_init (static_mutex)

			Precursor {EV_APPLICATION_IMP} (an_interface)
		end

feature -- Idle Action Handling

	do_once_on_idle (an_action: PROCEDURE [ANY, TUPLE]) is
			-- Perform `an_action' one time only on idle.
			-- Thread safe.
		do
			lock
			Precursor {EV_APPLICATION_IMP} (an_action)
			unlock
		end

	add_idle_action (a_idle_action: PROCEDURE [ANY, TUPLE]) is
			-- Extend `idle_actions' with `a_idle_action'.
			-- Thread safe.
		do
			lock
			idle_actions.extend (a_idle_action)
			unlock
		end

feature -- Thread Handling.

	lock is
			-- Lock the Mutex.
		do
			g_static_rec_mutex_lock (static_mutex)
		end

	try_lock: BOOLEAN is
			-- Try to see if we can lock, False means no lock could be attained
		do
			Result := g_static_rec_mutex_trylock (static_mutex)
		end

	unlock is
			-- Unlock the Mutex.
		do
			g_static_rec_mutex_unlock (static_mutex)
		end

feature {NONE} -- Implementation

	call_idle_actions is
			-- Execute idle actions.
		do
				-- If we cannot obtain a lock then do not call idle actions, it will be called again in the next CPU slice.
			if try_lock then
				Precursor {EV_APPLICATION_IMP}
				unlock
			end
		end

feature {NONE} -- Externals

	static_mutex: POINTER
		-- Pointer to the global static mutex

	new_g_static_rec_mutex: POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"malloc (sizeof(GStaticRecMutex))"
		end

	frozen g_static_rec_mutex_init (a_static_mutex: POINTER) is
		external
			"C signature (GStaticRecMutex*) use <gtk/gtk.h>"
		end

	frozen g_static_rec_mutex_lock (a_static_mutex: POINTER) is
		external
			"C blocking signature (GStaticRecMutex*) use <gtk/gtk.h>"
		end

	frozen g_static_rec_mutex_trylock (a_static_mutex: POINTER): BOOLEAN is
		external
			"C blocking signature (GStaticRecMutex*): gboolean use <gtk/gtk.h>"
		end

	frozen g_static_rec_mutex_unlock (a_static_mutex: POINTER) is
		external
			"C signature (GStaticRecMutex*) use <gtk/gtk.h>"
		end

	frozen g_thread_supported: BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_thread_supported()"
		end

	frozen g_thread_init is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				#ifdef EIF_THREADS
					g_thread_init (NULL);
				#endif
			}
			]"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class EV_THREAD_APPLICATION_IMP
