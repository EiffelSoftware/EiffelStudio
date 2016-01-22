note
	description: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	EDK_APPLICATION

create {EDK_APPLICATION_SERVER}
	make_with_default_namespace

feature {NONE} -- Initialization

	make_with_default_namespace (a_namespace: STRING_8)
			-- Create application object using `a_namespace' for default namespace.
		do
			default_namespace := a_namespace
			create display_cell.put (Void)
			display_cell.put (create {EDK_DISPLAY_DESKTOP}.make_for_application (Current))
		end

feature -- Access

	default_namespace: IMMUTABLE_STRING_8
		-- Default namespace of `Current' application object.
		-- Used as a prefix for creating differentiating multiple application objects at run-time

	display: EDK_DISPLAY
			-- Return the display used for displaying Windows.
		do
			check
				from_invariant: attached display_cell.item as d
			then
				Result := d
			end
		end

feature {NONE} -- Implementation

	display_cell: CELL [detachable EDK_DISPLAY]
		-- Place holder for cell.

invariant
	attached_display_cell_item: attached display_cell.item

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
