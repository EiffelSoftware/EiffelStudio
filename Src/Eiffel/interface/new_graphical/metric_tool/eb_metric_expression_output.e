note
	description: "Object that represents a generated metric expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_EXPRESSION_OUTPUT

feature -- Access

	string_representation: STRING_GENERAL
			-- String representation of generated output
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Result operations

	wipe_out
			-- Wipe out all generated output.
		deferred
		end

feature{EB_METRIC_EXPRESSION_GENERATOR}

	prepare_output
			-- Prepare output.
		deferred
		end

feature -- Metric element output

	put_metric_name (a_metric_name: STRING)
			-- Display metric name `a_metric_name'.
		require
			a_metric_name_attached: a_metric_name /= Void
		deferred
		end

	put_criterion_name (a_criterion: EB_METRIC_CRITERION)
			-- Display name of criterion `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	put_target_domain_item (a_target_item: EB_METRIC_TARGET_DOMAIN_ITEM)
			-- Display `a_target_item'.
		require
			a_target_item_attached: a_target_item /= Void
		deferred
		end

	put_group_domain_item (a_group_item: EB_METRIC_GROUP_DOMAIN_ITEM)
			-- Display `a_group_item'.
		require
			a_group_item_attached: a_group_item /= Void
		deferred
		end

	put_folder_domain_item (a_folder_item: EB_METRIC_FOLDER_DOMAIN_ITEM)
			-- Display `a_folder_item'.
		require
			a_folder_item_attached: a_folder_item /= Void
		deferred
		end

	put_class_domain_item (a_class_item: EB_METRIC_CLASS_DOMAIN_ITEM)
			-- Display `a_class_item'.
		require
			a_class_item_attached: a_class_item /= Void
		deferred
		end

	put_feature_domain_item (a_feature_item: EB_METRIC_FEATURE_DOMAIN_ITEM)
			-- Display `a_feature_item'.
		require
			a_feature_item_attached: a_feature_item /= Void
		deferred
		end

	put_delayed_domain_item (a_delayed_item: EB_METRIC_DELAYED_DOMAIN_ITEM)
			-- Display `a_delayed_item'.
		require
			a_delayed_item_attached: a_delayed_item /= Void
		deferred
		end

	put_string (a_string: STRING_GENERAL)
			-- Display `a_string'.
		require
			a_string_attached: a_string /= Void
		deferred
		end

	put_operator (a_operator: STRING_GENERAL)
			-- Display `a_operator', such as "+", "-".
		require
			a_operator_attached: a_operator /= Void
		deferred
		end

	put_double (a_double: DOUBLE)
			-- Display `a_double'.
		deferred
		end

	put_integer (a_integer: INTEGER)
			-- Display `a_integer'.
		deferred
		end

	put_keyword (a_keyword: STRING_GENERAL)
			-- Display `a_keyword'.
		require
			a_keyword_attached: a_keyword /= Void
		deferred
		end

	put_error (a_error_msg: STRING_GENERAL)
			-- Display error message `a_error_msg'.
		require
			a_error_msg_attached: a_error_msg /= Void
		deferred
		end

	put_warning (a_warning_msg: STRING_GENERAL)
			-- Display warning message `a_warning_msg'.
		require
			a_warning_msg_attached: a_warning_msg /= Void
		deferred
		end

	put_normal_text (a_text: STRING_GENERAL)
			-- Display normal text `a_text'.
		require
			a_text_attached: a_text /= Void
		deferred
		end

	put_modifier (a_modifier: STRING_GENERAL)
			-- Display modifier `a_modifier'.
		require
			a_modifier_attached: a_modifier /= Void
		deferred
		end

note
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
