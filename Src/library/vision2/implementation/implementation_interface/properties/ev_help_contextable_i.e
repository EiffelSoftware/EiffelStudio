indexing
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

	help_context: FUNCTION [ANY, TUPLE, EV_HELP_CONTEXT] is
			-- Agent that evaluates to help context sent to help engine when help is requested
		local
			w: EV_WIDGET_I
		do
			from
				w ?= current
			until
				w = Void or Result /= Void
			loop
				Result := w.internal_help_context
				if w.has_parent then
					w := w.parent.implementation
				else
					w := Void
				end
			end
		ensure
			current_if_exists: internal_help_context /= Void implies Result = internal_help_context
		end

feature -- Element change

	set_help_context (an_help_context: like help_context) is
			-- Assign `a_help_context' to `help_context'.
			-- Assign `an_help_context' to `help_context'.
		require
			an_help_context_not_void: an_help_context /= Void
		do
			internal_help_context := an_help_context
			on_help_context_changed
		ensure
			help_context_assigned: help_context.is_equal (an_help_context)
		end

	remove_help_context is
			-- Remove key press action associated with `EV_APPLICATION.help_key'.
		require
			help_context_not_void: help_context /= Void
		do
			internal_help_context := Void
			on_help_context_removed
		ensure
			no_help_context: internal_help_context = Void
		end

feature {EV_ANY_I} -- Implementation
	
	interface: EV_HELP_CONTEXTABLE

feature {EV_HELP_CONTEXTABLE_I} -- Implementation

	internal_help_context: FUNCTION [ANY, TUPLE, EV_HELP_CONTEXT]
			-- Help context

feature {NONE} -- Implementation

	on_help_context_changed is
			-- Call back to process help context changes.
		do
		end

	on_help_context_removed is
			-- Call back to process help context removals.
		do
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




end -- class EV_HELP_CONTEXTABLE_I

