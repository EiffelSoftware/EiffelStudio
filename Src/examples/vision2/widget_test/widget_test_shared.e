indexing
	description: "Objects that provide access to common data for system."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIDGET_TEST_SHARED
	
inherit
	INTERNAL

feature -- Access
		
	test_widget: EV_WIDGET is
			-- `Result' is current widget for testing.
		do
			Result := test_widget_holder.widget
		end
		
	test_widget_type: STRING is
			-- `Result' is type of `test_widget'.
		do
			Result := class_name (test_widget)
		end

feature -- Basic operation

	set_test_widget_type (a_type: STRING) is
			-- Assign a new widget of type `a_type' to
			-- `test_widget'.
		require
			a_type_not_void_or_empty: a_type /= Void and not a_type.is_empty
		local
			new_widget: EV_WIDGET
			temp: BOOLEAN
		do
			new_widget ?= new_instance_of (dynamic_type_from_string (a_type))
			temp := feature {ISE_RUNTIME}.check_assert (False)
			new_widget.default_create
			temp := feature {ISE_RUNTIME}.check_assert (temp)
			test_widget_holder.set_widget (new_widget)
			widget_type_changed
		ensure
			test_widget_not_void: test_widget /= Void
		end
		
	register_type_change_agent (an_agent: PROCEDURE [ANY, TUPLE [EV_WIDGET]]) is
			-- Insert `an_agent' into `widget_type_changed_agents'.
		require
			agent_not_void: an_agent /= Void
		do
			widget_type_changed_agents.extend (an_agent)
		ensure
			agent_added: widget_type_changed_agents.count = old widget_type_changed_agents.count + 1
		end

feature {NONE} -- Implementation

	test_widget_holder: TEST_WIDGET_HOLDER is
			-- Provides once access to to current widget being
			-- tested.
		once
			Create Result
		end

	widget_type_changed is
			-- Call all agents in `widget_type_changed_agents'.
		do
			from
				widget_type_changed_agents.start
			until
				widget_type_changed_agents.off
			loop
				widget_type_changed_agents.item.call ([test_widget])
				widget_type_changed_agents.forth
			end
		end
		
	widget_type_changed_agents: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_WIDGET]]] is
			-- A list of agents to be executed when the type of the current
			-- test widget changes. A client may use `register_type_change_agent'
			-- to an associate an event with this list.
		once
			create Result.make (4)
		end

end -- class WIDGET_TEST_SHARED
