indexing

	description: 
		"Command to create a class in the workarea.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_MAKE_CLASS_COM

inherit

	WORKAREA_MAKE_COM
	TRANSLATION_ID

creation

	make

feature {NONE} -- Implementation

	make_entity (cluster_parent: CLUSTER_DATA; x_coord, y_coord: INTEGER) is
			-- Make class entity with parent `cluster_parent' 
			-- at coordinates `x_coord' and `y_coord'.
		local
			new_class: CLASS_DATA;
			new_class_u: ADD_CLASS_U
			name : STRING
		do
			!! new_class.make (class_name (cluster_parent), System.class_view_number);
			--name := class_name ( cluster_parent )
			--!! new_class.make ( name, from_string_to_id ( name ))
			new_class.set_id ( System.class_id_number);
			--new_class.set_id ( from_string_to_id (new_class.name) )
			new_class.set_x (x_coord);
			new_class.set_y (y_coord);
			--new_class.create_internal_file;
			!! new_class_u.make (cluster_parent, new_class, workarea);

			---- directly name the new class
			--Windows.namer_window.set_new_entity
			--Windows.namer_window.popup_at_current_position (new_class.stone)
		end;

feature -- name of Current creation

	class_name (cluster: CLUSTER_DATA): STRING is
			-- New default class name
		local
			tmp: STRING
		do
			from
			until
				Result /= Void
			loop
				!! tmp.make (7);
				tmp.append ("CLASS_");
				tmp.append_integer (system.class_view_number);
				System.increment_class_id_number;
				System.increment_class_view_number;
				if not cluster.has_class (tmp) then
					Result := tmp;
				end;
			end
		end; 

end -- class WORKAREA_MAKE_CLASS_COM
