indexing

	description: 
		"Graphical representation for inheritance relationship.";
	date: "$Date$";
	revision: "$Revision $"

class GRAPH_INHERIT 

inherit

	GRAPH_RELATION
		rename
			from_form as heir,
			to_form as parent
		redefine
			data, link_body, link_head,
			draw_in
		end
	
creation

	make
	
feature {NONE} -- Initialization

	make (a_inherit: INHERIT_DATA; a_workarea: WORKAREA) is
			-- Create GRAPH_INHERIT object with `a_inherit' as link.
		do
			workarea := a_workarea;
			data := a_inherit;
			if data.color_name = Void then
				if resources.link_color/= Void then
					data.set_color_name (resources.link_color.name)
				else
					data.set_color_name (resources.inh_link_color.name)
				end
				data.set_color_name (resources.inh_link_color.name)
			end
			heir := a_workarea.find_linkable (data.heir);
			parent := a_workarea.find_linkable (data.parent);
			if heir /= Void and then parent /= Void then
				a_workarea.inherit_list.add_form (Current);
				!! link_body.make;
				make_relation (a_workarea);
				update_clip_area;
			end;
		end;

feature -- Graphical properties

	link_body: EC_SINGLE_LINE;
			-- Link body figure

	link_head: EC_TRIANGLE_HEAD
			-- Head of link figure

	--link_head_uml : EC_TRIANGLE_HEAD
			-- Head of link figure in the uml format

	data: INHERIT_DATA;
			-- Data associated with Current graphical entity

	heir: GRAPH_LINKABLE;
			-- Heir linkable

	parent: GRAPH_LINKABLE
			-- Parent linkable

feature -- Output

	draw_in (clip_closure: EC_CLOSURE) is
			-- Draw the graphical representation in the analysis window
			-- if in clear area `clip'.
		do
		--	if (System.show_all_relations or else
		--			not data.is_implementation) and then
		--			clip_closure.intersects (closure)
		--	then
		--		debug ("DRAWING");
		--			io.error.putstring (data.focus);
		--			io.error.new_line;
		--		end;

				draw
		--	end;
		end

feature -- Removal

	destroy_without_clip_update is
			-- Destroy 'Current' from 'workarea'
		do
			workarea.inherit_list.remove_form (Current)
		end

feature {NONE} -- implementation

	make_link_head is
			-- Create the link head figure.
		do
			!!link_head.make (to_point, 1)
				-- 1 is to specify that it is an inheritance link
		end

end -- class GRAPH_INHERIT
