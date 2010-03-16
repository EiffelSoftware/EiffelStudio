note
	description:
		"EiffelVision box. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_BOX_IMP

inherit
	EV_BOX_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_WIDGET_LIST_IMP
		redefine
			interface,
			on_new_item,
			on_removed_item,
			on_event,
			initialize,
			child_offset_top,
			child_offset_bottom,
			child_offset_left,
			child_offset_right,
			child_has_resized
		end

feature -- Initialization

	initialize
			-- Initialize `Current'
		local
			target, h_ret: POINTER
		do
			Precursor
			event_id := app_implementation.get_id (current)
			target := get_control_event_target_external( c_object )
			h_ret := app_implementation.install_event_handler ( event_id, target, {CARBONEVENTS_ANON_ENUMS}.keventclasscontrol, {CARBONEVENTS_ANON_ENUMS}.keventcontrolboundschanged )
			set_border_width (1)
		end

feature -- Access

	is_homogeneous: BOOLEAN
			-- Are all children restricted to be the same size?

	border_width: INTEGER
			-- Width of border around container in pixels.

	padding: INTEGER
			-- Space between children in pixels.	

feature {EV_ANY, EV_ANY_I} -- Status report

	is_item_expanded (child: EV_WIDGET): BOOLEAN
			-- Is `child' expanded to occupy available spare space?
		local
			w_imp : EV_WIDGET_IMP
		do
			w_imp ?= child.implementation
			check
				w_imp_not_void : w_imp /= Void
			end
			Result := w_imp.expandable
		end

feature {EV_ANY, EV_ANY_I} -- Status settings

	set_homogeneous (flag: BOOLEAN)
			-- Set whether every child is the same size.
		do
			is_homogeneous := flag
			setup_layout
		end

	set_border_width (value: INTEGER)
			 -- Assign `value' to `border_width'.
		do
				border_width := value
		end

	set_padding (value: INTEGER)
			-- Assign `value' to `padding'.
		local
			old_padding: INTEGER
			v: EV_VERTICAL_BOX_IMP
			h: EV_HORIZONTAL_BOX_IMP
		do
			old_padding := padding
			padding := value
			if count > 0 then
				v ?= current
				if v/= void then
					child_has_resized (void, (count-1) * (padding - old_padding), 0)
				else
					child_has_resized (void, 0, (count-1) * (padding - old_padding))
				end
			end
		end

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN)
			-- Set whether `child' expands to fill available spare space.
		local
			w_imp : EV_WIDGET_IMP
		do
			w_imp ?= child.implementation
			check
				w_imp_not_void : w_imp /= Void
			end
			if flag /= w_imp.expandable then
				if flag then
					expandable_item_count := expandable_item_count + 1
				else
					expandable_item_count := expandable_item_count - 1
				end
			end
			w_imp.set_expandable ( flag )
			setup_layout
		end

feature {NONE} -- Carbon implementation

	expandable_item_count : INTEGER

	setup_binding ( upper_control, lower_control : POINTER; left_of, right_of, bottom_of, top_of, a_padding: INTEGER )
			-- Setup Carbon Layout API
		deferred
		end


feature {EV_CONTAINER_IMP}
--	carbon_arrange_children is
--	--		 Setup positioning constraints for all children
--		require
--			at_least_one_child : count > 0
--		local
--			w: EV_BOX_IMP
--		do
--			layout
--			if parent /= void then
--				w ?= parent.implementation
--				if w /= void then
--					w.carbon_arrange_children
--				end

--			end

--		end



	child_has_resized (a_widget_imp: EV_WIDGET_IMP; a_height, a_width: INTEGER)
			-- propagate it to the top (or if we could resize, resize)
			-- calculate minimum sizes
		local
			old_minimum_width, old_minimum_height: INTEGER
			container: EV_CONTAINER_IMP
		do
			if (a_widget_imp /= void) and then a_widget_imp.expandable then

			else
			--	container ?= a_widget_imp
			--	if container /= void then
			--		container.setup_layout
			--	end
			--	layout
			end
			old_minimum_width := minimum_width
			old_minimum_height := minimum_height
			calculate_minimum_sizes
			if parent_imp /= void then
				parent_imp.child_has_resized (current, minimum_height - old_minimum_height,  minimum_width - old_minimum_width)
			end

		end

	calculate_minimum_sizes
			deferred
			end


feature --Meassurement

	child_offset_bottom: INTEGER
	do
		Result := border_width
	end

	child_offset_right: INTEGER
	do
		Result := border_width
	end

	child_offset_left: INTEGER
	do
		Result := border_width
	end
	child_offset_top: INTEGER
	do
		Result := border_width
	end


feature -- Event handling

	on_event (a_inhandlercallref, a_inevent, a_inuserdata: POINTER ) : INTEGER
			-- Called when a Carbon event arrives
		local
			event_class, event_kind : INTEGER_32
			actual_type, actual_size : NATURAL_32
			prev_rect, cur_rect :CGRECT_STRUCT
			attributes : NATURAL_32
			err : INTEGER
		do
			event_class := get_event_class_external (a_inevent)
			event_kind := get_event_kind_external (a_inevent)

			if event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassControl and event_kind =  {CARBONEVENTS_ANON_ENUMS}.keventcontrolboundschanged then
				create prev_rect.make_new_unshared
				create cur_rect.make_new_unshared
				err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamattributes, {AEDATA_MODEL_ANON_ENUMS}.typeWildCard, $actual_type, 4, $actual_size, $attributes ) -- 4 = sizeof(INTEGER_32)
				err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamoriginalbounds, {CARBONEVENTS_ANON_ENUMS}.typehirect, $actual_type, prev_rect.sizeof, $actual_size, prev_rect.item )
				err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamcurrentbounds, {CARBONEVENTS_ANON_ENUMS}.typehirect, $actual_type, cur_rect.sizeof, $actual_size, cur_rect.item )
				bounds_changed ( attributes, prev_rect, cur_rect )
				Result := noErr -- Event handled
			else
				Result := {CARBON_EVENTS_CORE_ANON_ENUMS}.eventnothandlederr
			end
		end

	on_new_item (an_item_imp: EV_WIDGET_IMP)
			-- Called after a new item is added
		do
			Precursor ( an_item_imp )
			an_item_imp.set_expandable ( True )
			expandable_item_count := expandable_item_count + 1
			child_has_resized (current, an_item_imp.minimum_height, an_item_imp.minimum_width)
		end

	on_removed_item (an_item_imp: EV_WIDGET_IMP)
			-- Called just before `an_item' is removed.
		do
			Precursor ( an_item_imp )
			if  an_item_imp.expandable then
				expandable_item_count := expandable_item_count - 1
			end
			if count > 0 then
				child_has_resized (current, - an_item_imp.minimum_height, - an_item_imp.minimum_width)
			end
		end



feature {EV_ANY_I, EV_ANY} -- Implementation

	interface: EV_BOX;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	expandable_item_count_correct : expandable_item_count >= 0 and expandable_item_count <= count

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_BOX_IMP

