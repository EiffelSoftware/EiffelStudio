indexing

	description:	
		"Abstract notion of a formatter."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EB_FORMATTER

inherit
	SHARED_CONFIGURE_RESOURCES
	NEW_EB_CONSTANTS

feature -- Properties

	formatted: STONE

	tool: EB_MULTIFORMAT_TOOL

	do_format: BOOLEAN
			-- Will we call `format' without checking if this is 
			-- really necessary (i.e. the format and the stone
			-- haven't changed since last call)?

feature -- Initialization
	make (t: like tool) is
		do
			tool := t
			create launch_cmd.make (Current)
		end

feature -- Setting

	set_do_format (b: BOOLEAN) is
			-- Assign `b' to `do_format'.
		do
			do_format := b
		end

feature -- Formatting

	format (stone: STONE) is
			-- Show special format of `stone' in class text `text_area',
			-- if it's clickable; do nothing otherwise.
		local
			retried: BOOLEAN
			edit_tool: EB_MULTIFORMAT_TOOL
--			mp: MOUSE_PTR
			wd: EV_WARNING_DIALOG
		do
			if not retried then 
				if 
					do_format or else filtered or else
					(tool.last_format /= Current or
					(stone /= Void and then not stone.same_as (tool.stone)))
				then
					if stone /= Void and then stone.is_valid then
--						tool.close_search_dialog	
						if stone.clickable then
							display_temp_header (stone)
--							create mp.set_watch_cursor
							tool.text_area.freeze
							tool.text_area.clear_window
							tool.text_area.set_editable (True)
							tool.set_stone (stone)
--							tool.set_file_name (file_name (stone))
							display_info (stone)
							tool.text_area.set_position (1)
							tool.text_area.set_editable (False)
							tool.text_area.thaw
							tool.set_last_format (Current)
							filtered := false
							display_header (stone)
--							mp.restore
						else
							set_selected (False)
							edit_tool ?= tool
							if edit_tool /= Void then
								edit_tool.format_list.text_format.format (stone)
							end
						end
					else
						set_selected (False)
					end
				end
			else
				create wd.make_default (tool.parent, Interface_names.t_Warning, Warning_messages.w_Cannot_retrieve_info)
--				mp.restore
			end
		rescue
			if not fail_on_rescue then
--				if original_exception = Io_exception then
--						-- We probably don't have the read permissions
--						-- on the server files.
					retried := true
					retry
--				end
			end
		end

feature -- Filters; Properties

	filtered: BOOLEAN
			-- Has the last action of `current' been a filter action?
			-- (In other words, do we need to reformat the target)

feature -- Filters; Implementation

	filter (filtername: STRING) is
			-- Filter the `Current' format with `filtername'.
		require
			filtername_not_void: filtername /= Void
			current_format: tool.last_format = Current
		local
			wd: EV_WARNING_DIALOG
		do
			if tool.stone /= Void then
				create wd.make_default (tool.parent, Interface_names.t_Warning,
					Warning_messages.w_Not_a_filterable_format)
			end
		end

feature {NONE} -- Implementation

	post_fix: STRING is
			-- Postfix name of current format
			-- Used as an extension while saving
		deferred
		ensure
			Result_not_void: Result /= Void
			valid_extension: Result.count <= 3
		end

	title_part: STRING is
		deferred
		end

	file_name (stone: STONE): STRING is
		local
			filed_stone: FILED_STONE
			fname: FILE_NAME
			i: INTEGER
		do
			filed_stone ?= stone
			if filed_stone /= Void then
				Result := clone (filed_stone.file_name)
					--| remove the extension
				from
					i := Result.count
				until
					i = 0 or else Result.item (i) = '.'
				loop
					i := i - 1
				end
				if i /= 0 and i >= Result.count - 3 then
					Result.head (i - 1)
				end

				create fname.make_from_string (Result)
				fname.add_extension (post_fix)
				Result := fname
			else
				create Result.make (0)
			end
		end

feature {EB_FEATURE_TOOL} -- Implementation

	display_header (stone: STONE) is
			-- Show header for 'stone'.
		local
			new_title: STRING
		do
			create new_title.make (50)
			new_title.append (title_part)
			new_title.append (stone.stone_signature)
			tool.set_title (new_title)
		end

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		local
			new_title: STRING
		do
			create new_title.make (50)
			new_title.append (title_part)
			new_title.append (stone.stone_signature)
			new_title.append (" ...")
			tool.set_title (new_title)
		end

	display_info (s: STONE) is
			-- Display special format of for stone `s'.
		deferred
		end

feature -- Dumb Features: Only here for compilation

	symbol: EV_PIXMAP is
		deferred
		end

	menu_name: STRING is
		deferred
		end

	set_selected (b: BOOLEAN) is
		do
		end

feature -- Commands

	launch_cmd: EB_FORMAT_COMMAND

end -- class EB_FORMATTER
