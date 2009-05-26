note
	description: "[
		Represents a xeb file.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_TEMPLATE
create
	make, make_empty

feature -- Initialization

	make (a_root_tag: XP_TAG_ELEMENT; a_is_template: BOOLEAN; a_controller_class: STRING; a_template_name: STRING)
			-- `a_root_tag': The root tag
			-- `a_is_template': Should the template be rendered
			-- `a_controller_class': The used controller class
			-- `a_template_name': The name of the template
		require
			a_controller_class_valid: attached a_controller_class
			a_root_tag_attached: attached a_root_tag
			a_template_name_attached: attached a_template_name
			a_servlet_name_is_valid: not a_template_name.is_empty
		do
			controller_class := a_controller_class
			root_tag := a_root_tag
			is_template := a_is_template
			template_name := a_template_name
		ensure
			controller_class_attached: attached controller_class
			root_tag_attached: attached root_tag
			template_name_attached: attached template_name
		end

	make_empty
			-- Creates an empty template
		do
			controller_class := ""
		end

feature {XP_TEMPLATE} -- Access

	root_tag: XP_TAG_ELEMENT
			-- The root tag of the tag tree

feature -- Access

	template_name: STRING
			-- The name of the servlet

	controller_class: STRING
			-- The controller corresponding to this template

	is_template: BOOLEAN
			-- Can the XP_TEMPLATE NOT be renderered on its own?

	date: INTEGER assign set_date
			-- The date of the corresponding .xeb-file

feature -- Status setting

	set_date (a_date: INTEGER)
			-- Sets the date.
		require
			a_date_attached: attached a_date
		do
			date := a_date
		ensure
			date_set: date = a_date
		end

feature -- Basic functionality

	absorb (a_other: XP_TEMPLATE)
			-- Takes all the instvars of `a_other'
		require
			a_other_attached: attached a_other
		do
			template_name := a_other.template_name
			controller_class := a_other.controller_class
			is_template := a_other.is_template
			root_tag := a_other.root_tag.copy_tag_tree
		end

	resolve (a_templates: HASH_TABLE [XP_TEMPLATE, STRING]; a_region: HASH_TABLE [LIST[XP_TAG_ELEMENT], STRING]; a_pending_uids: LIST [PROCEDURE [ANY, TUPLE [a_uid: STRING; a_controller_class: STRING]]]; a_servlet_gen: XGEN_SERVLET_GENERATOR_GENERATOR): XP_TAG_ELEMENT
			-- Resolves the templates "includes" and returns the tag element tree
		require
			a_templates_attached: attached a_templates
			a_region_attached: attached a_region
			a_pending_uids: attached a_pending_uids
		local
			l_visitor: XP_REGION_TAG_ELEMENT_VISITOR
			l_root_tag: XP_TAG_ELEMENT
			l_uid: STRING
		do
			l_root_tag := root_tag.copy_tag_tree
			if not controller_class.is_empty then
				l_uid := a_servlet_gen.next_unique_identifier
				set_uids (l_root_tag, a_servlet_gen, l_uid, controller_class)
				from
					a_pending_uids.start
				until
					a_pending_uids.after
				loop
					a_pending_uids.item.call ([l_uid, controller_class])
					a_pending_uids.forth
				end
				a_pending_uids.wipe_out
					-- All the pending uid requests have  been resolved, so the list can be emptied
			else
					-- Retrieve the proper controller
				a_pending_uids.extend (agent set_uids (l_root_tag, a_servlet_gen, ?, ?))
			end

			create l_visitor.make (a_region)
			l_root_tag.accept (l_visitor)

			l_root_tag.resolve_all_dependencies (a_templates, a_pending_uids, a_servlet_gen)
			if l_root_tag.date < date then
				l_root_tag.date := date
			end
			Result := l_root_tag
		end

	set_uids (a_tag: XP_TAG_ELEMENT; a_servlet_gen: XGEN_SERVLET_GENERATOR_GENERATOR; a_uid: STRING; a_controller_class: STRING)
			-- Sets the `a_uid' recursively over the tag tree defined by `a_tag'
		require
			a_tag_attached: attached a_tag
			a_servlet_attached: attached a_servlet_gen
			a_uid_attached: attached a_uid
			a_controller_class_attached: attached a_controller_class
		local
			l_uid_visitor: XP_UID_TAG_VISITOR
		do
			a_servlet_gen.add_controller (a_uid, a_controller_class)
			create l_uid_visitor.make_with_uid (a_uid)
			a_tag.accept (l_uid_visitor)
		end

invariant
	controller_class_attached: attached controller_class
	root_tag_attached: attached root_tag
	template_name_attached: attached template_name
end
