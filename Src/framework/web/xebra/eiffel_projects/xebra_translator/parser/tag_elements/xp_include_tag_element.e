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
			accept,
			resolve_all_dependencies,
			copy_self
		end
create
	make


feature -- Initialization

feature -- Access

	copy_self: XP_TAG_ELEMENT
		do
			create {XP_INCLUDE_TAG_ELEMENT} Result.make (namespace, id, class_name, debug_information)
		end

	resolve_all_dependencies (a_templates: HASH_TABLE [XP_TEMPLATE, STRING]; a_pending: LIST [PROCEDURE [ANY, TUPLE [a_uid: STRING; a_controller_class: STRING]]]; a_servlet_gen: XGEN_SERVLET_GENERATOR_GENERATOR)
			-- Precursor
		local
			l_child: XP_TAG_ELEMENT
			l_region: HASH_TABLE [LIST [XP_TAG_ELEMENT], STRING]
		do
			from
				children.start
				create l_region.make (10)
			until
				children.after
			loop
				l_child := children.item
				if l_child.id.is_equal ("define_region") then
						-- We have found a region
					l_region [l_child.retrieve_value ("id")] := l_child.children
				end
				children.forth
			end
			set_child (a_templates [retrieve_value ("template")].resolve (a_templates, l_region, a_pending, a_servlet_gen))
		end

	retrieve_next_controller_class (a_region: STRING; a_template: XGEN_SERVLET_GENERATOR_GENERATOR; a_templates: LIST [XGEN_SERVLET_GENERATOR_GENERATOR]): STRING
			-- Recursively searches for the region `a_region' and returns its parent includes template controller class.
		require
			a_region_is_valid: not a_region.is_empty
		local
			l_region_seeker: XP_REGION_SEEK_VISITOR
		do
			Result := ""
			if a_template.controller_class.is_empty then
				create l_region_seeker.make (a_region)
				a_template.root_tag.accept (l_region_seeker)
				Result := retrieve_next_controller_class (a_region, retrieve_template (l_region_seeker.template, a_templates), a_templates)
			else
				Result := a_template.controller_class
			end
		ensure
			class_is_set: not Result.is_empty
		end

	retrieve_template (a_template_name: STRING; a_templates: LIST [XGEN_SERVLET_GENERATOR_GENERATOR]): XGEN_SERVLET_GENERATOR_GENERATOR
			-- Retrieves the template according to the `template_name'
		require
			template_name_valid: not a_template_name.is_empty
		do
			from
				a_templates.start
			until
				a_templates.after
			loop
				if a_templates.item.servlet_name.is_equal (a_template_name) then
					Result := a_templates.item.copy_generator
				end
				a_templates.forth
			end
		end

	accept (visitor: XP_TAG_ELEMENT_VISITOR)
			-- Element part of the Visitor Pattern
		do
			visitor.visit_include_tag_element (Current)
			accept_children (visitor)
		end

end
