indexing
	description:
		"Stone based on feature name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	FEATURE_NAME_STONE

inherit
	FEATURE_STONE
		rename
			make as old_make
		redefine
			update, feature_name, stone_signature, synchronized_stone
		end

create
	make

feature {NONE} -- Initialization

	make (f_name: STRING; ec: CLASS_C) is
		require
			valid_f_name: f_name /= Void
			ec_attached: ec /= Void
		do
			feature_class := ec
			e_class := ec
			feature_name := f_name
			if ec.has_feature_table then
				e_feature := ec.feature_with_name (f_name)
				if e_feature /= Void then
					e_class := e_feature.written_class
				end
			end
			internal_start_position := -1
			internal_end_position := -1
			internal_start_line_number := -1
		ensure
			feature_name_set: feature_name = f_name
			feature_class_set: feature_class = ec
		end

feature -- Properties

	feature_name: STRING
			-- Feature name

	feature_class: CLASS_C
			-- Class with feature `feature_name'

	stone_signature: STRING is
			-- Signature of Current feature
		do
			Result := feature_name.twin
		end

feature -- Update

	update is
			-- Update current feature stone.
		local
			retried: BOOLEAN
		do
			if not retried then
				if internal_start_position = -1 or else e_feature = Void then
						-- Means check has been done and is invalid
						-- Find e_feature from feature_name.
					if feature_class.has_feature_table then
							-- System has been completely compiled and has all its
							-- feature tables.
						e_feature := feature_class.feature_with_name (feature_name)
						if e_feature /= Void then
							e_class := e_feature.written_class
							Precursor {FEATURE_STONE}
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Dragging

	synchronized_stone: CLASSI_STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		local
			new_e_feature: like e_feature
			classc_stone: CLASSC_STONE
		do
			if e_class /= Void then
				create classc_stone.make (feature_class)
				Result := classc_stone.synchronized_stone
				classc_stone ?= Result
				if classc_stone /= Void then
						-- Class is still valid
						-- Check feature
					new_e_feature := e_feature.updated_version
					if new_e_feature /= Void then
						create {FEATURE_NAME_STONE} Result.make (feature_name, classc_stone.e_class)
					end
				end
			end
		end

indexing
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

end -- class FEATURE_NAME_STONE
