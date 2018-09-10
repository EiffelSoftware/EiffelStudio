note
	description: "Helper class to connect the compiler with the blackboard."
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_BLACKBOARD_COMPILER_HELPER

feature -- Basic operations

	handle_changed_feature (a_feature: FEATURE_I)
			-- Handle that feature `a_feature' changed.
			--
			-- Added to {CLASS_C}.insert_changed_feature
		do
			if attached blackboard as l_blackboard and then l_blackboard.is_running then
				l_blackboard.handle_changed_feature (a_feature)
			end
		end

	handle_removed_feature (a_feature: FEATURE_I)
			-- Handle that feature `a_feature' was removed.
			--
			-- Added to {FEATURE_TABLE}.fill_pass2_control
		do
			if attached blackboard as l_blackboard and then l_blackboard.is_running then
				l_blackboard.handle_removed_feature (a_feature)
			end
		end

	handle_changed_invariant (a_class: CLASS_C)
			-- Handle that invariant of class `a_class' changed.
			--
			-- Added to {INHERIT_TABLE}.pass2
		do
			if attached blackboard as l_blackboard and then l_blackboard.is_running then
				l_blackboard.handle_changed_invariant (a_class.original_class)
			end
		end

	handle_added_class (a_class: CLASS_I)
			-- Handle that class `a_class' was added.
		do
			if attached blackboard as l_blackboard and then l_blackboard.is_running then
				l_blackboard.handle_added_class (a_class)
			end
		end

	handle_removed_class (a_class: CLASS_I)
			-- Handle that class `a_class' was removed.
		do
			if attached blackboard as l_blackboard and then l_blackboard.is_running then
				l_blackboard.handle_removed_class (a_class)
			end
		end

feature {NONE} -- Implementation

	blackboard: EBB_BLACKBOARD
			-- Shared blackboard.
		local
			l_service_consumer: SERVICE_CONSUMER [BLACKBOARD_S]
		do
			create l_service_consumer
			if l_service_consumer.is_service_available and then l_service_consumer.service.is_interface_usable then
				Result ?= l_service_consumer.service
			end
		end

end
