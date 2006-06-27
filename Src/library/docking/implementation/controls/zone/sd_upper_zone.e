indexing
	description: "Zone which tab at top common features."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_UPPER_ZONE

feature -- Query

	parent: EV_CONTAINER  is
			-- Parent container.
		deferred
		end

feature -- Command

	recover_normal_size_from_minimize is
			-- Recover to normal zone size from minimized state.
		local
			l_parent: EV_SPLIT_AREA
		do
			if is_minimized then
				l_parent ?= parent
				if l_parent /= Void then
					if last_spliter_position >= l_parent.minimum_split_position and last_spliter_position <= l_parent.maximum_split_position  then
						l_parent.set_split_position (last_spliter_position)
					elseif last_spliter_position < l_parent.minimum_split_position then
						l_parent.set_split_position (l_parent.minimum_split_position)
					else
						l_parent.set_split_position (l_parent.maximum_split_position)
					end
				end
				is_minimized := False
			end
		ensure
			recovered: not is_minimized
		end

	is_minimized: BOOLEAN
			-- If Current is minimized?

feature {NONE} -- Implementation

	on_pointer_pressed is
			-- If pointer pressed with in Current, we should recover to normal state.
		do

		end

	on_minimize is
			-- Handle minimize actions.
		local
			l_parent: EV_SPLIT_AREA
		do
			if is_minimized then
				recover_normal_size_from_minimize
			else
				l_parent ?= parent
				if l_parent /= Void then
					last_spliter_position := l_parent.split_position
					if l_parent.first = Current then
						l_parent.set_split_position (l_parent.minimum_split_position)
					else
						l_parent.set_split_position (l_parent.maximum_split_position)
					end
					is_minimized := True
				end
			end
		end

	last_spliter_position: INTEGER
			-- Last spliter position if `is_minimized'.

end
