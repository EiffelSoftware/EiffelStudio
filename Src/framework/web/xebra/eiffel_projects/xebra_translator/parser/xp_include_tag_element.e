note
	description: "[
		Special implementation of a XP_TAG_ELEMENT. Makes sure include calls are resolved with the proper
		template.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_INCLUDE_TAG_ELEMENT

inherit
	XP_TAG_ELEMENT
		redefine
			internal_build_tag_tree,
			accept
			--copy_tag_tree
		end

create make

feature -- Initialization

feature -- Access

	internal_build_tag_tree (a_feature: XEL_FEATURE_ELEMENT; templates: LIST [XGEN_SERVLET_GENERATOR_GENERATOR]; root_template: XGEN_SERVLET_GENERATOR_GENERATOR; is_root: BOOLEAN)
				-- Adds the needed expressions which build the tree of Current with the correct classes
			local
				template: XGEN_SERVLET_GENERATOR_GENERATOR
				child: XP_TAG_ELEMENT
				tag_visitor: XP_REGION_TAG_ELEMENT_VISITOR
				regions: HASH_TABLE [LIST [XP_TAG_ELEMENT], STRING]
				uid: STRING
			do
				a_feature.append_comment (debug_information)
				template := retrieve_template (parameters ["template"], templates)

				create regions.make (4)

				if has_children then
					from
						children.start
					until
						children.after
					loop
						child := children.item

						if child.id.is_equal ("define_region") then
							regions.put (child.children, child.retrieve_value ("id"))
						end
						children.forth
					end

					uid := root_template.next_unique_identifier
					create tag_visitor.make (regions, uid)
					template.root_tag.accept (tag_visitor)
						-- Updates the regions. Additionally it sets the controller name
					root_template.add_controller (uid, template.controller_class)
					template.root_tag.internal_build_tag_tree (a_feature, templates, root_template, is_root)
				end
			end

	retrieve_template (template_name: STRING; templates: LIST [XGEN_SERVLET_GENERATOR_GENERATOR]): XGEN_SERVLET_GENERATOR_GENERATOR
			-- Retrieves the template according to the `template_name'
		require
			template_name_valid: not template_name.is_empty
		do
			from
				templates.start
			until
				templates.after
			loop
				if templates.item.servlet_name.is_equal (template_name) then
					Result := templates.item.copy_generator
				end
				templates.forth
			end
		end

	accept (visitor: XP_TAG_ELEMENT_VISITOR)
			-- Element part of the Visitor Pattern
		do
			visitor.visit_include_tag_element (Current)
			from
				children.start
			until
				children.after
			loop
				children.item.accept (visitor)
				children.forth
			end
		end

end
