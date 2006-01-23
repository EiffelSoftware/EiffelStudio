indexing
	description:
		"Implementation of widget with no child for Windows"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PRIMITIVE_IMP

inherit
	WIDGET_IMP
		redefine
			unrealize
		end;

	PRIMITIVE_I

	COLORED_FOREGROUND_WINDOWS

	FONTABLE_IMP

feature  -- Status report

	is_stackable: BOOLEAN is
		do
		end

feature  -- Status setting

	propagate_event is
			-- Propagate event to direct ancestor if no action
			-- is specified for event.
		do
		end

	set_no_event_propagation is
			-- Propagate no event to direct ancestor if no action
			-- is specified for event.
		do
		end

	unrealize is
			-- Destroy current primitive.
		do
			if exists then
				wel_destroy
			end
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




end -- class PRIMITIVE_IMP

