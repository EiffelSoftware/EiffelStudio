indexing

	description: "Abstract view information for a relation.";
	date: "$Date$";
	revision: "$Revision $"

class RELATION_VIEW

inherit

	VIEW;
	ONCES

creation

	make

feature {NONE} -- Initialization

	make (relation_data: RELATION_DATA) is
			-- Initialize Current with `relation_data'.
		local
			bp: LINKED_LIST [HANDLE_DATA];
			handle_data: HANDLE_DATA;
			sh_handle_view: SHARED_HANDLE_VIEW;
			real_handle_view: REAL_HANDLE_VIEW;
		do
			is_system_defined := relation_data.is_system_defined;
			color_name := relation_data.color_name;
			bp := relation_data.break_points;
			view_id := relation_data.view_id;
			is_in_compressed_link := relation_data.is_in_compressed_link;
			if not bp.empty then
				!! break_points.make_filled (bp.count);		
				from
					bp.start;
					break_points.start
				until
					bp.after
				loop
					handle_data := bp.item;
					if handle_data.is_shared then		
						!! sh_handle_view.make 
							(view_information.shared_handle_identifier 
								(handle_data));
						break_points.replace (sh_handle_view);
					else
						!! real_handle_view.make (bp.item);
						break_points.replace (real_handle_view);
					end
					bp.forth;
					break_points.forth
				end
			end
		end;

feature -- Properties

	color_name: STRING;
			-- Color of Current 

	view_id: INTEGER;
			-- Relation view based on target linkable view_id

	break_points: FIXED_LIST [HANDLE_VIEW]
			-- List of break points

	is_in_compressed_link: BOOLEAN;
			-- Is Current in a compressed link?

	is_system_defined: BOOLEAN;
			-- Is Current a system defined link? (for iconisation)

	is_valid: BOOLEAN is
			-- Is current view valid?
		do
			Result := View_information.linkable_of_view_id (view_id) /= Void
		end;	

feature {LINKABLE_VIEW} -- Setting

	update_data (relation_data: RELATION_DATA) is
			-- Update `relation_data' from Current.
		local
			bp: LINKED_LIST [HANDLE_DATA];
			handle_data: HANDLE_DATA
		do	
			if color_name= Void or else color_name.is_equal("default") then
				relation_data.set_color_name (relation_data.default_color.name)
			else
				relation_data.set_color_name ( color_name )
			end
			relation_data.set_is_in_compressed_link (is_in_compressed_link);
			relation_data.set_is_system_defined (is_system_defined);
			if break_points /= Void then
				bp := relation_data.break_points;
				from
					break_points.start
				until
					break_points.after
				loop
					handle_data := break_points.item.data;
					if handle_data.is_in_system then
							-- Handle is valid
						handle_data.set_shared (handle_data.shared + 1);
						bp.finish;
						bp.put_right (handle_data);
					end;
					break_points.forth
				end
			end
		end;

end -- class RELATION_VIEW
