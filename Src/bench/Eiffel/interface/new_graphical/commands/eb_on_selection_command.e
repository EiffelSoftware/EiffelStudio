indexing
	description: "Command on selected text"
	author: "Etienne AMODEO"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ON_SELECTION_COMMAND

inherit

	EB_STANDARD_CMD
		rename
			make as make_standard
		redefine
			executable
		end

	EB_DEVELOPMENT_WINDOW_COMMAND
		redefine
			executable, make
		end


	TEXT_OBSERVER
		redefine
			on_selection_begun, on_selection_finished
		end

create
	make

feature {NONE} -- initialization

	make (a_target: EB_DEVELOPMENT_WINDOW) is
			-- creation function
		do
			make_standard
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND} (a_target)
		end

feature -- Execution

	executable: BOOLEAN is
		do
			Result := is_sensitive
		end

feature -- Status setting

	set_needs_editable (ed: BOOLEAN) is
			-- Tell the command it requires the editor to be editable.
		do
			needs_editable := True
		end

	update_status is
			-- Enable or disable `Current'.
		do
			if has_selection then
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

feature -- Observer pattern

	on_selection_begun is
			-- make the command sensitive
		do
			has_selection := True
			update_status
		end

	on_selection_finished is
			-- make the command insensitive
		do
			has_selection := False
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

	has_selection: BOOLEAN
			-- Is a text loaded?
			
	is_editable: BOOLEAN
			-- Is the current text editable?

end -- class EB_COMMENT_COMMAND
