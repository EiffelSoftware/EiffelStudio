note
	description	: "Array preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date:"
	revision	: "$Revision$"

class
	ARRAY_PREFERENCE

inherit
	TYPED_PREFERENCE [ARRAY [STRING]]

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature -- Access

	string_value: STRING
			-- String representation of `value'.				
		local
			index: INTEGER
			l_value: STRING
			l_array: like value
		do
			create Result.make_empty
			from
				l_array := value
				check l_array /= Void end -- implied by precondition `has_value'

				index := l_array.lower
			until
				index > l_array.upper
			loop
				l_value := l_array.item (index)
				if is_choice and then index = selected_index then
					Result.append ("[" + l_value + "]")
				else
					Result.append (l_value)
				end
				if not (index = l_array.count) then
					Result.append (";")
				end
				index := index + 1
			end
		end

	string_type: STRING
			-- String description of this preference type.
		once
			Result := "LIST"
		end

	selected_value: detachable STRING
			-- Value of the selected index.
		do
			if
				(attached value as l_value) and then
				l_value.valid_index (selected_index)
			then
				Result := l_value.item (selected_index)
			end
		end

	selected_index: INTEGER
			-- Selected index from list.

feature -- Status Setting

	set_is_choice (a_flag: BOOLEAN)
			-- Set `is_choice' to`a_flag'.
		do
			is_choice := a_flag
			if selected_index = 0 then
				selected_index := 1
			end
		end

	set_selected_index (a_index: INTEGER)
			-- Set `selected_index'
		require
			index_valie: a_index > 0
			is_choice: is_choice
		do
			selected_index := a_index
		ensure
			index_set: selected_index = a_index
		end

	set_value_from_string (a_value: STRING)
			-- Parse the string value `a_value' and set `value'.
		local
			cnt: INTEGER
			s: STRING
			values: LIST [STRING]
			l_value: like value
		do
			create internal_value.make_empty
			values := a_value.split (';')
			if values.count > 1 or not values.first.is_empty then
				from
					l_value := value
					check l_value /= Void end -- implied by `internal_value /= Void'
					values.start
					cnt := 1
				until
					values.after
				loop
					s := values.item
					if not s.is_empty and then s.item (1) = '[' and then s.item (s.count) = ']' then
						s := s.substring (2, s.count - 1)
						is_choice := True
						set_selected_index (cnt)
					end
					l_value.force (s, cnt)
					values.forth
					cnt := cnt + 1
				end
			end
			set_value (internal_value)
		end

feature -- Query

	is_choice: BOOLEAN
			-- Is this preference a single choice or the full list?

	valid_value_string (a_string: STRING): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?		
		do
			Result := True
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		do
			if is_choice then
				Result := "COMBO"
			else
				Result := "TEXT"
			end
		end

feature {NONE} -- Implementation

	auto_default_value: ARRAY [STRING]
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			create Result.make_filled ("", 0, 1)
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class ARRAY_PREFERENCE
