indexing

	description:
		"Abstract notion of a data capture panel."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EB_ENTRY_PANEL

inherit
	EV_VERTICAL_BOX
		rename
			make as make_container
		end

feature {NONE} -- Initialization

	make (par: EV_CONTAINER; a_tool: like tool) is
			-- Initialize Current.
		do
			make_container (par)
			set_minimum_size (400, 300)
--			set_border_width (4)
			create title.make_with_text (Current, name)
			title.set_minimum_height (50)
			set_child_expandable (title, False)
			tool := a_tool
			create resources.make
			create raise_cmd.make (Current)
		end

feature -- Initialization

	update_resources is
			-- Update `resources'.
			--| This feature is used to reset `resources'.
		require
			valid_resources: resources /= Void
		local
			res: EB_RESOURCE_DISPLAY
		do
--			if shown then
			if displayed then
				from
					resources.start
				until
					resources.after
				loop
					res := resources.item
					res.reset
					resources.forth
				end
			end
		end

feature -- Access

	title: EV_LABEL

	resources: LINKED_LIST [EB_RESOURCE_DISPLAY]
			-- All resources for the user interface

	tool : EB_PREFERENCE_TOOL
			-- associated tool

	parameters: EB_PARAMETERS is
			-- Category Current is about
		deferred
		end

	name: STRING is
			-- Name of the category
		deferred
		end
	
	symbol: EV_PIXMAP is
			-- Pixmap representing the category
		deferred
		end

feature -- Validation

	is_all_valid: BOOLEAN
			-- Are all resources in Current valid?

	validate is
			-- Validate all resources in Current
		local
			res: like resources
		do
			from
				res := resources
				res.start
				is_all_valid := True
			until
				res.after or else not is_all_valid
			loop
				res.item.validate
				is_all_valid := is_all_valid and res.item.is_resource_valid
				res.forth
			end
		end

feature -- Element change

	save_resources (file: PLAIN_TEXT_FILE) is
			-- Save the resources from Current in `file'.
		require
			file_not_void: file /= Void
			file_is_open_write: file.is_open_write
		local
			res: like resources
		do
			file.putstring ("-- **** ")
			file.putstring (name)
			file.putstring (" **** ")
			file.new_line
			from
				res := resources
				res.start
			until
				res.after
			loop
				res.item.save (file)
				res.forth
			end
			file.new_line
		end

feature -- Element Change

	update is
			-- Update the resource users from
			-- `parameters'.
		local
--			mod_res: EB_MODIFIED_RESOURCE
			res: like resources
			lrd: EB_LINE_RESOURCE_DISPLAY
		do
			from
				res := resources
				res.start
			until
				res.after
			loop
				if res.item.is_changed then
					lrd ?= res.item
					if lrd /= Void then
						parameters.add_modified_resource (lrd.modified_resource)
					end
				end
				res.forth
			end
			parameters.update
		end

feature -- Output

	display is
			-- Display Current
			--| This feature is used to initialize `resources'.
		local
			res: EB_RESOURCE_DISPLAY
		do
--			holder.set_selected (True)
			if not displayed then
--			if not shown then
				from
					resources.start
				until
					resources.after
				loop
					res := resources.item
--					res.init (Current)
					res.reset
					resources.forth
				end
				init_colors
				set_parent (tool.panels_box)
				show
			end
		ensure
			has_parent: parent /= Void
			visible: shown
		end

	undisplay is
			-- Undisplay Current
			--| This only updates the pixmap on the button
		do
--			holder.set_selected (False)
			hide
			set_parent (Void)
		ensure
			orphan: parent = Void
			invisible: not shown
		end

feature -- Commands

	raise_cmd: EB_RAISE_ENTRY_PANEL_COMMAND

feature -- Linking

	link (i: EV_ANY) is
		do
		end

feature {NONE} -- Implementation

--	holder: CATEGORY_HOLDER
			-- Holder for the visual aspects

	init_colors is
			-- Initialize the colors.
		do
		end

end -- class EB_ENTRY_PANEL
