
class S_RESIZE_POLICY 

inherit


creation

	make

	
feature 

	make (resize_p: RESIZE_POLICY) is
		do
			x_fixed := resize_p.x_fixed;
			y_fixed := resize_p.y_fixed;
			is_width_resizeable := resize_p.is_width_resizeable;
			is_height_resizeable := resize_p.is_height_resizeable;
			follow_x_modified := resize_p.follow_x_modified;
			follow_y_modified := resize_p.follow_y_modified;
			resize_width_modified := resize_p.resize_width_modified;
			resize_height_modified := resize_p.resize_height_modified;
		end;

	
feature {NONE}

	x_fixed: BOOLEAN; 
	y_fixed: BOOLEAN;
	is_width_resizeable: BOOLEAN;
	is_height_resizeable: BOOLEAN;
	follow_x_modified: BOOLEAN;
	follow_y_modified: BOOLEAN;
	resize_width_modified: BOOLEAN;
	resize_height_modified: BOOLEAN;

	
feature 

	resize_policy (a_context: CONTEXT) : RESIZE_POLICY is
		do
			!!Result.make;
			Result.set_context (a_context);
			if follow_x_modified then
				Result.follow_x (not x_fixed)
			end;
			if follow_y_modified then
				Result.follow_y (not y_fixed)
			end;
			if resize_width_modified then
				Result.width_resizeable (is_width_resizeable)
			end;
			if resize_height_modified then
				Result.height_resizeable (is_height_resizeable)
			end;
			Result.update
		end;

end

