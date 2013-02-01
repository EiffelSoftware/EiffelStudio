note
	description: "Objects that specify rules for files to be excluded or included."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FILE_RULE

inherit
	CONF_CONDITIONED
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create
		do
		end

feature -- Status

	is_empty: BOOLEAN
			-- Is this file rule empty?
		do
			Result := (exclude = Void or else exclude.is_empty) and (include = Void or else include.is_empty)
		end

feature -- Access, stored in configuration file

	exclude: SEARCH_TABLE [STRING_32]
			-- Exclude patterns

	include: SEARCH_TABLE [STRING_32]
			-- Include patterns

	description: STRING_32
			-- A description about the rules.

feature {CONF_ACCESS} -- Update, stored in configuration file

	add_exclude (a_pattern: STRING_32)
			-- Add an exclude pattern.
		require
			a_pattern_ok: valid_regexp (a_pattern)
		do
			if exclude = Void then
				create exclude.make (1)
			end
			exclude.put (a_pattern)
			compile
		end

	add_include (a_pattern: STRING_32)
			-- Add an include pattern.
		require
			a_pattern_ok: valid_regexp (a_pattern)
		do
			if include = Void then
				create include.make (1)
			end
			include.put (a_pattern)
			compile
		end

	del_exclude (a_pattern: STRING_32)
			-- Delete an exclude pattern.
		require
			a_pattern_ok: exclude /= Void and then exclude.has (a_pattern)
		do
			exclude.remove (a_pattern)
			if exclude.is_empty then
				exclude := Void
			end
			compile
		end

	del_include (a_pattern: STRING_32)
			-- Delete an include pattern.
		require
			a_pattern_ok: include /= Void and then include.has (a_pattern)
		do
			include.remove (a_pattern)
			if include.is_empty then
				include := Void
			end
			compile
		end

	set_description (a_description: like description)
			-- Set `description' to `a_description'
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

feature {CONF_ACCESS} -- Merging

	merge (other: like Current)
			-- Merge with other.
		require
			other_valid: other.valid_excludes and other.valid_includes
		do
			if other /= Void then
				if exclude = Void then
					if other.exclude /= Void then
						exclude := other.exclude.twin
					end
				elseif other.exclude /= Void then
					exclude.merge (other.exclude)
				end
				if include = Void then
					if other.include /= Void then
						include := other.include.twin
					end
				elseif other.include /= Void then
					include.merge (other.include)
				end

				compile
--				exclude_regexp.merge (other.exclude_regexp)
--				include_regexp.merge (other.include_regexp)
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is it the same file_rule as `other'?
		do
			Result := equal (include, other.include) and equal (exclude, other.exclude)
		end

feature -- Basic operation

	is_included (a_path, a_sub_path: READABLE_STRING_32): BOOLEAN
			-- Test if the location made of `a_path/a_sub_path' is included according to the exclude/include rules.
			-- That means it is either not excluded or it is included.
			-- FIXME: We currently perform the match on the UTF-8 version of the string.
		require
			a_path_not_void: a_path /= Void
			a_sub_path_not_void: a_sub_path /= Void
		local
			l_exclude_regexp: like exclude_regexp
			l_include_regexp: like include_regexp
			u: UTF_CONVERTER
			l_loc: STRING_8
		do
			Result := True
			l_exclude_regexp := exclude_regexp
			if l_exclude_regexp /= Void then
					-- Our regular expressions in ECFs always contain the cluster separator /
					-- so we need to include it.
				if a_path.is_empty then
					create l_loc.make (a_sub_path.count + 1)
				else
					create l_loc.make (a_path.count + a_sub_path.count + 2)
					l_loc.append_character ('/')
					u.utf_32_string_into_utf_8_string_8 (a_path, l_loc)
				end
				l_loc.append_character ('/')
				u.utf_32_string_into_utf_8_string_8 (a_sub_path, l_loc)
				l_exclude_regexp.match (l_loc)
				if l_exclude_regexp.has_matched then
					Result := False
					l_include_regexp := include_regexp
					if l_include_regexp /= Void then
							-- it's excluded, check if there is an include that matches
						l_include_regexp.match (l_loc)
						Result := l_include_regexp.has_matched
					end
				end
			end
		end

feature {NONE} -- Implementation

	compile
			-- (Re)compile the regexp patterns.
		do
			exclude_regexp := compile_list (exclude)
			include_regexp := compile_list (include)
		end

	compile_list (a_list: like include): REGULAR_EXPRESSION
			-- Compile `a_list' into a regular expression.
		local
			l_regexp_str: STRING
			l_left_paren, l_right_paren_and_bar: STRING
			u: UTF_CONVERTER
		do
			if a_list /= Void and then not a_list.is_empty then
				debug ("fixme")
					(create {REFACTORING_HELPER}).fixme ("Support regular expressions with Unicode.")
				end
				create l_regexp_str.make (50)
				from
					l_left_paren := "("
					l_right_paren_and_bar := ")|"
					a_list.start
				until
					a_list.after
				loop
					l_regexp_str.append (l_left_paren)
						-- FIXME: We currently perform the match on the UTF-8 version of the string.
					u.utf_32_string_into_utf_8_string_8 (a_list.item_for_iteration, l_regexp_str)
					l_regexp_str.append (l_right_paren_and_bar)
					a_list.forth
				end
				l_regexp_str.remove_tail (1)

				create Result
				Result.set_caseless ({PLATFORM}.is_windows)
				Result.compile (l_regexp_str)
				check
					correct_regexp: Result.is_compiled
				end
				Result.optimize
			end
		end

feature {CONF_FILE_RULE} -- Implementation, merging

	exclude_regexp: REGULAR_EXPRESSION
			-- The compiled regexp object for all the strings.
	include_regexp: REGULAR_EXPRESSION
			-- The compiled regexp object for all the strings.

feature -- Contracts

	valid_excludes: BOOLEAN
			-- Are excludes valid?
		do
			if exclude = Void or else exclude.is_empty then
				Result := exclude_regexp = Void
			else
				Result := exclude_regexp.is_compiled
			end
		end

	valid_includes: BOOLEAN
			-- Are includes valid?
		do
			if include = Void or else include.is_empty then
				Result := include_regexp = Void
			else
				Result := include_regexp.is_compiled
			end
		end

invariant
	exclude_patterns_valid: valid_excludes
	include_patterns_valid: valid_includes

note
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
