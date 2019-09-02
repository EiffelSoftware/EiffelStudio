note
	description: "Item associated to a class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EBB_CLASS_ASSOCIATION

inherit

	SHARED_WORKBENCH

	INTERNAL_COMPILER_STRING_EXPORTER

feature {NONE} -- Initialization

	make_with_class_id (a_class_id: like class_id)
			-- Initialize associated to `a_class_id'.
		require
			class_exists: system.class_of_id (a_class_id) /= Void
		do
			system.names.put (system.class_of_id (a_class_id).name)
			class_name_id := system.names.id_of (system.class_of_id (a_class_id).name)
		ensure
			class_id_set: class_id = a_class_id
			compiled_class_set: compiled_class.class_id = class_id
		end

	make_with_class (a_class: attached like associated_class)
			-- Initialize associated to `a_class'.
		do
			system.names.put (a_class.name)
			class_name_id := system.names.id_of (a_class.name)
		ensure
-- might not be the same object
--			class_id_set: associated_class = a_class
			class_set: a_class.name.is_equal (associated_class.name)
		end

feature -- Access

	associated_class: attached CLASS_I
			-- Class associated with this data.
		do
			if associated_class_cache = Void then
				associated_class_cache := system.universe.classes_with_name (system.names.item_32 (class_name_id)).first
			end
			check associated_class_cache /= Void end
			Result := associated_class_cache
		end

	class_name: attached STRING
			-- Class name of class associated with this data.
		do
			Result := associated_class.name
		end

	class_id: INTEGER
			-- Class ID of class associated with this data.
		require
			compiled: is_compiled
		do
			if class_id_cache = 0 and associated_class.is_compiled then
				class_id_cache := associated_class.compiled_class.class_id
			end
			Result := class_id_cache
		end

	compiled_class: attached CLASS_C
			-- Compiled class associated with this data.
		require
			compiled: is_compiled
		do
			if compiled_class_cache = Void then
				compiled_class_cache := associated_class.compiled_class
			end
			check compiled_class_cache /= Void end
			Result := compiled_class_cache
		end

feature -- Status report

	is_compiled: BOOLEAN
			-- Is class associated with this data compiled?
		do
			Result := associated_class.is_compiled
		end

feature {NONE} -- Implementation

	class_name_id: INTEGER
			-- Name id of associated class.

	class_id_cache: INTEGER
			-- Cached value of class id of associated class (if any).
		note
			option: transient
		attribute
		end

	associated_class_cache: CLASS_I
			-- Cached reference to associated class.
		note
			option: transient
		attribute
		end

	compiled_class_cache: CLASS_C
			-- Cached reference to compiled class.
		note
			option: transient
		attribute
		end

invariant
	class_id_set: is_compiled implies class_id /= 0
	compiled_class_consistent: is_compiled implies compiled_class.class_id = class_id

end
