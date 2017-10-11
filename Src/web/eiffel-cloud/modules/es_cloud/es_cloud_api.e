note
	description: "API to handle ES Cloud api."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_API

inherit
	CMS_MODULE_API
		redefine
			initialize
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor
					-- Storage initialization
			if attached cms_api.storage.as_sql_storage as l_storage_sql then
				create {ES_CLOUD_STORAGE_SQL} es_cloud_storage.make (l_storage_sql)
			else
					-- FIXME: in case of NULL storage, should Current be disabled?
				create {ES_CLOUD_STORAGE_NULL} es_cloud_storage
			end
		end

feature {CMS_MODULE} -- Access nodes storage.

	es_cloud_storage: ES_CLOUD_STORAGE_I

feature -- Access

	plans: LIST [ES_CLOUD_PLAN]
		do
			Result := es_cloud_storage.plans
		end

	plan_by_name (a_name: READABLE_STRING_GENERAL): detachable ES_CLOUD_PLAN
		do
			across
				plans as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not a_name.is_case_insensitive_equal (Result.name) then
					Result := Void
				end
			end
		end

	user_subscription (a_user: CMS_USER): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		do
			Result := es_cloud_storage.user_subscription (a_user)
			if Result = Void then
					-- Subscribe to default plan
				if attached plans as lst and then not lst.is_empty then
					create Result.make (a_user, lst.first)
						-- Set default plan!
					es_cloud_storage.save_subscription (Result)
				end
			end
		end

	user_installations (a_user: CMS_USER): LIST [ES_CLOUD_INSTALLATION]
		do
			Result := es_cloud_storage.user_installations (a_user)
		end

feature -- Change	

	save_plan (a_plan: ES_CLOUD_PLAN)
		do
			es_cloud_storage.save_plan (a_plan)
		end

	subscribe_user_to_plan (a_user: CMS_USER; a_plan: ES_CLOUD_PLAN; nb_months: INTEGER)
		require
			a_plan.has_id
		local
			sub: ES_CLOUD_PLAN_SUBSCRIPTION
			l_date: DATE
			y,mo: INTEGER
		do
			create sub.make (a_user, a_plan)
			l_date := sub.creation_date.date
			y := l_date.year
			mo := l_date.month
			mo := mo + nb_months
			if mo = 12 then
				y := y + 1
			else
				y := y + mo // 12
				mo := mo \\ 12
			end
			create l_date.make (y, mo, l_date.day)
			sub.set_expiration_date (create {DATE_TIME}.make_by_date_time (l_date, sub.creation_date.time))
			es_cloud_storage.save_subscription (sub)
		end

	register_installation (a_user: CMS_USER; a_install_id: READABLE_STRING_GENERAL; a_info: detachable READABLE_STRING_GENERAL)
		local
			ins: ES_CLOUD_INSTALLATION
		do
			create ins.make (a_install_id, a_user)
			ins.set_info (a_info)
			es_cloud_storage.save_installation (ins)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

