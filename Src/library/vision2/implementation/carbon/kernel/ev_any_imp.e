note
	description:
		"Base class for Carbon implementation (_IMP) classes. %N%
		%Handles interaction between Eiffel objects and Carbon objects %N%
		%See important notes on memory management at end of class"


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

	c_object: POINTER -- C pointer to corresponding carbon struct

feature {EV_ANY_I} -- Access

	set_c_object (a_c_object: POINTER)
			-- Assign `a_c_object' to `c_object'.
			--| (See note at end of class)
		require
			a_c_object_not_null: a_c_object /= NULL
		do
			c_object := a_c_object
--		ensure
--			c_object_coupled: eif_object_from_c (c_object) = Current
		end

--	frozen eif_object_from_c (a_c_object: POINTER): EV_ANY_IMP is
--			-- Retrieve the EV_ANY_IMP stored in `a_c_object'.
--		do
--		end

feature {EV_ANY, EV_ANY_IMP} -- Implementation

	destroy
			-- Destroy `c_object'.
			-- Render `Current' unusable.
		do

		end

feature {EV_ANY_I, EV_APPLICATION_IMP} -- Event handling

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


feature {NONE} -- Implementation


	c_object_dispose
			-- Called when `c_object' is destroyed.
			-- Only called if `Current' is referenced from `c_object'.
			-- Render `Current' unusable.
		do
		ensure
			is_destroyed_set: is_destroyed
			c_object_detached: c_object = NULL
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_ANY_I, EV_STOCK_PIXMAPS_IMP} -- Implementation

		App_implementation: EV_APPLICATION_IMP
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

feature -- Measurement

	frozen NULL: POINTER
		external
			"C [macro <stdio.h>]"
		alias
			"NULL"
		end

	frozen sizeof ( item : POINTER ) : INTEGER_32
		external
			"C [macro <stdio.h>]"
		alias
			"sizeof"
		end

	frozen noErr : INTEGER = 0

invariant
	c_object_not_void : c_object /= null
note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_ANY_IMP

