indexing
	description: "Widget for XML Browsing"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_WIDGET
	
inherit
	EV_VERTICAL_BOX
		rename
			initialize as initialize_box
		end

	XML_ROUTINES
		undefine
			copy,
			default_create,
			is_equal
		end

create
	make
	
feature -- Create

	make (a_xml: STRING) is
			-- Make with `xml'
		local
			l_xml_widget: EV_HORIZONTAL_BOX
		do
			default_create
			initialize
			xml := deserialize_text (a_xml)
			if xml = Void then
				create report_label.make_with_text (error_description)
				extend (report_label)
			else
				create report_label.make_with_text ("Processing, please wait...")
				extend (report_label)
				l_xml_widget := element_widget (xml.root_element)
				wipe_out
				extend (l_xml_widget)
			end		
		end

feature -- Initialization

	initialize is
			-- Initialize
		do
			set_background_color (create {EV_COLOR}.make_with_rgb (1.0, 1.0, 1.0))
			set_tag_color ((create {EV_STOCK_COLORS}).blue)
			set_name_color ((create {EV_STOCK_COLORS}).red)
			set_content_color (create {EV_COLOR}.make_with_rgb (0.0, 0.0, 0.0))
			set_indent_size (10)
		end		

feature -- Status Setting

	set_indent_size (a_size: INTEGER) is
			-- Set indent size for XML tags in pixels to `a_size'
		require
			valid_size: a_size >= 0
		do
			Indent_size := a_size	
		end		
		
	set_tag_color (a_color: EV_COLOR) is
			-- Set color used for special character tags (<,>,[, etc.)
		require
			color_not_void: a_color /= Void
		do
			tag_color := a_color
		ensure
			color_set: tag_color = a_color
		end
		
	set_name_color (a_color: EV_COLOR) is
			-- Set color used for element and attributes names
		require
			color_not_void: a_color /= Void
		do
			name_color := a_color
		ensure
			color_set: name_color = a_color
		end
		
	set_content_color (a_color: EV_COLOR) is
			-- Set color used for element and attributes content text
		require
			color_not_void: a_color /= Void
		do
			content_color := a_color
		ensure
			color_set: content_color = a_color
		end

feature {NONE} -- Access
	
	element_widget (a_el: XM_ELEMENT): EV_HORIZONTAL_BOX is
			-- Widget representation of `a_element'
		local			
		 	l_elements: DS_LIST [XM_ELEMENT]
		 	cell: EV_CELL
		 	v_box: EV_VERTICAL_BOX
			button, left_tag, right_tag, name_label, content_label: EV_LABEL
		 	h_box, sub_element_box: EV_HORIZONTAL_BOX
		 	l_content: STRING
		do			
			create Result		
			Result.set_background_color (background_color)
			
			if step > 0 then
						-- Account for indenting
				create cell
				cell.set_minimum_width (indent_size + button_size)
				cell.set_background_color (background_color)
				Result.extend (cell)
				Result.disable_item_expand (cell)
			end
			
			create v_box
			create h_box		
		
						-- '+<element>'
			create button.make_with_text ("+")
			button.set_minimum_size (Button_size, Button_size)
			button.set_background_color (background_color)
			create left_tag.make_with_text ("<")
			left_tag.set_foreground_color (tag_color)
			left_tag.set_background_color (background_color)
			create name_label.make_with_text (a_el.name)
			name_label.set_foreground_color (name_color)
			name_label.set_background_color (background_color)
			create right_tag.make_with_text (">")
			right_tag.set_foreground_color (tag_color)
			right_tag.set_background_color (background_color)
			h_box.extend (button)
			h_box.extend (left_tag)
			h_box.extend (name_label)
			h_box.extend (right_tag)			
			h_box.set_background_color (background_color)
			h_box.disable_item_expand (button)
			h_box.disable_item_expand (left_tag)
			h_box.disable_item_expand (name_label)
			h_box.disable_item_expand (right_tag)
			create cell
			cell.set_background_color (background_color)
			h_box.extend (cell)		
			v_box.extend (h_box)			
			v_box.disable_item_expand (h_box)
			
					-- Element content
			create h_box
			create cell
			cell.set_minimum_width (button_size)
			h_box.extend (cell)
			cell.set_background_color (background_color)
			h_box.disable_item_expand (cell)
			l_content := a_el.text
			if l_content /= Void then
				create content_label.make_with_text (l_content)
			else
				create content_label.make_with_text ("")				
			end
			
			content_label.set_foreground_color (content_color)
			content_label.set_minimum_size (0,0)
			h_box.extend (content_label)
			v_box.extend (h_box)
			v_box.disable_item_expand (h_box)
			button.pointer_button_press_actions.force_extend (agent toggle_element (v_box, h_box, button))

					-- Sub-elements
			if not a_el.is_empty then
				from
					step := step + 1
					l_elements := a_el.elements
					l_elements.start
				until
					l_elements.after
				loop		
					sub_element_box := element_widget (l_elements.item_for_iteration)
					v_box.extend (sub_element_box)
					v_box.disable_item_expand (sub_element_box)
					l_elements.forth
				end
				step := step + 1
			end

					-- '</element>'
			create h_box
			create left_tag.make_with_text ("   </")
			left_tag.set_foreground_color (tag_color)
			left_tag.set_background_color (background_color)
			create name_label.make_with_text (a_el.name)
			name_label.set_background_color (background_color)
			name_label.set_foreground_color (name_color)
			create right_tag.make_with_text (">")
			right_tag.set_foreground_color (tag_color)
			right_tag.set_background_color (background_color)
			h_box.extend (left_tag)
			h_box.extend (name_label)
			h_box.extend (right_tag)
			h_box.disable_item_expand (left_tag)
			h_box.disable_item_expand (name_label)
			h_box.disable_item_expand (right_tag)		
			create cell
			h_box.extend (cell)
			cell.set_background_color (background_color)
			v_box.extend (h_box)
			v_box.disable_item_expand (h_box)
			Result.extend (v_box)
		end

	toggle_element (vbox: EV_VERTICAL_BOX; textbox: EV_HORIZONTAL_BOX; label: EV_LABEL) is
			--
		local
			l_parent: EV_VERTICAL_BOX
			lp2: EV_HORIZONTAL_BOX
		do
			lp2 ?= vbox.parent
			l_parent ?= vbox.parent.parent
			if vbox.is_item_expanded (textbox) then
				vbox.disable_item_expand (textbox)
				lp2.disable_item_expand (vbox)
				l_parent.disable_item_expand (lp2)
				textbox.set_minimum_size (0, 0)
				label.set_text ("+")
			else
				vbox.enable_item_expand (textbox)
				lp2.enable_item_expand (vbox)
				l_parent.enable_item_expand (lp2)
				textbox.set_minimum_size (20, 20)
				label.set_text ("-")
			end
		end


feature {NONE} -- Implementation

	xml: XM_DOCUMENT
			-- XML text

	report_label: EV_LABEL
			-- Parsing error XML label

	step: INTEGER
			-- Current tab step
	
	indent_size: INTEGER
			-- Tag indent size
	
	button_size: INTEGER is 10
			-- Element button size

	tag_color,
	name_color,
	content_color: EV_COLOR
			-- Colors for text display

end -- class XML_WIDGET
