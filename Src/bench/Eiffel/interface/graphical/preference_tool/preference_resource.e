indexing

	description:
		"A resource with an interface.";
	date: "$Date$";
	revision: "$Revision$"

deferred class PREFERENCE_RESOURCE

inherit
	FORM;
	COMMAND

feature -- Validation

	is_resource_valid: BOOLEAN;
			-- Is Currennt's value valid?

	validate is
			-- Validate Current's value.
			-- Store result in `is_valid'.
			--| Actual validation should only happen when
			--| the user specified a new value.
		deferred
		end

feature {PREFERENCE_CATEGORY} -- User Interface

	display is
			-- Display Current
		deferred
		end

feature {PREFERENCE_CATEGORY} -- Access

	save (file: PLAIN_TEXT_FILE) is
			-- Save Current in `file'.
		require
			file_not_void: file /= Void;
			file_is_open_write: file.is_open_write
		do
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

feature {NONE} -- Initialization

	init is
			-- Create and attach widgets to Current
		deferred
		end

feature {NONE} -- Properties

	associated_resource: RESOURCE;
			-- The resource to represent

	name_label: LABEL;
			-- Label which holds the name of `associated_resource'

	a_parent: COMPOSITE
			-- Parent for Current

feature {NONE} -- Implementation

	raise_warner (message: STRING) is
			-- Popup a warning dialog containing the
			-- string "Resource <name> must be <message>.".
		local
			warning_d: WARNING_D;
			msg: STRING
		do
			!! warning_d.make ("Warning", Current);
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
			warning_d.popup;
			warning_d.raise
		end;

	execute (argument: ANY) is
			-- Execute Current.
			--| If `argument' is of type WARNING_D then
			--| pop it down, else extended_execute with
			--| `argument' as argument.
		local
			wd: WARNING_D
		do
			wd ?= argument;
			if wd /= Void then
				wd.popdown;
				wd.destroy
			else
				extended_execute (argument)
			end
		end;

	extended_execute (argument: ANY) is
			-- Execute Current.
			--| Only called if `execute' cannot deal with
			--| `argument'.
			--| Does nothing by default.
		do
		end

end -- class PREFERENCE_RESOURCE
