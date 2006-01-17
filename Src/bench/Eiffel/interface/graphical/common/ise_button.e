indexing

	description:
		"Abstract notion of a tool button."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class ISE_BUTTON

inherit
	ACTIVE_PICT_COLOR_B
		redefine
			make
		end

	FOCUSABLE

	TTY_CONSTANTS

	RESOURCE_USER
		redefine
			update_boolean_resource
		end

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create the 
		do
			Precursor {ACTIVE_PICT_COLOR_B} (a_name, a_parent)
			if General_resources.regular_button /= Void then
					-- Not Void implies that we are on Windows where
					-- the functionality is fully implemented.
				set_active (not General_resources.regular_button.actual_value)
				General_resources.add_user (Current)
			end
		end

feature -- Access

	symbol: PIXMAP is
			-- The pixmap representing Current.
		deferred
		end;

	focus_source: WIDGET is
			-- Widget representing Current on the screen.
		do
			Result := Current
		end;

	focus_label: FOCUS_LABEL_I is
			-- Focus_label
		local
			ti: TOOLTIP_INITIALIZER
		do
			ti ?= top
			check
				has_tooltip: ti /= Void
			end
			Result := ti.label
		end

feature -- Status Setting

	set_symbol (p: PIXMAP) is
			-- Set the pixmap if it it valid
		do
			if p.is_valid then
				set_pixmap (p)
			end;
		end;

feature -- Resource Update

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
		do
			if old_res = general_resources.regular_button then
				if new_res.actual_value then
					set_active (False)
				else
					set_active (True)
				end
					-- To update the display, the only way we found is to resize
					-- each button.
				set_width (width - 1)
				set_width (width + 1)
			end
		end
	
feature {NONE} -- Properties

	button_name: STRING is "push_b";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ISE_BUTTON
