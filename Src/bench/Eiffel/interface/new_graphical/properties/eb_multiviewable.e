indexing
	description	: "Abstraction for an editor capable of displaying several formats."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_MULTIVIEWABLE

inherit
	EB_STONABLE

feature {NONE} -- Initialization

	init_formatters is
			-- Create the list of formats,
			-- initialize default format values.
		deferred
		ensure
			last_format_non_void: last_format /= Void
		end

feature -- Access

	last_format: EB_FORMATTER
			-- Last format used

	format_list: EB_FORMATTER_LIST
			-- List of all formats, with the data used
			-- to build the associated toolbar.

feature -- Status report

	is_editable is
			-- Is the text editable?
		deferred
		end

feature -- Status setting

	enable_editable is
			-- Set the text to be editable
		deferred
		end

	disable_editable is
			-- Set the text not to be editable
		deferred
		end

	set_last_format (f: like last_format) is
			-- Assign `f' to `last_format'.
		require
			format_exists: f /= Void
		do
			if last_format /= f then
				if last_format /= Void then
					last_format.set_selected (False)
				end
				last_format := f
				last_format.set_selected (True)
			else
				last_format.set_selected (True)
			end
		ensure
			last_format_set: last_format = f
		end

	set_default_format is
			-- Set format to default format of windows.
		do
		end

feature -- Basic operation

	clear_window is
			-- Clear the current output.
		deferred
		end

	reset is
			-- Reset the window contents.
		do
			set_default_format
		end

feature -- Update

	update_format is
			-- Update the content of the window (only after saving the content of
			-- the tool).
			--| FIXME
			--| Christophe, 18 oct 1999
			--| this function looks pretty much like `synchronize_stone';
			--| we could maybe mix the two features in one.
		local
			old_do_format: BOOLEAN
			f: EB_FORMATTER
		do
			f := last_format
			old_do_format := f.do_format
			f.set_do_format (True)
			f.launch (stone)
			f.set_do_format (old_do_format)
		end

	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
			synchronise_stone
		end

	synchronise_stone is
			-- Synchronize the root stone of the tool
			-- and the history's stones.
		local
			old_do_format: BOOLEAN
			f: EB_FORMATTER
			sync_stone : STONE
		do
			if stone /= Void then
				sync_stone := stone.synchronized_stone
				if not stone.same_as (sync_stone) then
					set_stone (sync_stone)
				else
						-- The root stone is still valid.
					f := last_format
					old_do_format := f.do_format
					f.set_do_format (true)
					f.format
					f.set_do_format (old_do_format)
				end
			else
					-- The root stone is not valid anymore.
				reset
			end
		end

	refresh is
			-- Update screen according to `stone'.
			-- do not touch history.
		local
			f: EB_FORMATTER
			old_do_format: BOOLEAN
		do
			f := last_format
			old_do_format := f.do_format
			f.set_do_format (true)
			f.format
			f.set_do_format (old_do_format)
		end

end -- class EB_MULTIVIEWABLE
