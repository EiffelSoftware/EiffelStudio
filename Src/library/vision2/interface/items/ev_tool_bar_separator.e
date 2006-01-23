indexing
	description:
		"[
			Scored line separator for use in EV_TOOL_BAR.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "separator, tool, bar, line, devide"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR

inherit
	EV_TOOL_BAR_ITEM
		export
			{EV_TOOL_BAR_SEPARATOR} all
			{ANY} out, tagged_out, parent, equal,
				conforms_to, generating_type, print,
				destroy, is_destroyed, set_data, data,
				id_object, object_id
			{EV_ANY_I, EV_ABSTRACT_PICK_AND_DROPABLE}
				init_drop_actions, pointer_motion_actions
		redefine
			implementation
		end
		

create
	default_create

feature {EV_ANY, EV_ANY_I, EV_SHARED_TRANSPORT_I} -- Implementation

	implementation: EV_TOOL_BAR_SEPARATOR_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TOOL_BAR_SEPARATOR_IMP} implementation.make (Current)
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




end -- class EV_TOOL_BAR_SEPARATOR

