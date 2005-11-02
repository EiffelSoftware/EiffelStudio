indexing
	description: "Objects that store config datas about inner container."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_INNER_CONTAINER_DATA

feature -- Properties
	title: STRING is
			-- Content title.
		do
			Result := internal_title
		end
	
	set_title (a_title: STRING) is
			-- 
		require
			a_title_not_void: a_title /= Void
		do
			internal_title := a_title
		end
		
	state: STRING is
			-- 
		do
			Result := internal_state
		end
	
	set_state (a_class_name: STRING) is
			-- 
		do
			internal_state := a_class_name
		end
		
	split_position: INTEGER is
			-- Parent split area position.
		do
			Result := internal_split_position
		end
	
	set_split_position (a_value: INTEGER) is
			-- 
		do
			internal_split_position := a_value
		end
		
	children_left: SD_INNER_CONTAINER_DATA is
			-- 
		do
			Result := internal_children_left	
		end
	
	set_children_left (a_data: like internal_children_left) is
			-- 
		do
			internal_children_left := a_data
		end
		
	children_right: SD_INNER_CONTAINER_DATA is
			-- 
		do
			Result := internal_children_right
		end
		
	set_children_right (a_data: like internal_children_right) is
			-- 
		do
			internal_children_right := a_data
		end		
	
	parent: like Current is
			-- 
		do
			Result := internal_parent
		end
	
	set_parent (a_parent: like Current) is
			-- 
		require
			a_parent_not_void: a_parent /= Void
		do
			internal_parent := a_parent
		end
		
		
	is_split_area: BOOLEAN is
			-- If it is a EV_SPLIT_AREA? Otherwise it's a SD_ZONE.
		do
			Result := internal_is_split_area
		end
	
	set_is_split_area (a_value: BOOLEAN) is
			-- Set if `Current' is a split area.
		do
			internal_is_split_area := a_value
		end
		
	is_horizontal_split_area: BOOLEAN is
			-- 
		do
			Result := internal_spliter_horizontal
		end
	
	set_is_horizontal_split_area (a_value: BOOLEAN) is
			-- 
		do
			internal_spliter_horizontal := a_value
		end
		
		
feature {NONE} -- Implementation
	internal_is_split_area: BOOLEAN
			-- If Current data is a split area.
	internal_spliter_horizontal: BOOLEAN
			-- iF Current is a spliter, if Current is EV_HORIZONTAL_SPLIT_AREA ?
			
	internal_split_position: INTEGER
			-- If current is a split area, this is the spliter position. -1 if current spliter not full.
--	
	internal_children_left, internal_children_right: SD_INNER_CONTAINER_DATA
			-- 
	internal_title: STRING
	
	internal_state: STRING
			-- The state class name.
	
	internal_parent: like Current
			-- `Current' data's parent data.
end
