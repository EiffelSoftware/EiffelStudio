indexing
	description: "Objects that represent paragraph formatting information."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PARAGRAPH_FORMAT_IMP
	
inherit
	EV_PARAGRAPH_FORMAT_I
	
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create paragraph format
		do
			base_make (an_interface)
		end

	initialize is
			-- Do nothing
		do
			is_initialized := True
		end
		
feature -- Status report

	alignment: INTEGER
		-- Current alignment. See EV_PARAGRAPH_CONSTANTS
		-- for possible values.

	is_left_aligned: BOOLEAN is
			-- Is `Current' left aligned?
		do
			Result := alignment = feature {EV_PARAGRAPH_CONSTANTS}.alignment_left
		end
		
	is_center_aligned: BOOLEAN is
			-- Is `Current' center aligned?
		do
			Result := alignment = feature {EV_PARAGRAPH_CONSTANTS}.alignment_center
		end
	
	is_right_aligned: BOOLEAN is
			-- Is `Current' right aligned?
		do
			Result := alignment = feature {EV_PARAGRAPH_CONSTANTS}.alignment_right
		end
	
	is_justified: BOOLEAN is
			-- Is `Current' justified?
		do
			Result := alignment = feature {EV_PARAGRAPH_CONSTANTS}.alignment_justified
		end
		
	left_margin: INTEGER
		-- Left margin between border and text in pixels
		
	right_margin: INTEGER
		-- Right margin between line end and border in pixels
		
	top_spacing: INTEGER
		-- Spacing between top of paragraph and previous line in pixels.
		
	bottom_spacing: INTEGER
		-- Spacing between bottom of paragraph and next line in pixels.

feature -- Status setting

	enable_left_alignment is
			-- Ensure `is_left_aligned' is `True'.
		do
			set_alignment (feature {EV_PARAGRAPH_CONSTANTS}.alignment_left)
		end
		
	enable_center_alignment is
			-- Ensure `is_center_aligned' is `True'.
		do
			set_alignment (feature {EV_PARAGRAPH_CONSTANTS}.alignment_center)
		end
		
	enable_right_alignment is
			-- Ensure `is_right_aligned' is `True'.
		do
			set_alignment (feature {EV_PARAGRAPH_CONSTANTS}.alignment_right)
		end
		
	enable_justification is
			-- Ensure `is_justified' is `True'.
		do
			set_alignment (feature {EV_PARAGRAPH_CONSTANTS}.alignment_justified)
		end

	set_alignment (a_alignment: INTEGER) is
			-- Set `alignment' to `a_alignment'
		do
			alignment := a_alignment
		end

	set_left_margin (a_margin: INTEGER) is
			-- Set `left_margin' to `a_margin'.
		do
			left_margin := a_margin
		end

	set_right_margin (a_margin: INTEGER) is
			-- Set `right_margin' to `a_margin'.
		do
			right_margin := a_margin
		end
		
	set_top_spacing (a_margin: INTEGER) is
			-- Set `top_spacing' to `a_margin'.
		do
			top_spacing := a_margin
		end
		
	set_bottom_spacing (a_margin: INTEGER) is
			-- Set `bottom_spacing' to `a_margin'.
		do
			bottom_spacing := a_margin
		end
		
feature {EV_RICH_TEXT_IMP} -- Implementation

	new_paragraph_tag_from_applicable_attributes (applicable_attributes: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION): POINTER is
			-- 
		local
			propname: EV_GTK_C_STRING
		do
			Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_tag_new (default_pointer)
			
			if applicable_attributes.alignment then
				create propname.make ("justification")
				inspect
					alignment
				when feature {EV_PARAGRAPH_CONSTANTS}.alignment_left then
					feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (Result, propname.item, feature {EV_GTK_EXTERNALS}.gtk_justify_left_enum)
				when feature {EV_PARAGRAPH_CONSTANTS}.alignment_center then
					feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (Result, propname.item, feature {EV_GTK_EXTERNALS}.gtk_justify_center_enum)
				when feature {EV_PARAGRAPH_CONSTANTS}.alignment_right then
					feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (Result, propname.item, feature {EV_GTK_EXTERNALS}.gtk_justify_right_enum)
				when feature {EV_PARAGRAPH_CONSTANTS}.alignment_justified then
					feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (Result, propname.item, feature {EV_GTK_EXTERNALS}.gtk_justify_fill_enum)
				end
			end
			
			if applicable_attributes.left_margin then
				create propname.make ("left-margin")
				feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (Result, propname.item, left_margin)				
			end
			
			if applicable_attributes.right_margin then
				create propname.make ("right-margin")
				feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (Result, propname.item, right_margin)				
			end

			if applicable_attributes.top_spacing then
				create propname.make ("pixels-above-lines")
				feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (Result, propname.item, top_spacing)				
			end
			
			if applicable_attributes.bottom_spacing then
				create propname.make ("pixels-below-lines")
				feature {EV_GTK_DEPENDENT_EXTERNALS}.g_object_set_integer (Result, propname.item, bottom_spacing)				
			end
		end

	dummy_paragraph_format_range_information: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION is
			-- 
		do
			create Result.make_with_values (True, True, True, True, True)
		end

feature {NONE} -- Implementation

	destroy is
			-- Clean up `Current'
		do
			
		end

end -- class EV_PARAGRAPH_FORMAT
