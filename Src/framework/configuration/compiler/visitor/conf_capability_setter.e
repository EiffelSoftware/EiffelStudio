note
	description: "Setter of capability options."
	instruction: "Call creation procedure `make` to propagate target's settings to dependent capabilities."

class CONF_CAPABILITY_SETTER

inherit
	CONF_ACCESS
	CONF_INTERFACE_CONSTANTS
	CONF_ITERATOR
		redefine
			process_assembly,
			process_cluster,
			process_library,
			process_override,
			process_precompile,
			process_target
		end

create
	make

feature {NONE} -- Creation

	make (t: CONF_TARGET)
			-- Update capabilities of all elements used by target `t` to its settings.
		local
			root_options: CONF_TARGET_OPTION
		do
			root_options := t.options
			root_catcall_detection_index := root_options.catcall_safety_capability.root_index
			root_concurrency_index := root_options.concurrency_capability.root_index
			root_void_safety_index := root_options.void_safety_capability.root_index
			create targets.make_map (1)
			process_target (t)
		end

feature {CONF_VISITABLE} -- Visitor

	process_target (t: CONF_TARGET)
			-- <Precursor>
		do
			if not targets.has (t) then
				targets.force (t)
					-- Update target options.
				update_target (t)
				if attached t.extends as parent then
						-- Recurse to parent.
					process_target (parent)
				end
					-- Check groups.
				Precursor (t)
			end
		end

	process_library (a_library: CONF_LIBRARY)
			-- <Precursor>
		do
				-- Update library.
			update_group (a_library)
				-- Update library target.
			if attached a_library.library_target as t then
				process_target (t)
			end
		end

	process_precompile (a_precompile: CONF_PRECOMPILE)
			-- <Precursor>
		do
			process_library (a_precompile)
		end

	process_assembly (an_assembly: CONF_ASSEMBLY)
			-- <Precursor>
		do
 			update_group (an_assembly)
		end

	process_cluster (a_cluster: CONF_CLUSTER)
			-- <Precursor>
		do
			update_group (a_cluster)
			update_cluster (a_cluster)
		end

	process_override (an_override: CONF_OVERRIDE)
			-- <Precursor>
		do
			process_cluster (an_override)
		end

feature {NONE} -- Traversal

	root_catcall_detection_index: like {CONF_TARGET_OPTION}.catcall_detection_index_none
			-- Catcall setting specified for `root_target'.

	root_concurrency_index: like {CONF_TARGET_OPTION}.concurrency_index_none
			-- Concurrency setting specified for `root_target'.

	root_void_safety_index: like {CONF_TARGET_OPTION}.void_safety_index_none
			-- Void safety setting specified for `root_target'.

	targets: SEARCH_TABLE [CONF_TARGET]
			-- Already processed targets.

	update_cluster (cluster: CONF_CLUSTER)
			-- Update options of classes in `cluster'.
		local
			o: like {CONF_CLUSTER}.internal_class_options.item
			f: like {CONF_CLUSTER}.forced_class_options
		do
			if attached cluster.internal_class_options as os then
				across
					os as option
				loop
					o := option.item
						-- Update class options to use the root setting.
					if
						o.catcall_detection.index /= root_catcall_detection_index or else
						o.void_safety.index /= root_void_safety_index
					then
						o := o.twin
						o.catcall_detection.put_index (root_catcall_detection_index)
						o.void_safety.put_index (root_void_safety_index)
						if not attached f then
							create f.make_caseless (os.count)
						end
						f [option.key] := o
					end
				end
				if attached f then
					cluster.force_class_options (f)
				end
			end
		end

	update_group (group: CONF_GROUP)
			-- Update options of group `group'.
		local
			o: like {CONF_GROUP}.internal_options
		do
			if
				attached group.internal_options as option and then
				(option.catcall_detection.index /= root_catcall_detection_index or else
				option.void_safety.index /= root_void_safety_index)
			then
					-- Update group options to use the root setting.
				o := option.twin
				o.catcall_detection.put_index (root_catcall_detection_index)
				o.void_safety.put_index (root_void_safety_index)
				group.force_options (o)
			end
		end

	update_target (parent: CONF_TARGET)
			-- Update options of target `parent'.
		local
			o: like {CONF_TARGET}.internal_options
		do
			o := parent.internal_options
			if not attached o then
				o := {like {CONF_TARGET}.internal_options}.create_from_namespace_or_latest (parent.namespace)
			end
			if
				o.catcall_detection.index /= root_catcall_detection_index or else
				o.concurrency.index /= root_concurrency_index or else
				o.void_safety.index /= root_void_safety_index
			then
				o := o.twin
					-- Update target options to use the root setting.
				o.catcall_detection.put_index (root_catcall_detection_index)
				o.concurrency.put_index (root_concurrency_index)
				o.void_safety.put_index (root_void_safety_index)
				parent.force_options (o)
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
