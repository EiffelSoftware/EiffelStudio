indexing

	description:
		"A list of text resources, stored in a combo box"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMBO_TEXT_DISPLAY

inherit
	EB_COMBO_DISPLAY
		redefine
			make,
			reset,
			validate,
			resources,
			resource_now_displayed
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Initialize Current.
		require else
			valid_parent: par /= Void 
		do
			Create container.make (par)
			precursor (container)
			Create rich_edit.make (container)
		end

feature -- Access

	resources: LINKED_LIST [EB_FORMAT_RESOURCE_DISPLAY]

	resource_now_displayed: EB_FORMAT_RESOURCE_DISPLAY

feature -- Implementation

	add_resource_display (rd: EB_FORMAT_RESOURCE_DISPLAY) is
		local
			i: EV_LIST_ITEM
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [EB_FORMAT_RESOURCE_DISPLAY]
		do
			Create i.make_with_text (combo_box, rd.name)
			resources.extend (rd)
			Create arg.make (rd)
			Create cmd.make (~change_selection)
			i.add_activate_command (cmd, arg)
		end

feature -- Cursor movement

	select_item (i: INTEGER) is
		local
			arg: EV_ARGUMENT1[EB_FORMAT_RESOURCE_DISPLAY]
		do
			if combo_box.count >= i then
				combo_box.select_item (i)
			end
		end

feature -- Validation

	validate is
		do
			Precursor
			rich_edit.reset
		end

	reset is
		do
			Precursor
			rich_edit.reset
		end

feature {NONE} -- Implementation

	container : EV_VERTICAL_BOX
	rich_edit : EB_TEXT_SAMPLE_DISPLAY
		
feature {NONE} -- Execution

	change_selection (arg: EV_ARGUMENT1[EB_FORMAT_RESOURCE_DISPLAY]; data: EV_EVENT_DATA) is
		do
			if (arg /= void) and then (arg.first /= Void) then
				if resource_now_displayed /= Void then
					resource_now_displayed.undisplay
				end
					-- If not destroyed is mandatory,
					-- to avoid a failure during Current's destruction
				if not destroyed then
					arg.first.display (Current)
					resource_now_displayed := arg.first
				end
			end
		end

end -- class EB_COMBO_DISPLAY
