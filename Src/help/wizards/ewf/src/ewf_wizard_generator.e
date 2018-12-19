note
	description: "Summary description for {EWF_WIZARD_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_WIZARD_GENERATOR

inherit
	WIZARD_GENERATOR
		redefine
			copy_template
		end

	SHARED_TEMPLATE_CONTEXT

create
	make

feature -- Query

	collection: detachable WIZARD_DATA

feature -- Execution

	execute (a_collection: WIZARD_DATA)
		local
			d: DIRECTORY
			pdn, dn: PATH
		do
			collection := a_collection
			if
				attached a_collection.item ("project:name") as pn and
				attached a_collection.item ("project:location") as l_loc
			then
				create pdn.make_from_string (l_loc)

				variables.force (pn.as_lower, "APP_NAME")
				variables.force (pn.as_upper, "APP_ROOT")
				variables.force (new_uuid, "UUID")
				variables.force ("none", "CONCURRENCY")

				variables.force ("yes", "WIZ_YES")
				variables.force ("no", "WIZ_NO")

				dn := pdn
				create d.make_with_path (dn)
				if not d.exists then
					d.recursive_create_dir
				end

				recursive_copy_templates (application.layout.resources_location, dn)

				send_response (create {WIZARD_SUCCEED_RESPONSE}.make (dn.extended (pn).appended_with_extension ("ecf"), d.path))
			else
				send_response (create {WIZARD_FAILED_RESPONSE})
			end
		end

feature -- Templates

	smarty_template_extensions: ARRAY [READABLE_STRING_32]
		once
			Result := <<"e", "ecf", "ini">>
		end

	is_smarty_template_file (f: PATH): BOOLEAN
		do
			if attached f.extension as ext then
				Result := across smarty_template_extensions as ext_ic some ext_ic.item.is_case_insensitive_equal_general (ext) end
			end
		end

	is_template_file (f: PATH): BOOLEAN
		do
			Result := is_smarty_template_file (f)
		end

	copy_template (a_src: PATH; a_target: PATH)
		do
			if is_smarty_template_file (a_src) then
				copy_smarty_template (a_src, a_target)
			else
				Precursor (a_src, a_target)
			end
		end

	copy_smarty_template (a_res: PATH; a_target: PATH)
		local
			tpl: TEMPLATE_FILE
			f,t: PLAIN_TEXT_FILE
			inspectors: ARRAYED_LIST [TEMPLATE_INSPECTOR]
		do
			create f.make_with_path (a_res)
			if f.exists and f.is_readable then
				create tpl.make_from_file (f.path.name)
				if attached collection as l_collection then
					tpl.add_value (l_collection, "WIZ")
				end
				across
					variables as ic
				loop
					tpl.add_value (ic.item, ic.key)
				end
				template_context.set_template_folder (application.layout.templates_location)
				create inspectors.make (2)
				inspectors.force (create {WIZARD_DATA_TEMPLATE_INSPECTOR}.register (({detachable WIZARD_DATA}).name))
				inspectors.force (create {WIZARD_PAGE_DATA_TEMPLATE_INSPECTOR}.register (({detachable WIZARD_PAGE_DATA}).name))
				tpl.analyze
				tpl.get_output
				across
					inspectors as ic
				loop
					ic.item.unregister
				end
				if attached tpl.output as l_output then
					create t.make_with_path (a_target)
					if not t.exists or else t.is_writable then
						t.create_read_write
						t.put_string (l_output)
						t.close
					end
				else
					copy_file (a_res, a_target)
				end
			end
		end

end
