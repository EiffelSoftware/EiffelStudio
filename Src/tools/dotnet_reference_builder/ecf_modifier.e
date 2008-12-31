note
	description: "[
		Used to modify Eiffel Configuration Files (ECF) by the way of adding assemblies and modifying
		existing assemblies.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	ECF_MODIFIER

create
	default_create

feature -- Basic Operations

	modify (a_fn: STRING; a_targets: LIST [STRING]; a_assemblies: LIST [LOCATED_ASSEMBLY])
			-- Modifies `a_fn' by adding the assemblies in `a_assemblies' to the ECF targets `a_targets' (or all targets if empty).
		require
			a_fn_attached: a_fn /= Void
			a_fn_exist: (create {RAW_FILE}.make (a_fn)).exists
			a_targets_attached: a_targets /= Void
			a_assemblies_attached: a_assemblies /= Void
			not_a_assemblies_is_empty: not a_assemblies.is_empty
		local
			l_doc: XML_DOCUMENT
			l_nodes: XML_NODE_LIST
			l_lists: ARRAYED_LIST [XML_NODE_LIST]
			l_cursor: CURSOR
			l_node: XML_ELEMENT
			l_errors: ARRAYED_LIST [STRING]
			l_count: INTEGER
			i: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				create l_errors.make (0)
				create l_doc.make
				l_doc.load (a_fn)
				l_doc.save (a_fn + ".bak")

				create l_lists.make (5)
				if a_targets = Void or else a_targets.is_empty then
						-- Add node list for all targets
					l_nodes := l_doc.document_element.select_nodes ("child::target")
					if l_nodes.count > 0 then
						l_lists.extend (l_nodes)
					end
				else
						-- Add node list for specified targets
					l_cursor := a_targets.cursor
					from a_targets.start until a_targets.after loop
						l_nodes := l_doc.document_element.select_nodes ("child::target[@name=%"" + a_targets.item + "%"]")
						if l_nodes.count > 0 then
							l_lists.extend (l_nodes)
						else
							l_errors.extend ("The specified target '" + a_targets.item + "' does not exist in the specified ECF file.")
						end
						a_targets.forth
					end
					a_targets.go_to (l_cursor)
				end

				from l_lists.start until l_lists.after loop
					l_nodes := l_lists.item
					l_count := l_nodes.count
					from i := 0 until i = l_count loop
						l_node ?= l_nodes.item (i)
						check l_node_attached: l_node /= Void end
						if l_node /= Void then
							add_assemblies (l_doc, l_node, a_assemblies)
						end
						i := i + 1
					end
					l_lists.forth
				end
				if l_errors.is_empty then

				end
				l_doc.save (a_fn)
			else
				l_errors.extend ("File '" + "' could not be modified. Please check you have the correct permission and it is a valid ECF file.")
			end
			errors := l_errors
		ensure
			a_targets_unmoved: a_targets.cursor.is_equal (old a_targets.cursor)
			a_assemblies_unmoved: a_assemblies.cursor.is_equal (old a_assemblies.cursor)
		rescue
			retried := True
			retry
		end

feature -- Access

	errors: LIST [STRING]
			-- List of error generated during modification

feature -- Status report

	successful: BOOLEAN
			-- Indicates if modification was successful
		do
			Result := errors = Void or else errors.is_empty
		end

feature {NONE} -- Modification implementation

	add_assemblies (a_doc: XML_DOCUMENT; a_node: XML_ELEMENT; a_assemblies: LIST [LOCATED_ASSEMBLY])
			-- Add assemblies `a_assemblies' to XML node `a_node'.
		local
			l_cursor: CURSOR
			l_name: SYSTEM_STRING
			l_elm: XML_ELEMENT
			l_atr: XML_ATTRIBUTE
			l_nodes: XML_NODE_LIST
			l_prefix: SYSTEM_STRING
			l_count: INTEGER
			i: INTEGER
		do
			l_cursor := a_assemblies.cursor
			from a_assemblies.start until a_assemblies.after loop
				l_prefix := Void
				l_name := a_assemblies.item.assembly.get_name.name.to_lower

					-- Remove existing nodes and retrieve a prefix, if any
				l_nodes := a_node.select_nodes ("child::assembly[@name=%"" + create {STRING}.make_from_cil (l_name) + "%"]")
				l_count := l_nodes.count
				from i := 0 until i = l_count loop
					l_elm ?= l_nodes.item (i)
					l_atr := l_elm.get_attribute_node ("prefix")
					if l_atr /= Void then
						l_prefix := l_atr.value
					end
					l_elm ?= a_node.remove_child (l_elm)
					i := i + 1
				end
				l_elm := a_doc.create_element ("assembly")

				l_atr := a_doc.create_attribute ("name")
				l_atr.set_value (l_name)
				l_atr := l_elm.attributes.append (l_atr)

				l_atr := a_doc.create_attribute ("location")
				l_atr.set_value (location_for_assembly (a_assemblies.item))
				l_atr := l_elm.attributes.append (l_atr)

				if l_prefix /= Void and then l_prefix.length > 0 then
					l_atr := a_doc.create_attribute ("prefix")
					l_atr.set_value (l_prefix)
					l_atr := l_elm.attributes.append (l_atr)
				end

				l_elm ?= a_node.append_child (l_elm)
				a_assemblies.forth
			end
			a_assemblies.go_to (l_cursor)
		ensure
			a_assemblies_unmoved: a_assemblies.cursor.is_equal (old a_assemblies.cursor)
		end

feature -- Query

	location_for_assembly (a_assembly: LOCATED_ASSEMBLY): STRING
			-- Retrieve a formatted location for assembly `a_assembly'
		require
			a_assembly_attached: a_assembly /= Void
		local
			l_loc: STRING
			l_fw_path: STRING
			l_len: INTEGER
		do
			l_loc := a_assembly.real_path.as_lower
			l_fw_path := {RUNTIME_ENVIRONMENT}.get_runtime_directory.to_lower
			l_len := l_fw_path.count
			if l_loc.count >= l_len and then l_fw_path.is_equal (l_loc.substring (1, l_len)) then
					-- Replace with ISE_DOTNET_FRAMEWORK
				l_loc.replace_substring (once "${ISE_DOTNET_FRAMEWORK}\", 1, l_len)
			end
			Result := l_loc
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

invariant
	errors_attached: not successful implies errors /= Void
	not_errors_is_empty: not successful implies not errors.is_empty

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class {ECF_MODIFIER}
