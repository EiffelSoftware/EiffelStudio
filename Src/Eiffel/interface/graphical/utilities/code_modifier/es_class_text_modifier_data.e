indexing
	description: "[
		Data used in conjuntion with an Eiffel code class text modifier {ES_CLASS_TEXT_MODIFIER}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CLASS_TEXT_MODIFIER_DATA

inherit --{NONE}
	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_INST_CONTEXT
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: !like associated_class; a_text: !like text)
			-- Initializes the data required to perform class modifications.
			--
			-- `a_class': The associated class to perform modifications on.
			-- `a_text': Actual class text to modify.
		do
			associated_class := a_class
			text ?= a_text.twin
			create position_adjustments.make_default
			original_count := text.count
		ensure
			associated_class_set: associated_class = a_class
			text_set: text.is_equal (a_text)
			original_count_set: original_count = text.count
		end

feature -- Access

	text: !STRING_32 assign set_text
			-- Modified text.

	original_count: INTEGER
			-- Original count of `text'.

feature {NONE} -- Access

	associated_class: !CLASS_I
			-- Class associated with Current

	position_adjustments: !DS_ARRAYED_LIST [TUPLE [position: INTEGER; adjustment: INTEGER]]
			-- Positional adjustments for batch modifications.

feature {ES_CLASS_TEXT_MODIFIER} -- Element change

	set_text (a_text: !like text)
			-- Sets new modifier text.
			-- Note: Please use only when commiting changes for synchronization purposes
		do
			text := a_text
			original_count := text.count
		ensure
			text_set: text.is_equal (a_text)
			original_count_set: original_count = text.count
		end

feature -- Status report

	is_prepared: BOOLEAN
			-- Indicates if Current has been prepared to make modifications. If not, call `prepare'

feature {ES_CLASS_TEXT_MODIFIER} -- Query

	adjusted_position (a_pos: INTEGER): INTEGER
			-- Retrieve an adjusted position from an original position.
			--
			-- `a_pos': The orginal position to retrieve an adjustment for.
			-- `Result': The adjusted position.
		require
			a_pos_positive: a_pos > 0
		local
			l_adjustments: like position_adjustments
			p, v: INTEGER
			l_adjusted_count: INTEGER
		do
			Result := a_pos
			l_adjustments := position_adjustments
			l_adjusted_count := original_count
			from
				l_adjustments.start
			until
				l_adjustments.after
			loop
				P := l_adjustments.item_for_iteration.position
				v := l_adjustments.item_for_iteration.adjustment
				if Result >= p then
					Result := p.max (Result + v)
				end
				l_adjusted_count := l_adjusted_count + v
				Result := Result.max (1).min (l_adjusted_count)
				l_adjustments.forth
			end
		ensure
			result_non_negative: Result >= 0
		end

feature -- Basic operations

	prepare
			-- Prepares Current
		require
			not_is_prepared: not is_prepared
		do
			reset
			is_prepared := True
		ensure
			is_prepared: is_prepared
		end

feature {ES_CLASS_TEXT_MODIFIER} -- Basic operations

	reset
			-- Resets prepared data.
		do
			position_adjustments.wipe_out
			is_prepared := False
		ensure
			position_adjustments_is_empty: position_adjustments.is_empty
			not_is_prepared: not is_prepared
		end

	adjust_position (a_pos: INTEGER; a_count: INTEGER)
			-- Adjusts a position logging an adjustment count.
			--
			-- `a_pos': Original position to adjust.
			-- `a_count': The adjustment count to log to the position. Less than zero, if chars were removed.
		local
			l_adjustments: like position_adjustments
			l_pos: INTEGER
			p, v: INTEGER
			l_adjusted_count: INTEGER
		do
			l_adjustments := position_adjustments
			l_adjusted_count := original_count
			l_pos := a_pos.max (1).min (l_adjusted_count + 1)
				-- Calculate adjusted position.
			from
				l_adjustments.start
			until
				l_adjustments.after
			loop
				P := l_adjustments.item_for_iteration.position
				v := l_adjustments.item_for_iteration.adjustment
				if l_pos >= p then
					l_pos := p.max (l_pos + v)
				end
				l_adjusted_count := l_adjusted_count + v
				l_pos := l_pos.max (1).min (l_adjusted_count + 1)
				l_adjustments.forth
			end
				-- We save adjusted position `l_pos'.
			position_adjustments.put_last ([l_pos, a_count])
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
