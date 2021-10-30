note
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CONF_SYSTEM_VIEW_SCORER

inherit
	ES_SEARCH_SCORER [CONF_SYSTEM_VIEW]

feature -- Conversion

	scored_list (a_query: READABLE_STRING_GENERAL; a_libs: LIST [CONF_SYSTEM_VIEW]; a_keep_all: BOOLEAN): LIST [SCORED_VALUE [CONF_SYSTEM_VIEW]]
		local
			l_filter_engine: detachable KMP_WILD
			f: STRING_32
			cfg: CONF_SYSTEM_VIEW
		do
			if a_libs.is_empty then
				create {ARRAYED_LIST [SCORED_VALUE [CONF_SYSTEM_VIEW]]} Result.make (0)
			elseif
				attached scores_factory.criteria_from_string (a_query) as l_score
			then
					-- Using SCORE Criteria
				Result := l_score.scores (a_libs, a_libs.count)
			else
				create {ARRAYED_LIST [SCORED_VALUE [CONF_SYSTEM_VIEW]]} Result.make (a_libs.count)
					-- Using simple wildchar comparison.
				create f.make_from_string_general (a_query)
				f.adjust
				if f.item (1) /= '*' then
					f.prepend_character ('*')
				end
				if f.item (f.count) /= '*' then
					f.append_character ('*')
				end
				create l_filter_engine.make_empty
				l_filter_engine.set_pattern (f)
				l_filter_engine.disable_case_sensitive
				across
					a_libs as l
				loop
					cfg := l
					l_filter_engine.set_text (cfg.library_target_name)
					if l_filter_engine.pattern_matches then
						Result.force (create {SCORED_VALUE [CONF_SYSTEM_VIEW]}.make (cfg, 1.0))
					elseif a_keep_all then
						Result.force (create {SCORED_VALUE [CONF_SYSTEM_VIEW]}.make (cfg, 0.0))
					end
				end
			end
		end

	filtered_list (a_query: READABLE_STRING_GENERAL; a_libs: LIST [CONF_SYSTEM_VIEW]): LIST [CONF_SYSTEM_VIEW]
		local
			l_filter_engine: detachable KMP_WILD
			l_scores: LIST [SCORED_VALUE [CONF_SYSTEM_VIEW]]
			f: STRING_32
			cfg: CONF_SYSTEM_VIEW
		do
			Result := a_libs
			create {ARRAYED_LIST [CONF_SYSTEM_VIEW]} Result.make (a_libs.count)
			if not a_libs.is_empty then
				if attached scores_factory.criteria_from_string (a_query) as l_score then
					l_scores := l_score.scores (a_libs, a_libs.count)
					across
						l_scores as ic
					loop
						Result.force (ic.value)
					end
				else
					create f.make_from_string_general (a_query)
					f.adjust
					if f.item (1) /= '*' then
						f.prepend_character ('*')
					end
					if f.item (f.count) /= '*' then
						f.append_character ('*')
					end
					create l_filter_engine.make_empty
					l_filter_engine.set_pattern (f)
					l_filter_engine.disable_case_sensitive
					across
						a_libs as l
					loop
						cfg := l
						l_filter_engine.set_text (cfg.library_target_name)
						if l_filter_engine.pattern_matches then
							Result.force (cfg)
						end
					end
				end
			end
		end

	filtered_table (a_query: READABLE_STRING_GENERAL; a_libs: STRING_TABLE [CONF_SYSTEM_VIEW]): STRING_TABLE [CONF_SYSTEM_VIEW]
		local
			l_filter_engine: detachable KMP_WILD
			l_scores: LIST [SCORED_VALUE [CONF_SYSTEM_VIEW]]
			f: STRING_32
			cfg: CONF_SYSTEM_VIEW
			k: detachable READABLE_STRING_GENERAL
		do
			create Result.make (a_libs.count)
			if not a_libs.is_empty then
				if attached scores_factory.criteria_from_string (a_query) as l_score then
					l_scores := l_score.scores (a_libs, a_libs.count)
					across
						l_scores as ic
					loop
						k := Void
						cfg := ic.value
						across
							a_libs as libs_ic
						until
							k /= Void
						loop
							if libs_ic = cfg then
								k := @ libs_ic.key
							end
						end
						if k /= Void then
							Result.put (cfg, k)
						else
							check has_associated_key: False end
						end
					end
				else
					create f.make_from_string_general (a_query)
					f.adjust
					if f.item (1) /= '*' then
						f.prepend_character ('*')
					end
					if f.item (f.count) /= '*' then
						f.append_character ('*')
					end
					create l_filter_engine.make_empty
					l_filter_engine.set_pattern (f)
					l_filter_engine.disable_case_sensitive
					across
						a_libs as l
					loop
						cfg := l
						l_filter_engine.set_text (cfg.library_target_name)
						if l_filter_engine.pattern_matches then
							Result.put (cfg, @ l.key)
						end
					end
				end
			end
		end

	name_weight: REAL = 0.3
	title_weight: REAL = 0.25
	description_weight: REAL = 0.20
	tag_weight: REAL = 0.25
	any_weight: REAL
		do
			Result := name_weight + title_weight + tag_weight + tag_weight
		end

	scores_factory: SCORER_CRITERIA_FACTORY [CONF_SYSTEM_VIEW]
		once
			create Result.make
			Result.register_builder ("name", agent (n, v: READABLE_STRING_32): detachable SCORER_CRITERIA [CONF_SYSTEM_VIEW]
						do
							create {SCORER_CRITERIA_AGENT [CONF_SYSTEM_VIEW]} Result.make (n + ":" + v, name_weight, agent score_name (?, v))
						end
				)
			Result.register_builder ("title", agent (n, v: READABLE_STRING_32): detachable SCORER_CRITERIA [CONF_SYSTEM_VIEW]
						do
							create {SCORER_CRITERIA_AGENT [CONF_SYSTEM_VIEW]} Result.make (n + ":" + v, title_weight, agent score_title (?, v))
						end
				)
			Result.register_builder ("description", agent (n, v: READABLE_STRING_32): detachable SCORER_CRITERIA [CONF_SYSTEM_VIEW]
						do
							create {SCORER_CRITERIA_AGENT [CONF_SYSTEM_VIEW]} Result.make (n + ":" + v, description_weight, agent score_description (?, v))
						end
				)
			Result.register_builder ("tag", agent (n, v: READABLE_STRING_32): detachable SCORER_CRITERIA [CONF_SYSTEM_VIEW]
						do
							create {SCORER_CRITERIA_AGENT [CONF_SYSTEM_VIEW]} Result.make (n + ":" + v, tag_weight, agent score_tag (?, v))
						end
				)
			Result.register_builder ("any", agent (n, v: READABLE_STRING_32): detachable SCORER_CRITERIA [CONF_SYSTEM_VIEW]
						do
							create {SCORER_CRITERIA_AGENT [CONF_SYSTEM_VIEW]} Result.make (n + ":" + v, any_weight, agent score_any (?, v))
						end
				)
			Result.register_default_builder ("any")
		end

	meet_any (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := meet_name (obj, s)
				or meet_title (obj, s)
				or meet_tag (obj, s)
		end

	meet_name (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := meet_text (obj.system_name, s)
		end

	meet_title (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := meet_text (obj.title, s) or meet_text (obj.info ("title"), s)
		end

	meet_description (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := meet_text (obj.description, s) or meet_text (obj.info ("description"), s)
		end

	meet_tag (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := meet_text (obj.info ("tags"), s)
		end

	meet_text (a_text: detachable READABLE_STRING_GENERAL; s: READABLE_STRING_GENERAL): BOOLEAN
		local
			kmp: KMP_WILD
			tok: READABLE_STRING_GENERAL
			tok_len: INTEGER
			l_lower_text: READABLE_STRING_GENERAL
			c: CHARACTER_32
			i: INTEGER
		do
			if a_text /= Void then
				if s.has ('*') or s.has ('?') then
					create kmp.make (s, a_text)
					kmp.disable_case_sensitive
					Result := kmp.pattern_matches
				else
					from
						l_lower_text := a_text.as_lower
						tok := s.as_lower
						tok_len := tok.count
						i := 1
					until
						i = 0 or Result
					loop
						i := l_lower_text.substring_index (tok, i)
						if i > 0 then
							Result := True
							if i > 1 then
									-- Check lower boundary
								c := l_lower_text [i - 1]
								if c.is_alpha_numeric then
									Result := False
								end
							end
							if Result and i + tok_len <= l_lower_text.count then
									-- Check lower boundary
								c := l_lower_text [i + tok_len]
								if c.is_alpha_numeric then
									Result := False
								end
							end
							if not Result then
								i := i + 1
							end
						end
					end
				end
			end
		end

	score_any (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): REAL
		do
			Result := score_name (obj, s) * name_weight
				+ score_title (obj, s) * title_weight
				+ score_tag (obj, s) * tag_weight
				+ score_description (obj, s) * description_weight
		end

	score_name (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): REAL
		do
			Result := if meet_name (obj, s) then 1.0 else 0.0 end
		end

	score_title (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): REAL
		do
			Result := if meet_title (obj, s) then 1.0 else 0.0 end
		end

	score_description (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): REAL
		do
			Result := if meet_description (obj, s) then 1.0 else 0.0 end
		end

	score_tag (obj: CONF_SYSTEM_VIEW; s: READABLE_STRING_GENERAL): REAL
		do
			Result := if meet_tag (obj, s) then 1.0 else 0.0 end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
