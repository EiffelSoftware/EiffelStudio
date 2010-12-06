note
	description	: "[
					Describes a breakpoint's location. It is by its `body_index' 
				  	and its `breakable_line_number' (line number in stop points view).
				  ]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "$Author$"
	date		: "$Date$"
	revision	: "$Revision$"

frozen class
	BREAKPOINT_LOCATION

inherit
	BREAKPOINT_KEY_I
		redefine
			is_equal
		end

	E_FEATURE_COMPARER
		redefine
			is_equal
		end

	DEBUG_OUTPUT
		redefine
			is_equal
		end

	SHARED_WORKBENCH
		redefine
			is_equal
		end

create {BREAKPOINTS_MANAGER}
	make

create {BREAKPOINT, BREAKPOINT_LOCATION}
	make_copy_for_saving

feature {NONE} -- Creation

	make (a_feature: E_FEATURE; a_breakable_index: INTEGER)
			-- Create a breakpoint in the feature `a_feature'
			-- at the line `a_breakable_index'.
		require
			valid_location: 	a_feature /= Void and then
								a_breakable_index > 0 and then
								a_feature.body_index /= 0
		do
			application_status := Application_breakpoint_not_set
			if not is_corrupted then
				breakable_line_number := a_breakable_index
				routine := a_feature
				body_index := routine.body_index
			end
		rescue
			is_corrupted := True
			retry
		end

	make_copy_for_saving (a_bp_loc: like Current)
		do
			application_status := a_bp_loc.application_status
			body_index := a_bp_loc.body_index
			breakable_line_number := a_bp_loc.breakable_line_number
			if attached a_bp_loc.routine as r then
				routine_written_in := r.written_in
			end
		ensure
			routine_ids_valid: routine_from_ids ~ a_bp_loc.routine
		end

feature {BREAK_LIST, BREAKPOINT} -- Copy for saving

	copy_for_saving: like Current
			-- Create Current as a copy of `bp'
		do
			create Result.make_copy_for_saving (Current)
		end

	restore
			-- Restore Current when loaded from storage.
		do
			set_application_not_set
			routine := routine_from_ids
			if routine = Void then
				is_corrupted := True
			end
		end

	routine_from_ids: detachable E_FEATURE
			-- Routine computed from saved ids
		do
			if attached system.class_of_id (routine_written_in) as cl then
				Result := cl.feature_with_body_index (body_index)
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' equal to `Current'?
			-- `other' equals to `Current' if they represent
			-- the same physical breakpoint, in other words they
			-- have the same `body_index' and `offset'.
			-- We use 'body_index' because it does not change after
			-- a recompilation
		do
			Result := (other.breakable_line_number = breakable_line_number) and (other.body_index = body_index)
		end

	is_lesser_than (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		local
			acl,ocl: CLASS_C
		do
			if routine /= Void then
				acl := routine.associated_class
			end
			if other.routine /= Void then
				ocl := other.routine.associated_class
			end
			if acl = Void and ocl = Void then
				Result := True
			elseif acl = Void then
				Result := True
			else --| none are Void
				if acl.name_in_upper.is_equal (ocl.name_in_upper) then
					--| routine not Void neither
					if routine.is_equal (other.routine) then
						Result := breakable_line_number < other.breakable_line_number
					else
						Result := routine.name_32 < other.routine.name_32
					end
				else
					Result := acl.name_in_upper < ocl.name_in_upper
				end
			end
		end

feature -- Properties

	routine: E_FEATURE
			-- Feature where this breakpoint is situated.
		note
			option: transient
		attribute
		end

	breakable_line_number: INTEGER
			-- Line number of the breakpoint in the stoppoint view under EiffelStudio.

	body_index: INTEGER
			-- `body_index' of the feature where this breakpoint is situated

	is_corrupted: BOOLEAN
			-- False unless there was a problem at initialization (no feature).

	application_status: INTEGER
			-- Last status sent to the application, this is the current
			-- status of this breakpoint location from the application point of view
			--
			-- See the private constants at the end of the class to see the
			-- different possible values taken.			

feature {NONE} -- Storage

	routine_written_in: INTEGER
			-- Class id where this breakpoint is situated

feature -- Access

	is_valid: BOOLEAN
			-- Is using `Current' safe?
		local
			l_feat: E_FEATURE
			cl: CLASS_C
			first_rout_id: INTEGER
		do
			if
				not is_corrupted and
				attached routine as r and then
				r.is_valid
			then
				cl := r.associated_class
				if cl /= Void and then r.is_debuggable then
					first_rout_id := r.rout_id_set.first
					if r.is_inline_agent then
						if attached cl.eiffel_class_c.inline_agent_of_rout_id (first_rout_id) as l_feat_i then
							l_feat := l_feat_i.api_feature (r.written_in)
						end
					else
						l_feat := cl.feature_with_rout_id (first_rout_id)
					end
					Result := l_feat /= Void and then same_feature (routine, l_feat)
				end
			end
		end

	is_set_for_application: BOOLEAN
			-- Is the breakpoint location set for the application?
		do
			Result := application_status = Application_breakpoint_set
		end

feature -- Query

	real_body_ids_list: LIST [INTEGER]
			-- List of real body ids related to Current location
			-- i.e: `routine'
		local
			lcurs: CURSOR
		do
			if
				attached routine as l_routine and then
				attached l_routine.associated_class as l_associated_class and then
				attached l_routine.associated_feature_i as fi and then
				attached l_routine.written_class as l_wc and then
				attached l_wc.types as l_class_type_list
			then
				create {ARRAYED_LIST [INTEGER]} Result.make (l_class_type_list.count)
				lcurs := l_class_type_list.cursor
				from
					l_class_type_list.start
				until
					l_class_type_list.after
				loop
					Result.extend (fi.real_body_id (l_class_type_list.item))
					l_class_type_list.forth
				end
				if l_class_type_list.valid_cursor (lcurs) then
					l_class_type_list.go_to (lcurs)
				end
			end
		end

feature {BREAKPOINTS_MANAGER, BREAKPOINT_KEY} -- Change

	set_is_corrupted (b: like is_corrupted)
			-- Set `is_corrupted' to `b'
		do
			is_corrupted := b
		end

	update_routine_version
			-- Set `routine' to the updated_version of `routine'
		do
			if attached routine as r then
				routine := r.updated_version
			end
			is_corrupted := is_corrupted or routine = Void
		end

feature -- Change status

	set_application_set
			-- Tell that this breakpoint has been added in the application.
		do
			application_status := Application_breakpoint_set
		ensure
			location_is_set_for_application: application_status = Application_breakpoint_set
		end

	set_application_not_set
			-- Tell that this breakpoint has been removed in the application.
		do
			application_status := Application_breakpoint_not_set
		ensure
			location_is_not_set_for_application: application_status = Application_breakpoint_not_set
		end

feature -- String representation

	to_string: STRING_32
			-- String representation of Current location.
		local
			lcl: CLASS_C
		do
			create Result.make_empty
			Result.append_character ('{')
			if routine /= Void then
				lcl := routine.associated_class
			end
			if lcl /= Void then
				Result.append_string (lcl.name_in_upper)
			else
				Result.append_string ("???")
			end
			Result.append_string ("}.")
			if routine /= Void then
				Result.append_string (routine.name_32)
			else
				Result.append_string ("???")
			end
			Result.append_string (" [" + breakable_line_number.out + "] ")
		ensure
			Result_not_void: Result /= Void
		end

feature -- debug output

	debug_output: STRING
			-- Debug output.
		do
			Result := to_string
			if is_set_for_application then
				Result.append_string (" <set for application> ")
			end
		end

feature {NONE} -- Private constants		

	Application_breakpoint_set: INTEGER 	= 0
	Application_breakpoint_not_set: INTEGER = 1

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
