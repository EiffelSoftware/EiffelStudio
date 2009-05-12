note
	description: "[
		{XP_SERVLET_GG_REGISTRY}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_SERVLET_GG_REGISTRY
create
	make

feature -- Initialization

	make (a_path: STRING)
		do
			path := a_path
			create template_registry.make (10)
			create taglib_registry.make (10)
			create {ARRAYED_LIST [XGEN_SERVLET_GENERATOR_GENERATOR]} servlet_g_generators.make (10)
		end

feature {NONE} -- Access

	template_registry: HASH_TABLE [XP_TEMPLATE, STRING]
			-- Registry for the templates

	servlet_g_generators: LIST [XGEN_SERVLET_GENERATOR_GENERATOR]
			-- Resolved servlet_generator_generators

	path: STRING
			-- The output path

feature -- Access

	has_resolved: BOOLEAN
			-- Checks if the templates have already been resolved

	taglib_registry: HASH_TABLE [XTL_TAG_LIBRARY, STRING]
			-- Registry for the taglibs

	retrieve_template (a_name: STRING): XP_TEMPLATE
		do
			if attached template_registry [a_name] as template then
				Result := template
			else
				create Result.make_empty
			end
		end

	put_template (a_name: STRING; a_template: XP_TEMPLATE)
		require
			a_name_valid: not a_name.is_empty
		do
			if attached template_registry [a_name] as template then
				template.absorb (a_template)
			else
				template_registry [a_name] := a_template
			end
			has_resolved := False
		end

	put_registry (a_id: STRING; a_taglib: XTL_TAG_LIBRARY)
		require
			a_id_valid: not a_id.is_empty
		do
			taglib_registry [a_id] := a_taglib
		end

	resolve_all_templates
			-- Retrieves all the templates which should become servlets.
			-- Resolves dependencies to other templates
		local
			l_template: XP_TEMPLATE
			l_root_tag: XP_TAG_ELEMENT
			l_servlet_gen: XGEN_SERVLET_GENERATOR_GENERATOR
		do
			from
				template_registry.start
			until
				template_registry.after
			loop
				l_template := template_registry.item_for_iteration
				if not template_registry.item_for_iteration.is_template then
					create l_servlet_gen.make_minimal (l_template.servlet_name, path)
					l_root_tag := l_template.resolve (template_registry, create {HASH_TABLE [LIST [XP_TAG_ELEMENT], STRING]}.make (1), create {ARRAYED_LIST [PROCEDURE [ANY, TUPLE [a_uid: STRING; a_controller_class: STRING]]]}.make (1), l_servlet_gen)
					l_servlet_gen.set_root_tag (l_root_tag)
					servlet_g_generators.extend (l_servlet_gen)
				end
				template_registry.forth
			end
			has_resolved := True
		end

	retrieve_servlet_generator_generators: LIST [XGEN_SERVLET_GENERATOR_GENERATOR]
			--
		require
			is_resolved: has_resolved
		do
			Result := servlet_g_generators
		end

end
