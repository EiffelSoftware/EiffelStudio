indexing
	description	: "Abstract notion of a command for the editor"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_EDITOR_COMMAND

inherit

	EB_STANDARD_CMD

	TEXT_OBSERVER
		redefine
			on_text_fully_loaded,
			on_text_reset
		end

creation
	make

feature -- Status setting

	set_needs_editable (ed: BOOLEAN) is
			-- Tell the command it requires the editor to be editable.
		do
			needs_editable := True
		end

	update_status is
			-- Enable or disable `Current'.
		do
			if is_loaded then
				if needs_editable then
					if is_editable then
						enable_sensitive
					else
						disable_sensitive
					end
				else
					enable_sensitive
				end
			else
				disable_sensitive
			end
		end

feature -- Status report

	needs_editable: BOOLEAN
			-- Does the command require the editor to be editable?

feature -- observer pattern

	on_text_fully_loaded is
			-- make the command sensitive
		do
			is_loaded := True
			update_status
		end

	on_text_reset is
			-- make the command sensitive
		do
			is_loaded := False
			update_status
		end

	on_editable is
			-- Editor has become editable.
		do
			is_editable := True
			update_status
		end

	on_not_editable is
			-- Editor is no longer editable.
		do
			is_editable := False
			update_status
		end

feature {NONE} -- Implementation

	is_loaded: BOOLEAN
			-- Is a text loaded?
			
	is_editable: BOOLEAN
			-- Is the current text editable?

end -- class EB_EDITOR_COMMAND
