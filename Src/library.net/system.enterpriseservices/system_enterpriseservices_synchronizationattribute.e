indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.SynchronizationAttribute"

frozen external class
	SYSTEM_ENTERPRISESERVICES_SYNCHRONIZATIONATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_synchronizationattribute,
	make_synchronizationattribute_1

feature {NONE} -- Initialization

	frozen make_synchronizationattribute is
		external
			"IL creator use System.EnterpriseServices.SynchronizationAttribute"
		end

	frozen make_synchronizationattribute_1 (val: SYSTEM_ENTERPRISESERVICES_SYNCHRONIZATIONOPTION) is
		external
			"IL creator signature (System.EnterpriseServices.SynchronizationOption) use System.EnterpriseServices.SynchronizationAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_ENTERPRISESERVICES_SYNCHRONIZATIONOPTION is
		external
			"IL signature (): System.EnterpriseServices.SynchronizationOption use System.EnterpriseServices.SynchronizationAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_ENTERPRISESERVICES_SYNCHRONIZATIONATTRIBUTE
