note
	description: "[
		Represents a xeb file.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
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
			controller_create_name := Default_create_name
		ensure
			controller_class_attached: attached controller_class
			root_tag_attached: attached root_tag
			template_name_attached: attached template_name
		end

	make_empty
			-- Creates an empty template
		do
			controller_class := ""
			create root_tag.make_empty
			template_name := ""
			controller_create_name := Default_create_name
		end

feature {XP_TEMPLATE} -- Access


feature -- Access

	root_tag: XP_TAG_ELEMENT
			-- The root tag of the tag tree

	force: BOOLEAN assign set_force
			-- Should the regeneration be forced?

	set_force (a_force: BOOLEAN)
			-- May the force be with you
		do
			force := a_force
		ensure
			force_set: force = a_force
		end

	template_name: STRING assign set_name
			-- The name of the servlet

	controller_create_name: STRING assign set_controller_create_name
			-- The name of the creation procedure of the controller

	set_controller_create_name (a_controller_create_name: STRING)
			-- Sets the controller_create_name.
		require
			a_controller_create_name_valid: attached a_controller_create_name and then not a_controller_create_name.is_empty
		do
			controller_create_name := a_controller_create_name
		ensure
			controller_create_name_set: a_controller_create_name = controller_create_name
		end

	controller_class: STRING assign set_controller_class
			-- The controller corresponding to this template

	set_controller_class (a_class_name: STRING)
			-- Sets the controller class name.
		do
			controller_class := a_class_name
		end

	is_template: BOOLEAN assign set_is_template
			-- Can the XP_TEMPLATE NOT be renderered on its own, that is,
			-- are explicit region declarations?

	set_is_template (a_is_template: BOOLEAN)
			-- Sets the is_template variable
		do
			is_template := a_is_template
		end

	date: INTEGER assign set_date
			-- The date of the corresponding .xeb-file

	put_root_tag (a_root_tag: XP_TAG_ELEMENT)
			-- Sets the root tag
		require
			a_root_tag_attached: attached a_root_tag
		do
			root_tag := a_root_tag
		ensure
			root_tag_set: root_tag = a_root_tag
		end

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

	set_name (a_name: STRING)
			-- Sets the name.
		require
			a_name_attached: attached a_name
		do
			template_name := a_name
		ensure
			name_set: template_name = a_name
		end

feature -- Basic functionality

	copy_template: XP_TEMPLATE
			-- Creates a new copy of itself
		do
			create Result.make_empty
			Result.absorb (Current)
		ensure
			Result_attached: attached Result
			new_instance: Result /= Current
		end

	absorb (a_other: XP_TEMPLATE)
			-- Takes all the instvars of `a_other'
		require
			a_other_attached: attached a_other
		do
			template_name := a_other.template_name
			controller_class := a_other.controller_class
			controller_create_name := a_other.controller_create_name
			is_template := a_other.is_template
			root_tag := a_other.root_tag.copy_tag_tree
			date := a_other.date
		end

	resolve (a_templates: HASH_TABLE [XP_TEMPLATE, STRING]; a_regions: HASH_TABLE [LIST[XP_TAG_ELEMENT], STRING]; a_pending_uids: LIST [PROCEDURE [ANY, TUPLE [a_uid: STRING; a_controller_class: STRING]]]; a_servlet_gen: XGEN_SERVLET_GENERATOR_GENERATOR): XP_TAG_ELEMENT
			-- `a_templates': All the templates that can be included
			-- `a_regions': All regions already defined with 'page:define_region'
			-- `a_pending_uids': A list of agents which set the proper controller uids as soon as possible
			-- `a_servlet_gen': The servlet generator generator for this xeb file
			-- Resolves the template's "includes" and returns the tag element tree
		require
			a_templates_attached: attached a_templates
			a_region_attached: attached a_regions
			a_pending_uids_attached: attached a_pending_uids
			a_servlet_gen_atttachd: attached a_servlet_gen
		local
			l_region_visitor: XP_REGION_TAG_ELEMENT_VISITOR
			l_root_tag: XP_TAG_ELEMENT
			l_uid: STRING
		do
			--l_root_tag := root_tag.copy_tag_tree
			l_root_tag := root_tag
			if not controller_class.is_empty then
						-- The controller is defined, so all pending templates can be resolved
				l_uid := a_servlet_gen.next_unique_identifier
					-- Set your own uid
				set_uids (l_root_tag, a_servlet_gen, l_uid, controller_class, controller_create_name)
					-- Set all the pending uids
				from
					a_pending_uids.start
				until
					a_pending_uids.after
				loop
					a_pending_uids.item.call ([l_uid, controller_class, controller_create_name])
					a_pending_uids.forth
				end
					-- All the pending uid requests have been resolved, so the list can be emptied
				a_pending_uids.wipe_out
			else
					-- Delay the setting of the controller id.
				a_pending_uids.extend (agent set_uids (l_root_tag, a_servlet_gen, ?, ?, ?))
			end

			create l_region_visitor.make (a_regions)
				-- Insert all regions from `a_regions' which match a declare_region tag element
			l_root_tag.accept (l_region_visitor)

				-- l_region_visitor might have unused regions. Pass them over
				-- to the next resolve_all_dependencies so regions can be used transitively!
			l_root_tag.resolve_all_dependencies (a_templates, a_pending_uids, a_servlet_gen, l_region_visitor.regions)
			if l_root_tag.date < date then
				l_root_tag.date := date
			end
			Result := l_root_tag
		end

	set_uids (a_tag: XP_TAG_ELEMENT; a_servlet_gen: XGEN_SERVLET_GENERATOR_GENERATOR; a_uid, a_controller_class, a_creator: STRING)
			-- Sets the `a_uid' recursively over the tag tree defined by `a_tag'
		require
			a_tag_attached: attached a_tag
			a_servlet_attached: attached a_servlet_gen
			a_uid_attached: attached a_uid
			a_controller_class_attached: attached a_controller_class
		local
			l_uid_visitor: XP_UID_TAG_VISITOR
		do
			a_servlet_gen.add_controller (a_uid, a_controller_class, a_creator)
			create l_uid_visitor.make_with_uid (a_uid)
			a_tag.accept (l_uid_visitor)
		end

feature -- Constants

	Default_create_name: STRING = "default_create"

invariant
	controller_class_attached: attached controller_class
	root_tag_attached: attached root_tag
	template_name_attached: attached template_name
end
