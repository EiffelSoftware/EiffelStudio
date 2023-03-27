note
	description: "[
		Objects which are recording IL code info at compilation time
		the concerned information are :
			- class token
			- feature token
			- module filename
			- entry_point token
			- once `_done' and `_result' token
			- line debug info
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$author$"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_DEBUG_INFO_RECORDER

inherit
	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
		do

		end

feature {CIL_CODE_GENERATOR} -- Token recording

	record_il_feature_info (a_module: IL_MODULE; a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_class_token, a_feature_token: INTEGER)
			-- Record feature information : class, feature token, and module name throught the other data.
		do
			to_implement ("TODO add implement")
		end

feature {CIL_CODE_GENERATOR} -- line debug recording

	ignore_next_debug_info
			-- Ignore recording of debug info (nop) for next recording
		do
			ignoring_next_debug_info := True
		ensure
			ignoring_next_debug_info
		end

	ignoring_next_debug_info: BOOLEAN
			-- Do we ignore recording of debug info (nop) for next recording ?

	record_ghost_debug_infos (a_class_type: CLASS_TYPE; a_feat: FEATURE_I;
								a_il_line: INTEGER; a_eiffel_line: INTEGER;
								a_nb: INTEGER)
			-- Record potential IL offset stoppable without any IL generation
			-- this is used for non generated debug clauses
			-- for enabling estudio to show correct eiffel line.
		do
			to_implement ("TODO add implement")
		end

	record_once_info_for_class (a_data_class_token,
					a_once_done_token, a_once_result_token, a_once_exception_token: INTEGER;
					a_feature: FEATURE_I; a_class_c: CLASS_C)
			--  Record `_done' `_result' and `_exception' tokens for once `a_once_name' from `a_class_type'.
		do
			to_implement ("TODO add implement")
		end

	record_line_info (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_il_line: INTEGER; a_eiffel_line: INTEGER;)
			-- Record IL information regarding breakable line
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		do
			to_implement ("TODO add implement")
		end

feature {CIL_CODE_GENERATOR} -- Recording context

	set_record_context (a_is_single_class, a_is_attr, a_is_static, a_in_interface: BOOLEAN)
			-- Save generation context in order to determine what to record.
		do
			to_implement ("TODO add implement")
		end

feature {CIL_CODE_GENERATOR} -- Cleaning

	clean_class_type_info_for (a_class_type: CLASS_TYPE)
			-- Clean info related to this `a_class_type'.
		require
			class_type_not_void: a_class_type /= Void
		do
			to_implement ("TODO add implement")
		end

feature {CIL_CODE_GENERATOR} -- Access

	is_recording: BOOLEAN
			-- Are we inside a recording session ?

	start_recording_session (debug_mode: BOOLEAN)
			-- Start recording session.
		do
			is_recording := True
			to_implement ("TODO add implement")
		ensure
			is_inside_recording_session: is_recording
		end

	end_recording_session
			-- End recording session
		require
			is_inside_recording_session: is_recording
		do
			is_recording := False
			to_implement ("TODO add implement")
		ensure
			is_outside_recording: not is_recording
		end

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

end -- class IL_DEBUG_INFO_RECORDER
