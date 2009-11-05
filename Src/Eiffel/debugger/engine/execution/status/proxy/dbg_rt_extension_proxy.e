note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	DBG_RT_EXTENSION_PROXY

inherit
	DBG_RT_PROXY

create
	make

feature {NONE} -- Initialization

	make (a_value: ABSTRACT_REFERENCE_VALUE; a_app: APPLICATION_EXECUTION) is
			-- Initialize `Current'.
		require
			a_value_attached: a_value /= Void
			a_app_attached: a_app /= Void
		do
			value := a_value
			dynamic_class := a_value.dynamic_class
			set_associated_application (a_app)
		end

feature -- Access

	value: ABSTRACT_REFERENCE_VALUE
			-- Handle on the remote {RT_EXTENSION} object

	dynamic_class: CLASS_C
			-- Dynamic class

feature -- Remote Invocation: Record and Replay

	execution_recorder: detachable DBG_RT_EXECUTION_RECORDER_PROXY
			-- Proxy for `RT_EXTENSION.execution_recorder: RT_DBG_EXECUTION_RECORDER'
		do
			if attached query_evaluation_on ("execution_recorder", Void) as dv then
				create Result.make (dv, associated_application)
			end
		end

	activate_execution_replay_recording (b: BOOLEAN; ref: detachable DUMP_VALUE; cid: INTEGER; fid: INTEGER; dep: INTEGER; break_index: INTEGER): BOOLEAN
			-- Invoke `activate_execution_replay_recording' on remote object
		local
			params: ARRAYED_LIST [DUMP_VALUE]
			dv_fact: DUMP_VALUE_FACTORY
			i32cl: CLASS_C
		do
			dv_fact := dump_value_factory
			i32cl := compiler_data.integer_32_class_c

			create params.make (6) -- 	(b: BOOLEAN; ref: ANY; cid: INTEGER; fid: INTEGER; dep: INTEGER; break_index: INTEGER)
			params.extend (dv_fact.new_boolean_value (b, compiler_data.boolean_class_c))
			if ref = Void then
				params.extend (dv_fact.new_void_value (compiler_data.any_class_c))
			else
				params.extend (ref)
			end
			params.extend (dv_fact.new_integer_32_value (cid, i32cl)) -- cid
			params.extend (dv_fact.new_integer_32_value (fid, i32cl)) -- fid
			params.extend (dv_fact.new_integer_32_value (dep, i32cl)) -- dep
			params.extend (dv_fact.new_integer_32_value (break_index, i32cl)) -- break_index

			Result := command_evaluation_on ("activate_execution_replay_recording", params)
		end

feature -- Remote Invocation: Debuggee evaluation

	tilda_equal_evaluation_feature_name: STRING = "tilda_equal_evaluation"
	is_equal_evaluation_feature_name: STRING = "is_equal_evaluation"
	equal_sign_evaluation_feature_name: STRING = "equal_sign_evaluation"
	debugger_type_string_evaluation_feature_name: STRING = "debugger_type_string"

	tilda_equal_evaluation (a_value, a_other_value: DUMP_VALUE; error_handler: detachable DBG_ERROR_HANDLER): BOOLEAN
		require
			a_value_attached: a_value /= Void
			a_other_value_attached: a_other_value /= Void
		do
			Result := two_args_resulting_boolean_evaluation (tilda_equal_evaluation_feature_name, a_value, a_other_value, error_handler)
		end

	is_equal_evaluation (a_value, a_other_value: DUMP_VALUE; error_handler: detachable DBG_ERROR_HANDLER): BOOLEAN
		require
			a_value_attached: a_value /= Void
			a_other_value_attached: a_other_value /= Void
		do
			Result := two_args_resulting_boolean_evaluation (is_equal_evaluation_feature_name, a_value, a_other_value, error_handler)
		end

	equal_sign_evaluation (a_value, a_other_value: DUMP_VALUE; error_handler: detachable DBG_ERROR_HANDLER): BOOLEAN
		require
			a_value_attached: a_value /= Void
			a_other_value_attached: a_other_value /= Void
		do
			Result := two_args_resulting_boolean_evaluation (equal_sign_evaluation_feature_name, a_value, a_other_value, error_handler)
		end

	debugger_type_string_evaluation (a_value: DUMP_VALUE; error_handler: detachable DBG_ERROR_HANDLER): detachable STRING
			-- Get the `generating_type' as STRING by evaluation on the debuggee
		require
			a_value_is_not_void: a_value /= Void and then not a_value.is_void
		do
			Result := one_arg_resulting_string_evaluation (debugger_type_string_evaluation_feature_name, a_value, 0,0, error_handler)
		end

feature -- Remote Invocation: Object Storage

	store_object (a_add: DBG_ADDRESS; fn: STRING): BOOLEAN
			-- Store in file `fn' on the application the object addressed by `oa'
			-- Return True is succeed.
		local
			params: ARRAYED_LIST [DUMP_VALUE]
			dv_fact: DUMP_VALUE_FACTORY
		do
			dv_fact := dump_value_factory
			create params.make (2)
			params.extend (dv_fact.new_object_value (a_add, Void)) -- ref
			params.extend (dv_fact.new_manifest_string_value (fn, compiler_data.string_8_class_c)) -- fn

			Result := query_evaluation_on ("saved_object_to", params) /= Void
		end

	loaded_object (a_addr: detachable DBG_ADDRESS; fn: STRING): detachable DUMP_VALUE
		local
			params: ARRAYED_LIST [DUMP_VALUE]
			dv_fact: DUMP_VALUE_FACTORY
		do
			dv_fact := dump_value_factory

			create params.make (2)
			if a_addr = Void then
				params.extend (dv_fact.new_void_value (compiler_data.any_class_c))
			else
				params.extend (dv_fact.new_object_value (a_addr, Void))
			end
			params.extend (dv_fact.new_manifest_string_value (fn, compiler_data.string_8_class_c))

			Result := query_evaluation_on ("object_loaded_from", params)
		end

feature {NONE} -- Implementation: helper

	one_arg_resulting_string_evaluation (a_featname: STRING; a_value: DUMP_VALUE; min,max: INTEGER; a_error_handler: detachable DBG_ERROR_HANDLER): detachable STRING
		require
			a_value_attached: a_value /= Void
		local
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			create params.make (1)
			params.extend (a_value)
			if
				attached query_evaluation_on (a_featname, params) as dv and then
				dv.has_formatted_output
			then
				if min >= max then
					Result := dv.string_representation
				else
					Result := dv.truncated_string_representation (min, max)
				end
			else
				if a_error_handler /= Void then
					a_error_handler.notify_error_evaluation_report_to_support (Void)
				end
			end
		end

	two_args_resulting_boolean_evaluation (a_featname: STRING; a_value, a_other_value: DUMP_VALUE; a_error_handler: detachable DBG_ERROR_HANDLER): BOOLEAN
		require
			a_value_attached: a_value /= Void
			a_other_value_attached: a_other_value /= Void
		local
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			create params.make (2)
			params.extend (a_value)
			params.extend (a_other_value)
			if
				attached query_evaluation_on (a_featname, params) as dv and then
				dv.is_valid_value and then
				dv.is_type_boolean
			then
				Result := dv.as_dump_value_basic.value_boolean
			else
				if a_error_handler /= Void then
					a_error_handler.notify_error_evaluation_report_to_support (Void)
				end
			end
		end

feature {NONE} -- Implementation

	query_evaluation_on (fname: STRING_8; params: LIST [DUMP_VALUE]): detachable DUMP_VALUE
			-- method `{cl}.fname' evaluation on `edv'
			-- using `params' as argument if any
		do
			Result := associated_application.query_evaluation_on (value, Void, dynamic_class, fname, params)
		end

	command_evaluation_on (fname: STRING_8; params: LIST [DUMP_VALUE]): BOOLEAN
			-- Evaluation's result for `a_expr' in current context
			-- (note: Result = Void implies an error occurred)		
		do
			Result := associated_application.command_evaluation_on (value, Void, dynamic_class, fname, params)
		end

invariant
	value_attached: value /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
