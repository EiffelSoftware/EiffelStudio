note
	description: "Array preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date:"
	revision: "$Revision$"

class
	ARRAY_PREFERENCE

inherit
	ABSTRACT_ARRAY_PREFERENCE [STRING]
		redefine
			valid_value_string
		end

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature -- Access

	string_type: STRING
			-- String description of this preference type.
		once
			Result := "LIST"
		end

feature -- Status Setting

	set_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Parse the string value `a_value' and set `value'.
		local
			cnt: INTEGER
			s: STRING_32
			values: LIST [STRING_32]
			l_value: like value
		do
			create internal_value.make_empty
			values := splitted_strings (a_value.to_string_32)
			if not values.is_empty and then (values.count > 1 or else not values.first.is_empty) then
				from
					l_value := value
					check has_value: l_value /= Void end -- implied by `internal_value /= Void'
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
						-- Per precondition, `s' should be valid as a STRING_8.
					l_value.force (unescaped_string (s).to_string_8, cnt)
					values.forth
					cnt := cnt + 1
				end
			end
			set_value (internal_value)
		end

feature -- Status Report

	valid_value_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' valid?
		do
			Result := a_string.is_valid_as_string_8
		end

feature {NONE} -- Implementation

	auto_default_value: ARRAY [STRING]
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			create Result.make_filled ("", 0, 1)
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class ARRAY_PREFERENCE
