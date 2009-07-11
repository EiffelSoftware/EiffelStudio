note
	description: "[
		Defines validator classes for an input field.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_EFA_TITLE_BOX_TAG

inherit
	XTAG_TAG_SERIALIZER

create
	make

feature -- Initialization

	make
		do
			make_base
			create {XTAG_TAG_VALUE_ARGUMENT} title.make ("No title set")		
		end

feature {NONE} -- Access

	title: XTAG_TAG_ARGUMENT
			-- The name of the feature to call

feature -- Implementation

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precusor>
		do
			if a_id.is_equal ("title") then
				title := a_attribute
			end			
		end

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		do
			--a_servlet_class.render_html_page.append_output_expression ("[
--"<table cellpadding="0" cellspacing="0" class="frame"><tr style="line-height:0"><td style="width:16px"><img src="images/title_box/--title_top_lef.gif" width="16" height="16" alt=""/></td><td style="width:200px;height:16px;background-image:url(images/title_box/title_top_mid.gif);"><img src="images/title_box/title_top_mid.gif" width="16" height="16" alt=""/></td><td style="width:16px"><img src="images/title_box/title_top_rig.gif" width="16" height="16" alt=""/></td></tr><tr><td style="width:16px;background-image:url(images/title_box/title_cen_lef.gif);"><img src="images/title_box/title_cen_lef.gif" width="16" height="16" alt=""/></td><td><h1>
--]" + title.value (current_controller_id) +  "[
--</h1></td><td style="width:16px;background-image:url(images/title_box/title_cen_rig.gif);"><img src="images/title_box/title_cen_rig.gif" width="16" height="16" alt=""/></td></tr><tr><td style="width:16px"><img src="images/title_box/title_bot_lef.gif" width="16" height="16" alt=""/></td><td style="height:16px;background-image:url(images/title_box/title_bot_mid.gif);"><img src="images/title_box/title_bot_mid.gif" width="16" height="16" alt=""/></td><td style="width:16px"><img src="images/title_box/title_bot_rig.gif" width="16" height="16" alt=""/></td></tr></table>"
--]")
		end

end
