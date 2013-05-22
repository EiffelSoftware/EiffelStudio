note
	description: "[
			Server of creation dependances for incremental validity check.
			It is merged with CREATION_SERVER if the compilation is successful.
			Indexed by class id.
		]"

class TMP_CREATION_SERVER

inherit
	COMPILER_SERVER [CREATION_DEPENDANCE]

create
	make

feature -- Modification

	set_has_qualified_call (value: BOOLEAN; client_routine: like {ROUT_ID_SET}.first; client_class: like {CLASS_C}.class_id)
			-- Set `has_qualified_call (client_routine, client_class)' to `value'.
		do
			attached_item (client_class).set_has_qualified_call (value, client_routine)
		end

	put_creation (supplier_routine: like {ROUT_ID_SET}.first; supplier_class: like {CLASS_C}.class_id;
			client_routine: like {ROUT_ID_SET}.first; client_class: like {CLASS_C}.class_id)
			-- Record that creation procedure `client_routine' from class `client_class'
			-- calls creation procedure `supplier_routine' from `supplier_class'.
		do
			attached_item (client_class).put (supplier_routine, supplier_class, client_routine)
		end

	put_uninitialized_creation (supplier_routine: like {ROUT_ID_SET}.first; supplier_class: like {CLASS_C}.class_id;
			client_routine: like {ROUT_ID_SET}.first; client_class: like {CLASS_C}.class_id;
			feature_ids: SPECIAL [like {ROUT_ID_SET}.first]; location: LOCATION_AS; written_feature: like {ROUT_ID_SET}.first)
			-- Same as `put', but supplier is known to be called in an uninitialized state.
		do
			attached_item (client_class).put_uninitialized (supplier_routine, supplier_class, client_routine, feature_ids, location, written_feature)
		end

feature -- Removal

	remove_procedure (client_routine: like {ROUT_ID_SET}.first; client_class: like {CLASS_C}.class_id)
			-- Wipe out any information recorded for creation procedure `client_routine' from class `client_class'.
		do
			if attached item (client_class) as i then
				i.remove (client_routine)
			elseif attached creation_server.item (client_class) as i then
				i.remove (client_routine)
					-- Make sure a local copy is made.
				cache.force (i)
			end
		end

feature -- Update

	update (id: INTEGER)
			-- Update dependencies for class of `id'.
		do
			if attached cache.item_id (id) as i then
				put (i)
			end
		end

feature {NONE} -- Access

	attached_item (id: INTEGER): CREATION_DEPENDANCE
			-- `item' or a newly created object if `not attached item (id)'.
		do
			if attached item (id) as i then
				Result := i
			else
				create Result.make (id)
					-- Record local copy for future use.
				cache.force (Result)
			end
		end

feature -- Storage

	cache: CACHE [CREATION_DEPENDANCE]
			-- Cache for creation procedure dependencies.
		once
			create Result.make
		end

	Chunk: INTEGER = 500;
			-- <Precursor>

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
