indexing

	description:
		"A resource with an interface.";
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
				file.putstring ("--");
			end;
			file.putstring (associated_resource.name);
			file.putstring (": ");
			save_value (file);
			file.putstring ("%N")
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
			!! warning_d.make ("Warning", top);
			!! msg.make (0);
			msg.append ("Resource `");
			msg.append (associated_resource.name);
			msg.append ("' must be ");
			msg.append (message);
			msg.append (".");
			warning_d.set_message (msg);
			warning_d.hide_help_button;
			warning_d.hide_cancel_button;
			warning_d.add_ok_action (Current, warning_d);
			!! att;
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

end -- class PREFERENCE_RESOURCE
