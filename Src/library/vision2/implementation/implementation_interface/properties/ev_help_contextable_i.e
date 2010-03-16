note
	description:
		"EV_HELP_CONTEXTABLE implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "help"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_HELP_CONTEXTABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	help_context: detachable FUNCTION [ANY, TUPLE, EV_HELP_CONTEXT]
			-- Agent that evaluates to help context sent to help engine when help is requested
		local
			w: detachable EV_WIDGET_I
			l_exit_loop: BOOLEAN
		do
			w ?= Current
			if w /= Void then
				from

				until
					l_exit_loop
				loop
					Result := w.internal_help_context
					if attached w.parent as l_parent and then attached l_parent.implementation as l_parent_imp then
						w := l_parent_imp
					else
						l_exit_loop := True
					end
				end
			end
		ensure
			current_if_exists: internal_help_context /= Void implies Result = internal_help_context
		end

feature -- Element change

	set_help_context (an_help_context: like help_context)
			-- Assign `a_help_context' to `help_context'.
			-- Assign `an_help_context' to `help_context'.
		require
			an_help_context_not_void: an_help_context /= Void
		do
			internal_help_context := an_help_context
			on_help_context_changed
		ensure
			help_context_assigned: attached help_context as l_help_context and then l_help_context.is_equal (an_help_context)
		end

	remove_help_context
			-- Remove key press action associated with `EV_APPLICATION.help_key'.
		require
			help_context_not_void: help_context /= Void
		do
			internal_help_context := Void
			on_help_context_removed
		ensure
			no_help_context: internal_help_context = Void
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_HELP_CONTEXTABLE note option: stable attribute end

feature {EV_HELP_CONTEXTABLE_I} -- Implementation

	internal_help_context: detachable FUNCTION [ANY, TUPLE, EV_HELP_CONTEXT]
			-- Help context

feature {NONE} -- Implementation

	on_help_context_changed
			-- Call back to process help context changes.
		do
		end

	on_help_context_removed
			-- Call back to process help context removals.
		do
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_HELP_CONTEXTABLE_I











