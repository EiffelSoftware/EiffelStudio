indexing

	description:
		"A simple resource, displayed in one line."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_LINE_RESOURCE_DISPLAY

inherit
	EB_RESOURCE_DISPLAY
		redefine
			implementation
		end

	EV_HORIZONTAL_BOX
		redefine
			implementation
		end


feature {NONE} -- Initialization

	make_with_resource (par: EV_CONTAINER; a_resource: like resource) is
			-- Initialize Current with `a_resource' as `resource'.
		require
			resource_not_void: a_resource /= Void
			valid_parent: par /= Void 
		do
			make (par)
			Current.set_expand (false)
			resource := a_resource
		ensure
			set: resource = a_resource
		end

feature -- Access

	resource: EB_RESOURCE
			-- The resource to represent

feature {NONE} -- Access

	modified_resource: CELL2 [EB_RESOURCE, EB_RESOURCE] is
			-- Modified resource
		require
			is_changed: is_changed
		deferred
		end

feature -- Basic Operations

	save (file: PLAIN_TEXT_FILE) is
			-- Save Current in `file'.
		do
			if not resource.has_changed then
				file.putstring ("--")
			end;
			file.putstring (resource.name)
			file.putstring (": ")
			save_value (file)
			file.putstring ("%N")
		end

feature {NONE} -- Implementation

	implementation: EV_HORIZONTAL_BOX_I

	raise_warner (message: STRING) is
			-- Popup a warning dialog containing the
			-- string "Resource <name> must be <message>.".
		local
			warning_d: EV_WARNING_DIALOG
			msg: STRING
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT
		do
			Create msg.make (0)
			msg.append ("Resource `")
			msg.append (resource.name)
			msg.append ("' must be ")
			msg.append (message)
			msg.append (".")
			Create warning_d.make_with_text (Current, "Warning: not valid", msg)
			Create cmd.make (~execute)
			Create {EV_ARGUMENT1 [EV_WARNING_DIALOG]} arg.make (warning_d)
			warning_d.show_ok_button
			warning_d.add_ok_command (cmd, arg)
			warning_d.show
		end

end -- class EB_LINE_RESOURCE_DISPLAY
