indexing
	description: 
		"Stone representing an uncompiled Eiffel class."
	date: "$Date$"
	revision: "$Revision $"

class
	CLASSI_STONE 

inherit

	FILED_STONE
		redefine
			is_valid, synchronized_stone, same_as
		end

	SHARED_EIFFEL_PROJECT

creation
	make
	
feature {NONE} -- Initialization

	make (aclassi: CLASS_I) is
			-- Copy all information from argument
			-- OR KEEP A REFERENCE?
		do
			actual_class_i := aclassi
		end

feature -- Properties
 
	class_i: CLASS_I is
		do
			Result := actual_class_i
		ensure
			non_void: Result /= Void
		end

	class_name: STRING is
			-- Name of `class_i'.
		do
			Result := class_i.name
		end

	cluster: CLUSTER_I is
			-- Cluster associated with current.
		do
			Result := class_i.cluster
		end

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		once
			Result := Cursors.cur_Class
		end

	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		once
			Result := Cursors.cur_X_Class
		end

	file_name: FILE_NAME is
			-- File associated with `class_i'.
		do
			Result := class_i.file_name
		end

	stone_signature: STRING is
		do
			Result := class_i.name_in_upper
		end

	history_name: STRING is
		do
			Result := Interface_names.s_Class_stone + stone_signature
		end

	same_as (other: STONE): BOOLEAN is
			-- Do `Current' and `other' represent the same class?
		local
			convcur: CLASSI_STONE
		do
			convcur ?= other
			Result := convcur /= Void and then class_i.is_equal (convcur.class_i)
		end

feature -- Access

	header: STRING is
			-- Display class name, class' cluster and class location in 
			-- window title bar.
		do
			create Result.make (20)
			Result.append (stone_signature)
			Result.append ("  in cluster ")
			Result.append (class_i.cluster.cluster_name)
			Result.append ("  (not in system)")
			Result.append ("  located in ")
			Result.append (class_i.file_name)
		end
 
	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result := class_i /= Void
		end

	synchronized_stone: CLASSI_STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore. It may also 
			-- be a classc_stone if the class is compiled now)
		local
			new_cluster: CLUSTER_I
			new_ci: CLASS_I
		do
			if class_i /= Void then
				new_cluster := Eiffel_Universe.cluster_of_name 
							(class_i.cluster.cluster_name)
				if new_cluster /= Void then
					new_ci := new_cluster.class_with_name (class_i.name)
					if
						new_ci /= Void
					then
						if new_ci.compiled then
							!CLASSC_STONE! Result.make (new_ci.compiled_class)
						else
							!CLASSI_STONE! Result.make (new_ci)
						end
					end
				end
			end
		end

feature -- Implementation

	actual_class_i: CLASS_I

end -- class CLASSI_STONE
