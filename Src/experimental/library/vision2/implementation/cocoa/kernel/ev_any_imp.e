note
	description:
		"Base class for Cocoa implementation (_IMP) classes. %N%
		%Handles interaction between Eiffel objects and Cocoa objects"
	author: "Daniel Furrer"


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

	old_make (an_interface: like interface)
			-- Create the window.
		do
			assign_interface (an_interface)
		end

	cocoa_item: NS_OBJECT

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
		local
			a_widget: EV_WIDGET_IMP
		do
			a_widget ?= current
			if  a_widget /= void then
				a_widget.destroy
			end
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_ANY_I, EV_STOCK_PIXMAPS_IMP} -- Implementation

	app_implementation: EV_APPLICATION_IMP
			--
		local
			env: EV_ENVIRONMENT
		once
			create env
			Result ?= env.application.implementation
			check
				Result_not_void: Result /= Void
			end
		end

invariant
--	cocoa_view_set: cocoa_item /= void
end -- class EV_ANY_IMP
