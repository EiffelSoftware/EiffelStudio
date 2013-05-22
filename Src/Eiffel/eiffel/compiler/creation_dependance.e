note
	description: "Dependancies of a class creation procedure indexed by the creation procedure routine ID."

class CREATION_DEPENDANCE

inherit
	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

create
	make

feature {NONE} -- Creation

	make (id: like {CLASS_C}.class_id)
			-- Create creation dependency for class of `id'.
		do
			create supplier.make (0)
			create uninitialized_supplier.make (0)
			create uninitialized_context.make (0)
			create qualified_call.make (0)
			set_class_id (id)
		ensure
			class_id_set: class_id = id
		end

feature -- Access

	has_qualified_call (client_routine: like {ROUT_ID_SET}.first): BOOLEAN
			-- Does creation procedure `client_routine' from class `client_class'
			-- make qualified call?
		do
			Result := qualified_call [client_routine]
		end

feature -- Modification

	set_has_qualified_call (value: BOOLEAN; client_routine: like {ROUT_ID_SET}.first)
			-- Set `has_qualified_call (client_routine, client_class)' to `value'.
		do
			qualified_call [client_routine] := value
			if value then
					-- There is no need to keep suppliers as soon as there are qualified calls.
				supplier.remove (client_routine)
			end
		ensure
			has_qualified_call (client_routine) = value
		end

	put (supplier_routine: like {ROUT_ID_SET}.first; supplier_class: like {CLASS_C}.class_id;
		client_routine: like {ROUT_ID_SET}.first)
			-- Record that creation procedure `client_routine' from class `client_class'
			-- calls creation procedure `supplier_routine' from `supplier_class'.
		local
			t: like supplier.item
		do
				-- There is no reason to record suppliers as soon as the procedure makes a qualified call.
			if not qualified_call [client_routine] then
				t := supplier [client_routine]
				if not attached t then
						-- Add a new entry for the client.
					create t.make (1)
					supplier [client_routine] := t
				end
				t.force ([supplier_routine, supplier_class])
			end
		end

	put_uninitialized (supplier_routine: like {ROUT_ID_SET}.first; supplier_class: like {CLASS_C}.class_id;
			client_routine: like {ROUT_ID_SET}.first;
			feature_ids: SPECIAL [like {ROUT_ID_SET}.first]; location: LOCATION_AS; written_feature: like {ROUT_ID_SET}.first)
			-- Same as `put', but supplier is known to be called in an uninitialized state.
		local
			t: like uninitialized_supplier.item
		do
			t := uninitialized_supplier [client_routine]
			if not attached t then
					-- Add a new entry for the client.
				create t.make (1)
				uninitialized_supplier [client_routine] := t
				uninitialized_context [client_routine] := [feature_ids, create {LOCATION_AS}.make_from_other (location), written_feature]
			end
			t.force ([supplier_routine, supplier_class])
		end

feature -- Removal

	remove (client_routine: like {ROUT_ID_SET}.first)
			-- Remove any information recorded for creation procedure identified by `client_routine'.
		do
			supplier.remove (client_routine)
			uninitialized_supplier.remove (client_routine)
			uninitialized_context.remove (client_routine)
			qualified_call.remove (client_routine)
		end

feature {CREATION_SERVER} -- Storage

	supplier: HASH_TABLE [SEARCH_TABLE [TUPLE [routine_id: like {ROUT_ID_SET}.first; class_id: like {CLASS_C}.class_id]], like {ROUT_ID_SET}.first]
			-- Sets of supplier creation procedures indexes by client creation procedures.

	uninitialized_supplier: like supplier
			-- Same as `supplier', but suppliers are known to be called in uninitialized state.

	uninitialized_context: HASH_TABLE [TUPLE [feature_ids: SPECIAL [like {ROUT_ID_SET}.first]; location: LOCATION_AS; written_feature: like {ROUT_ID_SET}.first], like {ROUT_ID_SET}.first]
			-- Information on uninitialized position: list of attributes, location and written feature.

	qualified_call: HASH_TABLE [BOOLEAN, like {ROUT_ID_SET}.first]
			-- Indicators whether creation procedures make qualified calls.

;note
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
