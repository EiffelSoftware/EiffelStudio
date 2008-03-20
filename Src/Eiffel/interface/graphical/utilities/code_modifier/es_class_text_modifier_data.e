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
		ensure
			associated_class_set: associated_class = a_class
			text_set: text.is_equal (a_text)
		end

feature -- Access

	text: !STRING
			-- Modified text.

feature {NONE} -- Access

	associated_class: !CLASS_I
			-- Class associated with Current

	position_adjustments: !DS_LINKED_LIST [TUPLE [position: INTEGER; adjustment: INTEGER]]
			-- Positional adjustments for batch modifications.

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
		do
			Result := a_pos
			l_adjustments := position_adjustments
			from l_adjustments.start until l_adjustments.after or l_adjustments.item_for_iteration.position > a_pos loop
				Result := Result + l_adjustments.item_for_iteration.adjustment
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
			-- `a_count': The adjustment count to log to the position.
		require
			a_pos_positive: a_pos > 0
		local
			l_adjustments: like position_adjustments
		do
			l_adjustments := position_adjustments
			from l_adjustments.start until l_adjustments.after or else l_adjustments.item_for_iteration.position > a_pos loop
				l_adjustments.forth
			end
			if l_adjustments.after then
				l_adjustments.force_last ([a_pos, a_count])
			else
				l_adjustments.force_right ([a_pos, a_count])
			end
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
