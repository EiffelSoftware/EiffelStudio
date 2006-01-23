indexing
	description: 
		"Multiple widget container accessible as a list."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_WIDGET_LIST

inherit
	EV_CONTAINER
		undefine
			extend,
			prune_all,
			fill,
			put,
			replace,
			item,
			initialize,
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_DYNAMIC_LIST [EV_WIDGET]
		export
			{EV_WIDGET_LIST}
				changeable_comparison_criterion,
				compare_references,
				compare_objects,
				object_comparison
		redefine
			implementation,
			is_in_default_state
		select
			put,
			set_extend
		end

feature {NONE} -- Contract support
	
	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CONTAINER} and Precursor {EV_DYNAMIC_LIST}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_WIDGET_LIST_I;
			-- Responsible for interaction with native graphics toolkit.

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




end -- class EV_WIDGET_LIST

