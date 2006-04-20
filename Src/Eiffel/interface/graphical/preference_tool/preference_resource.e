indexing

	description:
		"A resource with an interface."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class PREFERENCE_RESOURCE

inherit
	FORM
		rename
			make as form_make
		end;
	COMMAND

feature {NONE} -- Initialization

	make (a_resource: like associated_resource) is
			-- Initialize Current with `a_resource' as `associated_resource'.
		require
			resource_not_void: a_resource /= Void
		do
			associated_resource := a_resource
		ensure
			set: associated_resource = a_resource
		end

feature -- Validation

	is_resource_valid: BOOLEAN;
			-- Is Current's value valid?

	validate is
			-- Validate Current's value.
			-- Store result in `is_valid'.
			--| Actual validation should only happen when
			--| the user specified a new value.
		deferred
		end;

	reset is
			-- Reset the contents
		require
			not_destroyed: not destroyed
		deferred
		end

feature {PREFERENCE_CATEGORY} -- Access

	save (file: PLAIN_TEXT_FILE) is
			-- Save Current in `file'.
		require
			file_not_void: file /= Void;
			file_is_open_write: file.is_open_write
		do
			if not associated_resource.has_changed then
				file.put_string ("--");
			end;
			file.put_string (associated_resource.name);
			file.put_string (": ");
			save_value (file);
			file.put_string ("%N")
		end;

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current's value in `file'.
		require
			file_not_void: file /= Void;
			file_is_open_write: file.is_open_write
		deferred
		end;

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		deferred
		end;

	modified_resource: CELL2 [RESOURCE, RESOURCE] is
			-- Modified resource
		require
			is_changed: is_changed
		deferred
		end

	init (a_parent: COMPOSITE) is
			-- Create and attach widgets to Current
		require
			valid_parent: a_parent /= Void 
		deferred
		end

feature {NONE} -- Properties

	associated_resource: RESOURCE;
			-- The resource to represent

	name_label: LABEL;
			-- Label which holds the name of `associated_resource'

feature {NONE} -- Implementation

	raise_warner (message: STRING) is
			-- Popup a warning dialog containing the
			-- string "Resource <name> must be <message>.".
		local
			warning_d: WARNING_D;
			msg: STRING;
			att: WINDOW_ATTRIBUTES;
		do
			create warning_d.make ("Warning", top);
			create msg.make (0);
			msg.append ("Resource `");
			msg.append (associated_resource.name);
			msg.append ("' must be ");
			msg.append (message);
			msg.append (".");
			warning_d.set_message (msg);
			warning_d.hide_help_button;
			warning_d.hide_cancel_button;
			warning_d.add_ok_action (Current, warning_d);
			create att;
			att.set_composite_attributes (warning_d);
			warning_d.popup
		end;

	execute (argument: ANY) is
			-- Execute Current.
		local
			wd: WARNING_D
		do
			wd ?= argument;
			if wd /= Void then
				wd.popdown;
				wd.destroy
			else
				validate
			end
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class PREFERENCE_RESOURCE
