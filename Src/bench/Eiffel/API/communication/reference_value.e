class REFERENCE_VALUE

inherit

	DEBUG_VALUE;
	SHARED_WORKBENCH

creation
	make

feature

	append_value (cw: CLICK_WINDOW) is 
		local
			os: OBJECT_STONE;
			class_c: CLASS_C;
			void_pointer: POINTER
        do 
--			class_c := System.class_types.item (dynamic_type + 1).associated_class;
--			class_c.append_clickable_name (cw);
			if (reference = void_pointer) then
				cw.put_string (" Void")
			else
				cw.put_string (" [");
				!! os.make (reference.out);
				cw.put_clickable_string (os, reference.out);
				cw.put_string ("]");
			end
        end;

	reference: POINTER;

	dynamic_type: INTEGER;

	make (ref: like reference; type: like dynamic_type) is
		do
			reference := ref;
			dynamic_type := type;
		end

end

