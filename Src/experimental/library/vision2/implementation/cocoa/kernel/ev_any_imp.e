note
	description:
		"Base class for Cocoa implementation (_IMP) classes. %N%
		%Handles interaction between Eiffel objects and Cocoa objects"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"


deferred class
	EV_ANY_IMP

inherit
	EV_ANY_I
		export
			{EV_ANY_IMP}
				is_destroyed
		end

	IDENTIFIED
		undefine
			is_equal,
			copy
		redefine
			dispose
		end

feature {EV_ANY_I, EV_ANY} -- Access

	old_make (an_interface: attached like interface)
			-- Create the window.
		do
			assign_interface (an_interface)
		end

--	cocoa_item: NS_OBJECT

feature {EV_ANY, EV_ANY_IMP} -- Implementation

	destroy
			-- Destroy the cocoa_item
			-- Render `Current' unusable.
		do
			set_is_destroyed (True)
		end

feature --dispose

	dispose
			-- Called by the Eiffel GC when `Current' is destroyed.
			-- Destroy `c_object'.
		do
			if attached {EV_WIDGET_IMP} Current as l_widget then
				l_widget.destroy
			end
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_ANY_I, EV_STOCK_PIXMAPS_IMP} -- Implementation

	app_implementation: EV_APPLICATION_IMP
			--
		local
			env: EV_ENVIRONMENT
			l_app_imp: detachable EV_APPLICATION_IMP
		once
			create env
			l_app_imp ?= env.implementation.application_i
			check Result_not_void: l_app_imp /= Void then end
			Result := l_app_imp
		end

invariant
--	cocoa_view_set: cocoa_item /= void
note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_ANY_IMP
