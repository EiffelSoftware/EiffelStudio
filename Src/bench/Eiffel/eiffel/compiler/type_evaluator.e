indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Type evaluator

deferred class
	TYPE_EVALUATOR 

inherit
	SHARED_LIKE_CONTROLER

	SHARED_ERROR_HANDLER

	SHARED_RESCUE_STATUS

	COMPILER_EXPORTER
	
feature 

	evaluated_type (type: TYPE_AS; feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Evaluation of type `type' in the context of the feature
			-- table `feat_table' and the feature `f'
		require
			non_void_type: type /= Void
			non_void_feat_table: feat_table /= Void
			non_void_feature: f /= Void
		local
			error_msg: like new_error
		do
				-- Wipe out the like controler
			Like_control.turn_off
			Result := type.solved_type (feat_table, f)
		rescue
			if Rescue_status.is_like_exception then
					-- Cycle in anchored type or unvalid anchor: the
					-- exception is raise in routine `solved_type' of
					-- classes LIKE_ID_AS, LIKE_FEATURE and LIKE_ARGUMENT
				Rescue_status.set_is_like_exception (False)
				error_msg := new_error
				error_msg.set_class (feat_table.associated_class)
				error_msg.set_type (type)
				error_msg.set_feature (f)
				update (error_msg)
				Error_handler.insert_error (error_msg)
					-- Exception propagation now: cannot go on...
				Rescue_status.set_is_error_exception (True)
			end
		end

	evaluated_type_for_format
		(type: TYPE_AS; feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Evaluation of type `type' in the context of the feature
			-- table `feat_table' and the feature `f'
		require
			type /= Void
			feat_table /= Void
			f /= Void
		do
			if Rescue_status.is_like_exception or else 
				Rescue_status.is_error_exception
			then
				Error_handler.wipe_out
				Rescue_status.set_is_like_exception (False)
			else
					-- Wipe out the like controler
				Like_control.turn_off
				Result := type.solved_type_for_format (feat_table, f)
			end
		rescue
			if Rescue_status.is_like_exception or else 
				Rescue_status.is_error_exception
			then
					-- Cycle in anchored type or unvalid anchor: the
					-- exception is raise in routine `solved_type' of
					-- classes LIKE_ID_AS, LIKE_FEATURE and LIKE_ARGUMENT
				retry
			end
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
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
