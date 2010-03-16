note
	description:
		" EiffelVision tool-bar radio button. implementation%
		% interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_RADIO_BUTTON_IMP

inherit
	EV_TOOL_BAR_RADIO_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			make,
			interface,
			set_item_parent_imp,
			create_select_actions
		end

	EV_RADIO_PEER_IMP
		redefine
			interface,
			widget_object
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a Carbon toggle button.
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_bottom (100)
			rect.set_right (100)
			ret := create_bevel_button_control_external ( null, rect.item,
				null, -- text
				{CONTROLDEFINITIONS_ANON_ENUMS}.kControlBevelButtonLargeBevel, -- size/thickness
				{CONTROLDEFINITIONS_ANON_ENUMS}.kControlBehaviorSticky, -- the behaviour: we want a sticky-button
				null, 0, 0, 0, $ptr )
			set_c_object ( ptr )




		end

feature -- Status setting

	enable_select
			-- Select `Current'.
		local
			temp: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			temp ?= peers.first.implementation

			temp.disable_select
			radio_group.prune (current)
			radio_group.put_front (current)
			-- First element of 'radio_group' is the one that is selected
		end

	disable_select
			-- Unselect 'Current'
		do
			set_control32bit_value_external (c_object, 0)
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected.
		do
			Result := radio_group.first = current
			-- First element of 'radio_group' is the one that is selected
		end

feature {EV_ANY_I} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a select action sequence.
			-- Attach to GTK "clicked" signal.
		do
		end

feature {NONE} -- Implementation

	set_item_parent_imp (a_container_imp: EV_ITEM_LIST_IMP [EV_ITEM])
			-- Set `parent_imp' to `a_container_imp'.
		do
			Precursor {EV_TOOL_BAR_BUTTON_IMP} (a_container_imp)
		end

feature {EV_ANY_I} -- Implementation

	widget_object (a_list: POINTER): POINTER
			-- Returns c_object relative to a_list data.
		do
		end

	radio_group: LINKED_LIST [like current]
			-- List of all radio item implementations
		local
			temp: EV_TOOL_BAR_IMP
		do
			temp ?= item_parent_imp
			if
				temp /= Void
			then
				Result ?= temp.radio_group
			end
		end


	interface: EV_TOOL_BAR_RADIO_BUTTON;
			-- Interface of `Current'

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP

