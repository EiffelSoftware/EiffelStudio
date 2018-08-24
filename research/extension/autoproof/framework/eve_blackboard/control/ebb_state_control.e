note
	description: "Summary description for {EBB_STATE_CONTROL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_STATE_CONTROL

inherit

	EBB_CONTROL

create
	make

feature -- Access

	name: STRING = "State control"
			-- <Precursor>

feature -- Basic operations

	think
			-- <Precursor>
		do
			update_class_states
		end

	create_new_tool_executions
			-- <Precursor>
		do
			launch_tools
		end

feature {NONE} -- Implementation

	update_class_states
		local
			l_classes: LIST [EBB_CLASS_DATA]
			l_class: EBB_CLASS_DATA
		do
			from
				l_classes := blackboard.data.classes
				l_classes.start
			until
				l_classes.after
			loop
				l_class := l_classes.item
				inspect l_class.work_state
				when {EBB_STATE}.compilation then
					if l_class.associated_class.is_compiled then
						l_class.set_work_state ({EBB_STATE}.analysis)
					end
				when {EBB_STATE}.analysis then
					l_class.set_work_state ({EBB_STATE}.static_verification)
				when {EBB_STATE}.static_verification then
				when {EBB_STATE}.dynamic_verification then
				else
					check False end
				end
				l_classes.forth
			end
		end

	launch_tools
		local
			l_classes: LIST [EBB_CLASS_DATA]
			l_class: EBB_CLASS_DATA
		do
			from
				l_classes := blackboard.data.classes
				l_classes.start
			until
				l_classes.after
			loop
				l_class := l_classes.item
				inspect l_class.work_state
				when {EBB_STATE}.compilation then
					-- Nothing to do.
				when {EBB_STATE}.analysis then
					launch_tool (l_class, {EBB_TOOL_CATEGORY}.analysis)
				when {EBB_STATE}.static_verification then
					launch_tool (l_class, {EBB_TOOL_CATEGORY}.static_verification)
				when {EBB_STATE}.dynamic_verification then
					launch_tool (l_class, {EBB_TOOL_CATEGORY}.dynamic_verification)
				when {EBB_STATE}.contract_inference then
					launch_tool (l_class, {EBB_TOOL_CATEGORY}.contract_inference)
				when {EBB_STATE}.body_inference then
					launch_tool (l_class, {EBB_TOOL_CATEGORY}.code_inference)
				else
					check l_class.work_state = {EBB_STATE}.done end
				end
				l_classes.forth
			end
		end

	launch_tool (a_class: EBB_CLASS_DATA; a_category: INTEGER)
		local
			l_state: EBB_STATE
			l_tools: LIST [EBB_TOOL]
		do
			from
				l_tools := blackboard.tools
				l_tools.start
			until
				l_tools.after
			loop
				if l_tools.item.category = a_category then

				end
				l_tools.forth
			end

			create l_state
			io.put_string ("Start tool of category " + l_state.name_of_state (a_category) + " on " + a_class.class_name + "%N")
		end

end
