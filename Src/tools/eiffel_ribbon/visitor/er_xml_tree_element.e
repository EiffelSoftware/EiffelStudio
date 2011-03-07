note
	description: "Summary description for {ER_XML_TREE_ELEMENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_XML_TREE_ELEMENT

inherit
	XML_ELEMENT

create
	make,
	make_last,
	make_root

feature -- Command

	accept (a_visitor: ER_VISITOR)
			--
		require
			not_void: a_visitor /= Void
		do
			if attached name as l_name then
				if l_name.same_string (constants.ribbon_application_menu) then
					a_visitor.visit_ribbon_application_menu (Current)
				elseif l_name.same_string (constants.ribbon_tabs) then
					a_visitor.visit_ribbon_tabs (Current)
				elseif l_name.same_string (constants.application_commands) then
					a_visitor.visit_application_commands (Current)
				end
			end

			from
				start
			until
				after
			loop
				if attached {ER_XML_TREE_ELEMENT} item_for_iteration as l_item then
					l_item.accept (a_visitor)
				else
--					check item_not_valid: False end
				end

				forth
			end
		end

feature -- Command

	set_content (a_content: like content)
			--
		do
			content := a_content
		ensure
			set: a_content = content
		end

feature -- Query

	constants: ER_XML_CONSTANTS
			--
		once
			create Result
		end

	content: detachable STRING_32
			-- String contents
end
