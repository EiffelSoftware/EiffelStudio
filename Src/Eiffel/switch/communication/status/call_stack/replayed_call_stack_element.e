indexing
	description	: "Information about the replayed called stack element"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class
	REPLAYED_CALL_STACK_ELEMENT

inherit
	ANY

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create
	make_from_string

feature {NONE} -- Initialization

	make_from_string (a_id: STRING; s32: !STRING_32) is
			-- Initialize `Current'.
		local
			p,q,i: INTEGER
			m: BOOLEAN
		do
			id := a_id

			-- format:
			--|	[depth.cid.fid.line.nested.replayed_line.replayed_nested%T]  -> no sub calls
			--|	[depth.cid.fid.line.nested.replayed_line.replayed_nested%T#?+N()] -> N sub calls available
			--|	[depth.cid.fid.line.nested.replayed_line.replayed_nested%T#?+N([...][...])]
			--| check: to_string

			if s32.count > 0 then
				if s32.item (1) = '[' and s32.item (s32.count) = ']' then
					p := s32.index_of ('%T', 1)
					check tab_found: p > 0 end
					if p = 0 then --| should not occurs .. but
						p := s32.index_of (']', 1)
					end
					check p_positive: p > 0 end

					extract_properties (s32.substring (2, p - 1))
					rt_information_available := True

					from
					until
						s32.item (p) = ']'
					loop
						p := p + 1
						inspect s32.item (p)
						when '#' then
							-- is flat
							is_flat := True
						when '?' then
							-- is in the main eiffel call stack
							rt_information_available := False
						when '+' then
							q := s32.index_of ('(', p+1)
							calls_count := s32.substring (p+1, q-1).to_integer_32
							p := q + 1
							if p < (s32.count - 2) then
								create calls.make (1, calls_count)
								from
									i := 1
								until
									p >= (s32.count - 2)
								loop
									if s32.item (p) = '!' then
										m := True
										p := p + 1
									else
										m := False
									end
									check valid_left_limit: s32.item (p) = '[' end
									q := index_of_right_limit_position (s32, p + 1)
									if q /= 0 then
										check not_empty_substring: p < q  end
										check valid_index: i <= calls_count end
										calls[i] := create {like Current}.make_from_string (id + "." + i.out , s32.substring (p, q))
										calls[i].set_active_replayed (m)
										i := i + 1
										p := q + 1
									else
										p := s32.count - 2
									end
								end
							end
						else
						end
					end
				end
			end
		end

	index_of_right_limit_position (s32: !STRING_32; i: INTEGER): INTEGER is
			-- Index of next right limit position  i.e index of associated ']'
		local
			p: INTEGER
			n: INTEGER
		do
			from
				p := i
				n := 1
			until
				n = 0  or p > s32.count
			loop
				inspect s32.item (p)
				when '[' then
					n := n + 1
				when ']' then
					n := n - 1
				else
				end
				p := p + 1
			end
			if n = 0 then
				Result := p - 1
			end
		end

	extract_properties (s32: !STRING_32) is
			-- Extract stack properties
		require
			s32_not_empty: not s32.is_empty
		local
			dynamic_class_type_id: INTEGER -- dynamic class type id
			class_type_id: INTEGER -- class type id
			feature_body_id: INTEGER -- Real body id or body index
			ct: CLASS_TYPE
			cl: CLASS_C
			fi: FEATURE_I
			ft: FEATURE_TABLE
			lst: LIST [STRING_32]
		do
			lst := s32.split ('.')
			check lst.count = 6 or lst.count = 8 end
			lst.start
			depth := lst.item.to_integer_32
			lst.forth
			dynamic_class_type_id := lst.item.to_integer_32 + 1 --| Convert rt id to compiler id
			lst.forth
			class_type_id := lst.item.to_integer_32 + 1 --| Convert rt id to compiler id
			lst.forth
			feature_body_id := lst.item.to_integer_32 + 1 --| Convert rt id to compiler id
			lst.forth
			break_index := lst.item.to_integer_32
			lst.forth
			break_nested_index := lst.item.to_integer_32
			if not lst.after then
				lst.forth
				replayed_break_index := lst.item.to_integer_32
				lst.forth
				replayed_break_nested_index := lst.item.to_integer_32
			end

			ct := eiffel_system.system.class_type_of_id (dynamic_class_type_id)
			if ct /= Void then
				dynamic_class_type := ct
			end
			if class_type_id = dynamic_class_type_id then
				class_type := dynamic_class_type
			else
				ct := eiffel_system.system.class_type_of_id (class_type_id)
			end
			if ct /= Void then
				cl := ct.associated_class
				if cl /= Void then
					ft := cl.feature_table
					from
						ft.start
					until
						ft.after or fi /= Void
					loop
						fi := ft.item_for_iteration
						if not fi.valid_body_id or else fi.real_body_id (ct) /= feature_body_id then
							fi := Void
						end
						ft.forth
					end
				end
			end

			class_type := ct
			feature_i := fi
		end

feature -- Properties

	id: STRING
			-- Identifier

	remote_id: STRING is
			-- Remote id
		do
			create Result.make_empty
			Result.append_integer (depth)
			Result.append_character ('.')
			if {dct: CLASS_TYPE} dynamic_class_type then
				Result.append_integer (dct.type_id)
			else
				Result.append_character ('?')
			end
			Result.append_character ('.')
			if {wct: CLASS_TYPE} class_type then
				Result.append_integer (wct.type_id)
			else
				Result.append_character ('?')
			end
			Result.append_character ('.')
			if {fi: FEATURE_I} feature_i then
				if fi.valid_body_id then
					Result.append_integer (fi.real_body_id (class_type))
				else
					Result.append_integer (fi.body_index)
				end
			else
				Result.append_character ('?')
			end
			Result.append_character ('.')
			Result.append_integer (break_index)
			Result.append_character ('.')
			Result.append_integer (break_nested_index)
		end

	dynamic_class_type: CLASS_TYPE
			-- associated dymamic class type

	class_type: CLASS_TYPE
			-- associated written class type

	feature_i: FEATURE_I
			-- associated feature

	e_feature: E_FEATURE is
			-- API feature
		do
			if feature_i /= Void and dynamic_class /= Void then
				Result := feature_i.api_feature (dynamic_class.class_id)
			end
		end

	depth: INTEGER
			-- Depth in call stack

	break_index: INTEGER
			-- Breakable slot index

	break_nested_index: INTEGER
			-- Breakable slot nested index

	replayed_break_index: INTEGER
			-- Replayed breakable slot index		

	replayed_break_nested_index: INTEGER
			-- Replayed breakable slot nested index	

	calls: ARRAY [like Current] assign set_calls
			-- Calls from Current

	calls_count: INTEGER
			-- Calls' count

	is_active_replayed: BOOLEAN assign set_active_replayed
			-- Is Current the active replayed call ?

	is_flat: BOOLEAN
			-- Is flat record ?
			-- i.e: flatten for optimization

	rt_information_available: BOOLEAN
			-- Is Runtime information available for this call ?
			--| i.e: is this call in the main call stack			

feature -- Call stack element access

	class_name: STRING is
		do
			if {dc: CLASS_C} dynamic_class then
				Result := dc.name_in_upper
			end
		end

	routine_name: STRING is
		do
			Result := feature_i.feature_name
		end

	dynamic_class: CLASS_C is
		do
			if {ct: CLASS_TYPE} dynamic_class_type then
				Result := ct.associated_class
			end
		end

	written_class: CLASS_C is
		do
			if {ct: CLASS_TYPE} class_type then
				Result := ct.associated_class
			end
		end

	is_melted: BOOLEAN is
		do
			Result := False
		end

	has_rescue: BOOLEAN is
		do
			Result := feature_i /= Void and then feature_i.has_rescue_clause
		end

feature -- change

	set_calls (v: like calls) is
			-- Set `calls' to `v'
		require
			valid_cound: v /= Void and then v.count = calls_count
		do
			calls := v
		end

	set_active_replayed (b: BOOLEAN) is
			-- Set `is_active_replayed'
		do
			is_active_replayed := b
		end

feature -- Access

	to_string: !STRING is
		local
			fi: FEATURE_I
		do
			fi := feature_i

			create Result.make_from_string (id)
			Result.append_string (" -> ")
			if is_active_replayed then
				Result.append_character ('!')
			end
			Result.append_character ('[')
			Result.append_string (remote_id)
			Result.append_character ('.')
			Result.append_integer (replayed_break_index)
			Result.append_character ('.')
			Result.append_integer (replayed_break_nested_index)
			Result.append_character ('%T')
			if is_flat then
				Result.append_character ('#')
			end
			if not rt_information_available then
				Result.append_character ('?')
			end
			if calls_count > 0 then
				Result.append_character ('+')
				Result.append_integer (calls_count)
				Result.append_character ('(')
				Result.append_character (')')
			end
			Result.append_character (']')
		end

;indexing
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
