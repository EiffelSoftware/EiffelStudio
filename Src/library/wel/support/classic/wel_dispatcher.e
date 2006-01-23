indexing
	description: "Receives and dispatch the Windows messages to the Eiffel objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DISPATCHER

inherit
	WEL_ABSTRACT_DISPATCHER

	DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize the C variables
		do
			cwel_set_window_procedure_address ($window_procedure)
			cwel_set_dialog_procedure_address ($dialog_procedure)
			cwel_set_dispatcher_object (Current)
		end

feature {NONE} -- Implementation

	dispose is
			-- Wean `Current'
		local
			default_object: like Current
		do
			cwel_release_dispatcher_object
			cwel_set_dispatcher_object (default_object)
		end

feature {NONE} -- Externals

	cwel_set_window_procedure_address (address: POINTER) is
		external
			"C [macro %"disptchr.h%"]"
		end

	cwel_set_dialog_procedure_address (address: POINTER) is
		external
			"C [macro %"disptchr.h%"]"
		end

	cwel_set_dispatcher_object (dispatcher: like Current) is
		external
			"C macro signature (EIF_OBJECT) use %"disptchr.h%""
		end

	cwel_release_dispatcher_object is
		external
			"C [macro %"disptchr.h%"]"
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




end -- class WEL_DISPATCHER

