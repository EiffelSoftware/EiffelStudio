indexing
	description: "Server for class information indexed by class id."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_INFO_SERVER

inherit
	SHARED_SERVER
		export
			{NONE} all
		end

feature

	cache: CLASS_INFO_CACHE is
			-- Cache for routine tables
		once
			create Result.make
		end

	has (an_id: INTEGER): BOOLEAN is
			-- Is an item of id `an_id' present in the current server ?
		do
			Result := Tmp_ast_server.has (an_id) or else Ast_server.has (an_id)
		end

	server_has (an_id: INTEGER): BOOLEAN is
			-- Is an item of id `an_id' present in the current server ?
		do
			Result := Ast_server.has (an_id)
		end

	id (t: CLASS_INFO): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	item, disk_item (an_id: INTEGER): CLASS_INFO is
			-- Feature table of id `an_id'. Look first in the temporary
			-- feature table server. It not present, look in itself.
		local
			tmp_class: CLASS_AS
		do
			if Tmp_ast_server.has (an_id) then
				tmp_class := Tmp_ast_server.item (an_id)
			elseif Ast_server.has (an_id) then
				tmp_class := Ast_server.item (an_id)
			end
			if tmp_class /= Void then
				create Result
				Result.set_parents (tmp_class.parents)
				Result.set_creators (tmp_class.creators)
				Result.set_convertors (tmp_class.convertors)
				Result.set_class_id (tmp_class.class_id)
			end
		end;


	server_item (an_id: INTEGER): CLASS_INFO is
			-- Feature table of id `an_id'. Look first in the temporary
			-- feature table server. It not present, look in itself.
		local
			tmp_class: CLASS_AS
		do
			if Ast_server.has (an_id) then
				tmp_class := Ast_server.item (an_id)
			end
			if tmp_class /= Void then
				create Result
				Result.set_parents (tmp_class.parents)
				Result.set_creators (tmp_class.creators)
				Result.set_convertors (tmp_class.convertors)
				Result.set_class_id (tmp_class.class_id)
			end
		end

feature -- Server size configuration

	Size_limit: INTEGER is 200
			-- Size of the CLASS_INFO_SERVER file (200 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

invariant
	cache_not_void: cache /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end
