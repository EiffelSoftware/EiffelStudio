note
	description: "Objects that represents a debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DEBUGGER_FS_STORAGE

inherit
	ES_DEBUGGER_STORAGE_CELL_SESSION
		redefine
			profiles_data_from_storage,
			profiles_data_to_storage,
			exceptions_handler_data_from_storage,
			exceptions_handler_data_to_storage,
			profiles_data_to_file,
			profiles_data_from_file
		end

	EIFFEL_LAYOUT

	SHARED_WORKBENCH

create
	make

feature -- Access: profiles

	profiles_data_name: STRING = "execution_parameters"
			-- Name/identifier for the profiles data.
			-- Also used in file storage!

	profiles_data_location: detachable PATH
			-- Location of the profiles data file.
		local
			dn: PATH
			tgt_name: READABLE_STRING_GENERAL
			l_uuid: READABLE_STRING_GENERAL
			l_name: STRING_32
		do
			if workbench.system_defined then
				l_uuid := workbench.lace.conf_system.uuid.out
				tgt_name := workbench.lace.target_name
				if is_eiffel_layout_defined then
					dn := eiffel_layout.session_data_path
					create l_name.make_from_string_general (l_uuid)
					l_name.append_character ('.')
					l_name.append_string_general (tgt_name)
					l_name.append_character ('.')
					l_name.append ("dbg")
					l_name.append_character ('.')
					l_name.append ("profiles.xml")
					Result := dn.extended (l_name)
				end
			end
		end

	profiles_data_from_storage: detachable DEBUGGER_PROFILE_MANAGER
			-- <Precursor>
		do
				-- Session data
			if attached profiles_data_location as p then
				Result := profiles_data_from_file (p)
			else
					-- Note: load with previous binary storage.
					-- Todo: remove this in a few releases
				Result := Precursor
			end
		end

	profiles_data_from_file (a_path: PATH): like profiles_data_from_storage
			-- <Precursor>
		local
			prof: DEBUGGER_EXECUTION_PROFILE
			l_uuid: UUID
			l_root, e: XML_ELEMENT
			att: detachable XML_ATTRIBUTE
			k,v: detachable STRING_32
		do
				-- FIXME: check versioning information!
			if
				attached xml_document_from (a_path) as doc and then
				doc.root_element.name.same_string_general (profiles_data_name)
			then
				l_root := doc.root_element
				if attached l_root.elements_by_name ("profile") as l_profile_list then
					create Result.make (l_profile_list.count)
					across
						l_profile_list as ic
					loop
						e := ic.item
						att := e.attribute_by_name ("uuid")
						if att /= Void then
							create l_uuid
							if l_uuid.is_valid_uuid (att.value) then
								create l_uuid.make_from_string (att.value)
								create prof.make_with_uuid (l_uuid)
							else
								create prof.make
							end
						else
							create prof.make
						end
						Result.add (prof)

						att := e.attribute_by_name ("title")
						if att /= Void then
							prof.set_title (att.value)
						end
						att := e.attribute_by_name ("arguments")
						if att /= Void then
							prof.set_arguments (att.value)
						end
						att := e.attribute_by_name ("working_copy")
						if att /= Void then
							prof.set_working_directory (create {PATH}.make_from_string (att.value))
						end
						if attached e.element_by_name ("variables") as l_variables then
							across
								l_variables as var_ic
							loop
								if attached {XML_ELEMENT} var_ic.item as e2 then
									k := Void
									v := Void
									att := e2.attribute_by_name ("name")
									if att /= Void then
										k := att.value
										att := e2.attribute_by_name ("value")
										if att /= Void then
											v := att.value
										end
									end
									if k /= Void then
										if e2.name.is_case_insensitive_equal_general ("unset") then
											prof.unset_environment_variable (k)
										elseif e2.name.is_case_insensitive_equal_general ("set") then
											prof.set_environment_variable (v, k)
										else
											-- Ignore
										end
									end
								end
							end
						end
					end
				end
				if attached l_root.attribute_by_name ("last_profile") as l_att_last_prof then
					Result.set_last_profile_by_uuid (create {UUID}.make_from_string (l_att_last_prof.value))
				end
			end
		end

feature -- Access: exception handler

	exceptions_handler_data_name: STRING = "debugger_exceptions_handler"
			-- Name/identifier for the exceptions handler data.
			-- Also used in file storage!

	exceptions_handler_data_location: detachable PATH
			-- Location of the exceptions handler data file.
		local
			dn: PATH
			tgt_name: READABLE_STRING_GENERAL
			l_uuid: READABLE_STRING_GENERAL
			l_name: STRING_32
		do
			if workbench.system_defined then
				l_uuid := workbench.lace.conf_system.uuid.out
				tgt_name := workbench.lace.target_name
				if is_eiffel_layout_defined then
					dn := eiffel_layout.session_data_path
					create l_name.make_from_string_general (l_uuid)
					l_name.append_character ('.')
					l_name.append_string_general (tgt_name)
					l_name.append_character ('.')
					l_name.append ("dbg")
					l_name.append_character ('.')
					l_name.append ("exceptions_handler.xml")
					Result := dn.extended (l_name)
				end
			end
		end

	exceptions_handler_data_from_storage: detachable DBG_EXCEPTION_HANDLER
			-- <Precursor>
		do
			if attached exceptions_handler_data_location as p then
				Result := exceptions_handler_data_from_file (p)
			else
					-- Note: load with previous binary storage.
					-- Todo: remove this in a few releases
				Result := Precursor
			end
		end

	exceptions_handler_data_from_file (a_path: PATH): detachable DBG_EXCEPTION_HANDLER
			-- <Precursor>
		local
			rt: XML_ELEMENT
			att: detachable XML_ATTRIBUTE
			s: detachable STRING_32
			l_name: STRING
		do
				-- FIXME: check versioning information!
			if
				attached xml_document_from (a_path) as doc and then
				doc.root_element.name.same_string_general (exceptions_handler_data_name)
			then
				create Result.make_handling_by_name
				rt := doc.root_element
				att := rt.attribute_by_name ("enabled")
				if att /= Void and then att.value.is_case_insensitive_equal_general ("True") then
					Result.enable_exception_handling
				else
					Result.disable_exception_handling
				end

				if attached rt.element_by_name ("catcall_console_warning") as elt then
					att := elt.attribute_by_name ("disabled")
					if att /= Void then
						Result.set_catcall_console_warning_disabled (att.value.is_case_insensitive_equal_general ("True"))
					end
				end
				if attached rt.element_by_name ("catcall_debugger_warning") as elt then
					att := elt.attribute_by_name ("disabled")
					if att /= Void then
						Result.set_catcall_debugger_warning_disabled (att.value.is_case_insensitive_equal_general ("True"))
					end
				end
				if attached rt.elements_by_name ("exception") as l_exception_list then
					across
						l_exception_list as ic
					loop
						if attached ic.item.attribute_by_name ("name") as att_name then
							s := att_name.value
							if
								s.is_valid_as_string_8 and then
								attached ic.item.attribute_by_name ("role") as att_role
							then
								l_name := s.to_string_8
								if att_role.value.is_case_insensitive_equal_general ("disabled") then
									Result.disable_exception_by_name (l_name)
								elseif att_role.value.is_case_insensitive_equal_general ("continue") then
									Result.ignore_exception_by_name (l_name)
								elseif att_role.value.is_case_insensitive_equal_general ("stop") then
									Result.catch_exception_by_name (l_name)
								else
									check valid_role: False end
										-- Ignore!
								end
							end
						end
					end
				end
			end
		end

feature {NONE} -- Persistence

	profiles_data_to_storage (a_data: like profiles_data_from_storage)
			-- <Precursor>
		do
			profiles_data_to_file (a_data, profiles_data_location)
		end

	profiles_data_to_file (a_data: like profiles_data_from_storage; a_path: PATH)
			-- Save profiles data `a_data' to `a_path'.
		local
			doc: XML_DOCUMENT
			p: DEBUGGER_EXECUTION_PROFILE
		do
			doc := new_xml_document (profiles_data_name, "execution-parameters-1-0-0")
			if attached doc.root_element as rt then
				if attached a_data.last_profile as l_last_profile then
					rt.add_unqualified_attribute ("last_profile", l_last_profile.uuid.out)
				end
				across
					a_data as ic
				loop
					p := ic.item
					append_profile_to_xml_element (p, rt)
				end
			end
			save_xml_document_to (doc, a_path)
		end

	append_profile_to_xml_element (a_profile: DEBUGGER_EXECUTION_PROFILE; a_parent: XML_ELEMENT)
		local
			elt,vars_elt,var_elt: XML_ELEMENT
			k: STRING_32
		do
			create elt.make (a_parent, "profile", a_parent.namespace)
			a_parent.force_last (elt)
			elt.add_unqualified_attribute ("uuid", a_profile.uuid.out)
			if attached a_profile.title as l_title then
				elt.add_unqualified_attribute ("title", l_title)
			end
			elt.add_unqualified_attribute ("arguments", a_profile.arguments)
			if attached a_profile.working_directory as l_path then
				elt.add_unqualified_attribute ("working_directory", l_path.name)
			end
			if attached a_profile.environment_variables as l_vars then
				create vars_elt.make (elt, "variables", elt.namespace)
				elt.force_last (vars_elt)
				across
					l_vars as ic
				loop
					k := ic.key
					if k.starts_with ("&-") then
						k.remove_head (2)
						create var_elt.make (vars_elt, "unset", elt.namespace)
						var_elt.add_unqualified_attribute ("name", k)
					else
						create var_elt.make (vars_elt, "set", elt.namespace)
						var_elt.add_unqualified_attribute ("name", k)
						var_elt.add_unqualified_attribute ("value", ic.item)
					end
					vars_elt.force_last (var_elt)
				end
			end
--			elt.add_unqualified_attribute ("version", a_profile.version.out)
		end

	exceptions_handler_data_to_storage (a_data: like exceptions_handler_data_from_storage)
			-- <Precursor>
		do
			save_exceptions_handler_data_to_file (a_data, exceptions_handler_data_location)
		end

	save_exceptions_handler_data_to_file (a_data: like exceptions_handler_data_from_storage; a_path: PATH)
			-- <Precursor>		
		local
			doc: XML_DOCUMENT
			rt, elt: XML_ELEMENT
		do
			doc := new_xml_document (exceptions_handler_data_name, "debugger-exception-handler-1-0-0")

			rt := doc.root_element
			if a_data /= Void then
				if a_data.enabled then
					rt.add_unqualified_attribute ("enabled", "True")
				end
				if a_data.catcall_console_warning_disabled then
					create elt.make (rt, "catcall_console_warning", rt.namespace)
					elt.add_unqualified_attribute ("disabled", "True")
				end
				if a_data.catcall_debugger_warning_disabled then
					create elt.make (rt, "catcall_debugger_warning", rt.namespace)
					elt.add_unqualified_attribute ("disabled", "True")
				end
				across
					a_data.handled_exceptions_by_name as ic
				loop
					create elt.make (rt, "exception", rt.namespace)
					elt.add_unqualified_attribute ("name", ic.item.name)
					inspect ic.item.role
					when {DBG_EXCEPTION_HANDLER}.role_disabled then
						elt.add_unqualified_attribute ("role", "disabled")
					when {DBG_EXCEPTION_HANDLER}.role_continue then
						elt.add_unqualified_attribute ("role", "continue")
					when {DBG_EXCEPTION_HANDLER}.role_stop then
						elt.add_unqualified_attribute ("role", "stop")
					else
					end
					rt.force_last (elt)
				end
			end

			save_xml_document_to (doc, a_path)
		end

feature {NONE} -- Implementation: xml

	new_xml_document (a_root_name: READABLE_STRING_GENERAL; a_xmlns_name_version: detachable READABLE_STRING_GENERAL): XML_DOCUMENT
			-- New XML_DOCUMENT with predefined declaration and information.
		local
			decl: XML_DECLARATION
		do
			create Result.make_with_root_named (a_root_name.as_string_32, create {XML_NAMESPACE}.make_default)
			create decl.make_in_document (Result, "1.0", "ISO-8859-1", False)
			Result.set_xml_declaration (decl)
			if a_xmlns_name_version /= Void then
				Result.root_element.add_unqualified_attribute ("xmlns", "http://www.eiffel.com/developers/xml/" + a_xmlns_name_version)
					-- For now, let's use only xmlns for versioning.
--				Result.root_element.add_unqualified_attribute ("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance")
--				Result.root_element.add_unqualified_attribute ("xsi:schemaLocation", "http://www.eiffel.com/developers/xml/" + a_xmlns_name_version + " " + a_xmlns_name_version + ".xsd")
			end
		end

	xml_document_from (a_path: PATH): detachable XML_DOCUMENT
			-- XML document contained at `a_path', if any.
		local
			l_parser: XML_STANDARD_PARSER
			cb: XML_CALLBACKS_DOCUMENT
		do
			create l_parser.make
			create cb.make_null
			l_parser.set_callbacks (cb)
			l_parser.parse_from_path (a_path)
			if
				not l_parser.error_occurred
			then
				Result := cb.document
			end
		end

	save_xml_document_to (doc: XML_DOCUMENT; a_path: PATH)
			-- Save xml document `doc' into `a_path', if possible.
		local
			vis: XML_NODE_PRINTER
			t2e: XML_TREE_TO_EVENTS
			f: FILE
			cb: XML_INDENT_PRETTY_PRINT_FILTER
		do
			create {PLAIN_TEXT_FILE} f.make_with_path (a_path)
			create vis.make
			if f.exists then
				if f.is_access_writable then
					f.open_write
				else
					check has_permission: False end
				end
			else
				f.create_read_write
			end
			if f.is_open_write then
				create cb.make_null
				cb.set_output_file (f)
				create t2e.make (cb)
				t2e.process_document (doc)
				f.close
			end
				-- FIXME: handle eventual error!
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
