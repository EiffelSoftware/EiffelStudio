note
	description: "Controller of like types: the goal is to detect cycles in anchored types."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LIKE_CONTROLER

create
	make

feature {NONE} -- Initialize	

	make
			-- Prepare for recording anchors.
		do
			create features.make (10)
			create arguments.make (10)
		end

feature -- Status report

	has_argument (a_position: INTEGER): BOOLEAN
			-- Does current have an anchor on `a_position'?
		do
			Result := arguments.has (a_position)
		end

	has_feature (f: FEATURE_I): BOOLEAN
			-- Does current have an anchor involving `f'?
		require
			f_attached: attached f
		do
			Result := features.has (f.feature_id + ({INTEGER_64} 0 + f.written_in) |<< 32)
		end

feature -- Element change

	put_feature (f: FEATURE_I)
			-- Insert an anchor based on `f'.
		do
			features.extend (f.feature_id + ({INTEGER_64} 0 + f.written_in) |<< 32)
		ensure
			has_feature: has_feature (f)
		end

	put_argument (a_position: INTEGER)
			-- Insert an anchor based on `a_position'.
		do
			arguments.extend (a_position)
		ensure
			has_argument: has_argument (a_position)
		end

feature -- Removal

	remove_feature
			-- Remove last recorded feature.
		do
			features.remove
		end

	remove_argument
			-- Remove last recorded argument.
		do
			arguments.remove
		end

	reset
			-- Remove any previously recorded anchors.
		do
			features.wipe_out
			arguments.wipe_out
		end

feature {NONE} -- implementation

	arguments: ARRAYED_STACK [INTEGER]
			-- Used arguments

	features: ARRAYED_STACK [INTEGER_64]
			-- Used features

invariant
	arguments_not_void: arguments /= Void
	routine_ids_not_void: features /= Void

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
