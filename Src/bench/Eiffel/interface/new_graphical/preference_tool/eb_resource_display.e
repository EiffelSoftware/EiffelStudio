indexing

	description:
		"A resource with an interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_RESOURCE_DISPLAY

inherit
	EV_CONTAINER

feature -- Status report

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		deferred
		end

	is_resource_valid: BOOLEAN
			-- Is Current's value valid?

feature -- Status setting

	validate is
			-- Validate Current's value.
			-- Store result in `is_valid'.
			--| Actual validation should only happen when
			--| the user specified a new value.
		deferred
		end

	reset is
			-- Reset the contents
		require
			not_destroyed: not destroyed
		deferred
		end

feature -- Basic Operations

	save (file: PLAIN_TEXT_FILE) is
			-- Save Current in `file'.
		require
			file_not_void: file /= Void
			file_is_open_write: file.is_open_write
		deferred
		end

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current's value in `file'.
		require
			file_not_void: file /= Void
			file_is_open_write: file.is_open_write
		deferred
		end


feature {NONE} -- Implementation

	name_label: EV_LABEL
			-- Label which holds the name of resources being displayed

feature {EB_RESOURCE_DISPLAY} -- Execution

	execute (arg: EV_ARGUMENT1 [EV_WARNING_DIALOG]; data: EV_EVENT_DATA) is
			-- Execute Current.
		local
			wd: EV_WARNING_DIALOG
		do
			wd := arg.first
			if wd /= Void then
				wd.destroy
			else
				validate
			end
		end

end -- class EB_RESOURCE_DISPLAY
