note
	description: "[
					Container looks like a spliter area which have a gap between childs, but it can't be dragged by end users.
					It's be used when a zone is minimized.
																																]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HORIZONTAL_BOX

inherit
	SD_MIDDLE_CONTAINER
		rename
			count as count_except_spliter,
			full as full_docking
		undefine
			is_equal,
			is_in_default_state
		redefine
			initialize,
			implementation,
			may_contain,
			set_splitter_visible
		select
			count_except_spliter,
			full_docking
		end

	EV_HORIZONTAL_BOX
		rename
			first as first_vision2
		export
			{SD_HORIZONTAL_BOX} cl_extend
		redefine
			initialize,
			implementation,
			extend,
			may_contain,
			last,
			is_in_default_state
		end

create
	make

feature {NONE} -- Initlization

	make
			-- Creation method
		do
			create fake_spliter
			default_create
		end

feature {NONE} -- Query

	count_except_spliter: INTEGER
			-- Count except `fake_spliter'
		do
			Result := count
			if has (fake_spliter) then
				Result := Result - 1
			end
		end

	full_docking: BOOLEAN
			--	<Precursor>
		do
			Result := count > 0 and then (first /= Void and second /= Void)
		end

	initialize
			-- <Precursor>
		do
			Precursor {EV_HORIZONTAL_BOX}
			fake_spliter.set_minimum_width (spliter_width)
			extend (fake_spliter)
			disable_item_expand (fake_spliter)
		end

	fake_spliter: EV_CELL
			-- Fake spiter which can't be dragged

	extend (a_widget: EV_WIDGET)
			-- <Precursor>
		local
			l_index: INTEGER
		do
			if a_widget = fake_spliter then
				Precursor {EV_HORIZONTAL_BOX}(a_widget)
			else
				-- For postconditions
				l_index := index
				if first = Void then
					go_i_th (1)
					put_left (a_widget)
					second_was_void := True
				else
					check only_one: count = 2 end
					go_i_th (2)
					put_right (a_widget)
					second_was_void := False
				end
				go_i_th (l_index)
			end
		end

	first: detachable EV_WIDGET
			-- <Precursor>
		do
			if count > 0 and then i_th (1) /= Void then
				if i_th (1) /= fake_spliter then
					Result := i_th (1)
				end
			end
		end

	second_was_void: BOOLEAN
			-- If second is void?

	is_in_default_state: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	last: EV_WIDGET
			-- <Precursor>
		do
			if count /= 1 then
				if second_was_void then
					Result := first
				else
					Result := second
				end
			end
			if not attached Result then
				Result := fake_spliter
			end
		end

	spliter_width: INTEGER = 4
			-- Fake spliter width

feature -- Access

	second: detachable EV_WIDGET
			-- <Precursor>	
		do
			if first = Void then
				Result := i_th (2)
			elseif count = 3 then
				Result := i_th (3)
			end
		end

	minimum_split_position: INTEGER
			-- <Precursor>
		do
		end

	maximum_split_position: INTEGER
			-- <Precursor>
			-- This value is useful when executing SD_MULTI_DOCK_AREA.restore_spliter_position.
		do
			Result := {INTEGER}.max_value
		end

	split_position: INTEGER
			-- <Precursor>

feature -- Contract support

	may_contain (v: EV_WIDGET): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {EV_HORIZONTAL_BOX} (v) and then count <= 3
		end

feature -- Setting

	set_split_position (a_pos: INTEGER)
			-- <Precursor>
		do
			split_position := a_pos
		ensure then
			set: split_position = a_pos
		end

	set_splitter_visible (a_visible: BOOLEAN)
			-- <Precursor>
		do
			if fake_spliter /= Void then
				if a_visible then
					fake_spliter.show
				else
					fake_spliter.hide
				end
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_HORIZONTAL_BOX_I
			-- Responsible for interaction with native graphics toolkit

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
