indexing
	description: "Constants for EiffelStudio."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRAPHICAL_DATA

inherit
	SHARED_RESOURCES

feature {NONE} -- Resources

	class_color: EV_COLOR is
		do
			Result := secure_color_resource_value ("class_color", 0, 0, 255)
		end

	cluster_color: EV_COLOR is
		do
			Result := secure_color_resource_value ("cluster_color", 128, 0, 0)
		end

	error_color: EV_COLOR is
		do
			Result := secure_color_resource_value ("error_color", 255, 0, 0)
		end

	feature_color: EV_COLOR is
		do
			Result := secure_color_resource_value ("feature_color", 0, 128, 0)
		end

	object_color: EV_COLOR is
		do
			Result := secure_color_resource_value ("object_color", 0, 0, 255)
		end

	progress_bar_color: EV_COLOR is
		do
			Result := secure_color_resource_value ("progress_bar_color", 0, 0, 128)
		end
	
end -- class EB_GRAPHICAL_DATA
