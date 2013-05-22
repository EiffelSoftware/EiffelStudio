note
	description: "Storage of creation procedures initialization status."

class
	CREATION_SERVER

inherit
	COMPILER_SERVER [CREATION_DEPENDANCE]
		redefine
			has, item, remove
		end

	SHARED_ERROR_HANDLER

create
	make

feature {TMP_CREATION_SERVER} -- Access

	has (id: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := tmp_creation_server.has (id) or else Precursor (id)
		end

	item (id: INTEGER): detachable CREATION_DEPENDANCE
			-- Creation dependance for `id'.
		do
			Result := tmp_creation_server.item (id)
			if not attached Result then
				Result := Precursor (id)
			end
		end

feature {SYSTEM_I} -- Modification

	remove (id: INTEGER_32)
			-- <Precursor>
		do
			tmp_creation_server.remove (id)
			Precursor (id)
		end

feature {NONE} -- Access

	has_qualified_call (client_routine: like {ROUT_ID_SET}.first; client_class: like {CLASS_C}.class_id): BOOLEAN
			-- Does creation procedure `client_routine' from class `client_class'
			-- make qualified call?
		do
			if attached item (client_class) as i then
				Result := i.has_qualified_call (client_routine)
			end
		end

feature -- Validity checks

	check_initialization (c: CLASS_C)
			-- Check that initialization validity rules for a class `c' are not violated.
		local
			k: like key
			p: SEARCH_TABLE [like key]
			removed: SEARCH_TABLE [like {ROUT_ID_SET}.first]
		do
			if attached item (c.class_id) as i then
				create removed.make (0)
				across
					i.uninitialized_supplier as s
				loop
					if attached c.feature_of_rout_id (s.key) then
							-- The feature is still in the class.
						create p.make (1)
						k := key (s.key, c.class_id)
						p.force (k)
						check_suppliers (s.item, k, p)
					else
							-- The feature was removed.
						removed.force (s.key)
					end
				end
				across
					i.supplier as s
				loop
					if not attached c.feature_of_rout_id (s.key) then
							-- The feature was removed.
						removed.force (s.key)
					end
				end
				across
					i.qualified_call as s
				loop
					if not attached c.feature_of_rout_id (s.key) then
							-- The feature was removed.
						removed.force (s.key)
					end
				end
				across
					removed as s
				loop
					i.remove (s.item)
				end
			end
		end

feature {NONE} -- Validity checks

	check_suppliers (suppliers: detachable like {CREATION_DEPENDANCE}.supplier.item; k: like key; processed: SEARCH_TABLE [like key])
			-- Check that `suppliers' of a creation routine identified by `c' do not violate initialization validity rules.
		local
			s: like key
			w: SHARED_WORKBENCH
			l: ARRAYED_LIST [FEATURE_I]
			context: like {CREATION_DEPENDANCE}.uninitialized_context.item
			context_class: CLASS_C
		do
			if attached suppliers as ss then
				across
					ss as i
				loop
					s := i.item
						-- Supplier should not make any qualified calls.
					if has_qualified_call (s.routine_id, s.class_id) then
						if attached item (k.class_id) as x then
							create w
							context := x.uninitialized_context [k.routine_id]
							context_class := w.system.class_of_id (k.class_id)
							create l.make (context.feature_ids.count)
							across
								context.feature_ids as f
							loop
								l.extend (context_class.feature_of_rout_id (f.item))
							end
							error_handler.insert_error (create {VEVI}.make_attributes
								(l, k.class_id, context_class.feature_of_rout_id (k.routine_id),
								context.location, context_class.feature_of_rout_id (context.written_feature)))
						end
					elseif not processed.has (s) then
							-- Recurse only for non-processed procedures.
						processed.force (s)
						if attached item (s.class_id) as x then
							check_suppliers (x.uninitialized_supplier [s.routine_id], k, processed)
							check_suppliers (x.supplier [s.routine_id], k, processed)
						end
						processed.remove (s)
					end
				end
			end
		end

feature {SYSTEM_SERVER} -- Storage

	chunk: INTEGER = 100
			-- <Precursor>
			--| There should not be too many dependencies.

	cache: CACHE [CREATION_DEPENDANCE]
		once
			create Result.make
		end

feature {NONE} -- Index

	key (routine_id: like {ROUT_ID_SET}.first; class_id: like {CLASS_C}.class_id):
			TUPLE [routine_id: like {ROUT_ID_SET}.first; class_id: like {CLASS_C}.class_id]
			-- Key of `supplier', `uninitialized_supplier' and `qualified_call'
			-- computed for routine of `routine_id' from class of `class_id'.
		do
			Result := [routine_id, class_id]
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
