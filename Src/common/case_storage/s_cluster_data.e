
class S_CLUSTER_DATA

inherit

	S_LINKABLE_DATA

creation

	make

feature

	is_icon: BOOLEAN;
			-- Is current cluster iconified ?

	tag_relative_x: INTEGER;
			-- Relative horizontal position of tag

	tag_is_south: BOOLEAN;
			-- Is tag located to the south of cluster

	width: INTEGER;
			-- Cluster's physical width on drawing area

	height: INTEGER;
			-- Cluster's physical height on drawing area

	icon_width: INTEGER;
			-- Cluster's physical icon_width on drawing area

	icon_height: INTEGER;
			-- Cluster's physical icon_height on drawing area

	classes: FIXED_LIST [S_CLASS_DATA];
			-- Classes within Current cluster

	clusters: FIXED_LIST [S_CLUSTER_DATA];
			-- Clusters within Current cluster

feature -- Setting values

	set_icon_details (is_ic: BOOLEAN; w, h: INTEGER) is
			-- Set is_icon to `is_ic' and
			-- set icon_width and icon_height to `w' and `h'.
		require
			valid_values: w >= 0 and then h >=0
		do
			is_icon := is_ic;
			icon_width := w;
			icon_height := h;
		ensure
			icon_size_set: is_icon = is_ic and then 
							icon_height = h and then
							icon_width = w
		end;
 
	set_size (w, h: INTEGER) is
			-- Set width and height to `w' and `h'.
		require
			valid_values: w >= 0 and then h >=0
		do
			width := w;
			height := h;
		ensure
			size_set: width = w and then height = h
		end;
 
	set_classes (l: like classes) is
			-- Set classes to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			classes := l
		ensure
			classes_set: classes = l
		end;

	set_clusters (l: like clusters) is
			-- Set clusters to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			clusters := l
		ensure
			clusters_set: clusters = l
		end;

	set_tag_details (is_south: BOOLEAN; rel_x: INTEGER) is
			-- Set tag_is_south to `is_south' and set
			-- tag_relative_x to `rel_x'.
		do
			tag_is_south := is_south;
			tag_relative_x := rel_x
		ensure
			tag_details_set: tag_is_south = is_south and then
						tag_relative_x = rel_x
		end;
	
end
