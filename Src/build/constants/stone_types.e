 
-- Transportable entity
 
class STONE_TYPES
 
feature
 
	any_type: INTEGER is unique;
	attribute_type: INTEGER is unique;
	behavior_type: INTEGER is unique;
	color_type: INTEGER is unique;
	command_type: INTEGER is unique;
	context_type: INTEGER is unique;
	event_type: INTEGER is unique;
	label_type: INTEGER is unique;
	instance_type: INTEGER is unique;
	new_state_type: INTEGER is unique;
	state_type: INTEGER is unique;
	transition_type: INTEGER is unique;
	type_stone_type: INTEGER is unique;
 
end
