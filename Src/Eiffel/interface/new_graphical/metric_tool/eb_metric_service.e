indexing
	description: "Object that represents a service provider"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_SERVICE

feature -- Access

	quoted_name (a_name: STRING; a_prefix: STRING): STRING is
			-- Quoted name of `a_name'.
			-- If `a_prefix' is attached, add `a_prefix' before `a_name'.
			-- For example, when `a_name' is "Classes", and `a_prefix' is "metric",
			-- result will be: metric "Classes".
		require
			a_name_attached: a_name /= Void
		do
			if a_prefix /= Void then
				create Result.make (a_name.count + a_prefix.count + 3)
				Result.append (a_prefix)
				Result.append_character (' ')
			else
				create Result.make (a_name.count + 2)
			end
			Result.append_character ('%"')
			Result.append (a_name)
			Result.append_character ('%"')
		ensure
			result_attached: Result /= Void
		end

	substituted_text_with_hash (a_original_text: STRING; a_name_map: HASH_TABLE [STRING, STRING]): STRING is
			-- A string that is `a_original_text' with all its placeholder substituted by given names.
			-- `a_name_map' specifies every placeholder-name pairs.
			-- Placeholder is in form of $name.
			-- For example, if `a_original_text' is "$a is not $b.", and `a_name_map' is $a->abc (The first generic parameter is value "abc",
			-- the second generic parameter is place-holder "$a") and $b->def,
			-- then this feature will return "abc is not def".
		require
			a_original_text_attached: a_original_text /= Void
			a_name_map_attached: a_name_map /= Void
		do
			create Result.make (a_original_text.count + 256)
			Result.append (a_original_text)
			from
				a_name_map.start
			until
				a_name_map.after
			loop
				check
					a_name_map.key_for_iteration /= Void
					a_name_map.item_for_iteration /= Void
				end
				Result.replace_substring_all (a_name_map.key_for_iteration, a_name_map.item_for_iteration)
				a_name_map.forth
			end
		ensure
			result_attached: Result /= Void
		end

	substituted_text (a_original_text: STRING; a_name_map: ARRAY [STRING]): STRING is
			-- A string that is `a_original_text' with all its placeholder substituted by given names.
			-- `a_name_map' specifies every placeholder-name pairs in form of <<"$place-holder1", "value1", "$place-holder2", "value2", ...>>.
			-- For more information, see `substituted_text_with_hash'.
		require
			a_original_text_attached: a_original_text /= Void
			a_name_map_attached: a_name_map /= Void
			a_name_map_in_pairs: a_name_map.count \\ 2 = 0
		local
			l_hash: HASH_TABLE [STRING, STRING]
			i: INTEGER
			l_count: INTEGER
		do
			create l_hash.make (a_name_map.count // 2)
			from
				i := 1
				l_count := a_name_map.count
			until
				 i > l_count
			loop
				l_hash.put (a_name_map.item (i + 1), a_name_map.item (i))
				i := i + 2
			end
			Result := substituted_text_with_hash (a_original_text, l_hash)
		ensure
			result_attached: Result /= Void
		end

indexing
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

end
