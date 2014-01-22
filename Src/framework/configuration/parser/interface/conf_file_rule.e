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
		local
			l_exclude: like exclude
			l_include: like include
		do
			l_exclude := exclude
			l_include := include
			Result := (l_exclude = Void or else l_exclude.is_empty) and (l_include = Void or else l_include.is_empty)
		end

feature -- Access, stored in configuration file

	exclude: detachable SEARCH_TABLE [STRING_32]
			-- Exclude patterns

	include: detachable SEARCH_TABLE [STRING_32]
			-- Include patterns

	description: detachable STRING_32
			-- A description about the rules.

feature {CONF_ACCESS} -- Update, stored in configuration file

	add_exclude (a_pattern: STRING_32)
			-- Add an exclude pattern.
		require
			a_pattern_ok: valid_regexp (a_pattern)
		local
			l_exclude: like exclude
		do
			l_exclude := exclude
			if l_exclude = Void then
				create l_exclude.make (1)
				exclude := l_exclude
			end
			l_exclude.put (a_pattern)
			compile
		end

	add_include (a_pattern: STRING_32)
			-- Add an include pattern.
		require
			a_pattern_ok: valid_regexp (a_pattern)
		local
			l_include: like include
		do
			l_include := include
			if l_include = Void then
				create l_include.make (1)
				include := l_include
			end
			l_include.put (a_pattern)
			compile
		end

	del_exclude (a_pattern: STRING_32)
			-- Delete an exclude pattern.
		require
			a_pattern_ok: attached exclude as l_exclude and then l_exclude.has (a_pattern)
		do
			if attached exclude as l_exclude then
				l_exclude.remove (a_pattern)
				if l_exclude.is_empty then
					exclude := Void
				end
			else
					-- Does not occur with precondition `a_pattern_ok'
			end
			compile
		end

	del_include (a_pattern: STRING_32)
			-- Delete an include pattern.
		require
			a_pattern_ok: attached include as l_include and then l_include.has (a_pattern)
		do
			if attached include as l_include then
				l_include.remove (a_pattern)
				if l_include.is_empty then
					include := Void
				end
			else
					-- Does not occur with precondition `a_pattern_ok'
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
			if attached other as l_other then
				if attached l_other.exclude as l_other_exclude then
					if attached exclude as l_exclude then
						l_exclude.merge (l_other_exclude)
					else
						exclude := l_other_exclude.twin
					end
				end

				if attached l_other.include as l_other_include then
					if attached include as l_include then
						l_include.merge (l_other_include)
					else
						include := l_other_include.twin
					end
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

	compile_list (a_list: like include): detachable REGULAR_EXPRESSION
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

	exclude_regexp: detachable REGULAR_EXPRESSION
			-- The compiled regexp object for all the strings.

	include_regexp: detachable REGULAR_EXPRESSION
			-- The compiled regexp object for all the strings.

feature -- Contracts

	valid_excludes: BOOLEAN
			-- Are excludes valid?
		local
			l_exclude: like exclude
		do
			l_exclude := exclude
			if l_exclude = void or else l_exclude.is_empty then
				Result := exclude_regexp = Void
			elseif attached exclude_regexp as l_exclude_regexp then
				Result := l_exclude_regexp.is_compiled
			end
		end

	valid_includes: BOOLEAN
			-- Are includes valid?
		local
			l_include: like include
		do
			l_include := include
			if l_include = Void or else l_include.is_empty then
				Result := include_regexp = Void
			elseif attached include_regexp as l_include_regexp then
				Result := l_include_regexp.is_compiled
			end
		end

invariant
	exclude_patterns_valid: valid_excludes
	include_patterns_valid: valid_includes

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
