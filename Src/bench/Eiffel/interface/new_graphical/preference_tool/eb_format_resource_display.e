indexing
	description: "Composite resource made with a font and a color resource"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FORMAT_RESOURCE_DISPLAY

inherit
	EB_RESOURCE_DISPLAY
		redefine
			validate, implementation
		end
	EV_VERTICAL_BOX
		redefine
			implementation
		end

creation
	make_with_all,
	make_with_resource

feature {NONE} -- Initialization

	make_with_all (par: EV_CONTAINER; a_name: STRING; a_font: EB_FONT_RESOURCE;
		a_color: EB_COLOR_RESOURCE) is
			-- Builds a display with `a_font' and `a_color' as `font' and `color'
		require
			font_is_valid: is_valid (font)
			color_is_valid: is_valid (color)
			valid_parent: par /= Void 
		do
			make (par)
			
			name := a_name
			Create name_label.make_with_text (Current, name)
			name_label.set_minimum_height (50)
			name_label.set_expand (False)

			Create font.make_with_resource (Current, a_font)
			Create color.make_with_resource (Current, a_color)

			name_label.set_font (font.resource.actual_value)	
			name_label.set_foreground_color (color.resource.actual_value)
		end

	make_with_resource (par: EV_CONTAINER; a_format: EB_FORMAT_RESOURCE) is
			-- Builds a display according to `a_format'
		require
--			font_is_valid: is_valid (font)
--			color_is_valid: is_valid (color)
			valid_parent: par /= Void 
		do
			make (par)
			
			name := a_format.visual_name
			Create name_label.make_with_text (Current, name)
			name_label.set_minimum_height (50)
			name_label.set_expand (False)

			Create font.make_with_resource (Current, a_format.font_resource)
			Create color.make_with_resource (Current, a_format.color_resource)

			name_label.set_font (font.resource.actual_value)	
			name_label.set_foreground_color (color.resource.actual_value)
		end

feature -- Access

	name: STRING
		-- name of the resource;
		-- equivalent of EB_LINE_RESOURCE_DISPLAY's
		-- `resource.visual_name'

feature -- Validation

	validate is
			-- Validate Current's new value.
		do
			font.validate
			color.validate
			is_resource_valid := True

			if font.is_resource_valid then
				name_label.set_font (font.resource.actual_value)	
			else
				is_resource_valid := False
			end

			if color.is_resource_valid then
				name_label.set_foreground_color (color.resource.actual_value)
			else
				is_resource_valid := False
			end
		end

feature -- Status report

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		do
			Result := font.is_changed or else
				color.is_changed
		end

feature -- Element change

	reset is
			-- Reset the text field.
		do
			font.reset
			color.reset
		end


feature -- Basic Operations

	save (file: PLAIN_TEXT_FILE) is
			-- Save Current.
		do
			font.save (file)
			color.save (file)
		end

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current.
		do
			font.save_value (file)
			color.save_value (file)
		end

feature -- Display

	display (par: EV_CONTAINER) is
			-- Display Current in `par'
		do
			if not shown then
				set_parent (par)
				show
			end
		ensure
			has_parent: parent /= Void
			visible: shown
		end

	undisplay is
			-- Undisplay Current
		do
			set_parent (void)
			hide
		ensure
			orphan: parent = Void
			invisible: not shown
		end

feature {NONE} -- Properties

	font: EB_FONT_RESOURCE_DISPLAY
	color: EB_COLOR_RESOURCE_DISPLAY
			-- Resource Current represents

	implementation: EV_VERTICAL_BOX_I

end -- class EB_FORMAT_RESOURCE_DISPLAY
