indexing
	description: "EV_SHADOW_DIALOG Windows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "dialog, dialogue, popup, window, shadow"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SHADOW_DIALOG_IMP

inherit
	EV_UNTITLED_DIALOG_IMP
		redefine
			class_style,
			default_ex_style,
			new_class_name
		end
create
	make,
	make_with_real_dialog


feature {NONE} -- Implementation

	class_style: INTEGER is
			-- Redefine
		do
			Result := Precursor {EV_UNTITLED_DIALOG_IMP}
			Result := Result | cs_dropshadow
		end

	new_class_name: STRING_32 is
			-- Redefine
		do
			make_id
			Result := "EV_SHADOW_DIALOG_IMP"
		end

	default_ex_style: INTEGER_32 is
			-- Redefine
		do
			Result := Precursor {EV_UNTITLED_DIALOG_IMP}
			-- Ensure we hide title in task bar
			Result := Result | Ws_ex_toolwindow
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



end
