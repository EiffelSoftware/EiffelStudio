note
	description: "Eiffel Vision widget list. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_LIST_IMP

inherit
	EV_WIDGET_LIST_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			minimum_width,
			minimum_height
		redefine
			interface,
			initialize,
			setup_layout,
			layout
		end

	EV_DYNAMIC_LIST_IMP [EV_WIDGET]
		redefine
			interface,
			initialize
		end
	HIVIEW_FUNCTIONS_EXTERNAL

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'
		do
			Precursor {EV_CONTAINER_IMP}
			Precursor {EV_DYNAMIC_LIST_IMP}
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			v_imp : EV_WIDGET_IMP
			ret : INTEGER
			a_height, a_width: INTEGER
		do
			if v /= Void then
				v_imp ?= v.implementation
				check
					v_imp_not_void : v_imp /= Void
				end
				ret := hiview_add_subview_external ( c_object, v_imp.c_object)
				check
					view_added: ret = noerr
				end
				child_array.go_i_th (i)
				child_array.put_left (v)
				a_height := v_imp.minimum_height
				a_width := v_imp.minimum_width
			end
			on_new_item (v_imp)
			if parent_imp /= void then
				parent_imp.child_has_resized (current, a_height, a_width)
			end
		end

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		local
			v_imp: EV_WIDGET_IMP
			ret: INTEGER
		do
			v_imp ?= i_th (i).implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			child_array.go_i_th (i)
			child_array.remove

			ret := hiview_remove_from_superview_external (v_imp.c_object)
			check
				view_removed: ret = noErr
			end
			on_removed_item ( v_imp )
		end

		setup_layout
			local
				w: EV_WIDGET_IMP
				c: EV_CONTAINER_IMP
				i: INTEGER
			do

					layout
					from
						i := 1
					until
						(i = 0) or (i = count + 1)
					loop
						c ?= i_th (i).implementation
						if c /= void then
						--	if c.expandable then
								c.setup_layout
						--	end
						end
						i := i + 1
					end


			end

	layout
			do

			end



feature {NONE} -- Implementation

	interface: EV_WIDGET_LIST;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_WIDGET_LIST_IMP

