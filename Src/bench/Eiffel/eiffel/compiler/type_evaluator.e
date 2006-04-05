indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Type evaluator

deferred class
	TYPE_EVALUATOR

inherit
	SHARED_ERROR_HANDLER

	SHARED_RESCUE_STATUS

	COMPILER_EXPORTER

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

feature

	evaluated_type (type: TYPE_A; feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Evaluation of type `type' in the context of the feature
			-- table `feat_table' and the feature `f'
		require
			non_void_type: type /= Void
			non_void_feat_table: feat_table /= Void
			non_void_feature: f /= Void
		do
			type_a_checker.init_with_feature_table (f, feat_table, Void, error_handler)
			Result := type_a_checker.check_and_solved (type, Void)
		end

	new_error: VTAT1 is
			-- New error message
		deferred
		ensure
			Result /= Void
		end

	update (error_msg: VTAT1) is
			-- Update error message
		deferred
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

end
