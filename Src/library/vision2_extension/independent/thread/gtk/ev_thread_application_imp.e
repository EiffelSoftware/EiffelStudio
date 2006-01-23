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
			idle_actions
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Initialize thread handling and call precursor.
		do
				-- Initialize glib thread handling.
			g_thread_init
				-- Initialize gdk thread handling.
			{EV_GTK_EXTERNALS}.gdk_threads_init
			Precursor {EV_APPLICATION_IMP} (an_interface)
		end

feature -- Event Handling

	add_idle_action (a_idle_action: PROCEDURE [ANY, TUPLE]) is
			-- Extend `idle_actions' with `a_idle_action'.
			-- Thread safe
		do
			{EV_GTK_EXTERNALS}.gdk_threads_enter	
			idle_actions.extend (a_idle_action)
			{EV_GTK_EXTERNALS}.gdk_threads_leave
		end

feature -- Event handling

	idle_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when the application is otherwise idle.
		do
			{EV_GTK_EXTERNALS}.gdk_threads_enter	
			Result := Precursor {EV_APPLICATION_IMP}
			{EV_GTK_EXTERNALS}.gdk_threads_leave
		end

feature {NONE} -- Implementation

	call_idle_actions is
			-- Execute idle actions.
		do
			{EV_GTK_EXTERNALS}.gdk_threads_enter
			internal_idle_actions.call (Void)
			{EV_GTK_EXTERNALS}.gdk_threads_leave
			if idle_actions_internal /= Void then
				{EV_GTK_EXTERNALS}.gdk_threads_enter
				idle_actions_internal.call (Void)
				{EV_GTK_EXTERNALS}.gdk_threads_leave
			end
		end
feature {NONE} -- Externals

	g_thread_init is
		external
			-- Application needs to be linked against gthread.
			"C inline use <gtk/gtk.h>"
		alias
			"g_thread_init (NULL)"
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
