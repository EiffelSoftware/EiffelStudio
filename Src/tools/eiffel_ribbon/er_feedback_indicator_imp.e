note
	description: "[
		ER_FEEDBACK_INDICATOR implementatin
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_FEEDBACK_INDICATOR_IMP

inherit
	SD_FEEDBACK_INDICATOR_IMP
		redefine
			on_timer,
			timer_interval
		end

create
	make

feature {NONE} -- Implementation

	timer_interval: INTEGER
			-- <Precursor>
		once
			Result := 100
		end

	alpha_step_new: INTEGER
			-- Alpha step value used in this class

	on_timer
			-- <Precursor>
		do
			if counter > 3 then
				alpha_step_new := 255
			elseif (counter // 2) = 0 then
				alpha_step_new := (255 - alpha - 1)
			else
				alpha_step_new := 1 - alpha
			end
			counter := counter + 1

			on_timer_imp
		end

	counter: INTEGER
			-- Couter for `on_timer'

	on_timer_imp
			-- Implementaion for `on_timer'
		local
			l_timer: like timer
		do
			l_timer := timer
			check l_timer /= Void end	-- Implied by precondition `set'
			alpha := alpha + alpha_step_new
			if not (alpha <= 255) then
				alpha := 255
			end
			if exists then
				update_layered_window_rgba (alpha)
			else
				l_timer.destroy
			end
			if alpha >= 255 then
				l_timer.destroy
			end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
