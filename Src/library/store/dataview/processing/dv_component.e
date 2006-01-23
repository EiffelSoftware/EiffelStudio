indexing
	description: "Component that has to be activated."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DV_COMPONENT

feature -- Initialization

	activate is
			-- Activate component.
		require
			can_be_activated: can_be_activated
		deferred
		ensure
			is_activated: is_activated
		end

feature -- Status report

	can_be_activated: BOOLEAN is
			-- Can the component be activated?
		deferred
		end

	is_activated: BOOLEAN is
			-- Is component activated?
		deferred
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





end -- class DV_COMPONENT


