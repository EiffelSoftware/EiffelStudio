note
	description: "Match list server for a class indexed by class id."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MATCH_LIST_SERVER

inherit
	COMPILER_SERVER [LEAF_AS_LIST]
		rename
			item as stored_item,
			has as stored_has
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		undefine
			copy, is_equal
		end

		-- Text for direct parsing.
	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature -- Access

	item (an_id: INTEGER): LEAF_AS_LIST
			-- Retrieve object.
		local
			l_class: CLASS_C
			l_text: STRING
			l_options: CONF_OPTION
			l_scanner: like matchlist_scanner
			l_retried: BOOLEAN
		do
			if not l_retried then
					-- 02/06/2006 Patrickr
					-- On a read only project we can't write, so we just store the match list in the cache.
					-- It would be better to have a more intelligent store mechanism, that would do this.
				Result := cache.item_id (an_id)
				if Result = Void then
					Result := stored_item (an_id)
				end
				l_class := system.class_of_id (an_id)
					-- lazy computation, create match list if needed
				if Result = Void or else Result.generated /= l_class.lace_class.file_date then
					l_text := l_class.text
						-- If the file associated with `l_class` has been removed we might get no text
						-- thus the protection.
					if l_text /= Void then
						l_options := l_class.lace_class.options
						l_scanner := matchlist_scanner
						l_scanner.set_syntax_version
							(inspect l_options.syntax.index
							when {CONF_OPTION}.syntax_index_obsolete then
								{EIFFEL_SCANNER}.obsolete_syntax
							when {CONF_OPTION}.syntax_index_transitional then
								{EIFFEL_SCANNER}.transitional_syntax
							when {CONF_OPTION}.syntax_index_provisional then
								{EIFFEL_SCANNER}.provisional_syntax
							else
								{EIFFEL_SCANNER}.ecma_syntax
							end)
						error_handler.save
						l_scanner.set_filename (l_class.file_name)
						l_scanner.scan_utf8_string (l_text)
						error_handler.restore
						if attached l_scanner.match_list as l_list then
							Result := l_list
							Result.set_class_id (an_id)
							Result.set_generated (l_class.lace_class.file_date)
								-- 02/06/2006 Patrickr
								-- On a read only project we can't write, so we just store the match list in the cache.
								-- It would be better to have a more intelligent store mechanism, that would do this.
							if not system.eiffel_project.is_read_only then
								put (Result)
							else
								cache.remove_id (an_id)
								cache.force (Result)
							end
						else
								-- Ideally we should not be creating an empty list, but simply returning Void.
								-- However too many callers are not checking for a Void result.
							create Result.make (1)
						end
					end
				end
			else
				create Result.make (1)
			end
		rescue
			l_retried := True
			retry
		end

	cache: CACHE [LEAF_AS_LIST]
			-- Cache to speedup
		once
			create Result.make
		end

	has (an_id: INTEGER): BOOLEAN
			-- Does the server have the matchlist for `an_id'?
		do
			Result := stored_has (an_id)
			if not stored_has (an_id) then
					-- if we don't have it already, check if the class exists, if so, we can compute it.
				Result := system.class_of_id (an_id) /= Void
			end
		end

feature {NONE} -- Implementation

	Chunk: INTEGER = 500;
			-- Size of a HASH_TABLE' block

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
