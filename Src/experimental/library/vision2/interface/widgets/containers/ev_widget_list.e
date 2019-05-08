note
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
			fill,
			initialize,
			is_equal,
			item,
			new_cursor,
			put,
			prune_all,
			replace
		redefine
			implementation,
			is_in_default_state
		end

	EV_DYNAMIC_LIST [EV_WIDGET]
		rename
			sequence_put as cl_put,
			dl_extend as cl_extend,
			dl_prune as cl_prune
		export
			{EV_WIDGET_LIST}
				changeable_comparison_criterion,
				compare_references,
				compare_objects,
				object_comparison
		undefine
			cl_put, cl_extend, cl_prune
		redefine
			implementation,
			is_in_default_state
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CONTAINER} and Precursor {EV_DYNAMIC_LIST}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_WIDGET_LIST_I;
			-- Responsible for interaction with native graphics toolkit.

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
