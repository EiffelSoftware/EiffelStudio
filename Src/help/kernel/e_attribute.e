indexing
	description: "XML attribute with name."
	author: "Vincent Brendel"

class
	E_ATTRIBUTE

creation
	make

feature -- Initialization

	make(name:STRING; list:XML_ATTRIBUTE_TABLE) is
			-- Initialize
		require
			name_not_empty: (name /= Void) and then (not name.empty)
		do
			tag_name := name
			attrib_list := list
		ensure
			tag_name_set: tag_name = name
			atrib_list_set: attrib_list = list
		end

	change_character_format(cf:EV_CHARACTER_FORMAT) is
			-- Change 'cf' accoring to 'tag_name'.
		local
			color: EV_COLOR
		do
			if tag_name.is_equal("B") then
				cf.set_bold(true)
			elseif tag_name.is_equal("I") then
				cf.set_italic(true)
			elseif tag_name.is_equal("A") then
				create color.make_rgb(200,0,0)
				cf.set_color(color)
			end
		end

feature -- Access

	tag_name:STRING
		-- The name of this tag: B, I, U, UL, LI, BR, A, FONT

	attrib_list: XML_ATTRIBUTE_TABLE
		-- Any additional attributes for this tag?

invariant
	tag_name_not_empty: (tag_name /= Void) and then (not tag_name.empty)

end -- class E_ATTRIBUTE
