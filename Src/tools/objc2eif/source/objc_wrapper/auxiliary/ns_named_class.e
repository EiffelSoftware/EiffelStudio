note
	description: "A class that declares features to name Objective-C wrapped classes."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_NAMED_CLASS

inherit
	NS_ANY

feature {NONE} -- Implementation

	is_subclass_instance: BOOLEAN
			-- Return `True' if this class is a subclass of a Cocoa class.
		do
			Result := not (objc_class_name_to_eiffel_style(wrapper_objc_class_name) ~ generator)
		end

	get_class_name: STRING
			-- The Objective-C class name to use for `Current'.
		do
			if is_subclass_instance then
				Result := objc_subclass_name
			else
				Result := wrapper_objc_class_name
			end
		end

	objc_subclass_name: STRING
			-- The class name used for subclasses of the generated wrapper classes.
		do
			Result := generator
		end

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		deferred
		end

end
