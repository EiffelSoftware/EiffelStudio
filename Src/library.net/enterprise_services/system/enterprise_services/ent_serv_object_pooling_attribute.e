indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.ObjectPoolingAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_OBJECT_POOLING_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_object_pooling_attribute,
	make_ent_serv_object_pooling_attribute_1,
	make_ent_serv_object_pooling_attribute_2,
	make_ent_serv_object_pooling_attribute_3

feature {NONE} -- Initialization

	frozen make_ent_serv_object_pooling_attribute is
		external
			"IL creator use System.EnterpriseServices.ObjectPoolingAttribute"
		end

	frozen make_ent_serv_object_pooling_attribute_1 (min_pool_size: INTEGER; max_pool_size: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.EnterpriseServices.ObjectPoolingAttribute"
		end

	frozen make_ent_serv_object_pooling_attribute_2 (enable: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.EnterpriseServices.ObjectPoolingAttribute"
		end

	frozen make_ent_serv_object_pooling_attribute_3 (enable: BOOLEAN; min_pool_size: INTEGER; max_pool_size: INTEGER) is
		external
			"IL creator signature (System.Boolean, System.Int32, System.Int32) use System.EnterpriseServices.ObjectPoolingAttribute"
		end

feature -- Access

	frozen get_creation_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.ObjectPoolingAttribute"
		alias
			"get_CreationTimeout"
		end

	frozen get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.EnterpriseServices.ObjectPoolingAttribute"
		alias
			"get_Enabled"
		end

	frozen get_min_pool_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.ObjectPoolingAttribute"
		alias
			"get_MinPoolSize"
		end

	frozen get_max_pool_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.ObjectPoolingAttribute"
		alias
			"get_MaxPoolSize"
		end

feature -- Element Change

	frozen set_max_pool_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.EnterpriseServices.ObjectPoolingAttribute"
		alias
			"set_MaxPoolSize"
		end

	frozen set_min_pool_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.EnterpriseServices.ObjectPoolingAttribute"
		alias
			"set_MinPoolSize"
		end

	frozen set_creation_timeout (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.EnterpriseServices.ObjectPoolingAttribute"
		alias
			"set_CreationTimeout"
		end

	frozen set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.EnterpriseServices.ObjectPoolingAttribute"
		alias
			"set_Enabled"
		end

feature -- Basic Operations

	frozen apply (info: HASHTABLE): BOOLEAN is
		external
			"IL signature (System.Collections.Hashtable): System.Boolean use System.EnterpriseServices.ObjectPoolingAttribute"
		alias
			"Apply"
		end

	frozen is_valid_target (s: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.EnterpriseServices.ObjectPoolingAttribute"
		alias
			"IsValidTarget"
		end

	frozen after_save_changes (info: HASHTABLE): BOOLEAN is
		external
			"IL signature (System.Collections.Hashtable): System.Boolean use System.EnterpriseServices.ObjectPoolingAttribute"
		alias
			"AfterSaveChanges"
		end

end -- class ENT_SERV_OBJECT_POOLING_ATTRIBUTE
