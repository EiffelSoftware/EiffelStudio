indexing
	description: "Counter for the system data"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_COUNTER

inherit

	ONCES

feature -- attributes

	counter_cluster, counter_class, counter_general : INTEGER

	max_class, max_cluster , max_general: INTEGER

	class_view_number_tmp : INTEGER
	
	cluster_view_number_tmp : INTEGER

	class_view_number : INTEGER
	
	cluster_view_number : INTEGER
	
feature -- functions

   set_class_view_number_tmp ( i : INTEGER ) is
		do
			class_view_number_tmp := i
		end

	set_cluster_view_number_tmp ( i : INTEGER ) is
		do
			cluster_view_number_tmp := i
		end

	set_total (cl: CLUSTER_DATA ) is
		do
			count_classes_and_clusters_in_cluster ( cl )
		end

	increment_total_general ( i : INTEGER ) is
		do
			max_general := max_general +i
		end

	init_counter is 
		do
			counter_cluster:=0
			counter_class :=0	
			counter_general := 0
			max_class := 0
			max_cluster := 0	
			max_general := 0
		end

	increment_general is
		do
			if max_general>0 then
				counter_general := counter_general+1
			--	Windows.documentation_window.progress_cluster.set_position ((counter_general*100)//max_general)
			end
		end

	set_class_label ( s : STRING ) is
		do
			if max_class>0 then	
				counter_class := counter_class +1
			--	if Windows.ace_window.progress_class /= Void then
			--		Windows.ace_window.progress_class.set_position((counter_class*100)//max_class)	
			--	end
			end	
		end

	set_cluster_label ( s: STRING ) is
		do
			if max_cluster>0 then	
				counter_cluster := counter_cluster +1
			--	if Windows.ace_window.progress_cluster /= Void then
			--		Windows.ace_window.progress_cluster.set_position((counter_cluster*100)//max_cluster)	
			--	end
			end	
		end

	count_classes_and_clusters_in_cluster ( c : cluster_data ) is
	do
		if c.clusters /= Void then
		from 
			c.clusters.start
		until
			c.clusters.after
		loop
			max_cluster := max_cluster +1
			count_classes_and_clusters_in_cluster ( c.clusters.item )
			c.clusters.forth
		end
		end
		if c.classes /= Void then
		from 
			c.classes.start
		until
			c.classes.after
		loop
			max_class := max_class+1
			c.classes.forth
		end
		end
	end

	count_classes_and_clusters ( c : s_cluster_data ) is
	do
	if c/= Void then
		if c.clusters /= Void then
			from 
				c.clusters.start
			until
				c.clusters.after
			loop
				cluster_view_number_tmp := cluster_view_number_tmp +1
				count_classes_and_clusters ( c.clusters.item )
				c.clusters.forth
				end
			end
			if c.classes /= Void then
				from 
					c.classes.start
				until
					c.classes.after
				loop
					class_view_number_tmp := class_view_number_tmp +1
					c.classes.forth
				end
			end
		end
	end

	decrement_cluster_view_number_tmp is
	do
		cluster_view_number_tmp := cluster_view_number-1
	end

	decrement_class_view_number_tmp is
	do
		class_view_number_tmp := class_view_number-1
	end

	increment_class_view_number is
		do
			class_view_number := class_view_number + 1
		ensure
			incremented: class_view_number = old class_view_number + 1
		end

	increment_cluster_view_number is
		do
			cluster_view_number := cluster_view_number + 1
		ensure
			incremented: cluster_view_number = old cluster_view_number + 1
		end


	decrement_cluster_view_number is
		do
			cluster_view_number := cluster_view_number - 1
		ensure
			decremented: cluster_view_number = old cluster_view_number - 1
		end

	set_class_view_number ( i : INTEGER ) is
		do
			class_view_number := i
		end

	set_cluster_view_number ( i : INTEGER ) is
		do
			cluster_view_number := i
		end

end -- class SYSTEM_COUNTER
