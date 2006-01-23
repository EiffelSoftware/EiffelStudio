indexing
	description	: "Wizard state: Error "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	WIZARD_ERROR_STATE_WINDOW

inherit
	WIZARD_FINAL_STATE_WINDOW
		redefine
			build,
			proceed_with_current_info
		end
			
feature -- Initialization

	build is
		do
			Precursor {WIZARD_FINAL_STATE_WINDOW}
			first_window.set_final_state ("Abort")
		end

feature -- basic Operations

	proceed_with_current_info is
		do
			cancel
			Precursor
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




end -- class WIZARD_ERROR_STATE_WINDOW



